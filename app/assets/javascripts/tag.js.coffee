@Tag = React.createClass
  getInitialState: ->
    active: null
  clickHandler: (e) ->
    @props.tagClickHandler(@props.tag.id)
    @setState active: true
  removeClicked: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.post '/tags/'+@props.tag.id, {'_method': 'delete'}, =>
      @props.removeTag @props.tag.id
  componentWillReceiveProps: (new_props) ->
    @setState active: new_props.active, remove_mode: new_props.remove_mode
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
        onClick: if @state.remove_mode then @removeClicked else @clickHandler
        "#{@props.tag.label}    "
        if @state.remove_mode
          React.DOM.i
            className: 'fa fa-remove fa-xs text-danger'