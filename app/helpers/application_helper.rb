module ApplicationHelper
    def gravatar_url(email)
        gravatar = Digest::MD5::hexdigest(email).downcase
        url = "http://gravatar.com/avatar/#{gravatar}.png"
    end

    def avatar_for(user)
        if user.avatar.attached?
            return url_for(user.avatar)
        else
            return gravatar_url(user.email)
        end
    end

    def display_name(user)
        name = user.name.empty? || user.name.nil? ? user.email : user.name
        contained(name)
    end

    def contained(str)
        str.length > 20 ? str[0..17] + "..." : str
    end

    def first_name(str)
        str.split[0]
    end

    def friendship_action(fr)
        return "Send a Friend Request!" if fr.nil?
        return "Not friends anymore?" unless fr.pending
        return fr.sender == current_user ? "Miss click? Cancel the Request!" : "#{first_name(fr.sender.name)} sent you a Friend Request!"
    end

    def find_friendship(user)
        Friendship.where(sender_id: user, receiver_id: current_user).or(Friendship.where(sender_id: current_user, receiver_id: user)).take
    end

    def display_time(time)
        diff = Time.now - time
        if diff < 60*60
            return "#{pluralize (diff/60).floor, "minute"} ago"
        elsif diff < 60*60*24
            return "#{pluralize (diff/(60*60)).floor, "hour"} ago"
        elsif diff < 30*60*60*24
            return "#{pluralize (diff/(60*60*24)).floor, "day"} ago"
        else
            return time.strftime("%B %d at %I:%M %p")
        end
    end

end
