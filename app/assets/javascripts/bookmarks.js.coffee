@Bookmarks = React.createClass
  getInitialState: ->
    bookmarks: []
    active_tag_id: null
  componentDidMount: ->
    $.get '/bookmarks/', (data) =>
      @setState bookmarks: data
  componentWillReceiveProps: (new_props) ->
    @setState active_tag_id: new_props.active_tag_id
  addBookmark: (bookmark) ->
    bookmarks = @state.bookmarks.slice()
    bookmarks.unshift bookmark
    @setState bookmarks: bookmarks
  render: ->
    modal_id = "add_bookmark_modal"
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col col-xs-12 bg-primary btn btn-block lead'
        'data-toggle': 'modal'
        'data-target': '#'+modal_id
        React.DOM.span null,
          React.DOM.i
            className: 'fa fa-plus-circle'
          ' Add New Bookmark'
      React.DOM.hr null, null
      for bookmark in @state.bookmarks
        render_tag = false
        if @state.active_tag_id
          for tag in bookmark.tags
            if tag.id == @state.active_tag_id
              render_tag = true
        else
          render_tag = true
        if render_tag
          React.createElement Bookmark, key: bookmark.id, bookmark: bookmark
      React.DOM.div
        id: modal_id
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
                "Add a New Bookmark"
            React.DOM.div
              className: 'modal-body'
              React.createElement BookmarkForm, handleNewBookmark: @addBookmark, modal_id: modal_id