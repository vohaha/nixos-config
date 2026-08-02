---
name: project-context
description: Summarize this NixOS config repo's current state — hosts, inputs, enabled modules, home-manager programs, and installed tool versions. Use at the start of a session, after /clear, or whenever you need a quick "what's actually configured here" overview instead of relying on memory or stale docs.
---

# Project context snapshot

This repo (`nixos-config`) changes fast and AGENTS.md already warns against
configuring tools from memory. Don't answer from memory or a previous run's
output — regenerate this snapshot fresh every time.

## For any agent (Claude Code or otherwise)

Run the agent-agnostic script directly, no harness-specific loading required:

```
.agents/skills/project-context/context.sh
```

It prints: flake inputs and lock revisions, hosts and their imported system
modules, which `modules/nixos/*.nix` flags are actually enabled, the
home-manager modules imported in `home/vh/default.nix`, installed versions of
fast-moving tools (nh, Hyprland, Zed, etc.) to cross-check against config
claims, recent commits, and working-tree status.

## Claude Code specifics

After running the script, also:

- Cross-reference anything version-sensitive with `nix flake check --no-build`
  — deprecation warnings there are authoritative over the script's grep-based
  output.
- If something looks stale (a module file present but never imported, or an
  option the flake check flags as deprecated), call it out in the summary.
- Report as a compact prose/bulleted summary in the conversation — do not
  write the snapshot to a memory file or doc; the point is that it's
  regenerated fresh each time.
