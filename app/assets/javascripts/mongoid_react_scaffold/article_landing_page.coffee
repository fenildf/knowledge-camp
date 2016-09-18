# 滑块，用于头条
#= require swiper.jquery.min

@ArticleLandingPage = React.createClass
  render: ->
    <div className='article-landing-page'>
      <ArticleLandingPage.Swiper articles={@props.data.top} />
      <ArticleLandingPage.Tabs cats={@props.data.cats} />
      {
        @props.data.cats.map (cat, index) ->
          <ArticleLandingPage.List articles={cat.articles} tab={index+1} key="tab_#{cat.name}" />
      }
    </div>

  statics:
    Swiper: React.createClass
      componentDidMount: ->
        new Swiper ".swiper-container",{
          pagination: ".swiper-pagination",
          paginationClickable: true,
          #direction: "vertical"
        }

      render: ->
        <div className="swiper-container">
          <div className="swiper-wrapper">
            {
              @props.articles.map (article)->
                <div className="swiper-slide" key={article.title} style={{backgroundImage: "url(#{article.img})"}}>
                  <a href={article.show_url} className="swiper-link" title={article.title}>
                  </a>
                </div>
            }
          </div>
          <div className="swiper-pagination"></div>
        </div>

    Tabs: React.createClass
      componentDidMount: ->
        jQuery(@refs.menu).find('.item').tab()

      render: ->
        <div className="tabs ui menu" ref="menu">
          {
            if @props.cats and @props.cats.length > 0
              <a className="item active" data-tab="1" href="javascript:;">
                 {@props.cats[0].name}
              </a>
          }
          {
            @props.cats[1..-1].map (cat, index) ->
              <a className="item" data-tab={index+2} href="javascript:;" key="cat_#{cat.name}">
                 {cat.name}
              </a>
          }
        </div>

    List: React.createClass
      class_name: "ui items tab divided segment"
      active_class_name: "ui items tab divided active segment"

      render: ->
        if @props.tab == undefined or @props.tab.toString() == "1"
          cls = @active_class_name
        else
          cls = @class_name

        <div className={cls} data-tab={@props.tab || "1"}>
          {
            @props.articles.map (article)->
              <div className="item">
                <a className="ui tiny image" key={article.title}>
                  <img src={article.img} />
                </a>
                <a className="middle aligned content"  href={article.show_url}>
                  {article.title}
                </a>
              </div>
          }
        </div>
