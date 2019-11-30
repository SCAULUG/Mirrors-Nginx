FROM locez/sphinx-builder:latest as builder

ENV DPATH="/dist"

RUN git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Help.git && \
    git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Index.git "${DPATH}/Mirrors-Index" && \
    cd /Mirrors-Help && make html && mv build/html ${DPATH}/Mirrors-Index/mirrors-help 
	
FROM locez/nginx
COPY --from=builder /dist/Mirrors-Index /Mirrors-Index/
RUN mkdir /mirrors \
	&& ln -s /mirrors/result /Mirrors-Index/result 
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./mime.types /etc/nginx/mime.types
	
