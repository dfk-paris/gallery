<kor-gallery>
  <div class="kor-gallery">
    <table>
      <tr each={row in grouped_items}>
        <td each={item in row} data-item-id={item.id}>
          <a target="_blank" href={parent.parent.item_url(item)}>
            <img src={parent.parent.opts.instance + item.url} />
          </a>

          <div each={pe in item.primary_entities}>
            <div each{se in pe.secondary_entities}>
              <a target="_blank" href={parent.parent.item_url(se)}>
                <strong>{se.name}</strong>
              </a>
            </div>  
          </div>

          <div each={pe in item.primary_entities}>
            <a target="_blank" href={parent.parent.item_url(pe)}>
              {pe.name}
            </a>
          </div>
        </td>
      </tr>
    </table>
  </div>

  <script type="text/coffee">
    self = this

    self.on 'mount', ->
      $.ajax(
        url: "#{self.opts.instance}/entities/gallery"
        dataType: 'json'
        data: {page: self.opts.page || 1}
        success: (data) ->
          console.log data
          self.data = data
          self.grouped_items = kor.in_groups_of(data.records, 4)
          self.update()
      )

    self.item_url = (item) -> "#{self.opts.instance}/blaze#/entities/#{item.id}"
  </script>

</kor-gallery>