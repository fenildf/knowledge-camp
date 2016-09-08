@ArticlePage = React.createClass
  componentDidMount: ->
    marked.setOptions {
      highlight: (code, lang, callback)->
        hljs.highlightAuto(code).value
    }

    @setState
      content: marked(@props.data.article.content)

  getInitialState: ->
    content: null

  render: ->
    console.log @props
    <div className='article-page'>
      <div className="segment ui">
        <h1 className="ui header center aligned">
          {@props.data.article.title}
        </h1>

        <ArticlePage.Content content={@state.content} />
      </div>
    </div>

  statics:
    Content: React.createClass
      componentDidUpdate: ->
        @refs.test.getDOMNode().innerHTML = @props.content

      render: ->
        <div ref='test' className="content" />
