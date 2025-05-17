
KEY_NAME="flin-keypair"
SECURITY_GROUP="flin-sg"
REGION="us-east-1"
AMI_ID="ami-0c02fb55956c7d316"  
INSTANCE_TYPE="t2.micro"
DB_USERNAME="admin"
DB_PASSWORD="FlinStrongPass123"

aws ec2 create-key-pair \
  --key-name $KEY_NAME \
  --query 'KeyMaterial' \
  --output text > $KEY_NAME.pem

aws ec2 create-security-group \
  --group-name $SECURITY_GROUP \
  --description "Allow HTTP, HTTPS, SSH" \
  --region $REGION

aws ec2 authorize-security-group-ingress \
  --group-name $SECURITY_GROUP \
  --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-name $SECURITY_GROUP \
  --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-name $SECURITY_GROUP \
  --protocol tcp --port 443 --cidr 0.0.0.0/0

aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-groups $SECURITY_GROUP \
  --region $REGION

aws rds create-db-instance \
  --db-instance-identifier flin-db \
  --db-instance-class db.t2.micro \
  --engine mysql \
  --allocated-storage 20 \
  --master-username $DB_USERNAME \
  --master-user-password $DB_PASSWORD \
  --backup-retention-period 0 \
  --publicly-accessible \
  --region $REGION

aws s3api create-bucket \
  --bucket flin-media-storage-$(date +%s) \
  --region $REGION \
  --create-bucket-configuration LocationConstraint=$REGION

aws cloudfront create-distribution \
  --origin-domain-name example.s3.amazonaws.com

echo "Basic AWS resources created (or staged)."
