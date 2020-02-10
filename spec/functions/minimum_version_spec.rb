require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '7.0.0') < 0
  describe 'minimum_version' do
    let(:pre_condition) do
      'function puppetdb_query($query) {
        return [
          {certname => \'puppet\', package_name => \'openssl\', version => \'2.1.2\', provider => \'puppet_gem\'},
          {certname => \'puppet\', package_name => \'openssl\', version => \'2.1.2\', provider => \'gem\'},
          {certname => \'puppet\', package_name => \'openssl\', version => \'1:1.0.1e-58.el7\', provider => \'yum\'}
        ]
      }'
    end

    it { is_expected.not_to eq(nil) }
    it { is_expected.to run.with_params.and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params(100).and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params('openssl').and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params([]).and_raise_error(ArgumentError) }
    it { is_expected.to run.with_params('openssl', '1:1.0.1a-00.el7').and_return('1:1.0.1e-58.el7') }
    it { is_expected.to run.with_params('openssl', '1:1.0.1a-00.el7', 'latest').and_return('1:1.0.1e-58.el7') }
    it { is_expected.to run.with_params('openssl', '1:1.0.1a-00.el7', 'latest', 'yum').and_return('1:1.0.1e-58.el7') }
    it { is_expected.to run.with_params('openssl', '1:1.0.2k-19.el7').and_return('1:1.0.2k-19.el7') }
    it { is_expected.to run.with_params('openssl', '1:1.0.2k-19.el7', 'latest').and_return('latest') }
    it { is_expected.to run.with_params('openssl', '1:1.0.2k-19.el7', '1:1.0.2k-19.el7', 'yum').and_return('1:1.0.2k-19.el7') }
    it { is_expected.to run.with_params('openssl', '1:1.0.2k-19.el7', 'latest', 'yum').and_return('latest') }
    it { is_expected.to run.with_params('openssl', '2.1.1', '2.1.1', 'gem').and_return('2.1.2') }
    it { is_expected.to run.with_params('openssl', '2.1.1', 'latest', 'gem').and_return('2.1.2') }
    it { is_expected.to run.with_params('openssl', '2.1.3', '2.1.3', 'gem').and_return('2.1.3') }
    it { is_expected.to run.with_params('openssl', '2.1.3', 'latest', 'gem').and_return('latest') }
  end
end
