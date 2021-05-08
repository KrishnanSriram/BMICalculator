
set_params() {
  ROOT_DIR=$(cd .. && pwd)
  DIST_DIR="$ROOT_DIR/dist"
  BUILD_DIR="$ROOT_DIR/build"
  LAMBDA_NAME="bmi"
  CODE_VERSION=$(date +'%Y%m%d%H%M')
  ZIP_FILE="${LAMBDA_NAME}_${CODE_VERSION}.zip"

  echo "ROOT_DIR=${ROOT_DIR}"
  echo "DIST_DIR=${DIST_DIR}"
  echo "ZIP_FILE=${ZIP_FILE}"
  echo ""
}

zip_package() {
  cd "${ROOT_DIR}"
  npm install --progress=false --production
  mkdir -p $DIST_DIR
  zip -q -9 -r "${DIST_DIR}/${ZIP_FILE}" .
  echo "Lambda file zip has been created: ${ZIP_FILE} in ${DIST_DIR}"
}

upload_zip_to_s3() {
  echo "Updload zip to S3"
  cd "${DIST_DIR}"
  aws s3 cp ${ZIP_FILE} s3://krish-lambdas-bmicalc/${ZIP_FILE} --no-verify-ssl
  echo "File uploaded successfully"
}

set_params
zip_package
upload_zip_to_s3