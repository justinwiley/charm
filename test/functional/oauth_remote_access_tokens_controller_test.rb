require 'test_helper'

class OauthRemoteAccessTokensControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:oauth_remote_access_tokens)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_oauth_remote_access_token
    assert_difference('OauthRemoteAccessToken.count') do
      post :create, :oauth_remote_access_token => { }
    end

    assert_redirected_to oauth_remote_access_token_path(assigns(:oauth_remote_access_token))
  end

  def test_should_show_oauth_remote_access_token
    get :show, :id => oauth_remote_access_tokens(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => oauth_remote_access_tokens(:one).id
    assert_response :success
  end

  def test_should_update_oauth_remote_access_token
    put :update, :id => oauth_remote_access_tokens(:one).id, :oauth_remote_access_token => { }
    assert_redirected_to oauth_remote_access_token_path(assigns(:oauth_remote_access_token))
  end

  def test_should_destroy_oauth_remote_access_token
    assert_difference('OauthRemoteAccessToken.count', -1) do
      delete :destroy, :id => oauth_remote_access_tokens(:one).id
    end

    assert_redirected_to oauth_remote_access_tokens_path
  end
end
