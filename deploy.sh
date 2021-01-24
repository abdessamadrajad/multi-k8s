docker build -t abdessamadrajd/multi-client:latest -t abdessamadrajd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abdessamadrajd/multi-server:latest -t abdessamadrajd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abdessamadrajd/multi-worker:latest -t abdessamadrajd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abdessamadrajd/multi-client:latest
docker push abdessamadrajd/multi-server:latest
docker push abdessamadrajd/multi-worker:latest

docker push abdessamadrajd/multi-client:$SHA
docker push abdessamadrajd/multi-server:$SHA
docker push abdessamadrajd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abdessamadrajd/multi-server:$SHA
kubectl set image deployments/client-deployment client=abdessamadrajd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abdessamadrajd/multi-worker:$SHA