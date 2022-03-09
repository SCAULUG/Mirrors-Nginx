FROM locez/sphinx-builder:latest as builder

ENV DPATH="/dist"

RUN git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Help.git && \
    git clone -b master --single-branch https://github.com/SCAULUG/Mirrors-Index.git "${DPATH}/Mirrors-Index" && \
    cd /Mirrors-Help && make html && mv build/html ${DPATH}/Mirrors-Index/mirrors-help 
	
FROM welkincf/nginx-fancyindex:1.20.1-alpine
COPY --from=builder /dist/Mirrors-Index /Mirrors-Index/
RUN mkdir /mirrors \
	&& ln -s /mirrors/result /Mirrors-Index/result \
	&& ln -s /mirrors/goaccess.html /Mirrors-Index/goaccess.html \
	&& ln -s /mirrors/mirrorz.d.json /Mirrors-Index/mirrorz.d.json
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./mime.types /etc/nginx/mime.types
	
