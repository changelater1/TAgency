module ApplicationHelper
  def switch_locale_path
    new_locale = I18n.locale == :ru ? 'en' : 'ru'
    request.original_url.gsub(/\/(ru|en)\//, "/#{new_locale}/")
  end
end
