@BookmarkForm = React.createClass
  url_regex: new RegExp("https?://.+")
  route: '/bookmarks'
  getInitialState: ->
    name:''
    path:'http://'
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault();
    if @valid
      $.post @route, {bookmark: @state}, (data) =>
        console.log '#'+@props.modal_id
        $('#'+@props.modal_id).modal('hide');
        @props.handleNewBookmark data
        @setState @getInitialState
    return false
  valid: ->
    @state.name && @state.path.match(@url_regex)
  render: ->
    React.DOM.form
      onSubmit: @handleSubmit
      React.DOM.div 
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Name'
          name: 'name'
          onChange: @handleChange
          value: @state.name
          required: true
      React.DOM.div 
        className: 'form-group'
        React.DOM.input
          type: 'url'
          className: 'form-control'
          placeholder: 'URL'
          name: 'path'
          onChange: @handleChange
          required: true
          value: @state.path
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Add'