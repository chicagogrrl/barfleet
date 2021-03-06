# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :get_profile
  before_action :set_membership, only: %i[show edit update destroy]
  before_action :set_collections, only: %i[new edit]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = @profile.memberships
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show; end

  # GET /memberships/new
  def new
    @membership = @profile.memberships.build
  end

  # GET /memberships/1/edit
  def edit; end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = @profile.memberships.build(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to profile_memberships_path(@profile), notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to profile_memberships_path(@profile), notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        set_collections
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to profile_memberships_path(@profile), notice: 'Membership was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def division_roles
    division_roles = Division.find(params[:division]).available_roles
    @roles = { 'Division Roles' => division_roles.map{ |role| [role.name, role.id] }, 'Non-Specific Roles' => Role.non_specific.map{ |role| [role.name, role.id] } }
    respond_to do |format|
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = @profile.memberships.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:division_id, :rank_id, :role_id)
  end

  def get_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_collections
    @divisions = helpers.ancestry_options(Division.all.arrange(order: 'name')) { |i| "#{'-' * i.depth} #{i.name}" }
    @ranks = Rank.all.order(:sort_number)
    division_roles = @membership.try(:division) ? @membership.division.available_roles : []
    @roles = { 'Division Roles' => division_roles, 'Non-Specific Roles' => Role.non_specific }
  end
end
