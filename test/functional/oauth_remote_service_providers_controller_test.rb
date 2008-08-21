require 'test_helper'

class OauthRemoteServiceProvidersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:oauth_remote_service_providers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_oauth_remote_service_provider
    assert_difference('OauthRemoteServiceProvider.count') do
      post :create, :oauth_remote_service_provider => { }
    end

    assert_redirected_to oauth_remote_service_provider_path(assigns(:oauth_remote_service_provider))
  end

  def test_should_show_oauth_remote_service_provider
    get :show, :id => oauth_remote_service_providers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => oauth_remote_service_providers(:one).id
    assert_response :success
  end

  def test_should_update_oauth_remote_service_provider
    put :update, :id => oauth_remote_service_providers(:one).id, :oauth_remote_service_provider => { }
    assert_redirected_to oauth_remote_service_provider_path(assigns(:oauth_remote_service_provider))
  end

  def test_should_destroy_oauth_remote_service_provider
    assert_difference('OauthRemoteServiceProvider.count', -1) do
      delete :destroy, :id => oauth_remote_service_providers(:one).id
    end

    assert_redirected_to oauth_remote_service_providers_path
  end
end
