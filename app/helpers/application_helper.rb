module ApplicationHelper
    def gravatar_url(email)
        gravatar = Digest::MD5::hexdigest(email).downcase
        url = "http://gravatar.com/avatar/#{gravatar}.png"
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
end
