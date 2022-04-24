docker build -t rubhern/multi-client:latest -t rubhern/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rubhern/multi-server:latest -t rubhern/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rubhern/multi-worker:latest -t rubhern/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rubhern/multi-client:latest
docker push rubhern/multi-worker:latest
docker push rubhern/multi-server:latest

docker push rubhern/multi-client:$SHA
docker push rubhern/multi-worker:$SHA
docker push rubhern/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rubhern/multi-server:$SHA
kubectl set image deployments/client-deployment client=rubhern/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rubhern/multi-worker:$SHA