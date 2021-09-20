docker build -t semie/multi-client:latest -t semie/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t semie/multi-server:latest -t semie/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t semie/multi-worker:latest -t semie/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push semie/multi-client:latest
docker push semie/multi-server:latest
docker push semie/multi-worker:latest

docker push semie/multi-client:$SHA
docker push semie/multi-server:$SHA
docker push semie/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=semie/multi-server:$SHA
kubectl set image deployments/client-deployment client=semie/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=semie/multi-worker:$SHA