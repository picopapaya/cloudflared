FROM cloudflare/cloudflared:latest

# The base image is distroless (no shell/curl), so copy a static busybox to
# provide `wget` for the healthcheck.
COPY --from=busybox:musl /bin/busybox /bin/busybox

# Enable cloudflared's metrics server so the /ready endpoint is available.
ENV TUNNEL_METRICS=0.0.0.0:2000

# /ready returns HTTP 200 only when >=1 tunnel connection is registered (503
# otherwise), so this probe fails if connectivity to Cloudflare's edge is lost.
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD ["/bin/busybox", "wget", "-q", "-O", "/dev/null", "http://127.0.0.1:2000/ready"]

ENTRYPOINT ["cloudflared", "--no-autoupdate", "tunnel", "run"]
