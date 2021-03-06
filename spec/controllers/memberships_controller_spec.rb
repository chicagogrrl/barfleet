require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe MembershipsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Membership. As you add validations to Membership, be sure to
  # adjust the attributes here as well.
  let(:profile) { create(:profile) }
  let(:division) { create(:division) }
  let(:valid_attributes) {
    { profile_id: profile.id, division_id: division.id }
  }

  let(:invalid_attributes) {
    { profile_id: profile.id, division_id: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MembershipsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      create(:membership, profile_id: profile.id)
      get :index, params: { profile_id: profile.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      membership = create(:membership, profile_id: profile.id)
      get :show, params: {profile_id: profile.id, id: membership.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {profile_id: profile.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      membership = create(:membership, profile_id: profile.id)
      get :edit, params: {profile_id: profile.id ,id: membership.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Membership" do
        expect {
          post :create, params: {profile_id: profile.id, membership: valid_attributes}, session: valid_session
        }.to change(Membership, :count).by(1)
      end

      it "redirects to the profile's memberships" do
        post :create, params: {profile_id: profile.id, membership: valid_attributes}, session: valid_session
        expect(response).to redirect_to(profile_memberships_path(profile))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {profile_id: profile.id, membership: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:division_2) { create(:division) }
      let(:new_attributes) {
        { division_id: division_2.id }
      }

      it "updates the requested membership" do
        membership = create(:membership, profile_id: profile.id, division_id: division.id)
        put :update, params: {profile_id: profile.id ,id: membership.to_param, membership: new_attributes}, session: valid_session
        membership.reload
        expect(membership.division).to eq(division_2)
      end

      it "redirects to the profile's memberships" do
        membership = create(:membership, profile_id: profile.id)
        put :update, params: {profile_id: profile.id ,id: membership.to_param, membership: new_attributes}, session: valid_session
        expect(response).to redirect_to(profile_memberships_path(profile))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        membership = Membership.create! valid_attributes
        put :update, params: {profile_id: profile.id, id: membership.to_param, membership: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested membership" do
      membership = Membership.create! valid_attributes
      expect {
        delete :destroy, params: {profile_id: profile.id, id: membership.to_param}, session: valid_session
      }.to change(Membership, :count).by(-1)
    end

    it "redirects to the profile's memberships list" do
      membership = Membership.create! valid_attributes
      delete :destroy, params: {profile_id: profile.id, id: membership.to_param}, session: valid_session
      expect(response).to redirect_to(profile_memberships_url(profile))
    end
  end

end
