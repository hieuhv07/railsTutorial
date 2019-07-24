module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end

def follow_user
	current_user.active_relationships.build
end

def unfollow_user
	current_user.active_relationships.find_by(followed_id: @user.id)
end