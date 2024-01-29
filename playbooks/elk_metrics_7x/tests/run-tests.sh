#!/usr/bin/env bash
# Copyright 2018, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ve

export TEST_DIR="$(readlink -f $(dirname ${0})/../../)"

pushd "${HOME}"
  if [[ ! -d "src" ]]; then
    mkdir src
  fi
  pushd src
    ln -sf "${TEST_DIR}"
  popd
popd

source "${TEST_DIR}/elk_metrics_7x/tests/manual-test.rc"

source "${TEST_DIR}/elk_metrics_7x/bootstrap-embedded-ansible.sh"
deactivate

${HOME}/ansible_venv/bin/ansible-galaxy install --force \
                                             --roles-path="${HOME}/ansible_venv/repositories/roles" \
                                             -r "${TEST_DIR}/elk_metrics_7x/tests/ansible-role-requirements.yml"

${HOME}/ansible_venv/bin/ansible-galaxy install --force \
                                             --roles-path="${HOME}/ansible_venv/repositories/roles" \
                                             -r "${TEST_DIR}/elk_metrics_7x/tests/ansible-collection-requirements.yml"

if [[ ! -e "${TEST_DIR}/elk_metrics_7x/tests/src" ]]; then
  ln -s ${TEST_DIR}/../ ${TEST_DIR}/elk_metrics_7x/tests/src
fi

${HOME}/ansible_venv/bin/ansible-playbook -i 'localhost,' \
                                       -vv \
                                       -e ansible_connection=local \
                                       -e test_clustered_elk=${CLUSTERED:-no} \
                                       ${TEST_DIR}/elk_metrics_7x/tests/test.yml
