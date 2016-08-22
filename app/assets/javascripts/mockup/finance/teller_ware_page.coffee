@FinanceTellerWarePage = React.createClass
  getInitialState: ->
    ware: @props.data.ware
  render: ->
    data = 
      baseinfo: @state.ware
      actioninfo:
        actions: @state.ware.actions
      relative_wares: @props.data.relative_wares
      hmdm_url: @props.data.hmdm_url

    <div>
      <TellerCourseWare data={data} />
    </div>

