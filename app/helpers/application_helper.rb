module ApplicationHelper

  def login_helper style = ''
    if user_signed_in?
      link_to t('logout'), destroy_user_session_path(locale: I18n.locale), method: :delete , class: style
    else
      (link_to t('login'), new_user_session_path(locale: I18n.locale), class: style) + " ".html_safe +
      (link_to t('register'), new_user_registration_path(locale: I18n.locale), class: style)
    end
  end

  def nav_items
    [
      {
        url: root_path(params[:locale]),
        title: t('.home')
      },

      {
        url: about_path(params[:locale]),
        title: t('.about')
      },

    ]
  end

  def nav_helper style, tag_type
    nav_links = ''
    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}' >#{item[:title]}</a></#{tag_type}>"
    end
    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])
    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Fix my name on the alert generator method in your application_helper", sticky: false)
  end

end
