# Airflow Kubernetes

## Secrets

You may create `Secret/airflow-ssh-git-secret` using this command, if you have the SSH private key stored under `$HOME/.ssh/id_rsa`:

```bash
kubectl create secret generic \
  airflow-ssh-git-secret \
  --from-file=id_rsa=$HOME/.ssh/id_rsa \
  --namespace airflow
```
