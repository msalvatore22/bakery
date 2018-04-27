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
subject = "Top Muffin Catalog"
content = Content.new(type: 'text/html', value: "

<h1>Thank you #{params[:name]}, here is our current catalog.</h1>
<h3>Top Muffins</h3>
<ul>
	<li>Pumpkin | $3.00</li>
	<li>Chocolate | $3.00</li>
	<li>Chocolate Chip | $3.00</li>
	<li>Apple | $3.00</li>
	<li>Poppy Seed | $3.00</li>
	<li>Blueberry | $3.00</li>
</ul>
<h3>Cupcakes</h3>
<ul>
	<li>Strawberry | $4.00</li>
	<li>Chocolate | $4.00</li>
	<li>Vanilla | $4.00</li>
	<li>Carrot Cake | $4.00</li>
	<li>Bacon Frosting | $5.00</li>
	<li>Strawberry Short-Cake | $5.00</li>
</ul>
<h3>Cookies</h3>
<ul>
	<li>Chocolate Chip | $2.50</li>
	<li>Double Chocolate Chip | $2.50</li>
	<li>Peanut Butter Chocolate | $2.50</li>
	<li>Peanut Butter | $2.50</li>
	<li>M&ampM | $2.50</li>
	<li>Oatmeal | $2.50</li>
</ul>
<h3>Cakes</h3>
<ul>
	<li>Chocolat Mousse Cake | $18.00</li>
	<li>Strawberry Short-Cake | $22.00</li>
	<li>Carrot Cake | $18.00</li>
	<li>Tiramisu | $24.00</li>
	<li>Cheesecake | $22.00</li>
	<li>Tart Cakes | $16.00</li>
</ul>
<h2>Thank you for joining our email list!</h2>" )

mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)

redirect "/thankyou"
end