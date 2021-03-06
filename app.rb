require 'sinatra'
require 'alexa_skills_ruby'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

class CustomHandler < AlexaSkillsRuby::Handler

  on_intent("GetDeveloperExcuse") do
    response.set_output_speech_text(get_excuse)
  end
  on_launch do
    response.set_output_speech_text(get_excuse)
  end

end
get '/livecheck' do
 "hello"
end

get '/excuse' do
  get_excuse
end



post '/' do
  content_type :json

  handler = CustomHandler.new(application_id: ENV['APPLICATION_ID'], logger: logger)

  begin
    handler.handle(request.body.read)
  rescue AlexaSkillsRuby::InvalidApplicationId => e
    logger.error e.to_s
    403
  end

end

def get_excuse
  rando = Random.rand(0..1)
  if rando == 0
    url = "http://programmingexcuses.com/"
  end
  if rando == 1
    url = "http://www.devexcuses.com/"
  end
  page = Nokogiri::HTML(open(url))
  page.css("a")[0].text
end
