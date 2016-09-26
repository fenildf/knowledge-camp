@CommentsWithForm = React.createClass
  load: ->
    # 读取评论
    jQuery.ajax
      url: @props.url
      type: "GET"
    .done (res)=>
      if res?.data?.comments and res.data.comments.length > 0
        comments = Immutable.fromJS @state.comments
        comments = comments.concat res.data.comments
        @setState
          comments: comments.toJS()
          loading: false
      else
        @setState
          loading: false
    .fail (res)->
      console.log res
      alert "读取列表失败"

  handleCreated: (comment)->
    comments = Immutable.fromJS @state.comments
    comments = comments.push comment
    @setState
      comments: comments.toJS()

  componentDidMount: ->
    @load()

  getInitialState: ->
    content: null
    comments: []
    loading: true

  render: ->
    <div className='comments-with-form ui segment'>
      <div className="ui comments">
        <h3 className="ui header dividing">
          评论
        </h3>

        <div className="list">
          {
            if @state.loading
              <Loading />
            else
              if @state.comments.length > 0
                for comment in @state.comments
                  <CommentsWithForm.Comment data={comment} key={comment.id} />
              else
                "暂无评论"
          }
        </div>

        {
          if @props.signed_in
            <CommentsWithForm.Form url={@props.create_url} handleCreated={@handleCreated} />
          else
            <CommentsWithForm.SignInWarning url={@props.sign_in_url} />
        }
      </div>
    </div>

  statics:
    Comments: React.createClass
      load: ->

      componentDidMount: ->
        @load()

      getInitialState: ->
        comments: null

      render: ->
        # 是否已经读取
        if @state.comments
          for comment in @state.comments
            <CommentsWithForm.Comment data={comment} />
        #else
          ## 显示正在读取
          #<Loading />

    Comment: React.createClass
      render: ->
        <div className="comment">
          <a className="avatar">
            <img src="http://semantic-ui.com/images/avatar/small/elliot.jpg" />
          </a>
          <div className="content">
            <a className="author">{@props.data.user_name}</a>
            <div className="metadata">
              <span className="date">
                <UTCDateTime datetime={@props.data.created_at} />
              </span>
            </div>
            <div className="text">
              {@props.data.content}
            </div>
          </div>
        </div> 

    Form: React.createClass
      done: (res)->
        @props.handleCreated(res.comment) if @props.handleCreated and res.comment
        @refs.form.refs.form.clear()

      render: ->
        {
          TextAreaField
          Submit
        } = DataForm

        layout =
          label_width: '100px'

        <div className="ui reply form">
          <h3 className='ui header dividing'>回复</h3>
          <SimpleDataForm
            model='comment'
            post={@props.url}
            done={@done}
            ref="form"
          >

            <TextAreaField {...layout} label='内容：' name='content' required />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>


    SignInWarning: ->
      render: ->
        <div className="">
          <h3 className='ui header dividing'>回复</h3>
          <p>
            登录后才能评论
          </p>
          <a href={@props.url}>点此登录</a>
        </div>
