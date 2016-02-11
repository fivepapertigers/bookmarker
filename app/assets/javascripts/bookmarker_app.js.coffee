@BookmarkerApp = React.createClass
  getInitialState: ->
    bookmarks: []
    tags: []
    active_tag_id: null
  componentDidMount: ->
    $.get '/tags/', (data) =>
      @setState tags: data
  tagClicked: (tag_id) ->
    @setState active_tag_id: tag_id
  addTag: (tag) ->
    tags = @state.tags.slice()
    tags.push tag
    @setState tags: tags
  showAllTags: (e) ->
    @setState active_tag_id: null
  render: ->
    tag_modal_id = "add_tag_modal"
    all_active = if @state.active_tag_id then '' else 'active'
    React.DOM.div null,
      React.DOM.div
        className: "page-header text-center bg-white"
        React.DOM.h1 null,
          "#{@props.current_user.name}'s Bookmarks "
      React.DOM.div
        className: 'text-center'
        React.DOM.ul
          className: 'nav nav-pills tag-pills'
          React.DOM.li
            className: "add-tag-list-item #{all_active}"
            role: 'presentation'
            React.DOM.a
              href: '#'
              onClick: @showAllTags
              'All'
          for tag in @state.tags
            React.createElement Tag,
              key: tag.id
              tag: tag
              active: @state.active_tag_id == tag.id
              tagClickHandler: @tagClicked
          React.DOM.li
            className: 'add-tag-list-item'
            role: 'presentation'
            React.DOM.a
              href: '#'
              'data-toggle': 'modal'
              'data-target': '#'+tag_modal_id  
              React.DOM.i
                className: 'fa fa-plus-circle'
              React.DOM.span
                ' Add New Tag'
      React.DOM.div
        id: tag_modal_id
        className: 'modal fade'
        role: 'dalog'
        React.DOM.div
          className: 'modal-dialog'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header'
              React.DOM.button
                className: 'close'
                'data-dismiss': 'modal'
                React.DOM.i
                  className: 'fa fa-remove'
              React.DOM.h4 null,
                "Add a New Tag"
            React.DOM.div
              className: 'modal-body'
              React.createElement TagForm, handleNewTag: @addTag, tag_modal_id: tag_modal_id
      React.DOM.hr null, null
      React.createElement Bookmarks, active_tag_id: @state.active_tag_id