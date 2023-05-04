echo creating zookeeper cluster
kubectl apply -f 1_zk

echo installing the clickhouse operator
OPERATOR_NAMESPACE="${OPERATOR_NAMESPACE:-"kube-system"}" # can change the operator namespace, default is "kube-system"
curl -s https://raw.githubusercontent.com/Altinity/clickhouse-operator/master/deploy/operator-web-installer/clickhouse-operator-install.sh | bash

echo sleeping for 20 sec
sleep 20

echo creating the clickhouse cluster with s3 credentials
envsubst < 2_ch/ch.yml | kubectl apply -f -
