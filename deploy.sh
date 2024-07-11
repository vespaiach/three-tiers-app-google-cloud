IMAGE_TAG="${1:-1.0.0}"

# Fetch the RAILS_MASTER_KEY from Google Secret Manager
RAILS_MASTER_KEY=$(gcloud secrets versions access latest --secret=RAILS_MASTER_KEY)

cd ./frontend
gcloud builds submit --config=./cloudbuild.yaml --substitutions=_IMAGE_TAG="${IMAGE_TAG}"
cd -
cd ./backend
gcloud builds submit --config=./cloudbuild.yaml --substitutions=_IMAGE_TAG="${IMAGE_TAG} --substitutions=_RAILS_MASTER_KEY="${RAILS_MASTER_KEY}"
