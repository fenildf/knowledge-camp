marked.setOptions {
  highlight: (code, lang, callback)->
    hljs.highlightAuto(code).value
}

@ManagerArticlePage = React.createClass
  componentDidMount: ->
    @setState
      content: marked(@props.data.manager_article.content)

  getInitialState: ->
    content: null

  render: ->
    <div className='manager_article-page'>
      <div className="ui header center aligned segment">
        {@props.data.manager_article.title}
      </div>

      <ManagerArticlePage.Content content={@state.content} />
    </div>

  #add_manager_article: (manager_article)->
    #manager_articles = Immutable.fromJS @state.manager_articles
    #manager_articles = manager_articles.push manager_article
    #@setState manager_articles: manager_articles.toJS()

  #update_manager_article: (manager_article)->
    #manager_articles = Immutable.fromJS @state.manager_articles
    #manager_articles = manager_articles.map (x)->
      #x = x.merge manager_article if x.get('id') is manager_article.id
      #x
    #@setState manager_articles: manager_articles.toJS()

  #delete_manager_article: (manager_article)->
    #manager_articles = Immutable.fromJS @state.manager_articles
    #manager_articles = manager_articles.filter (x)->
      #x.get('id') != manager_article.id
    #@setState manager_articles: manager_articles.toJS()

  statics:
    Content: React.createClass
      componentDidUpdate: ->
        @refs.test.getDOMNode().innerHTML = @props.content

      render: ->
        <div ref='test' className="ui segment" />

    #CreateBtn: React.createClass
      #render: ->
        #<a className='ui button green mini' href='javascript:;' onClick={@show_modal}>
          #<i className='icon plus' />
          #创建
        #</a>

      #show_modal: ->
        #params =
          #url: @props.data.create_url
          #title: '创建'
          #page: @props.page

        #jQuery.open_modal <ManagerArticlePage.Form {...params} />

    #Form: React.createClass
      #render: ->
        #{
          #TextInputField
          #TextAreaField
          #Submit
        #} = DataForm

        #layout =
          #label_width: '100px'

        #<div>
          #<h3 className='ui header'>{@props.title}</h3>
          #<SimpleDataForm
            #model='manager_article'
            #post={@props.url}
            #done={@done}  
          #>

            #<TextInputField {...layout} label='标题：' name='title' required />
            #<TextAreaField {...layout} label='内容：' name='content' required />
            #<Submit {...layout} text='确定保存' />
          #</SimpleDataForm>
        #</div>

      #done: (data)->
        #@props.page.add_manager_article data.manager_article
        #@state.close()

    #UpdateForm: React.createClass
      #render: ->
        #{
          #TextInputField
          #TextAreaField
          #Submit
        #} = DataForm

        #layout =
          #label_width: '100px'

        #<div>
          #<h3 className='ui header'>{@props.title}</h3>
          #<SimpleDataForm
            #model='manager_article'
            #put={@props.url}
            #done={@done}
            #data={@props.data}  
          #>

            #<TextInputField {...layout} label='标题：' name='title' required />
            #<TextAreaField {...layout} label='内容：' name='content' required />
            #<Submit {...layout} text='确定保存' />
          #</SimpleDataForm>
        #</div>

      #done: (data)->
        #@props.page.update_manager_article data.manager_article
        #@state.close()

    #Table: React.createClass
      #render: ->
        #table_data = {
          #fields:

            #title: '标题'
            #ops: '操作'
          #data_set: @props.data.map (x)=>
            #id: x.id

            #title:
              #<a href={x.manager_show_url}>{x.title}</a>
            #ops:
              #<div>
                #<a href='javascript:;' className='ui basic button blue mini' onClick={@edit(x)}>
                  #<i className='icon edit' /> 修改
                #</a>
                #<a href='javascript:;' className='ui basic button red mini' onClick={@delete(x)}>
                  #<i className='icon trash' /> 删除
                #</a>
              #</div>

          #th_classes: {
            #number: 'collapsing'
          #}
          #td_classes: {
            #ops: 'collapsing'
          #}
        #}

        #<div className='ui segment'>
          #<ManagerTable data={table_data} title="文章 " />
        #</div>

      #edit: (manager_article)->
        #=>
          #params =
            #url: manager_article.manager_update_url
            #title: '修改'
            #page: @props.page
            #data: manager_article

          #jQuery.open_modal <ManagerArticlePage.UpdateForm {...params} />

      #delete: (manager_article)->
        #=>
          #jQuery.modal_confirm
            #text: '确定要删除吗？'
            #yes: =>
              #jQuery.ajax
                #type: 'DELETE'
                #url: manager_article.manager_delete_url
              #.done =>
                #@props.page.delete_manager_article manager_article

