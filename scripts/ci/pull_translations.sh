#!/bin/bash

echo "::group::tx-pull"

if [[ ${TRAVIS_SECURE_ENV_VARS} = true ]]; then
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
  source ${DIR}/../version_number.sh
  
  if [[ ${TRAVIS_BRANCH} = master ]]; then
    tx pull --all --force
  else
    travis_to_release_branch
    tx pull --all --force --branch ${RELEASE_BRANCH//_/-}
  fi
  
  for x in android/res/values-*_*;do mv $x $(echo $x | sed -e 's/_/-r/') ;done
  
  lrelease QField.pro
fi

echo "::endgroup::"

