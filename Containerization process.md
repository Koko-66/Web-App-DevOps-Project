# Containerization Process

## Dockerfile configuration

Commands included in the Dockerfile:

1. `FROM --platform=linux/amd64 public.ecr.aws/docker/library/python:3.9.10-slim-buster`: uses Python image as base image.
    The image specified in the file is chosen for compatibilty with a M1/M2 chip Mac. If working on Windows or Linux a standard python image suitable for running Flask apps (e.g. `python:3.8-slim`), can be used.

2. `WORKDIR /app`: sets working directory to `/app`.

3. `COPY . /app`: copies the contents of the local directory into the container's `/app` directory to ensure the application code and files are available within the container.

4. `RUN apt-get update...`: sets up the environment for Microsoft ODBC Driver for SQL Server on a Debian-based system, including installing necessary dependencies, adding the Microsoft repository, and installing the ODBC driver.
    Below is a more detailed description of individual commands in this block and what they do<sup>*</sup>:

    - `RUN apt-get update`: updates the package list to get the latest information on available packages.

    - `apt-get install -y unixodbc unixodbc-dev odbcinst odbcinst1debian2 libpq-dev gcc`: Installs packages required for ODBC (Open Database Connectivity) support, including development libraries (unixodbc-dev, libpq-dev, gcc).

    - `apt-get install -y gnupg`: installs GNU Privacy Guard (GPG) requied for secure communication with Microsoft APT repository.

    - `apt-get install -y wget`: installs the wget command-line utility for downloading files.

    - `wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -`: downloads the Microsoft GPG key, used to verify the authenticity of Microsoft packages, and adds it to the APT keyring.

    - `wget -qO- https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list`: adds the Microsoft SQL Server APT repository configuration to a file (mssql-release.list) in the /etc/apt/sources.list.d/ directory.

    - `apt-get update`: updates the package list again, now including the newly added Microsoft repository.

    - `ACCEPT_EULA=Y apt-get install -y msodbcsql18`: installs the Microsoft ODBC Driver for SQL Server (msodbcsql18). The ACCEPT_EULA=Y environment variable is set to automatically accept the End-User License Agreement during installation.

    - `apt-get purge -y --auto-remove wget`: removes the wget package and its dependencies after it's no longer needed (--auto-remove removes automatically installed dependencies).

    - `apt-get clean`: cleans the local repository of retrieved package files that are no longer necessary.

    <span style="color:green"><sup>*</sup>Descriptions obtained with help of ChatGPT.</span>

5. `RUN pip install --upgrade pip setuptools`: upgrades  `pip` and `setuptools` to their latest versions to ensure that the subsequent Python packages installed using pip benefit from bug fixes, new features, and improvements in the package management system.

6. `RUN pip install --trusted-host pypi.python.org -r requirements.txt`: installs Python packages required to run the application, specifyng pypi.python.org as a trusted host.

7. `EXPOSE 5000`: exposes port 5000 to allow access to the Flask application from outside of the container. See [Troubleshooting](#running-the-container---truoubleshooting) section below for potenital issues with accessing 5000 port on a Mac and how to solve them.

8. `CMD ["python", "app.py]`: runs app.py file with Python.

## Build Docker image

To build the docker image run `docker build -t <image-name>` command in your temrinal, replacing `<image-name>` with name of your choice.
We chose `flask-orders-app`.

### Test containerization

To test whether your containerization was successful and the app can be accessed from the container, run the container from the pulled/newly created image. For example, to initiate the Docker container from the pulled image, execute `docker run -p 5000:5000 koko660/flask-orders-app` in your terminal/command line. Once the containers is up and running, access http://127.0.0.1:5000 in your browsers to check access to the application and test if everything is working as expected.

## Push image to Docker Hub

If you decided to create your own image, you can push to your own Docker Hub. To do this, first tag it with your username and version, e.g.:
`docker tag <your-image-name> <docker-hub-username>/<your-image-name>:<version>`
Once this is done, executing `docker push` will push the image to your the hub. (Make sure you are logged in to your Docker Hub account).
It is recommended that the newly pushed image is tested following the testing steps as described above: pull the image, run the container and test access to the application.

## Running the container - Truoubleshooting

_**Issue**_: Mac users can get an error: <span style="color:#ca1b47">_Port 5000 is already in use_</span> when trying to run the container.

_**Reason**_: Port 5000 is used by Mac for an AirPlay Receiver. 

_**Solution**_: You can either disable AirPlay Receiver from Settings > AirDrop & Handoff or you can map the container to a different port on your machine, e.g. port 5001. To do this use the following command when buildin an image: `docker run -p 5001:5000 flask-orders-app`. This will map the container port 5000 to port 5001 on your localhost.
The application will then be accessible at http://127.0.0.1:5001 rather than http://127.0.0.1:5000 as indicated by Flask.
***
_**Issue**_: When running the app, a warning message appears: <span style="color:orange">_WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested_</span>

_**Reason**_: By default Docker uses the amd64 platform, while Mac with Apple silicon processor uses an ARM platform.

_**Solution**_: To resolve this issue, you can run the container specifying the required target platform with the --platform flag, i.e.: `docker run --platform linux/amd64 -p 5000:5000 flask-orders-app`.
