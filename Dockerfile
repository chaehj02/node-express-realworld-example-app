FROM node:lts-alpine

ENV HOST=0.0.0.0
ENV PORT=3000

WORKDIR /app

RUN addgroup --system api && \
    adduser --system -G api api

COPY dist/api api

# 의존성 설치 및 Prisma Client 생성
RUN npm --prefix api --omit=dev -f install && \
    npx --prefix api prisma generate

RUN chown -R api:api .

USER api

CMD ["node", "api"]
