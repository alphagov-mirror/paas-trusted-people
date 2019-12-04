require 'yaml'

RSpec.describe 'users.yml' do
  let(:users_path) { File.expand_path(File.join(__dir__, '..', 'users.yml')) }
  let(:users_contents) { File.read(users_path) }

  context 'parsing users.yml' do
    it 'should be valid yaml' do
      expect { YAML.load(users_contents) }.not_to raise_error
    end
  end
end
