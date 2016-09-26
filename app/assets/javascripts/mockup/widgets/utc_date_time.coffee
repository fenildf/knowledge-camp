#需要引用vendor的jquery-dateFormat.min
#= require jquery-dateFormat.min
@UTCDateTime = React.createClass
  render: ->
    @string = @props.defaultNullValue || ''
    @format = @props.format || "yyyy-MM-dd HH:mm"
    @string = jQuery.format.date(@props.datetime, @format) if @props.datetime
    <span>
      {@string}
    </span>
