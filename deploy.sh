docker build -t aaronrryan/multi-client:latest -t aaronrryan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aaronrryan/multi-server:latest -t aaronrryan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aaronrryan/multi-worker:latest -t aaronrryan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aaronrryan/multi-client:latest
docker push aaronrryan/multi-server:latest
docker push aaronrryan/multi-worker:latest

docker push aaronrryan/multi-client:$SHA
docker push aaronrryan/multi-server:$SHA
docker push aaronrryan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aaronrryan/multi-server:$SHA
kubectl set image deployments/client-deployment client=aaronrryan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aaronrryan/multi-worker:$SHA