install argocd kubernetes:

create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get svc -n argocd
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
Si el comando anterior no funciona editar el manifiesto
kubectl edit svc argocd-server -n argocd

kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl exec -n argocd argocd-server-6576896669-rnwfp -- argocd admin initial-password -n argocd

minikube:
minikube service argocd-server --url -n argocd
admin
**password**
lkCI1qGnI3LeJJ5R

kubectl create namespace biblioteca
kubectl port-forward pod/mysql-db-0 3309:3306 -n biblioteca


Autenticación SSH REPOBACKEND AL REPOGITOPS
ssh-keygen -t rsa -b 4096 -C "gitops-deploy-key"
id_rsa (o el nombre que le des, clave privada)
id_rsa.pub (o el nombre que le des, clave pública)

ssh-keygen -p -m PEM -f ~/.ssh/id_rsa


minikube addons enable ingress