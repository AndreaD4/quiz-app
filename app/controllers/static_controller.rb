class StaticController < ApplicationController
  def backup
    hmac_secret = 'qw1D6gpXeD='
    token = params[:token]

    decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    authorized = decoded_token[0]["authorized"] rescue nil

    respond_to do |format|
      if authorized == 'YES'
        BackupS3Job.perform_now(current_company)
        format.json { render json: { response: 'OK' }, status: :ok }
      else
        format.json { render json: { response: 'KO', message: 'Non Autorizzato' }, status: :ok }
      end
    end
  end
end