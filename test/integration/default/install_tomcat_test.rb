# InSpec test for recipe tomcat::install_tomcat

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe command('curl http://localhost:8080') do
  its('stdout') { should match(/Apache Tomcat\/8.5.69/) }
end

describe port(8080) do
  it { should be_listening }
end
