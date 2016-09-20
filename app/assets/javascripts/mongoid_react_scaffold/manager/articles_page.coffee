@ManagerArticlesPage = React.createClass
  getInitialState: ->
    manager_articles: @props.data.manager_articles

  render: ->
    <div className='manager_articles-page'>
    {
      if @state.manager_articles.length is 0
        data =
          header: "文章"
          desc: '还没有创建任何文章'
          init_action: <ManagerArticlesPage.CreateBtn data={@props.data} page={@} />
        <ManagerFuncNotReady data={data} />

      else
        <div>
          <ManagerArticlesPage.CreateBtn data={@props.data} page={@} />
          <ManagerArticlesPage.Table articles={@state.manager_articles} data={@props.data} page={@} />
        </div>
    }
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

  delete_manager_article: (manager_article)->
    manager_articles = Immutable.fromJS @state.manager_articles
    manager_articles = manager_articles.filter (x)->
      x.get('id') != manager_article.id
    @setState manager_articles: manager_articles.toJS()

  statics:
    CreateBtn: React.createClass
      render: ->
        <a className='ui button green mini' href={@props.data.manager_new_url}>
          <i className='icon plus' />
          创建
        </a>

    #Form: React.createClass
      #render: ->
        #{
          #TextInputField
          #TextAreaField
          #SelectField
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
            #<SelectField {...layout} label='课件：' name='ware_id' required values={@props.wares} />
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
          #SelectField
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
            #<SelectField {...layout} label='课件：' name='ware_id' required values={@props.wares} />
            #<Submit {...layout} text='确定保存' />
          #</SimpleDataForm>
        #</div>

      #done: (data)->
        #@props.page.update_manager_article data.manager_article
        #@state.close()

    Table: React.createClass
      render: ->
        table_data = {
          fields:

            title: '标题'
            ops: '操作'
          data_set: @props.articles.map (x)=>
            id: x.id

            title:
              <a href={x.manager_show_url}>{x.title}</a>
            ops:
              <div>
                <a href={x.manager_edit_url} className='ui basic button blue mini'>
                  <i className='icon edit' /> 修改
                </a>
                <a href='javascript:;' className='ui basic button red mini' onClick={@delete(x)}>
                  <i className='icon trash' /> 删除
                </a>
              </div>

          th_classes: {
            number: 'collapsing'
          }
          td_classes: {
            ops: 'collapsing'
          }
          paginate: @props.data.paginate
        }

        <div className='ui segment'>
          <ManagerTable data={table_data} title="文章 " />
        </div>

      edit: (manager_article)->
        =>
          params =
            url: manager_article.manager_update_url
            title: '修改'
            page: @props.page
            data: manager_article
            wares: @props.data.wares

          jQuery.open_modal <ManagerArticlesPage.UpdateForm {...params} />

      delete: (manager_article)->
        =>
          jQuery.modal_confirm
            text: '确定要删除吗？'
            yes: =>
              jQuery.ajax
                type: 'DELETE'
                url: manager_article.manager_delete_url
              .done =>
                @props.page.delete_manager_article manager_article
