class YouTube

  def self.search(query)
    results = get 'search', search_params(query)
    filtered = filter_results parse(results)
    ids = filtered.map {|v| v['id']['videoId'] }.join(',')
    results = get 'videos', id: ids, part: 'contentDetails'
    results = parse(results)
  end

  def self.filter_results(results)
    # make sure results dont have cover or live in their title or description
    results.select do |result|
      snippet = result['snippet']
      title, description = snippet['title'], snippet['description']
      title !~ filter_regex && description !~ filter_regex
    end
  end

  def self.is_embeddable?(id)
    result = get 'videos', id: id, part: 'status'
    video = parse(result)
    video.first['status']['embeddable']
  end

  def self.filter_regex
    Regexp.new filter_words.map{|word| '\b' + word + '\b' }.join('|'), Regexp::IGNORECASE
  end

  def self.filter_words
    %w(live cover performance)
  end

  def self.search_params(query)
    {
      part: 'snippet',
      maxResults: 50,
      q: query,
      type: 'video',
      # videoDefinition: 'high',
      videoEmbeddable: true
    }
  end

  def self.get(url, params = {})
    HTTParty.get "https://www.googleapis.com/youtube/v3/#{url}", query: params.merge(key: Rails.application.credentials.youtube[:api_key])
  end

  def self.parse(response)
    response.parsed_response['items']
  end
end
