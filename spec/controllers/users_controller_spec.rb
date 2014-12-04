require 'rails_helper'

describe UsersController, :type => :controller do
  describe '#admin' do
    context "when not logged in" do
      it "redirects you to about page" do
        get :admin
        expect(response).to redirect_to("/")
      end
    end

    context "when you're logged in but not an admin" do
      before { User.create(username: "Meow", password: "a", password_digest: "a")
              session[:current_user] = User.last.id }
      it "redirects you to about page" do
        get :admin
        expect(response).to redirect_to("/")

      end
    end

    context "when you're logged in and an admin" do
      before { User.create(username: "Meow",
                          password: "a",
                          password_digest: "a",
                          admin: true)
              session[:current_user] = User.last.id }
      it "renders the admin page" do
        get :admin
        expect(response).to render_template("admin")
      end

    end
  end
end
