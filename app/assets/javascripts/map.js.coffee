initHappyMap = ->
  if ($ '#happyMap').size() > 0
    maximizeMap(($ '#happyMap'))
    center = new L.LatLng(50.941252, 6.958283)
    map = new L.Map('happyMap', { center: center, zoom: 13 })

    cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/29dbe9cf32a84247b2513fc03266b085/997/256/{z}/{x}/{y}.png');

    map.addLayer(cloudmade)

    marker = new L.Marker(center)
    map.addLayer(marker)

maximizeMap = (map)->
  map.width(($ window).width())
  map.height(($ window).height())

$ ->
  initHappyMap()
  ($ window).resize =>
    maximizeMap(($ '#happyMap'))

