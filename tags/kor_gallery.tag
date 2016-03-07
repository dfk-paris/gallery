<kor-gallery>
  <div class="kor-gallery">
    <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
      <div class="slides"></div>
      <a class="prev">‹</a>
      <a class="next">›</a>
      <a class="close">×</a>
      <ol class="indicator"></ol>
    </div>

    <table>
      <tr each={row in grouped_items}>
        <td each={item in row} data-item-id={item.id} class="gallery-item">
          <a href={parent.parent.item_url(item)}>
            <img src={item.thumbnail} />
          </a>

          <div>
            <strong>{item.fotographer}</strong>
          </div>

          <div>
            {item.title} ({item.dating})
          </div>
        </td>
      </tr>
    </table>
  </div>

  <style type="text/scss">
    @import 'lib/blueimp-gallery.min';

    .blueimp-gallery .slide .slide-content {
      height: 100%;

      .kor-center-vertically {
        position: relative;
        top: 10%;
        height: 90%;

        img {
          max-height: 70%;
        }

        p {
          color: #ffffff;
        }
      }
    }
  </style>

  <script type="text/coffee">
    self = this

    # url: "#{self.opts.instance}/entities/gallery"
    # data: {page: self.opts.page || 1}

    self.slide_tpl = '
      <div class="slide-content">
        <div class="kor-center-vertically">
          <img src={medium} />
          <p>
            <strong>{title}</strong><br />
            {dating}, {fotographer}<br />
            © {copyright}
          </p>
        </div>
      </div>
    '

    update_heights = (event) ->
      if self.gallery && self.gallery.slides.length > 0
        $('.kor-center-vertically').css 'top', $(window).height() / 10

    self.on 'mount', ->

      $(window).on 'resize', update_heights

      $(self.root).on 'click', '.gallery-item > a', (event) ->
        event.preventDefault()
        item_id = $(event.target).parents('[data-item-id]').attr('data-item-id')
        initial = 0
        gallery_data = for e, i in self.data
          initial = i if "#{e.id}" == item_id
          {
            title: e.title
            href: e.medium
            thumbnail: e.thumbnail
            description: "Bla bla bla"
          }
        self.gallery = blueimp.Gallery(gallery_data,
          index: initial
          slideLoadingClass: 'kor-slide-loading'
          toggleControlsOnReturn: false
          onslide: (index, slide) ->
            item = self.data[index]
            new_content = riot.util.tmpl(self.slide_tpl, item)
            $(slide).html new_content
            update_heights()

        )


      $.ajax(
        url: self.opts.dataUrl
        dataType: 'json'
        success: (data) ->
          console.log data
          self.data = data
          self.grouped_items = kor.in_groups_of(data, 4)
          self.update()
      )

    self.item_url = (item) -> "#{self.opts.instance}/blaze#/entities/#{item.id}"
  </script>

</kor-gallery>