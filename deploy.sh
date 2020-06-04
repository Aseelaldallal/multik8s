docker build -t aseel/multi-client:latest -t aseel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aseel/multi-server:latest -t aseel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aseel/multi-worker:latest -t aseel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aseel/multi-client:latest
docker push aseel/multi-server:latest
docker push aseel/multi-worker:latest

docker push aseel/multi-client:$SHA
docker push aseel/multi-server:$SHA
docker push aseel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aseel/multi-server:$SHA
kubectl set image deployments/client-deployment client=aseel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aseel/multi-worker:$SHA