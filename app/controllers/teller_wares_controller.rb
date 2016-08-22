class TellerWaresController < ApplicationController
  before_filter :pundit_wares
  layout "new_version_base"

  def show
    ware = ::Finance::TellerWare.where(number: params[:id]).first

    # 如果在此用户业务分类内，则直接设置阅读进度100%
    ware.set_read_percent_by_user(current_user, 100) if current_user and current_user.teller? and ware.in_business_categories?(current_user)

    num = ware.number[0...3]

    @page_name = "finance_teller_ware"
    @component_data = {
      ware: DataFormer.new(ware)
              .logic(:actions)
              .logic(:business_kind_str)
              .data,
      hmdm_url: hmdm_teller_wares_path,
      relative_wares:  Finance::TellerWare.where(number: /^#{num}/)
                        .order(number: :asc)
                        .select {|x|
                          x.id != ware.id
                        }
                        .map {|x|
                          DataFormer.new(x)
                            .logic(:business_kind_str)
                            .url(:show_url)
                            .data
                        }
    }
    render "/mockup/page", layout: 'new_version_ware'
  end

  def hmdm
    screen = ::Finance::TellerWareScreen.where(hmdm: params[:hmdm]).first
    data = DataFormer.new(screen)
      .logic(:selects)
      .data
    render json: data
  end

  private
  def pundit_wares
    authorize :wares, "#{action_name}?"
  end
end
