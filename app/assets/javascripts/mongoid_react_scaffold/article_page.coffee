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
    <div className='article-page'>
      <div className="segment ui">
        <h1 className="ui header center aligned">
          {@props.data.article.title}
        </h1>

        <ArticlePage.Content content={@state.content} />
      </div>

      <CommentsWithForm url={@props.data.comments_url} />
    </div>

  statics:
    Content: React.createClass
      componentDidUpdate: ->
        @refs.test.innerHTML = @props.content

      render: ->
        <div ref='test' className="content" />
