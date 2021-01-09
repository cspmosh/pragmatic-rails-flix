module UsersHelper
  def profile_image(user, size: 150)
    url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, size: size, alt: user.name)
  end
end
