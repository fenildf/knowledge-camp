@Loading = React.createClass
  componentDidMount: ->
    jQuery('.react-loading').dimmer('show')

  componentWillUnmount: ->
    jQuery('.react-loading').dimmer('hide')

  render: ->
    <div className="ui inverted dimmer react-loading">
      <div className="ui text loader">加载中</div>
    </div>

