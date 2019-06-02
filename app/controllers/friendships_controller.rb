class FriendshipsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @friendship = Friendship.new(friendship_params)
        if @friendship.save
            flash[:success] = "Friendship request sent"
        else
            flash[:error] = "Friendship request failed"
        end
        redirect_to request.referrer
    end

    def update
        @friendship = Friendship.find_by(id: params[:id])
        if @friendship.update(friendship_params)
            flash[:success] = "Friendship accepted"
        else
            flash[:success] = "Friendship failed"
        end
        redirect_to request.referrer
    end

    def destroy
        Friendship.find_by(id: params[:id]).destroy
        flash[:success] = "Friendship destroyed"
        redirect_to request.referrer
    end
    
    private

    def friendship_params
        params.require(:friendship).permit(:sender_id, :receiver_id, :pending)
    end

end
