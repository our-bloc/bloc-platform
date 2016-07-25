require 'firebase'
require 'json'

base_uri = 'https://bloc-platform-8bde4.firebaseio.com/'
f = Firebase::Client.new(base_uri)

class UsersController < ApplicationController

  # all users
  def index

  end

  # display user profile
  def show
    f.get('users')
  end

  # creates user


  def create(userId, name, email, imageUrl) {
    f.database().ref('users/' + userId).set({
      username: name,
      email: email
    });
  end

  # edits profile
  def edit
    @user = User.find(params[:id])
  end

  # posts updated profile
  def update
    @user = User.find(params[:id])
    f.put('users/test', @user)
  end

  # deletes account
  def destroy
    @user = current_user
    f.delete('users/test')
    redirect_to("/")
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email
    )
  end

end
