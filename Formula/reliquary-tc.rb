class ReliquaryTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/reliquary-tc"
  version "2.0.1"
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
      sha256 "cf0e7ab5e2c1d9f7ad5f3681fd1669ce09c25b4e5fa9d53ae8e16060321d9893"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-darwin-x64"
      sha256 "c728d5bc85c2600292b969c9ac6e8de74d01efe8071afcba2890901a7d787ad6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-linux-arm64"
      sha256 "6365689878b0ffa7e9f56b52e6744a2616642d75246a942081dc5451405a1210"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/reliquary-tc/releases/download/v#{version}/reliquary-tc-bun-linux-x64"
      sha256 "b1b1ee21b376e2b857c59b67bcd7f31d2e9ae7db85204586c6ba3d7f1ed9ebad"
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
