docker build -t marvinmaran/multi-client:latest -t marvinmaran/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marvinmaran/multi-server:latest -t marvinmaran/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marvinmaran/multi-worker:latest -t marvinmaran/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marvinmaran/multi-client:latest
docker push marvinmaran/multi-server:latest
docker push marvinmaran/multi-worker:latest

docker push marvinmaran/multi-client:$SHA
docker push marvinmaran/multi-server:$SHA
docker push marvinmaran/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=marvinmaran/multi-server:$SHA
kubectl set image deployments/client-deployment client=marvinmaran/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marvinmaran/multi-worker:$SHA
