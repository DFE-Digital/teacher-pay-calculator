require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '.footer_links' do
    subject { helper.footer_links}

    let(:expected_links) do
      {
        'Privacy notice' => privacy_notice_path,
        'Accessibility statement' => accessibility_statement_path,
        'Terms and conditions' => terms_and_conditions_path,
      }
    end

    it { is_expected.to eq(expected_links) }
  end
end
