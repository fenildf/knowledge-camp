@ManagerFinanceTellerWaresPage = React.createClass
  displayName: 'ManagerFinanceTellerWaresPage'
  getInitialState: ->
    wares: @props.data.wares
    paginate: @props.data.paginate
    filters: @props.data.filters

  render: ->
    <div className='manager-bank-teller-wares'>
      <ManagerFinanceTellerWaresPage.Table data={@state} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            number: '业务代码'
            kind: '业务类型'
            name: '业务名称'
            memo: '备注'
            ops: '操作'
          data_set: @props.data.wares.map (x)->
            jQuery.extend x, {
              kind: x.business_kind_str
              ops:
                <div>
                  <a href={x.preview_url} target='_blank' className='ui basic button mini'>预览</a>
                </div>
            }
          th_classes:
            number: 'collapsing '
          td_classes:
            number: 'number'
            kind: 'collapsing'
            ops: 'collapsing'
          paginate: @props.data.paginate
        }

        <div className='ui segment'>
          <ManagerTable data={table_data} title='前端柜员操作业务' />
        </div>


# 暂时没有启用

# ManagerFinanceTellerWaresCardsPage = React.createClass
#   displayName: 'ManagerFinanceTellerWaresPage'
#   getInitialState: ->
#     wares: @props.data.wares
#     paginate: @props.data.paginate

#   render: ->
#     <div className='manager-bank-teller-wares'>
#       <div className='wares'>
#         <div className='ui cards'>
#         {
#           for ware in @state.wares
#             <ManagerFinanceTellerWaresPage.WareCard key={ware.id} data={ware} />
#         }
#         </div>
#       </div>
#     </div>

#   statics:
#     WareCard: React.createClass
#       render: ->
#         ware = @props.data
#         <div className='card ware'>
#           <div className='content'>
#             <div className='right floated mini ui image'>
#               <div className='ic'>
#                 <i className='icon rmb' />
#               </div>
#             </div>
#             <div className='header number'>
#               {ware.number}
#             </div>
#             <div className='meta name'>
#               {ware.name}
#             </div>
#           </div>
#           <div className='extra content'>
#             <a className='ui basic button fluid pill' href={ware.manage_url}>
#               管　理
#             </a>
#           </div>
#         </div>
