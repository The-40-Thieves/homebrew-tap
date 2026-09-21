class ObsidianTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/obsidian-tc"
  version "1.31.2"
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
      sha256 "85db9c8e5e77d94546af65e14bafb12afdd29a3eeaab3560a4a37c63a0cbed3d"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-x64"
      sha256 "c207ffeae3b7f15ba9b2ab613462f2e415243b0e7403bbff76f16fb3505ea870"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-arm64"
      sha256 "719723cd87d4d04ccf60a0e1fa4208c43d48d2e742330392b542d0de56423360"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-x64"
      sha256 "20e1f96f3876b1cfb1a377b75ef36521e290dada57d2cdffbece9d550d29ab62"
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
