# 基础镜像
FROM python:alpine

# 配置镜像地址
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories
# 设置时区
RUN apk add --no-cache tzdata && \
          echo "Asia/Shanghai" > /etc/timezone && \
          TZ=Asia/Shanghai && \
          ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装项目环境依赖
RUN apk add --no-cache gcc libc-dev

ADD . /usr/src/app
WORKDIR /usr/src/app


RUN pip install --no-cache-dir -r requirements.txt

ENV PORT 80
EXPOSE $PORT/tcp


CMD ["python","/usr/src/app/run.py"]

