FROM node:lts-alpine

ENV HOST=0.0.0.0
ENV PORT=3000

WORKDIR /app

# 애플리케이션 소스 복사
COPY package*.json ./
COPY prisma ./prisma
COPY dist/api ./api

# 의존성 설치
RUN npm install --omit=dev

# Prisma Client 생성
RUN npx prisma generate

# 퍼미션 설정
RUN addgroup --system api && adduser --system -G api api && chown -R api:api .

USER api

EXPOSE 3000

CMD ["node", "api"]
