require 'yaml'

RSpec.describe 'users.yml' do
  let(:users_path) { File.expand_path(File.join(__dir__, '..', 'users.yml')) }
  let(:users_contents) { File.read(users_path) }

  context 'parsing users.yml' do
    it 'should be valid yaml' do
      expect { YAML.load(users_contents) }.not_to raise_error
    end
  end

  context 'users and roles' do
    let(:team_roles) { YAML.load(users_contents).dig('meta', 'team_roles') }
    let(:users) { YAML.load(users_contents)['users'] }

    it 'should not give auditors any dangerous permissions in any accounts' do
      auditor_access_role = team_roles.dig('auditor_access')

      roles = auditor_access_role.values.flatten.map { |r| r['role'] }.uniq

      expect(roles).not_to include('bosh-admin')
      expect(roles).not_to include('cf-admin')
      expect(roles).not_to include('grafana-admin')

      expect(roles.grep(/admin/)).to be_empty
    end
  end
end
