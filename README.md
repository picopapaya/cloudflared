# cloudflared

Docker image that runs a **Cloudflare named tunnel** using the official [`cloudflare/cloudflared`](https://hub.docker.com/r/cloudflare/cloudflared) image with an added healthcheck.

## What it is

Cloudflare Tunnel creates an outbound-only connection from a service inside your network to Cloudflare's edge, without opening inbound firewall ports. This image wraps the official `cloudflared` binary and connects to a pre-configured named tunnel using a `TUNNEL_TOKEN`.

In this setup it routes external traffic into services on the `llm-net` Docker network.

## Requirements

- Docker with access to the `llm-net` network: `docker network create llm-net`
- A `TUNNEL_TOKEN` from Cloudflare Zero Trust → Networks → Tunnels → create or select a tunnel → Docker → copy the token

## Usage

```bash
TUNNEL_TOKEN=eyJ... docker compose up --build
```

## Configuration

| Variable | Default | Description |
|---|---|---|
| `TUNNEL_TOKEN` | *(required)* | Token for the named Cloudflare tunnel |

## License

MIT — see [LICENSE](LICENSE).
