require 'chatwork'

module Danger
  class DangerChatwork < Plugin

    # API token to authenticate with ChatWork API
    #
    # @return [String]
    attr_writer :api_token

    def initialize(dangerfile)
      super(dangerfile)
      self.api_token = ENV['CHATWORK_API_TOKEN']
    end

    def notify(room_id:, text: '')
      return ChatWork::Message.create(room_id: room_id, body: text) unless text.empty?
      return if reports.empty?
      report = "[info][title]Danger Report[/title]#{pr_info}\n#{reports.join("\n")}[/info]"
      ChatWork::Message.create(room_id: room_id, body: report)
    end

    def api_token=(value)
      ChatWork.api_key = value
    end

    private

      def reports
        status_report.reject { |_, v| v.empty? }.map do |status, messages|
          messages = messages.map(&:message) if status == :markdowns
          <<-REPORT
#{status.to_s}
  - #{messages.join("\n  - ")}
          REPORT
        end
      end

      def pr_info
        # TODO: GitHub(Enterprise)以外のPR情報取得
        github = @dangerfile.github
        <<-INFO
#{github.pr_title} ##{github.pr_json['number']}
#{github.pr_json['html_url']}
        INFO
      end

  end
end
