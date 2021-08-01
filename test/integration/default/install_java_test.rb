# InSpec test for recipe tomcat::install_java

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# This is an example test, replace it with your own test.

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end
