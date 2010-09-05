require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubygems'

describe "Reading a Tomboy note file" do
  before(:all) do
    @note_path = File.join(File.dirname(__FILE__), 'fixtures', 'read_tomboy_note.note')
  end
  it "should instantiate itself based on an existing Tomboy note file" do
    Tomboy.read(@note_path).should be_an_instance_of Tomboy
  end
  it "should instantiate itself and contain the content of the tomboy note" do
    Tomboy.read(@note_path).content.should == 'This is my fixture content'
  end
end
