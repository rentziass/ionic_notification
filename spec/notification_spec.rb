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
      empty_payload = { payload: {} }
      expect(notification.android_payload).to eq empty_payload
    end

    it "has ios_payload defaulting to Hash" do
      notification = create_default_notification
      empty_payload = { payload: {}  }
      expect(notification.ios_payload).to eq empty_payload
    end

    it "assigns both payloads if a common one is given" do
      payload = { first: "pair" }
      notification = create_default_notification payload: payload
      expected_payload = { payload: payload }
      expect(notification.android_payload).to eq expected_payload
      expect(notification.ios_payload).to eq expected_payload
    end

    it "common payload is overwritten by a specfic one" do
      payload = { first: "pair" }
      ios_payload = { os: "ios" }
      android_payload = { os: "android" }

      # IOS
      notification = create_default_notification(
        payload: ios_payload
      )
      expected_payload = { payload: ios_payload }
      expect(notification.ios_payload).to eq expected_payload

      # Android
      notification = create_default_notification(
        payload: payload, android_payload: android_payload
      )
      expected_payload = { payload: android_payload }
      expect(notification.android_payload).to eq expected_payload
    end

    it "raises an error if a non hash is given as payload" do
      expect {
        create_default_notification payload: "I'm no hash"
      }.to raise_error IonicNotification::WrongPayloadType
    end
  end

  def create_default_notification(options = {})
    IonicNotification::Notification.new(
      { tokens: %w(asdf, fdsa) }.merge! options
    )
  end

  def create_notification(options = {})
    IonicNotification::Notification.new(options)
  end
end
