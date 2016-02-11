@TagForm = React.createClass
  url_regex: new RegExp("https?://.+")
  route: '/tags'
  getInitialState: ->
    label:''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault();
    if @valid
      $.post @route, {tag: @state}, (data) =>
        $('#'+@props.modal_id).modal('hide');
        @props.handleNewTag data
        @setState @getInitialState
    return false
  valid: ->
    @state.label
  render: ->
    React.DOM.form
      onSubmit: @handleSubmit
      React.DOM.div 
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Insert tag name here'
          name: 'label'
          onChange: @handleChange
          value: @state.label
          required: true
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Add'