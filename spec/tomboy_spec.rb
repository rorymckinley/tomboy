require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubygems'

describe "Reading a Tomboy note file" do
  before(:each) do
    @note_path = File.join(File.dirname(__FILE__), 'fixtures', 'read_tomboy_note.note')
  end

  it "should instantiate itself based on an existing Tomboy note file" do
    Tomboy.read(@note_path).should be_an_instance_of Tomboy
  end

  it "should instantiate itself and contain the content of the tomboy note" do
    Tomboy.read(@note_path).content.should == 'This is my fixture content'
  end

  it "should be able to return the title of the note" do
    Tomboy.read(@note_path).title.should == 'This is my fixture title'
  end
end

describe "Writing to a Tomboy note file" do
  before(:each) do
    @benchmark_path = File.join(File.dirname(__FILE__), 'fixtures', 'benchmark.note')
    @written_note_path = '/tmp/written_tomboy_note.note'
    File.delete if File.exist? @written_note_path
  end

  it "should create a tomboy note from a simple string" do
    t = Tomboy.write('This is my fixture content', @written_note_path)
    t.should be_an_instance_of Tomboy
    t.content.should == 'This is my fixture content'
  end

  it "should create the note in the location specified" do
    Tomboy.write('This is my fixture content', @written_note_path)
    File.exist?(@written_note_path).should be_true
  end

  it "should create the note so that it complies with the Tomboy XML schema" do
    schema_contents = IO.read(File.join(File.dirname(__FILE__), 'fixtures', 'valid_note.xsd'))
    schema_contents.gsub!(/__REL_FILE_PATH__/, File.join(File.dirname(__FILE__), 'fixtures'))
    schema = Nokogiri::XML::Schema.new(schema_contents)

    Tomboy.write('This is my fixture content', @written_note_path)

    written_xml = nil

    File.open(@written_note_path) do |file|
      written_xml = Nokogiri::XML(file)
    end

    schema.valid?(written_xml).should be_true
  end
end
