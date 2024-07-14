IMAGE_TAG="${1:-1.0.0}"
PROJECT_ID="ahhahihi"
PROJECT_NUMBER="660837874699"
REGION="us-west1"

# gcloud config set project $PROJECT_ID
# gcloud services enable compute.googleapis.com
# gcloud services enable secretmanager.googleapis.com
# gcloud services enable cloudbuild.googleapis.com
# gcloud services enable sqladmin.googleapis.com
# gcloud services enable run.googleapis.com
# gcloud services enable dns.googleapis.com
# gcloud services enable servicenetworking-googleapis-com
# gcloud secrets create TODO_DB_HOST --replication-policy="automatic"
# echo -n "/cloudsql/ahhahihi:us-west1:todo-db" | gcloud secrets versions add TODO_DB_HOST --data-file=-
# gcloud secrets create TODO_DB_USER --replication-policy="automatic"
# echo -n "todo-db-user" | gcloud secrets versions add TODO_DB_USER --data-file=-
# gcloud secrets create TODO_DB_USER_PASSWORD --replication-policy="automatic"
# echo -n "todo-db-user-root" | gcloud secrets versions add TODO_DB_USER_PASSWORD --data-file=-
# gcloud secrets create RAILS_MASTER_KEY --replication-policy="automatic"
# echo -n "14230907274cb48c1e28d6086424d9d0" | gcloud secrets versions add RAILS_MASTER_KEY --data-file=-

# set default region
gcloud config set run/region $REGION

RAILS_MASTER_KEY=$(gcloud secrets versions access latest --secret=RAILS_MASTER_KEY)
TODO_DB_USER=$(gcloud secrets versions access latest --secret="TODO_DB_USER")
TODO_DB_USER_PASSWORD=$(gcloud secrets versions access latest --secret="TODO_DB_USER_PASSWORD")
TODO_DB_HOST=$(gcloud secrets versions access latest --secret="TODO_DB_HOST")
# VITE_API_BASE_URL=$(gcloud run services describe three-tier-app-be --format=json | jq '.status.url')
VITE_API_BASE_URL="https://api.letbike.com"

cd ./frontend
gcloud builds submit \
    --config=./cloudbuild.yaml \
    --substitutions=_IMAGE_TAG="${IMAGE_TAG}",_VITE_API_BASE_URL="${VITE_API_BASE_URL}"

cd -
cd ./backend
gcloud builds submit \
    --config=./cloudbuild.yaml \
    --substitutions=_IMAGE_TAG="${IMAGE_TAG}",_RAILS_MASTER_KEY="${RAILS_MASTER_KEY}",_TODO_DB_USER="${TODO_DB_USER}",_TODO_DB_USER_PASSWORD="${TODO_DB_USER_PASSWORD},_TODO_DB_HOST=${TODO_DB_HOST}"

cd -
gcloud run deploy three-tier-fe \
    --image=gcr.io/${PROJECT_ID}/three-tier-app-fe:${IMAGE_TAG} \
    --allow-unauthenticated \
    --port=80 \
    --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --region=${REGION} \
    --project=$PROJECT_ID \
    --no-traffic

cd -
gcloud run deploy three-tier-be \
    --image=gcr.io/${PROJECT_ID}/three-tier-app-be:${IMAGE_TAG} \
    --allow-unauthenticated \
    --port=80 \
    --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --region=${REGION} \
    --project=$PROJECT_ID \
    --no-traffic

# gcloud run services update-traffic three-tier-be --to-revisions revision-name
# gcloud run services update-traffic three-tier-fe --to-revisions revision-name
