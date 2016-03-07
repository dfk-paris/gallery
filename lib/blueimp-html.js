blueimp.Gallery.prototype.textFactory = function (obj, callback) {
  var $element = $('<div>')
    .addClass('text-content')
    .attr('title', obj.title);
    $element.html(obj.html);
    callback({
      type: 'load',
      target: $element[0]
    });
  return $element[0];
};