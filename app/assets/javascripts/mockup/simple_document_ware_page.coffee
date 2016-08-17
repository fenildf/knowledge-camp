# 偏移量，预防有不能达到100%的情况
FIX_HEIGHT = 50
@SimpleDocumentWareShowPage = React.createClass
  render: ->
    <div className='simple-document-ware-show-page'>
      <SimpleDocumentWareShowPage.Shower data={@props.data} />
    </div>

  statics:
    Shower: React.createClass
      read: (percent)->
        @setState
          percent: percent
        jQuery.ajax
          url: "/wares/#{@ware.id}/read"
          type: "POST"
          data:
            ware:
              percent: percent
        .done (res) =>
          console.log 'done'
          console.log res
        .fail (res) ->
          console.log res.responseJSON

      #timeupdate: (mediaElement, domObject)->
        #(e) =>
          ## 大于前一次比值（百分比），则提交一次
          #p = Math.floor(100 * mediaElement.currentTime / mediaElement.duration)
          #@read(@percent = p) if p > @percent + 5

      #ended: (mediaElement, domObject)->
        #(e) =>
          ## 结束，则设置为100%
          #console.log 'ended'
          #@read(100)

      getInitialState: ->
        @ware = @props.data.ware
        percent: 0

      render: ->
        switch @props.data.ware.kind
          when "ppt"
          else
            params =
              data: @props.data
              read: @read
              percent: @state.percent
              height_fix: 30*2 # 缩进高度，根据css传入
            <SimpleDocumentWareShowPage.VerticalShower {...params} />

    # 竖行显示：PDF 
    VerticalShower: React.createClass
      componentDidMount: ->
        $div_ware = jQuery @refs.div_ware.getDOMNode()
        $div_ware_page = $div_ware.parent()
        @window_height = jQuery(window).height()
        @scrollHeight = $div_ware_page.get(0).scrollHeight
        $div_ware.css "height", @window_height - (@props.height_fix || 0)

        if @props.data.in_business_categories
          $div_ware_page.scroll (e) =>
            percent = Math.floor(100 * (e.target.scrollTop + @window_height + FIX_HEIGHT) / e.target.scrollHeight)
            if percent > @props.percent
              @props.read(percent)

      render: ->
        @percent = 0
        @ware = @props.data.ware

        <div className="simple-document-ware-show simple-document-ware-show-vertical" ref="div_ware">
          {
            @props.data.ware.document_urls.map (url, index)->
              <img src={url} key={index} className="ui image" />
          }
        </div>


