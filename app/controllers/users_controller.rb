class UsersController < ApplicationController

    wrap_parameters User, include: [:password, :username, :age, :name]

    def index
        users= User.all
        render json: users.ordered_by_name
    end

    def show
        user = User.find(params[:id])
        render json: user, include: '**'
    end

    def create 
        # byebug
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secret, 'HS256')
            render json: {user: user, token: token}, status: :created
            # render json: {user: user}, status: :created
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        # Goal is to make sure a user can not be updated unless they have the correct token
        # byebug
        # pass the user id from params on an update because i don't want someone to be albe to change that

        user = User.find(params[:id])
        # byebug
        if user == current_user
            # user.update(update_params)
            # byebug
            if user.update(update_params)
                render json: user, include: '**', status: :accepted
            else
                render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        end
    end
    
    def destroy
        # Goal is to make sure a user can not be deleted unless they have the correct token
        user = User.find(params[:id])
        # byebug
        if user == current_user
            # byebug
            user.destroy
            render json: { }
            # render json: { message: 'this account should be deleted' }
        else
            render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        end
    end

    private
    def user_params
        params.require(:user).permit([:name, :username, :password, :age])
    end

    def update_params
       params.require(:user).permit(:id, :name, :username,:password, :age )
    end

end
