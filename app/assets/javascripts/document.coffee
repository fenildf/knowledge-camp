get_content = ($content_editor)->
  $textarea = $content_editor.find('textarea').remove()
  return $textarea.val() || ''

focus_title = ($ipt)->
  return if $ipt.val().length > 0
  $ipt.focus()

init_ue = (content, $content_editor)->
  $content_editor.hide()

  UE.instants = {}
  
  ue = new UE.ui.Editor
    zIndex: 100
    toolbars: [[
      'bold', 'underline', 'strikethrough', 
      'insertorderedlist', 'insertunorderedlist',
      'quote', 'link', 'unlink'
      'source'
    ]]

  ue.ready ->
    ue.setContent content
    $content_editor.fadeIn(200)

    # 格式栏顶部浮动
    $toolbar = jQuery('.edui-mindpin.edui-editor-toolbarboxouter')
    add_fixtop($toolbar, 10, 102)
    check_fixtop()
    $parent = $toolbar.parent()
    $parent.height $parent.height()

  ue.render $content_editor[0]

  return ue

init_save_button = ($title_ipt, ue, url, method)->
  $btn = jQuery('.document .ops .save')

  $btn.on 'click', ->
    title = $title_ipt.val()
    content = ue.getContent()

    jQuery.ajax
      url: url
      type: method
      data:
        document:
          title: title
          content: content
      success: (res)->
        Turbolinks.visit res.url

jQuery(document).on 'ready page:load', ->
  $editor = jQuery('.document .page.editor')

  if $editor.length > 0
    $title_ipt = $editor.find('.title-editor input')
    $content_editor = $editor.find('.content-editor')

    focus_title $title_ipt
    content = get_content $content_editor

    ue = init_ue content, $content_editor

    url = $editor.data('url')
    method = $editor.data('method')
    init_save_button($title_ipt, ue, url, method)