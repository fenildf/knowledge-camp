@ArticlesPage = React.createClass
  componentDidMount: ->
    marked.setOptions {
      highlight: (code, lang, callback)->
        hljs.highlightAuto(code).value
    }

  getInitialState: ->
    console.log @props
    isInfiniteLoading: false
    articles: @props.data.articles
    page: 1
    hasMore: @props.data.paginate.total_pages > 1

  render: ->
    <div className='articles-page'>
      <Infinite 
        containerHeight={400}
        elementHeight={200}
        loadingSpinnerDelegate={@elementInfiniteLoad()}
        isInfiniteLoading={@state.isInfiniteLoading}

        onInfiniteLoad={@handleInfiniteLoad}
        timeScrollStateLastsForAfterUserScrolls={1000}
        useWindowAsScrollContainer
        infiniteLoadBeginEdgeOffset={20}
        >
        {
          for article in @state.articles
            <ArticlesPage.Article article={article} key={article.id} />
        }
      </Infinite>
    </div>

  elementInfiniteLoad: ->
    console.log 'elementInfiniteLoad'
    <div className="ui segment dimmable dimmed loadmore">
      <div className="ui inverted dimmer transition visible active" style={{display: "block !important"}}>
        <div className="ui text loader">加载中</div>
      </div>
    </div>


  add_article: (article)->
    articles = Immutable.fromJS @state.articles
    articles = articles.push article
    @setState articles: articles.toJS()

  add_articles: (articles)->
    tmp = @state.articles.concat articles
    @setState
      articles: tmp

  handleInfiniteLoad: ->
    console.log 'handleInfiniteLoad'
    next_page = @state.page + 1
    if @state.hasMore and next_page <= @props.data.paginate.total_pages
      @setState
        isInfiniteLoading: true

      if @props.data.q
        url = @props.data.next_page_url + "&page=#{next_page}"
      else
        url = @props.data.next_page_url + "?page=#{next_page}"
      jQuery.ajax
        type: 'GET'
        url: url
        dataType: "json"
      .done (res)=>
        console.log res
        @add_articles res.data.articles
        @setState
          page: next_page
          isInfiniteLoading: false
      .fail (res)->
        console.log res
        console.log res.responseJSON
        alert "加载错误"
        @setState
          isInfiniteLoading: false
    else
      console.log 'set has no more'
      @setState
        hasMore: false



  statics:
    Article: React.createClass
      componentDidMount: ->
        @setState
          content: marked(@props.article.content)

      getInitialState: ->
        content: null

      render: ->
        <div className='article'>
          <div className="segment ui">
            <h1 className="ui header center aligned">
              {@props.article.title}
            </h1>

            <ArticlePage.Content content={@state.content} />
          </div>
        </div>
