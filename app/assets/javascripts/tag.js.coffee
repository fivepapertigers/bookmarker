@Tag = React.createClass
  getInitialState: ->
    active: null
  clickHandler: (e) ->
    @props.tagClickHandler(@props.tag.id)
    @setState active: true
  componentWillReceiveProps: (new_props) ->
    @setState active: new_props.active
  render: ->
    if @state.active
      active = 'active'
    else
      active = ''
    React.DOM.li
      role: 'presentation'
      className: "tag-list-item #{active}"
      React.DOM.a
        className: 'tag'
        href: '#'
        onClick: @clickHandler
        @props.tag.label