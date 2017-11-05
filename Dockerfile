FROM alpine:latest AS builder

ENV DPATH="/dist"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
	apk update && apk add --no-cache py-pip git make gcc g++ linux-headers libc-dev&& \
	rm -rf /var/cache/apk/* && \
	pip install -i https://pypi.tuna.tsinghua.edu.cn/simple sphinx sphinx-autobuild sphinx_rtd_theme && \
	git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Help.git && \
	git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Index.git "${DPATH}/Mirrors-Index" && \
	cd /Mirrors-Help && make html && mv build/html ${DPATH}/Mirrors-Help 
	

	
