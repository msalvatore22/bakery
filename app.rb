require "sinatra"
require "sendgrid-ruby"
include SendGrid

get "/" do
  erb :home
end

get "/muffins" do
  erb :muffins
end

get "/cookies" do
  erb :cookies
end

get "/cupcakes" do
  erb :cupcakes
end

get "/cakes" do
  erb :cakes
end

get "/thankyou" do
  erb :thankyou
end

post "/" do
p	params.inspect

from = Email.new(email: "msalvatore22@gmail.com")
to = Email.new(email: params[:email])
subject = "top muffin catalog"
content = Content.new(type: 'text/plain', value: "muffins, cookies, cupcakes" )
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)

redirect "/thankyou"
end