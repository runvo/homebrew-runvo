class Runvo < Formula
  desc "Mobile command center for AI coding agents"
  homepage "https://github.com/runvo/runvo"
  url "https://github.com/runvo/runvo/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c9811a27df7a3529d41ef9f5f1b98d6c3fd77c07c1344d798fcf118e0018f7cf"
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
      Run 'runvo setup' to add your first project.

      Usage:
        runvo          Interactive menu
        runvo new      Create new project
        runvo 1        Open project #1
        runvo help     Full help
    EOS
  end

  test do
    assert_match "runvo", shell_output("#{bin}/runvo version 2>&1", 1)
  end
end
