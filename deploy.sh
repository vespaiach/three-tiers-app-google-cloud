IMAGE_TAG="${1:-1.0.0}"
PROJECT_ID="ahhuhu"
PROJECT_NUMBER="660837874699"
# Fetch the RAILS_MASTER_KEY from Google Secret Manager
RAILS_MASTER_KEY=$(gcloud secrets versions access latest --secret=RAILS_MASTER_KEY)

cd ./frontend
gcloud builds submit --config=./cloudbuild.yaml --substitutions=_IMAGE_TAG="${IMAGE_TAG}"

cd -
cd ./backend
gcloud builds submit --config=./cloudbuild.yaml --substitutions=_IMAGE_TAG="${IMAGE_TAG}",_RAILS_MASTER_KEY="${RAILS_MASTER_KEY}"

cd -
gcloud run deploy three-tier-fe \
    --image=gcr.io/${PROJECT_ID}/three-tier-app-fe:${IMAGE_TAG} \
    --allow-unauthenticated \
    --port=80 \
    --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --region=us-central1 \
    --project=${PROJECT_ID}

cd -
gcloud run deploy three-tier-be \
    --image=gcr.io/${PROJECT_ID}/three-tier-app-be:${IMAGE_TAG} \
    --allow-unauthenticated \
    --port=80 \
    --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --region=us-central1 \
    --project=${PROJECT_ID}
