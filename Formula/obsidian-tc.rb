class ObsidianTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/obsidian-tc"
  version "1.31.8"
  license "AGPL-3.0-only"

  # Prebuilt Bun standalone binaries, published per-platform on every GitHub release
  # (The-40-Thieves/obsidian-tc's publish.yml). The release also ships a SHASUMS256.txt whose
  # digests match the sha256 values below (independently recomputed with `shasum -a 256` on each
  # downloaded asset, not copied from that file) and GitHub's own per-asset `digest` field
  # (`gh release view <tag> --json assets`), which agree with both. There is no cosign/sigstore
  # signature yet — the repo's publish.yml itself notes "cosign still deferred" — so sha256 pinning
  # here is the only integrity check available; revisit this comment if that changes.
  on_macos do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-arm64"
      sha256 "a75e90d03834bab345819d86e08cd870648cb4ccd53e31071f02bfd1353e4a2a"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-x64"
      sha256 "9a54fa4a34901d8ebb194aa5b79ce9a8f745d31af7851655e32414a456be1999"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-arm64"
      sha256 "88e02e1513e735e27f0f9e12da9f0a59809a03f067a66efe7e552463de948260"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-x64"
      sha256 "5713e5a59f4dfc8777a911e146234be8046c9076954522aafb59812176653749"
    end
  end

  def install
    # Exactly one of the URLs above resolves per platform, so exactly one asset is staged here;
    # the downloaded filename carries the platform suffix (e.g. obsidian-tc-bun-linux-arm64).
    bin.install Dir["obsidian-tc-bun-*"].first => "obsidian-tc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/obsidian-tc --version")
  end
end
