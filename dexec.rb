# Dexec is the formula for the dexec CLI.
class Dexec < Formula
  desc 'Command line interface for running code with Docker Exec images'
  homepage 'https://docker-exec.github.io/'
  head 'https://github.com/docker-exec/dexec.git'

  depends_on 'go' => :build

  def install
    ENV['GOPATH'] = buildpath

    # Install Go dependencies
    system 'go', 'get', 'github.com/docker-exec/dexec/cli'
    system 'go', 'get', 'github.com/docker-exec/dexec/util'
    system 'go', 'get', 'github.com/docker-exec/dexec/dexec'

    # Build and install dexec
    system 'go', 'build', '-o', 'dexec'
    bin.install 'dexec'
  end

  test do
    assert_equal version, shell_output("#{bin}/dexec --version")
  end
end
