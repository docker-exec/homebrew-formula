# Dexec is the formula for the dexec CLI.
class Dexec < Formula
  desc 'Command line interface for running code with Docker Exec images'
  homepage 'https://docker-exec.github.io/'
  head 'https://github.com/docker-exec/dexec.git'

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    mkdir 'build' do
      ENV['GOPATH'] = "#{buildpath}/build"
      # Install Go dependencies
      system 'go', 'get', '../...'

      # Build and install dexec
      system 'go', 'build', '..'
      bin.install 'dexec'
    end
  end

  test do
    assert_equal version, shell_output("#{bin}/dexec --version")
  end
end
