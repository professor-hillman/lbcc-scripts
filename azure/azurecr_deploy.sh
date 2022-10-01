
##  Push Docker Container to Azure Container Registry + Create Azure Container Instance


# name of image we plan to build
IMAGE_NAME='blinkerfluids'

# buid and tag the local docker image (run in directory with Dockerfile)
docker build -t $IMAGE_NAME .

# start the container locally for testing
docker run --name=$IMAGE_NAME --rm -p1337:1337 -d $IMAGE_NAME

# stop the container if everything is working normally
docker stop $IMAGE_NAME

# login to azure
az login

# choose a name for your resource group
RG='RG-Containers'

# choose a name for your azure container registry (unique across azure)
ACR_NAME='AzureContainerRegistryName'

# choose region to deploy into
REGION='eastus'

# create resource group
az group create --name $RG --location $REGION

# create azure container registry (name must be unique across azure)
az acr create --resource-group $RG --name $ACR_NAME --sku Basic

# login to the container registry
az acr login --name $ACR_NAME

# get acr login server name to properly tag image before push
az acr show --name $ACR_NAME --query loginServer --output table

# login server for your container registry (from output above)
ACR_SERVER='AzureContainerRegistryLoginServer'

# list local images
docker images

# tag the local image with acr login server and add versioning
docker tag $IMAGE_NAME "$ACR_SERVER/$IMAGE_NAME:v1"

# verify tagging completed successfully
docker images

# push image to azure container registry
docker push "$ACR_SERVER/$IMAGE_NAME:v1"

# verify image pushed successfully
az acr repository list --name $ACR_NAME --output table

# to show tags for a specific image (optional)
az acr repository show-tags --name $ACR_NAME --repository $IMAGE_NAME --output table

# run the acr_create_spn.sh script to create service princial then paste credentials here
SPN_ID=''
SPN_PW=''

# select a dns prefix for your container (<blinkerfluids>.eastus.azurecontainer.io)
DNS_LABEL='blinkerfluids'

# port that the web app will operate on
PORTS='1337'

# create the container
az container create --resource-group $RG --name $IMAGE_NAME --image "$ACR_SERVER/$IMAGE_NAME:v1" --cpu 1 --memory 1 --registry-login-server $ACR_SERVER --registry-username $SPN_ID --registry-password $SPN_PW --ip-address Public --dns-name-label $DNS_LABEL --ports $PORTS

# verify deployment progress
az container show --resource-group $RG --name $IMAGE_NAME --query instanceView.state

# get container's fqdn (fully qualified domain name)
az container show --resource-group $RG --name $IMAGE_NAME --query ipAddress.fqdn

# view container's log output
az container logs --resource-group $RG --name $IMAGE_NAME

# delete the resource group and all resources
az group delete --name $RG
