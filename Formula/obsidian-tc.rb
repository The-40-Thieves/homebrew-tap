class ObsidianTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/obsidian-tc"
  version "1.32.0"
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
      sha256 "6103d07f5f084f9b15c1b11f31b75626dee18d673b9bc661a9c621976078fb80"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-x64"
      sha256 "d0873410a8aff1cccd506df9c57985dcd60456b72a4f27c5c027c2d41fcbc00d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-arm64"
      sha256 "4c0f22a6faba5b29ad719997dd554eea077001cd0438260cf913250029e19e93"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-x64"
      sha256 "28937703da21cd96b2d09dce5cc32d41fe9de94f3efe1e96845db38dcea249b1"
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
