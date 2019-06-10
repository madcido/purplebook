class FriendshipsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @friendship = Friendship.new(friendship_params)
        @friendship.save
        respond_to { |format| format.js }
    end

    def update
        @friendship = Friendship.find_by(id: params[:id])
        @friendship.update(friendship_params)
        respond_to { |format| format.js }
    end

    def destroy
        @friendship = Friendship.find_by(id: params[:id])
        @friendship.destroy
        respond_to { |format| format.js }
    end

    private

    def friendship_params
        params.require(:friendship).permit(:sender_id, :receiver_id, :pending)
    end

end
