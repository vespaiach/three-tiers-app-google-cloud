IMAGE_TAG="1.0.0"
cd ./frontend
gcloud builds submit --config=./cloudbuild.yaml --substitutions=_IMAGE_TAG="${IMAGE_TAG}"