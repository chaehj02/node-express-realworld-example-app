FROM node:lts-alpine

# OpenSSL 1.1 설치
RUN apk add --no-cache openssl1.1-compat

ENV HOST=0.0.0.0
ENV PORT=3000

WORKDIR /app

RUN addgroup --system api && \
    adduser --system -G api api

COPY package*.json ./
COPY src/prisma ./prisma
RUN npm install
RUN npx prisma generate --schema=./prisma/schema.prisma

COPY dist/api ./api
RUN chown -R api:api .

CMD ["node", "api"]
