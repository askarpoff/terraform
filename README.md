# terraform

yc iam key create  --service-account-id {} --folder-name crz-cloud --output key.json

yc config profile create crz-terraform

yc config set service-account-key key.json

yc config set cloud-id {}

yc config set folder-id {}

export YC_TOKEN=$(yc iam create-token)

export YC_CLOUD_ID=$(yc config get cloud-id)

export YC_FOLDER_ID=$(yc config get folder-id)

terraform init

terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex

