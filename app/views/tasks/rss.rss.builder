*xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{Settings.org} New Tasks"
    xml.description "Vatsim European Division newly created tasks feed"
    xml.link tasks_url

    for task in @tasks
      xml.item do
        xml.title task.name
        xml.author task.author.name
        xml.description task.description
        xml.pubDate task.created_at.to_s(:rfc822)
        xml.link task_url(task)
        xml.guid task_url(task)
      end
    end
  end
end
