def asset_url(resource, asset_name)
  host = "https://#{Refile.cdn_host || default_host}"
  Refile.attachment_url(resource, asset_name, host: host)
end

collection @user
attributes :id,
  :username,
  :role,
  :created_at,
  :last_sign_in_at,
  :slug,
  :first_name,
  :last_name,
  :email,
  :newsletter,
  :website,
  :graetzl_id,
  :avatar_content_type,
  :avatar do |u|
    asset_url(u, :avatar)
  end
