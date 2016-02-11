@Bookmark = React.createClass
  goToLink: ->
    window.open(@props.bookmark.path, '_blank')
  removeClicked: (e) ->
    $.post '/bookmarks/'+@props.bookmark.id, {'_method': 'delete'}, =>
      @props.removeBookmark @props.bookmark.id
  editClicked: (e) ->
    @props.editMode(@props.bookmark)
  render: ->
    React.DOM.div
      className: 'col col-xs-6 col-md-4 col-lg-3 bookmark-listing'
      React.DOM.a
        onClick: @removeClicked
        React.DOM.i
          className: 'fa fa-remove text-muted listing-remove'
      React.DOM.h3
        className: 'bookmark'
        @props.bookmark.name
      React.DOM.ul
        className: 'text-muted fa-ul'
        React.DOM.li null,
          React.DOM.i
            className: 'fa-li fa fa-link'
          React.DOM.span
            className: ''
            React.DOM.a
              href: @props.bookmark.path
              target: '_blank'
              @props.bookmark.path
        if @props.bookmark.tags.length > 0
          labels = @props.bookmark.tags.map (t) -> t.label 
          React.DOM.li null,
            React.DOM.i
              className: 'fa-li fa fa-tag'
            labels.join(', ')

            
      React.DOM.button
        className: 'btn btn-sm btn-block btn-primary text-left go-to-btn'
        onClick: @goToLink
        React.DOM.span
          "Go To Link"
      React.DOM.button
        className: 'btn btn-sm btn-block btn-warning text-left edit-btn'
        onClick: @editClicked
        'data-toggle': 'modal'
        'data-target': '#'+@props.modal_id
        React.DOM.span
          "Edit"