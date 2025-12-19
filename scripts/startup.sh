#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y nginx

cat >/var/www/html/index.html <<'HTML'
<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8" />
  <title>TP Terraform - GCP</title>
  <style>body{font-family:system-ui,Segoe UI,Roboto,Arial;margin:2rem}</style>
</head>
<body>
  <h1>✅ Hello depuis la VM : $(hostname)</h1>
  <p>Provisionnée par Terraform.</p>
</body>
</html>
HTML

systemctl enable --now nginx
