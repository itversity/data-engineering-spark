services:
  lmsappserver:
    build:
      context: .
      dockerfile: Dockerfile.lmsapp.dev
    ports:
      - "5000:5000"
    volumes:
      - "./lms-app:/lms/lms-app"
    depends_on:
      - "lmsdbserver"
  lmsdbserver:
    image: postgres:13
    ports:
      - "5432:5432"
    volumes:
      - ./db_scripts:/docker-entrypoint-initdb.d
      - ./lmsdbserver_volume:/var/lib/postgresql/data
    environment:
      POSTGRES_PASSWORD: itversity