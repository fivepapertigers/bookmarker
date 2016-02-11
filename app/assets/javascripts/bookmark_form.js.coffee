@BookmarkForm = React.createClass
  url_regex: new RegExp("https?://.+")
  route: '/bookmarks'
  getInitialState: ->
    name: ''
    path:'http://'
    tags: []
  componentWillReceiveProps: (new_props) ->
    $('.checkbox').prop('checked', false)
    if @props.edit_mode
      bookmark = new_props.bookmark
      if bookmark.tags
        for tag in bookmark.tags
          $('#'+@props.modal_id+' .checkbox'+tag.id).prop('checked', true)
      @setState
        bookmark: new_props.bookmark
        name: bookmark.name
        path: bookmark.path
    @setState
      tags: new_props.tags
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault();
    if @valid
      checkbox_values = []
      $('#'+@props.modal_id + ' input:checkbox:checked').each ->
        value = parseInt this.value
        checkbox_values.push value
      bookmark = name: @state.name, path: @state.path, tag_ids: checkbox_values
      route = if @props.edit_mode then @route+'/'+@props.bookmark.id else @route
      method = if @props.edit_mode then 'PUT' else 'POST'
      $.ajax route,
        data: {bookmark: bookmark}
        method: method
        success: (data) =>
          $('#'+@props.modal_id).modal('hide');
          if @props.edit_mode
            @props.handleUpdatedBookmark data
          else
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
      if @state.tags.length > 0
        
        React.DOM.div
          className: 'form-group'
          React.DOM.hr {}, null
          React.DOM.h5 null,
            'Choose any of following tags:'
          for tag in @state.tags
            React.DOM.label
              className: "checkbox-inline"
              key: tag.id
              React.DOM.input
                className: 'checkbox checkbox' + tag.id
                type: 'checkbox'
                name: 'tag_ids'
                value: tag.id
                onChange: @handleTagChange
              tag.label
          React.DOM.hr {}, null
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        "#{if @props.edit_mode then 'Update' else 'Add'}"