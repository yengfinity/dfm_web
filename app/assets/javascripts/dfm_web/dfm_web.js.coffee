# DFM Web Common Javascript

# Method to filter Table rows by a search query
# Your table must have the class live_table
# Your search field must have the class live_search
# See below for the binding.
filter_table_rows = (searched) ->
  $('.live_table > tbody > tr').show().filter(->
    text = $(this).text()
    ! ~text.indexOf(searched)
  ).hide()


$(document).on 'ready page:load', ->

  # Activate Tablesorter (add to table)
  $('.tablesorter').tablesorter({widgets: ['zebra']}) unless typeof(tablesorter) == "undefined"

  # Hide the flash[:notice] after 5 seconds
  $('#notice, #alert').click ->
    $(this).slideUp('slow')

  # Load anything you want with ajax easily.  Add ajax_load class to a div and set path html5 data attrib.
  $(".ajax_load").each ->
    $(this).load( $(this).data('path') )

  # Activate DatePicker (add to text_field)
  $('.datepicker').datepicker dateFormat: "yy-mm-dd"  unless typeof(datepicker) == "undefined"

  # Live search a table
  filter_table_rows($('#live_search').val())  # Initial Page Load
  $('#live_search').keyup ->                  # Refresh with user input.
    filter_table_rows($(this).val())

  # Submit Form on element change
  $(".auto_submit").change ->
    if this.form.hasAttribute("data-remote")
      $(this).submit()  # Remote form must call submit on a JQuery object
    else
      this.form.submit()  # Regular HTML submit

  # Show the Mobile Menu on Hamburger Click
  $('nav #nav').click ->
    $("nav #nav .right").toggle()
