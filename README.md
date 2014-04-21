#API Practice

##twilio application with environmental variables.



Use REST client to make HTTP requests.

Example request:

response = RestClient.post(
  'https://AC3e0af22b6b772460f352ba8c6586fbde:e04f17e88eb7b8c81feb1b951dcd7a2f@api.twilio.com/2010-04-01/Accounts/AC3e0af22b6b772460f352ba8c6586fbde/Messages.json',
  :Body => 'Hello world!',
  :To => '5038629187',
  :From => '5039463641'
)
Alternate, easier-to-understand syntax:

response = RestClient::Request.new(
  :method => :post,
  :url => 'https://api.twilio.com/2010-04-01/Accounts/AC3e0af22b6b772460f352ba8c6586fbde/Messages.json',
  :user => 'AC3e0af22b6b772460f352ba8c6586fbde',
  :password => 'e04f17e88eb7b8c81feb1b951dcd7a2f',
  :payload => { :Body => 'Hello world!',
                :To => '5038629187',
                :From => '5039463641' }
).execute

Turn the response into hashes and arrays:

```ruby
parsed_response = JSON.parse(response)
Take sensitive info out of your app and replace it with environmental variables:

ENV['TWILIO_ACCOUNT_SID']
Set the environmental variables in a .env file:

TWILIO_ACCOUNT_SID=AC3e0af22b6b772460f352ba8c6586fbde
and on Heroku:

$ heroku config:set TWILIO_ACCOUNT_SID=AC3e0af22b6b772460f352ba8c6586fbde
Add the dotenv-rails' to your test and development groups in your Gemfile.

For testing, add vcr and webmock to your test group in your Gemfile, and these lines to your spec_helper:

spec/spec_helper.rb
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<twilio account sid>') { ENV['TWILIO_ACCOUNT_SID'] } # example for filtering data
end
Enable VCR for a group of specs:

describe Message, :vcr => true do
...
or a particular spec:

it 'adds an error if the to number is invalid', :vcr => true do
...

