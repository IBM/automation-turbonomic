#!/usr/bin/env bash

terragrunt run-all plan --terragrunt-parallelism 1 --terragrunt-non-interactive --terragrunt-exclude-dir="${PWD}/.mocks/"*
