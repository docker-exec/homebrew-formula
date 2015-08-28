class Dexec < Formula
  desc "Command line interface for running code with Docker Exec images"
  homepage "https://docker-exec.github.io/"
  url "https://github.com/docker-exec/dexec.git"
  version "master"
  head "https://github.com/docker-exec/dexec.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    # Install Go dependencies
    system "go", "get", "github.com/docker-exec/dexec/cli"
    system "go", "get", "github.com/docker-exec/dexec/docker"
    system "go", "get", "github.com/docker-exec/dexec/util"
    # Build and install dexec
    system "go", "build", "-o", "dexec"
    build_version = "dev"
    bin.install "dexec"
  end

  test do
    system "#{bin}/dexec", "--version"
  end
end
