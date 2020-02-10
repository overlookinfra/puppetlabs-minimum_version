require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '7.0.0') < 0
  describe 'minimum_version' do
    let(:facts) { { operatingsystem: 'RedHat', operatingsystemmajrelease: '7' } }
    let(:pre_condition) do
      'function puppetdb_query($query) {
        return [
          {certname => \'puppet\', package_name => \'openssl\', version => \'2.1.2\', provider => \'puppet_gem\'},
          {certname => \'puppet\', package_name => \'openssl\', version => \'2.1.2\', provider => \'gem\'},
          {certname => \'puppet\', package_name => \'openssl\', version => \'1:1.0.2k-19.el7\', provider => \'yum\'}
        ]
      }'
    end

    it { is_expected.not_to eq(nil) }
    it { is_expected.to run.with_params.and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params(100).and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params('python').and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params([]).and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params('python', '2.7.5-77.el7_6').and_return('2.7.5-77.el7_6') }
  end
end
