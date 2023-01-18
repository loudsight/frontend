FROM localhost:5000/loudsight/dev-container:0.0.1

USER uknown

COPY .build/opt /opt/
RUN sudo mknod /opt/frontend/backpipe p && sudo chown -R uknown:uknown /opt/frontend/



ENTRYPOINT /opt/frontend/entrypoint.sh
