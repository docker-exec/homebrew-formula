# Dexec is the formula for the dexec CLI.
class Dexec < Formula
  desc 'Command line interface for running code with Docker Exec images'
  homepage 'https://docker-exec.github.io/'
  head 'https://github.com/docker-exec/dexec.git'

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    ENV['GOPATH'] = buildpath
    ENV['GO15VENDOREXPERIMENT'] = "1"

    require 'fileutils'
    FileUtils.mkdir_p("#{buildpath}/src/github.com/docker-exec")

    mkdir "#{buildpath}/src/github.com/docker-exec/dexec" do
      Dir.entries("#{buildpath}")
        .delete_if { |x| x == 'src' || /^\.+$/ =~ x }
        .each { |x|
          FileUtils.mv("#{buildpath}/#{x}", "#{buildpath}/src/github.com/docker-exec/dexec/#{x}")
        }

      system 'go', 'install'
    end

    bin.install "#{buildpath}/bin/dexec"
  end

  test do
    assert_equal version, shell_output("#{bin}/dexec --version")
  end
end
