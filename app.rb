require 'sinatra'
require 'alexa_skills_ruby'

class CustomHandler < AlexaSkillsRuby::Handler

  on_intent("GetDeveloperExcuse") do
    response.set_output_speech_text("Developer Excuses yo")
  end

end
get '/livecheck' do
 "hello"
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