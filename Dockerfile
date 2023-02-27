FROM sandeep4642/angular14:1

RUN  mkdir /apps

COPY . /apps

WORKDIR /apps

EXPOSE 8000

CMD ["ng", "serve", "--port", "8000"]
