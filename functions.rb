module Sites
  def sign_in(session:)
      session.visit 'https://slack.com/workspace-signin'
      session.find('#domain', visible: :all)
      session.find('.c-input_text.c-input_text--large.full_width.margin_bottom_100').click
      session.find('.c-input_text.c-input_text--large.full_width.margin_bottom_100').set(ENV['SERVER'])
      session.click_button('Continue')
      session.fill_in 'email', with: ENV['EMAIL']
      session.fill_in 'password', with: ENV['PASS']
      session.click_button('Sign in')
  end
  def interactive_message(action_url:, session:)
    session.visit("https://api.slack.com/apps/#{$slack_api_id}/interactive-messages?")
    sleep(2)
    session.fill_in 'attachment_action_url', with: action_url
    session.click_button('Reject All')
    session.click_button('Save Changes')
  end
  
  def slash_commands(slash_commands_url:, session:, number_for_command:)
    session.visit("https://api.slack.com/apps/#{$slack_api_id}/slash-commands?")
    b = session.find_all(".app_slack_commands_edit.btn_icon.btn_outline.btn.ts_icon.ts_icon_pencil.left_margin")
    sleep(3)
    b[number_for_command].click
    session.fill_in 'url', with: slash_commands_url
    session.click_button('Save')
    sleep(2)
  end
  def how_many_commands(session:)
    session.visit("https://api.slack.com/apps/#{$slack_api_id}/slash-commands?")
    session.find_all(".app_slack_commands_edit.btn_icon.btn_outline.btn.ts_icon.ts_icon_pencil.left_margin").count
  end
  def ouath(oauth_url:, session:)
    session.visit("https://api.slack.com/apps/#{$slack_api_id}/oauth?")
    session.find('.editor-button.btn_icon.btn_outline.btn.p-url_table_editor__buttons.ts_icon.ts_icon_pencil').click
    session.find('.float_left.p-url_table_editor__fields').click
    session.fill_in 'urls[0]_urls', with: oauth_url
    session.click_button('Done')
    sleep(1)
    session.click_button('Save URLs')
  end
  def event_subscription(session:, event_url:) 
    session.visit("https://api.slack.com/apps/#{$slack_api_id}/event-subscriptions?")
    session.click_button('Change')
    session.find('#request_url').click
    session.fill_in 'request_url', with: event_url
    sleep(4)
    session.click_button('Save Changes')
    
  end
end
