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
        if @props.data.ware.is_ppt
          params =
            data: @props.data
            read: @read
            percent: @state.percent
          <SimpleDocumentWareShowPage.PageShower {...params} />
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

    # 单页显示：PPT
    PageShower: React.createClass
      #componentDidMount: ->
        #$div_ware = jQuery @refs.div_ware.getDOMNode()
        #$div_ware_page = $div_ware.parent()
        #@window_height = jQuery(window).height()
        #@scrollHeight = $div_ware_page.get(0).scrollHeight
        #$div_ware.css "height", @window_height - (@props.height_fix || 0)

        #if @props.data.in_business_categories
          #$div_ware_page.scroll (e) =>
            #percent = Math.floor(100 * (e.target.scrollTop + @window_height + FIX_HEIGHT) / e.target.scrollHeight)
            #if percent > @props.percent
              #@props.read(percent)
      getInitialState: ->
        index: 1
        max: @props.data.ware.document_urls.length

      render: ->
        @percent = 0
        @ware = @props.data.ware

        <div className="simple-document-ware-show simple-document-ware-show-page-shower" ref="div_ware">
          <img src={@props.data.ware.document_urls[@state.index-1]} className="ui image" />
          <div className="page-controller">
            <a href="javascript:;" className="icon-link" onClick={@prev}>
              <i className="arrow left icon"></i>
            </a>
            <div className="ui mini input inline">
              <input type="text" ref="current" defaultValue={@state.index} onKeyUp={@handleCurrentKeyUp} onBlur={@handleCurrentBlur} />
            </div>
            / {@state.max}
            <a href="javascript:;" className="icon-link" onClick={@next}>
              <i className="arrow right icon"></i>
            </a>
          </div>
        </div>

      prev: ->
        @set_page @state.index - 1

      next: ->
        @set_page @state.index + 1

      set_page: (page) ->
        if page >=1 and page <= @state.max
          @refs.current.getDOMNode().value = page
          @setState
            index: page

      handleCurrentBlur: (evt)->
        evt.target.value = @state.index

      handleCurrentKeyUp: (evt)->
        # 回车
        if event.keyCode == 13
          @set_page parseInt(evt.target.value)
