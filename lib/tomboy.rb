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
    @note_obj.css('note-content').text
  end
end
