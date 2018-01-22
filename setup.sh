# First install Docker for macos from here
#https://store.docker.com/editions/community/docker-ce-desktop-mac

# cd into the cloned git directory

# Download and run a default mongodb instance
docker run --name mongo_001 -d -P mongo

# Create a docker image (using an ubuntu base) that runs this acmeair server
# This uses the Dockerfile in the current directory
docker build -t acmeair/web .

# Run the image just created and point it to the running mongodb instance
docker run -d -P --name acmeair_web_001 --link mongo_001:mongo acmeair/web

# Build the docker jmeter image. This image is used below to trigger acmeair.
docker build -t acmeair/workload document/workload

# MANUAL STEPS FOR DEMO

# To view the appmetrics dashboard, run the following command
#docker container ps
# You will notice that the container port 3001 is mapped to a real port on the host OS.
# Use that mapped port to open this url.
#http://localhost:[port]/appmetrics-dash

# To view the acmeair homepage use the port mapped to 9080.
#http://localhost:[port]/

# Run this manually to trigger spikes in the appmetrics-dashboard.
#docker run -i -t --link acmeair_web_001:app acmeair/workload
