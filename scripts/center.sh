#!/usr/bin/env bash

set -e

CHART_NAME="${1//\/}"

if [[ "${CHART_NAME}" == "" ]]
then
    echo "Helm center plugin"
    echo
    echo "Usage:"
    echo "Chart name must be provided"
    echo "helm center <CHART_NAME>"
    echo
    exit 0
fi

echo "Running helm dependency update"
helm dependency update ${CHART_NAME}
echo

FILES=${CHART_NAME}/charts/*.tgz
for f in $FILES
do
  echo "Processing $f sub-chart..."
  tar -xzf $f -C ${CHART_NAME}/charts
  rm -f $f
done
