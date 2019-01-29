class Test::Legislation::HomepagesController < Test::Legislation::BaseController
  include Translatable

  load_and_authorize_resource :process, class: "Legislation::Process"

  def edit
  end

  def update
    if @process.update(process_params)
      link = legislation_process_path(@process).html_safe
      redirect_to :back, notice: t('test.legislation.processes.update.notice', link: link)
    else
      flash.now[:error] = t('test.legislation.processes.update.error')
      render :edit
    end
  end

  private

    def process_params
      params.require(:legislation_process).permit(allowed_params)
    end

    def allowed_params
      [
        :homepage,
        :homepage_enabled,
        translation_params(::Legislation::Process)
      ]
    end

    def resource
      @process || ::Legislation::Process.find(params[:id])
    end
end
