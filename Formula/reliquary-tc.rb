class ReliquaryTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/reliquary-tc"
  version "1.34.0"
  license "Apache-2.0"

  # Prebuilt Bun standalone binaries, published per-platform on every GitHub release
  # (The-40-Thieves/reliquary-tc's publish.yml). The release also ships a SHASUMS256.txt whose
  # digests match the sha256 values below (independently recomputed with `shasum -a 256` on each
  # downloaded asset, not copied from that file) and GitHub's own per-asset `digest` field
  # (`gh release view <tag> --json assets`), which agree with both. There is no cosign/sigstore
  # signature yet — the repo's publish.yml itself notes "cosign still deferred" — so sha256 pinning
  # here is the only integrity check available; revisit this comment if that changes.
  on_macos do
    on_arm do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-darwin-arm64"
      sha256 "234049e0a141be4240a5a7028a4a8e4e02606ffaabb0a626668ddbd3ab9fcb69"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-darwin-x64"
      sha256 "8cdfbaa97663db8991450e8e94af1042721a6ee6b72a012c868ebc2ec64c55aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-linux-arm64"
      sha256 "78b66ac4ccc4eda76fbee4f9104eb3a9a0f59294953bca44f8faa0488b3330da"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-linux-x64"
      sha256 "069a5c0dc28f13d24236fffa6a35abc340d7570f510ea1f9efda410cf8558bb5"
    end
  end

  def install
    # Exactly one of the URLs above resolves per platform, so exactly one asset is staged here;
    # the downloaded filename carries the platform suffix (e.g. reliquary-tc-bun-linux-arm64).
    bin.install Dir["reliquary-tc-bun-*"].first => "reliquary-tc"
    # The pre-2.0 command name keeps working through 2.x.
    bin.install_symlink "reliquary-tc" => "obsidian-tc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reliquary-tc --version")
    assert_match version.to_s, shell_output("#{bin}/obsidian-tc --version")
  end
end
