require File.expand_path("../spec_helper", __FILE__)

module Danger
  describe Danger::DangerChatwork do
    it 'should be a plugin' do
      expect(Danger::DangerChatwork.new(nil)).to be_a Danger::Plugin
    end

    describe 'ChatWork.api_key assigning' do
      subject { ChatWork }

      context 'via initializer' do
        it { is_expected.to receive(:api_key=).with('INIT_API_TOKEN') }

        after do
          ENV['CHATWORK_API_TOKEN'] = 'INIT_API_TOKEN'
          Danger::DangerChatwork.new(nil)
          ENV['CHATWORK_API_TOKEN'] = nil
        end
      end

      context 'via setter' do
        plugin = Danger::DangerChatwork.new(nil)
        it { is_expected.to receive(:api_key=).with('HALFWAY_API_TOKEN') }
        after { plugin.api_token = 'HALFWAY_API_TOKEN' }
      end
    end

    describe 'notify' do
      context 'with specified text' do
        plugin = Danger::DangerChatwork.new(nil)
        subject { ChatWork::Message }
        it { is_expected.to receive(:create).with(room_id: 12345, body: 'BODY_TEXT') }
        after { plugin.notify(room_id: 12345, text: 'BODY_TEXT') }
      end
    end

    xdescribe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @plugin = @dangerfile.chatwork
      end

      describe 'notify' do
        context 'with no reports' do
          plugin = Danger::DangerChatwork.new(nil)
          it { is_expected.to_not receive(:create) }
          after { plugin.notify(room_id: 12345) }
        end
      end
    end

  end
end
