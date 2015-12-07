require 'spec_helper'

describe IonicNotification::Notification do
  subject(:notification) {
    create_default_notification
  }

  it { is_expected.to respond_to :tokens }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :message }
  it { is_expected.to respond_to :android_payload }
  it { is_expected.to respond_to :ios_payload }
  it { is_expected.to respond_to :production }

  context "initialize" do

    describe "tokens" do
      it "raises an error if given is not Array or String" do
        expect{ IonicNotification::Notification.new }.to raise_error(IonicNotification::WrongTokenType)
      end

      it "takes an array" do
        array = ["array", "of", "beautiful", "tokens"]
        notification = create_notification(tokens: array)
        expect(notification.tokens).to match_array array
      end

      it "creates an array if a string is provided" do
        string = "a_beautiful_lonely_token"
        notification = create_notification(tokens: string)
        expect(notification.tokens).to match_array [string]
      end
    end

    it "title defaults to configured app name" do
      IonicNotification.ionic_app_name = "AppName"
      notification = create_default_notification
      expect(notification.title).to eq "AppName"
    end

    it "should have a default message if none is given" do
      notification = create_default_notification
      expect(notification.message).not_to be_nil
      expect(notification.message).to be_a_kind_of String
    end

    it "has android_payload defaulting to Hash" do
      notification = create_default_notification
      expect(notification.android_payload).to eq {}
    end
  end

  def create_default_notification
    IonicNotification::Notification.new(tokens: ["asdf", "fdsa"])
  end

  def create_notification(options = {})
    IonicNotification::Notification.new(options)
  end
end
