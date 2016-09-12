@ManagerArticleNewPage = React.createClass
  render: ->
    params =
      url: @props.data.manager_create_url
      title: '创建'
      page: @props.page
      wares: @props.data.wares

    <div className='manager_article_new-page'>
      <ManagerArticleNewPage.Form {...params} />
    </div>

  statics:
    Form: React.createClass
      render: ->
        {
          TextInputField
          TextAreaField
          SelectField
          Submit
        } = DataForm

        layout =
          label_width: '100px'

        <div className="ui segment">
          <h3 className='ui header'>{@props.title}</h3>
          <SimpleDataForm
            model='manager_article'
            post={@props.url}
            done={@done}
          >

            <TextInputField {...layout} label='标题：' name='title' required />
            <TextAreaField {...layout} label='内容：' name='content' required />
            <SelectField {...layout} label='课件：' name='ware_id' required values={@props.wares} />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (res)->
        window.location.href = res.manager_article.manager_show_url
