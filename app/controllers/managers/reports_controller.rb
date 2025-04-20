class Managers::ReportsController < ManagersController
  before_action :set_report, only: [:destroy]
  include ReportHelper

  def index
    session[params[:type_of]] ||= {}
    session[params[:type_of]]['page'] = params[:page] if params[:page].present?
    @page = session[params[:type_of]]['page']

    @start_date = Date.today.beginning_of_year
    @end_date = Time.now

    @reports = current_manager.reports.order(id: :desc)
    @reports = @reports.paginate(per_page: 5, page: @page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @report = current_company.reports.new
    @report.manager = current_manager
    @report.type_of = report_params[:type]
    @report.model_name_of = report_params[:model_name_of]
    @report.method_name = report_params[:method_name]
    @report.params = params[:report]
    @report.filters = ActiveSupport::JSON.decode(report_params[:filters]) if report_params[:filters].present?
    @report.save

    respond_to do |format|
      format.html { redirect_to manager_reports_url }
      format.js
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to manager_reports_url }
    end
  end

  private

  def set_report
    @report = (current_manager.reports.find(params[:id]) or not_found)
  end

  def report_params
    params.require(:report).permit(:model_name_of, :method_name, :report_name, :date_range, :type, :type_of, :state, :manager, :reason, :taken, :name, :filters)
  end
end
