<pb-gallery>
  <div class="pb-gallery">
    <div id={gid} class="blueimp-gallery blueimp-gallery-controls">
      <div class="slides"></div>
      <a class="prev">‹</a>
      <a class="next">›</a>
      <a class="close">×</a>
      <ol class="indicator"></ol>
    </div>

    <div class="pb-item" each={item, i in data} data-item-id={i}>
      <div class="pb-medium">
        <img src={item.urls.thumbnail} />
      </div>

      <div class="pb-description" if={parent.shortCaption(item)}>
        {parent.shortCaption(item)}
      </div>
    </div>

    <yield />

    <div class="clearfix"></div>
  </div>

  <style type="text/scss">
    @import 'lib/blueimp-gallery.min';
    @import 'lib/pb-gallery';

    .pb-gallery {
      .next, .prev {
        line-height: 42px;
      }

      .pb-item {
        box-sizing: border-box;
        cursor: pointer;

        width: 265px;
        height: 380px;
        padding: 20px;
        border: 1px solid gallery;
        float: left;
        margin-right: 20px;

        .pb-medium {
          height: 225px;
          width: 100%;
          margin-bottom: 20px;

          img {
            max-width: 100%;
            max-height: 100%;
          }
        }
      }
    }

    .blueimp-gallery .slide .slide-content {
      height: 100%;

      .pb-center-vertically {
        position: relative;
        top: 10%;
        height: 90%;

        img, audio, video {
          max-height: 70%;
        }

        p {
          color: #ffffff;
        }
      }
    }
  </style>

  <script type="text/coffee">
    tag = this

    tag.gid = "blueimp-gallery-#{Math.floor(Math.random() * 10000000000)}"

    tag.slide_tpl = '
      <div class="slide-content pb-image">
        <div class="pb-center-vertically">
          <img src={urls.normal} />
          <p>{caption}</p>
        </div>
      </div>
    '

    update_heights = (event) ->
      if tag.gallery && tag.gallery.slides.length > 0
        $('.pb-center-vertically').css 'top', $(window).height() / 10

    tag.on 'mount', ->
      $(window).on 'resize', update_heights

      $(tag.root).on 'click', '.pb-item', (event) ->
        event.preventDefault()

        item_id = parseInt(
          $(event.target).parents('[data-item-id]').attr('data-item-id')
        )

        initial = 0
        for e, i in tag.data
          e.href = e.urls.thumbnail
          initial = i if item_id == i

        tag.gallery = blueimp.Gallery(tag.data,
          container: "##{tag.gid}"
          index: initial
          slideLoadingClass: 'pb-slide-loading'
          toggleControlsOnReturn: false
          thumbnailIndicators: false
          onslide: (index, slide) ->
            item = tag.data[index]
            tpl = "slide_tpl"
            new_content = riot.util.tmpl(tag[tpl], item)
            $(slide).html new_content
            update_heights()
        )

      tag.data = []
      items = tag.tags['pb-item']
      items = [items] if !$.isArray(items)
      for item in items
        tag.data.push item.item()
      tag.update()

    tag.shortCaption = (item) ->
      console.log(item)
      item.shortCaption || item.caption

  </script>

</pb-gallery>