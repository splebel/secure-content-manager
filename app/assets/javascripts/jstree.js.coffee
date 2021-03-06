syncTree = (tree) ->

  data = $.ajax({
    url: '/home.json',
    async: false
  }).responseText
  data = JSON.parse(data)


  initially_select = []
  if window.location.hash != ''
    id = window.location.hash.substr(1)
    initially_select.push(id)

  if tree.html() == ''
    tree.jstree
      plugins:
        [ "themes", "json_data", "ui", "core", "types", "search", "adv_search" ]
      search:
        case_insensitive: true
        show_only_matches: true
      themes:
        theme: 'classic'
      ui:
        select_limit: 1
        initially_select: initially_select
      types:
        types:
          root:
            icon:
              image: "/assets/jstree/static/root.png"
          server:
            icon:
              image: "/assets/jstree/static/file.png"
          group:
            icon:
              image: "/assets/jstree/static/folder.png"

      json_data:
        data: data


    # On load
    tree.bind "loaded.jstree", ->
      # hack... :(
      setTimeout ->
        tree.find('a.jstree-clicked').click()
      , 50

  else
    $.jstree._focused()._get_settings().json_data.data = data
    tree.jstree('refresh')


$(document).ready ->

  $('.treeGroup').each ->

    treeGroup = $(this)
    tree = $(this).find('.tree')

    syncTree(tree)

    tree.on 'click', "li[rel=group] > a", (e) ->
      e.preventDefault()
      e.stopPropagation()
      tree.jstree('toggle_node', $(this).parent())

    tree.on 'click', "li[rel=server] > a", (e) ->
      hash = '#' + $(this).parent().attr('id')
      if history.pushState
        history.pushState(null, null, hash);
      else
        location.hash = hash;


    treeGroup.on 'keypress keydown keyup blur', 'input.search', ->
      search = $(this)

      value = search.val()

      # Skip if no change
      if search.data('last') == value
        return

      search.data('last', value)

      if value == ''
        tree.jstree('clear_search')
      else if value.length >= 2
        tree.jstree('search', value, true)
      else
        # Ignore if less than 2 characters

  $(document).on 'ajaxAction', (e) ->

    $('.treeGroup').each ->
      tree = $(this).find('.tree')
      syncTree(tree)
