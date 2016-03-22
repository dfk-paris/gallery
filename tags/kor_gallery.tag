<kor-gallery>
  <div class="kor-gallery">
    <div id={gid} class="blueimp-gallery blueimp-gallery-controls">
      <div class="slides"></div>
      <a class="prev">‹</a>
      <a class="next">›</a>
      <a class="close">×</a>
      <ol class="indicator"></ol>
    </div>

    <div class="kor-item kor-{item.type}" each={item in data} data-item-id={item.id}>
      <div class="kor-medium">
        <a href={parent.item_url(item)}>
          <img src={item.urls.thumbnail} />
        </a>
      </div>

      <div class="kor-description"></div>
        <div>
          <strong>{item.fotographer}</strong>
        </div>
        <div>
          {item.title}
          <span if={item.dating}>({item.dating})</span>
        </div>
      </div>
    </div>

    <div class="clearfix"></div>
  </div>

  <style type="text/scss">
    @import 'lib/blueimp-gallery.min';
    @import 'lib/kor-gallery';

    .kor-gallery {
      .kor-item {
        box-sizing: border-box;

        width: 265px;
        height: 380px;
        padding: 20px;
        border: 1px solid gallery;
        float: left;
        margin-right: 20px;

        .kor-medium {
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

      .kor-center-vertically {
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
    self = this

    self.gid = "blueimp-gallery-#{Math.floor(Math.random() * 10000000000)}"

    self.slide_image_tpl = '
      <div class="slide-content kor-image">
        <div class="kor-center-vertically">
          <img src={urls.thumbnail} />
          <p>
            <strong>Titre: </strong>{title}<br />
            <strong>Date: </strong>{date}<br />
            <strong>Photo: </strong>{photographer}<br />
            © {copyright}
          </p>
        </div>
      </div>
    '

    self.slide_audio_tpl = '
      <div class="slide-content kor-audio">
        <div class="kor-center-vertically">
          <audio controls preload>
            <source src={urls["audio/mp3"]} type="audio/mp3" />
            <source src={urls["audio/ogg"]} type="audio/ogg" />
          </audio>
          <p>
            <strong>{title}</strong><br />
            {dating}, {fotographer}<br />
            © {copyright}
          </p>
        </div>
      </div>
    '

    self.slide_video_tpl = '
      <div class="slide-content kor-video">
        <div class="kor-center-vertically">
          <video controls preload>
            <source src={urls["video/mp4"]} type="video/mp4" />
            <source src={urls["video/webm"]} type="video/webm" />
            <source src={urls["video/ogv"]} type="video/ogg" />
          </video>
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

      $(self.root).on 'click', '.kor-item .kor-medium a', (event) ->
        event.preventDefault()

        item_id = parseInt(
          $(event.target).parents('[data-item-id]').attr('data-item-id')
        )

        initial = 0
        for e, i in self.data
          e.href = e.urls.thumbnail
          initial = i if e.id == item_id

        self.gallery = blueimp.Gallery(self.data,
          container: "##{self.gid}"
          index: initial
          slideLoadingClass: 'kor-slide-loading'
          toggleControlsOnReturn: false
          thumbnailIndicators: false
          onslide: (index, slide) ->
            item = self.data[index]
            tpl = "slide_#{item.type}_tpl"
            new_content = riot.util.tmpl(self[tpl], item)
            $(slide).html new_content
            update_heights()
        )

      $.ajax(
        url: self.opts.dataUrl
        dataType: 'json'
        success: (data) ->
          console.log data

          self.data = data
          for e in self.data
            for k, v of e.urls
              unless k == 'type'
                e.urls[k] = self.absolutize(v)
            
          self.update()
      )

    self.absolutize = (path) ->
      if path.match(/^http/)
        path
      else
        self.opts.dataUrl.replace(/\/[^\/]+$/, "/#{path}")
    self.item_url = (item) -> "#{self.opts.instance}/blaze#/entities/#{item.id}"
    self.thumbnail_url = (item) -> item.urls.thumbnail
    self.normal_url = (item) -> item.urls.thumbnail.replace(/\/thubmnail\//, '/normal/')
  </script>

</kor-gallery>