# 베이스 이미지 설정
FROM node:lts-alpine

# 환경 변수 설정
ENV HOST=0.0.0.0
ENV PORT=3000

# 작업 디렉터리 설정
WORKDIR /app

# 시스템 사용자 생성
RUN addgroup --system api && \
    adduser --system -G api api

# 패키지 파일 복사 및 의존성 설치
COPY package*.json ./
COPY src/prisma ./prisma
RUN npm install

# 빌드 결과물 복사 (nx build 결과물이 이 경로에 생성된다고 가정)
COPY dist/api ./api

# Prisma client 생성 (⚠️ schema.prisma 경로 확인)
RUN npx prisma generate --schema=./prisma/schema.prisma

# 권한 설정
RUN chown -R api:api .

# 실행
CMD ["node", "api"]
