require 'spec_helper'

context "baseimage" do
  before(:all) do
    set :os, :family => 'debian'
    image = Docker::Image.get(ENV['IMAGE'])
    set :docker_image, image.id
  end

  context "OS Version" do
    describe file('/etc/os-release') do
      its(:content) { should match /ID=debian/ }
      its(:content) { should match /VERSION=\"8 \(jessie\)\"/ }
    end
  end

  context "Environment" do
    describe command('echo $DEBIAN_FRONTEND') do
      its(:stdout) { should match /noninteractive/ }
    end
  end
end
