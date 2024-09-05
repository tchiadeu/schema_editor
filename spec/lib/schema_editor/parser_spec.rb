require "spec_helper"
require "schema_editor/parser"

RSpec.describe SchemaEditor::Parser do
  let(:file) do
    File.read(File.expand_path('../../../fixtures/schema.rb', __FILE__))
  end

  describe '.parse_tables' do
    it "should have the good keys" do
      result = SchemaEditor::Parser.send(:parse_tables, file)
      expect(result.keys.sort).to eq(%w[users posts comments articles tests].sort)
    end
  end

  describe '.parse_foreign_keys' do
    it "should have the good foreign keys" do
      result = SchemaEditor::Parser.send(:parse_foreign_keys, file)
      expect(result).to eq({ 'users' => 3, 'posts' => 1 })
    end
  end

  describe '.extract' do
    it 'should order the hash by reference occurrences' do
      result = SchemaEditor::Parser.extract(file)
      expect(result.keys[0]).to eq('users')
      expect(result.keys[1]).to eq('posts')
    end
  end
end
