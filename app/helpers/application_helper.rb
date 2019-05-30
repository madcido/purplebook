module ApplicationHelper
    def gravatar_url(email)
      gravatar = Digest::MD5::hexdigest(email).downcase
      url = "http://gravatar.com/avatar/#{gravatar}.png"
    end

    def contained(str)
      str.length > 20 ? str[0..17] + "..." : str
    end
end
