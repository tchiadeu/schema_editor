require "spec_helper"
require "schema_editor/parser"

RSpec.describe SchemaEditor::Parser do
  let(:file) do
    File.read(File.expand_path('../../../fixtures/schema.rb', __FILE__))
  end

  describe '.parse_tables' do
    it "should have the good keys" do
      result = SchemaEditor::Parser.send(:parse_tables, file)
      expect(result.keys).to eq(%w[users posts])
    end
  end

  describe '.parse_foreign_keys' do
    it "should have the good foreign keys" do
      result = SchemaEditor::Parser.send(:parse_foreign_keys, file)
      expect(result).to eq({ 'posts' => [ 'users' ] })
    end
  end
end
