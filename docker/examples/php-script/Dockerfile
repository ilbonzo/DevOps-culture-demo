FROM php:7.4-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./script.php" ]













# docker build -t my-php-app .

# docker run -it --rm --name my-running-app my-php-app


# run without dockerfile
# docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.4-cli php script.php