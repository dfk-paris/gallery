<pb-item>

  <script type="text/javascript">
    var tag = this;

    tag.item = function() {
      return {
        'urls': {
          'thumbnail': tag.opts.thumb || tag.opts.url,
          'normal': tag.opts.url,
        },
        'caption': tag.opts.caption,
        'shortCaption': tag.opts.shortCaption,
        'type': tag.opts.type || 'image'
      }
    }
  </script>
</pb-item>