class Notifications::NewLocationPost < Notification

  TRIGGER_KEY = 'post.create'
  BITMASK = 2

  def self.receivers(activity)
    User.where(graetzl_id: activity.trackable.graetzl_id)
  end

  def self.condition(activity)
    activity.trackable.author.is_a?(Location)
  end

  def self.description
    'Eine Location aus meinem Grätzl hat eine Neuigkeit erstellt'
  end

  def mail_vars
    {
      type: type.demodulize.underscore,
      post_title: activity.trackable.title,
      post_content: activity.trackable.content.truncate(255, separator: ' '),
      owner_name: activity.trackable.author.name,
      owner_avatar_url: Notifications::AvatarService.new(activity.trackable.author).call,
      owner_url: graetzl_location_url(activity.trackable.author.graetzl, activity.trackable.author, DEFAULT_URL_OPTIONS),
      post_url: graetzl_location_url(activity.trackable.graetzl, activity.trackable.author, DEFAULT_URL_OPTIONS),
    }
  end

  def mail_subject
    "Neuer Beitrag im Grätzl #{activity.trackable.graetzl.name}"
  end
end
