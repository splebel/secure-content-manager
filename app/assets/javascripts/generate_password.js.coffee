window.generate_password = (link) ->

  length = 15
  chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  pass = ''
  pass += chars[Math.round(Math.random() * chars.length - 1 )] while pass.length < length

  pass_field = $(link).parent().find('input')

  if $(pass_field).val().length
    if confirm "This will overwrite existing password! Continue?" 
      $(pass_field).val(pass)
  else
    $(pass_field).val(pass)
