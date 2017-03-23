${resfn.css(["/map-with-pins/.*styles.css"])}

${resfn.js(["/map-with-pins/webresources/js/jquery-1.12.4.js",
            "/map-with-pins/webresources/js/jquery-ui.js"])}

<div class="pin-on-map">

  <div class='map'>
    [#if content.map?has_content]
      [#assign map = damfn.getAsset(content.map)]
      [#assign mapLink = map.link]
      <img src='${mapLink!}' class='img-responsive' alt='image'>
    [/#if]

    <div class='pins [#if cmsfn.editMode]editMode[/#if]'></div>

  </div>
</div>


<script type="text/javascript">
  var pins = [];
  var defLeft = 50;
  var defTop = 50;

  pins = [
    [#if content.pins?has_content]
      [#assign pins = cmsfn.children(content.pins)]
      [#if pins?has_content && pins?size > 0]
        [#list pins as pin]
          [#if pin_index != 0],[/#if]
          {
            "name":"${pin.@name}",
            "title":"${pin.title!}",
            "address":"${pin.address!}",
            "top":"${pin.top!}",
            "left":"${pin.left!}"
          }
        [/#list]
      [/#if]
    [/#if]
  ];

  function pinHtml(name,title,address){
    return "<div class='pin new' pin='"+name+"'><div class='pinLabel'>"+title+"<div class='address'>"+address+"</div></div><div class='arrows'></div></div>"
  }

  function widthToPercents(num){
    var perc = num / ($(".pins").width() / 100);
    return Math.round(perc * 100) / 100;
  }
  function heightToPercents(num){
    var perc = num / ($(".pins").height() / 100);
    return Math.round(perc * 100) / 100;
  }

  function widthFromPercents(perc){
    var num = ($(".pins").width() / 100) * perc;
    return Math.round(num);
  }
  function heightFromPercents(perc){
    var num = ($(".pins").height() / 100) * perc;
    return Math.round(num);
  }

  function render(){
    $( ".pin" ).remove();

    pins.forEach( function (pin) {
      $( ".pins" ).append( pinHtml(pin.name,pin.title,pin.address) );
      $( ".pin.new" ).css({ top: pin.top+"%" , left: pin.left+"%" }).removeClass('new');

      [#if cmsfn.editMode]
        $( ".pin" ).draggable({
          stop: function(){
              var top = $(this).position().top;
              var left = $(this).position().left;
              saveOffset($(this).attr('pin'),widthToPercents(left),heightToPercents(top));
          }
        });
      [/#if]

    });
  }

  [#if cmsfn.editMode]
    function saveOffset(name,left,top) {
      var dataObject = {
        "property": [
              {
                "name": "left",
                "type": "String",
                "multiple": false,
                "value": [
                  left
                ]
              },
              {
                "name": "top",
                "type": "String",
                "multiple": false,
                "value": [
                  top
                ]
              }
            ]
          };

      $.ajax({
          url: '${ctx.contextPath}/.rest/nodes/v1/website${content.@path}/pins/'+name,
          type: 'POST',
          data: JSON.stringify(dataObject),
          contentType: 'application/json',
          success: function(result) {
          }
      });
    }
  [/#if]

  $( document ).ready( function () {
    render();
  });

</script>
