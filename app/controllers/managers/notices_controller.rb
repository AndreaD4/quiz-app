class Managers::NoticesController < ManagersController
  before_action :set_notice, only: [:destroy, :toggle_seen]

  def index
    session[:notices] ||= {}
    session[:notices]['page'] = params[:page] if params[:page].present?
    session[:notices]['per_page'] = params[:per_page] if params[:per_page].present?

    @per_page = params[:per_page] if params[:per_page].present?
    @per_page = 15 unless params[:notices].present?
    @per_page = session[:notices]['per_page'] if session[:notices]['per_page'].present?
    @page = session[:notices]['page']

    @notices = current_company.notices

    @notices = @notices.order(created_at: :desc).paginate(per_page: @per_page, page: @page)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def toggle_seen
    @notice.update(seen: !@notice.seen)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@notice, partial: "managers/notices/notice", locals: { notice: @notice })}
      format.html { redirect_to manager_notices_path }
    end
  end

  def destroy
    @notice.update(visible: false)

    respond_to do |format|
      format.js
    end
  end

  private

  def set_notice
    @notice = current_company.notices.find(params[:id])
  end
end