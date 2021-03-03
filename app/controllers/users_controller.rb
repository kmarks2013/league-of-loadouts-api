class UsersController < ApplicationController
    before_action :current_user, only: [:update, :destroy]
    wrap_parameters :user, include: [:password, :username, :age, :name]
    wrap_parameters :current_user, format: :json, include: [:password, :username, :age, :name]

    def index
        users= User.all
        render json: users.ordered_by_name
    end

    def show
        user = User.find(params[:id])
        render json: user, include: '**'
    end

    def create 
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secret, 'HS256')
            render json: {user: user, include: '**', token: token}, status: :created
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        if current_user.update(update_params)
            render json: current_user, include: '**', status: :accepted
        else
            render json: {errors: current_user.errors}
        end
        # current_user.update(update_params)
        # render json:current_user, include: '**', status: :accepted
        # user = User.find(params[:id])
        # if user == current_user
        #     if user.update(update_params)
        #         render json: user, include: '**', status: :accepted
        #     else
        #         render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        #     end
        # else
        #     render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        # end
    end
    
    def destroy
        user = User.find(params[:id])
        if user == current_user
            user.destroy
            render json: { }
        else
            render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        end
    end

    private
    def user_params
        params.require(:user).permit([:name, :username, :password, :age])
    end

    def update_params
        params.require(:current_user).permit(:name, :username,:password, :age )
    end

end
