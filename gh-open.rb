require 'formula'

HOMEBREW_GHOPEN_VERSION='0.1'
class GhOpen < Formula
  homepage "https://github.com/typester/gh-open"
  version "0.1"

  if OS.mac?
    url "https://github.com/typester/gh-open/releases/download/v#{HOMEBREW_GHOPEN_VERSION}/gh-open_#{HOMEBREW_GHOPEN_VERSION}_darwin_amd64.zip"
    sha256 "8bded1409b6252d915f4d364ae363f4b425c4721d2a281ce572b556734356c9d"
  end

  version HOMEBREW_GHOPEN_VERSION
  head 'https://github.com/typester/gh-open', :using => :git, :branch => 'master'

  if build.head?
    depends_on 'go' => :build
  end

  def install
    if build.head?
      gopath = buildpath/'.go'

      ( gopath/'src/github.com/typester/gh-open' ).make_relative_symlink buildpath

      ENV['GOPATH'] = gopath
      system 'go', 'get', 'github.com/typester/gh-open'
      system 'go', 'build', 'github.com/typester/gh-open'
    end

    bin.install 'gh-open'
  end
end
