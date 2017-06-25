module ApplicationHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=retro"
    image_tag(gravatar_url, alt: user.username, class: "img-circle text-center")
  end
end

