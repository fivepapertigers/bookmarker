@Bookmarks = React.createClass
  getInitialState: ->
    bookmarks: []
    tags: []
    active_tag_id: null
    edit_bookmark: {}
  componentDidMount: ->
    $.get '/bookmarks/', (data) =>
      @setState bookmarks: data
  componentWillReceiveProps: (new_props) ->
    @componentDidMount()
    @setState active_tag_id: new_props.active_tag_id, tags: new_props.tags
  addBookmark: (bookmark) ->
    bookmarks = @state.bookmarks.slice()
    bookmarks.unshift bookmark
    @setState bookmarks: bookmarks
  updateBookmark: (new_bookmark) ->
    for bookmark,i in @state.bookmarks
      if bookmark.id == new_bookmark.id
        bookmarks = @state.bookmarks
        bookmarks[i] = new_bookmark
        @setState bookmarks: bookmarks
        break
  removeBookmark: (bookmark_id) ->
    for bookmark,i in @state.bookmarks
      if bookmark.id == bookmark_id
        bookmarks = @state.bookmarks
        bookmarks.splice i, 1
        @setState bookmarks: bookmarks
        break
  editMode: (bookmark) ->
    @setState edit_bookmark: bookmark
  render: ->
    add_modal_id = "add_bookmark_modal"
    edit_modal_id = "edit_bookmark_modal"
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col col-xs-12 bg-primary btn btn-block lead'
        'data-toggle': 'modal'
        'data-target': '#'+add_modal_id
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
          React.createElement Bookmark, key: bookmark.id, bookmark: bookmark, removeBookmark: @removeBookmark, modal_id: edit_modal_id, editMode: @editMode
      React.DOM.div
        id: add_modal_id
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
              React.createElement BookmarkForm, handleNewBookmark: @addBookmark, modal_id: add_modal_id, tags: @state.tags
      React.DOM.div
        id: edit_modal_id
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
                "Edit Bookmark"
            React.DOM.div
              className: 'modal-body'
              React.createElement BookmarkForm, handleUpdatedBookmark: @updateBookmark, bookmark: @state.edit_bookmark, tags: @state.tags, edit_mode: true, modal_id: edit_modal_id