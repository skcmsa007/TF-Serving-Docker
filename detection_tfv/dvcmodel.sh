TOKEN=$1
VAULT_IP=$2

AWS_KEY=`curl --header 'X-Vault-Token:'$TOKEN http://$VAULT_IP/v1/secret/reminders/app | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["data"]["AWS_Access_Key_ID"])'`
AWS_SECRET_KEY=`curl --header 'X-Vault-Token:'$TOKEN http://$VAULT_IP/v1/secret/reminders/app | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["data"]["AWS_Secret_Access_Key_ID"])'`
AWS_REGION=`curl --header 'X-Vault-Token:'$TOKEN http://$VAULT_IP/v1/secret/reminders/app | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["data"]["Default_region_name"])'`

AWS_KEY=$AWS_KEY
AWS_SECRET_KEY=$AWS_SECRET_KEY
AWS_REGION=$AWS_REGION

aws configure set aws_access_key_id $AWS_KEY \
        && aws configure set aws_secret_access_key $AWS_SECRET_KEY \
        && aws configure set default.region $AWS_REGION

cd models/Yolo_Saved_11th_Oct22 \
	&& dvc config core.no_scm true \
	&& dvc pull
