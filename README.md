# Songhold
Pulls songs from spotify playlists and uploads them as hold music

Links:
https://rossta.net/blog/paginated-resources-in-ruby.html
https://raw.githubusercontent.com/juicer-io/juicer/b231697abe39ac0af7f76c7bba4dc50806fa5e42/lib/social/spotify.rb?token=AAC4D47CPZYU755NP2XV6CDBFF75K

BUGS:
the track with uid 3rlluu6zEZ8ttXNEch00cA from spotify is pulling in a super long video, which is not what we want.
Do we not compare length of the track from spotify from the length of the youtube videos because we should? In this case, there just isnt a good video.


Move the omniauth strategy to a gem:
- https://github.com/kmrshntr/omniauth-slack/blob/master/lib/omniauth/strategies/slack.rb
- https://github.com/zquestz/omniauth-google-oauth2/blob/master/lib/omniauth/strategies/google_oauth2.rb
- https://github.com/ringcentral/ringcentral-demos-oauth/blob/master/ruby-sinatra/app.rb
- https://github.com/wasabit/omniauth-angellist/blob/master/lib/omniauth/strategies/angellist.rb
- https://github.com/rdsoze/omniauth-buffer/blob/master/lib/omniauth/strategies/buffer.rb
- https://github.com/sandboxws/omniauth-behance
- https://www.polyglotprogramminginc.com/writing-a-non-gemified-strategy-for-omniauth/
- https://dev.to/vvo/devise-create-a-local-omniauth-strategy-for-slack-4066
- https://gist.github.com/dira/722793
- https://github.com/omniauth/omniauth/blob/master/lib/omniauth/strategy.rb
- https://github.com/omniauth/omniauth-oauth2/blob/master/lib/omniauth/strategies/oauth2.rb
- https://github.com/omniauth/omniauth-oauth2
