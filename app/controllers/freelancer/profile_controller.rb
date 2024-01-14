class Freelancer::ProfileController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, with: :langauges_must_be_unique
  before_action :current_profile, except: [:create]
  before_action :profile_persisted?, only: [:experiences, :education, :certifications, :languages]

  def show; end

  def new;  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save and @current_page == 'info'
      current_user.add_role :freelancer
      redirect_to experiences_profile_path
    else
      flash.now[:alert] = 'info is invalid!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    #debugger
    if @profile.update(profile_params)
      case @current_page
      when 'info'
        redirect_to experiences_profile_path
      when 'experiences'
        redirect_to education_profile_path
      when 'education'
        redirect_to certifications_profile_path
      when 'certifications'
        redirect_to languages_profile_path
      when 'languages'
        redirect_to profile_path
      end
    else
      case @current_page
      when 'info'
        render :edit, status: :unprocessable_entity
      when 'experiences'
        render :experiences, status: :unprocessable_entity
      when 'education'
        render :education, status: :unprocessable_entity
      when 'certifications'
        render :certifications, status: :unprocessable_entity
      when 'languages'
        render :languages, status: :unprocessable_entity
      end
    end
  end

  def experiences
    unless profile_persisted?
      redirect_to new_profile_path, alert: 'fill your basic info first!' and return
    end
    @profile.experiences.build unless @profile.experiences.present?
  end

  def education
    unless profile_persisted?
      redirect_to new_profile_path, alert: 'fill your basic info first!' and return
    end
    @profile.education_histories.build unless @profile.education_histories.present?
  end

  def certifications
    unless profile_persisted?
      redirect_to new_profile_path, alert: 'fill your basic info first!' and return
    end
    @profile.certifications.build unless @profile.certifications.present?
  end

  def languages
    unless profile_persisted?
      redirect_to new_profile_path, alert: 'fill your basic info first!' and return
    end
    @profile.languages.build unless @profile.languages.present?
  end

  private

    def profile_params
      @current_page = params.require(:profile).permit(:current_page)['current_page']
      params.require(:profile).permit(:professional_role, :bio, :hourly_rate, :postal_code, :phone, :country, :street_address, :city, :state, :skill_list,
      :service_list, :avatar, experiences_attributes: [:id, :company, :title, :location, :country, :start_date, :end_date, :description, :_destroy], 
      education_histories_attributes: [:id, :school, :degree, :study_field, :from, :to, :description, :_destroy],
      languages_attributes: [:id, :name, :proficiency, :_destroy], 
      certifications_attributes: [:id, :name, :issue_date, :expiration_date, :cert_id, :certification_url, :_destroy])
    end

    def current_profile
      @profile = Profile.find_or_initialize_by(user_id: current_user.id)
    end

    def langauges_must_be_unique
      @profile.errors.add(:base, 'selected languages must be unique')
      render :languages, status: :unprocessable_entity
    end

    def profile_persisted?
      @profile.persisted?
    end
end