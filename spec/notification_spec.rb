require 'spec_helper'

describe IonicNotification::Notification do
  subject(:notification) { IonicNotification::Notification.new }

  it { is_expected.to respond_to :tokens }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :message }
  it { is_expected.to respond_to :android_payload }
  it { is_expected.to respond_to :ios_payload }
  it { is_expected.to respond_to :production }
end
