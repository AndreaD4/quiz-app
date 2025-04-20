class Managers::CompaniesController < ManagersController

  def edit
  end

  def update
    respond_to do |format|
      if current_company.update(company_params)
        format.html { redirect_to edit_manager_company_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def backup
    BackupS3Job.perform_now(current_company)
    respond_to do |format|
      format.html { redirect_to edit_manager_company_path }
    end
  end

  def poweroff
    PoweroffRaspberryJob.perform_now
    respond_to do |format|
      format.html { redirect_to edit_manager_company_path }
    end
  end

  private

  def company_params
    params.require(:company).permit(:host, :name, :business_name, :address, :city, :zip_code, :tax_code, :vat_code, :province, :nationality, :company_logo, :trasmitter_vat_code, :trasmitter_phone, :trasmitter_email, :tax_regime, :iban, :bank, :phone, :email, :last_sdi_code, :rea_number, :partner_unique, :liquidation_state, :diet_notes, :calendar_reminders)
  end

end