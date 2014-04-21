require 'spec_helper'

describe Message, :vcr => true do
  it "It doesn't save the message if twilio gives an error" do
    message = Message.new(:body => 'hi', :to => '111111', :from => "3605249359")
    message.save.should be_false
  end

  it "adds an error if the number is invalid" do
    message = Message.new(:body => 'hi', :to => '111111', :from => "3605249359")
    message.save
    message.errors[:base].should eq ["The 'To' number 111111 is not a valid phone number."]
  end
end
