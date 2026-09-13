class ObsidianTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/obsidian-tc"
  version "1.29.0"
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
      sha256 "9b238c616cf2e7b79ea21302634fef09079633115149a24921a4aa9ac6a9a52d"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-x64"
      sha256 "c68109f1901bfed264e9f36fcfce273fe8ebba5df5ab133e4b7ee23434dfd053"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-arm64"
      sha256 "de6d28b09fd4b5f80cca404480daf416e17ad9a0c765845c6da4de88dc256370"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-x64"
      sha256 "02a46be32741f6fc42a1c0b28dfd5c1deb4160bfb3644f8d9c730bd4cd35f1df"
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
