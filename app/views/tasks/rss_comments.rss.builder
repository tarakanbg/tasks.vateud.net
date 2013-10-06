xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{ORG} Latest Comments"
    xml.description "Vatsim European Division latest task comments feed"
    xml.link tasks_url

    for comment in @comments
      xml.item do
        xml.title comment.task.name
        xml.author comment.user.name
        xml.description comment.text
        xml.pubDate comment.created_at.to_s(:rfc822)
        xml.link task_url(comment.task)
        xml.guid task_url(comment.task)
      end
    end
  end
end