class Senn < Formula
  desc "Git-native infrastructure for single operators, built on Nix and OpenTofu."
  homepage "https://github.com/mrbandler/senn"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrbandler/senn/releases/download/v0.2.0/senn-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c5527bdb0f7d84e0aab92064ee0cabbc5e841ca49b15de51f09bbca615ba868f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrbandler/senn/releases/download/v0.2.0/senn-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bf4e4e9a851451409612fc5bd874c96414150df57a2f7264b390fde4cebc3c9f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrbandler/senn/releases/download/v0.2.0/senn-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1969ef549d141dcb3fada276c573a2112f9e5cbe2613885d381a26e46eb6d08f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrbandler/senn/releases/download/v0.2.0/senn-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c55cec33b4f32ca710b13b07d3c5c5fba7fe4477fa7a36f01a3378f0be99138"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "senn"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "senn"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "senn"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "senn"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
