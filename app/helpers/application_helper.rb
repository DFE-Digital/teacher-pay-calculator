module ApplicationHelper
  def footer_links
    {
      'Privacy' => privacy_notice_path,
      'Accessibility statement' => accessibility_statement_path,
      'Terms and conditions' => terms_and_conditions_path,
    }
  end
end
