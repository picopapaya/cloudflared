FROM cloudflare/cloudflared:latest

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD cloudflared tunnel info 2>/dev/null || exit 1

ENTRYPOINT ["cloudflared", "--no-autoupdate", "tunnel", "run"]
