require 'nokogiri'

class Tomboy
  def self.read(path)
    tomboy = nil
    File.open(path) do |file|
      tomboy = new(Nokogiri::XML(file))
    end
    tomboy
  end
  def initialize(note_obj)
    @note_obj = note_obj
  end
  def content
    @note_obj.xpath('//bns:note-content', { "bns" => "http://beatniksoftware.com/tomboy"}).text
  end
  def self.write(note_content, note_path)
    xml_builder = seed_template_with note_content
    File.open(note_path, 'w') do |file|
      file.write(xml_builder.to_xml)
    end
    new(xml_builder.doc)
  end

  private

  def self.seed_template_with(note_content)
    Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
      xml.note( 'version' => "0.3", 'xmlns:link' => "http://beatniksoftware.com/tomboy/link", 'xmlns:size'=> "http://beatniksoftware.com/tomboy/size", 'xmlns' => "http://beatniksoftware.com/tomboy") do
        xml.text_ do
          xml.send("note-content".to_sym, note_content, 'version' => "0.1")
        end
      end
    end
  end
end
