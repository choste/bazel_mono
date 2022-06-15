DIR=$(dirname "$1")
echo "helm package $DIR"

PACKAGE_OUTPUT=$(helm package ${DIR})

echo "${PACKAGE_OUTPUT}"

[[ ${PACKAGE_OUTPUT} =~ (\/.*\.tgz) ]]

helm push ${BASH_REMATCH[1]} oci://us-central1-docker.pkg.dev/bazel-352318/quickstart-helm-repo
