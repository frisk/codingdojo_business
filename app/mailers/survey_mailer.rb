class SurveyMailer < ActionMailer::Base
  default from: "from@example.com"

  def survey_email(info)
  	@info = info
  	mail(to: @info[:to], from: @info[:from], :subject => @info[:subject])
  end
end
