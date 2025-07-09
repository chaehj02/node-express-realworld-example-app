FROM node:lts-slim

# 필수 의존성 설치
RUN apt-get update && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*

ENV HOST=0.0.0.0
ENV PORT=3000

WORKDIR /app

COPY package*.json ./
COPY src/prisma ./prisma

RUN npm install
RUN npx prisma generate --schema=./prisma/schema.prisma

COPY dist/api ./api

CMD ["node", "api"]
