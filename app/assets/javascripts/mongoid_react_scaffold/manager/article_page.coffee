@ManagerArticlePage = React.createClass
  componentDidMount: ->
    marked.setOptions {
      highlight: (code, lang, callback)->
        hljs.highlightAuto(code).value
    }

    @setState
      content: marked(@props.data.manager_article.content)

  getInitialState: ->
    content: null

  render: ->
    <div className='manager_article-page'>
      <div className="segment ui">
        <h1 className="ui header center aligned">
          {@props.data.manager_article.title}
        </h1>

        <ManagerArticlePage.Content content={@state.content} />
      </div>
    </div>

  statics:
    Content: React.createClass
      componentDidUpdate: ->
        @refs.test.innerHTML = @props.content

      render: ->
        <div ref='test' className="ui segment" />
