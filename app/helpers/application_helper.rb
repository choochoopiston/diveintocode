module ApplicationHelper
    
    def profile_img(user)
	    if user.image.present?
		img_url = user.image
	    elsif user.provider == 'facebook'
		img_url = "https://graph.facebook.com/#{user.uid}/picture?width=73&height=73"
	    elsif user.provider == 'twitter'
		img_url = user.profile_image_url
		img_url.slice!("_bigger") || img_url.slice!("_normal")
	    else
		img_url = "noimage.png"
		end
        image_tag(img_url, alt: user.name, size: '73x73')
    end

end
