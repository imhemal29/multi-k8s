docker build -t imhemal29/multi-client:latest -t imhemal29/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imhemal29/multi-server:latest -t imhemal29/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imhemal29/multi-worker:latest -t imhemal29/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push imhemal29/multi-client:latest
docker push imhemal29/multi-server:latest
docker push imhemal29/multi-worker:latest


docker push imhemal29/multi-client:$SHA
docker push imhemal29/multi-server:$SHA
docker push imhemal29/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=imhemal29/multi-server$SHA
kubectl set image deployments/client-deployment server=imhemal29/multi-client$SHA
kubectl set image deployments/worker-deployment server=imhemal29/multi-worker$SHA