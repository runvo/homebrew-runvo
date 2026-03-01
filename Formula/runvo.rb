class Runvo < Formula
  desc "Mobile command center for AI coding agents"
  homepage "https://github.com/runvo/runvo"
  url "https://github.com/runvo/runvo/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "5ed3fe9d10debaf14f2dbe46ece1786b4f1bc2977fd8551c484db1f4f14ca24e"
  license "AGPL-3.0-or-later"

  depends_on "tmux"

  def install
    libexec.install "runvo.sh", "setup.sh", "install.sh"
    libexec.install "prompts"

    # Create wrapper script
    (bin/"runvo").write <<~EOS
      #!/bin/bash
      exec bash "#{libexec}/runvo.sh" "$@"
    EOS
  end

  def post_install
    # Create user config dirs
    (var/"runvo/prompts/custom").mkpath
  end

  def caveats
    <<~EOS
      Next steps:

      1. Install an AI agent (if you haven't):
           npm i -g @anthropic-ai/claude-code   (Claude Code)
           pip install aider-chat                (Aider)

      2. Add your first project:
           runvo add my-app ~/Projects/my-app "My App"

      3. Start coding:
           runvo

      Phone access (optional):
           brew install --cask tailscale
           Guide: https://runvo.github.io

      More: runvo help | https://runvo.github.io
    EOS
  end

  test do
    assert_match "runvo", shell_output("#{bin}/runvo version 2>&1")
  end
end
