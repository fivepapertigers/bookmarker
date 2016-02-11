@Bookmark = React.createClass
  goToLink: ->
    window.open(@props.bookmark.path, '_blank')
  render: ->
    React.DOM.div
      className: 'col col-xs-6 col-md-4 col-lg-3 bookmark-listing'
      React.DOM.h3
        className: 'bookmark'
        @props.bookmark.name
      React.DOM.ul
        className: 'list-unstyled'
        React.DOM.li null,
          React.DOM.span
            className: 'text-muted'
            " #{@props.bookmark.path}"
        React.DOM.li null,
          for tag in @props.bookmark.tags
            console.log(tag)
      React.DOM.button
        className: 'btn btn-sm btn-block btn-primary text-left'
        onClick: @goToLink
        React.DOM.span
          "Go To Link"