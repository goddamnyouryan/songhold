# Songhold
Pulls songs from spotify playlists and uploads them as hold music

Links:
https://rossta.net/blog/paginated-resources-in-ruby.html
https://raw.githubusercontent.com/juicer-io/juicer/b231697abe39ac0af7f76c7bba4dc50806fa5e42/lib/social/spotify.rb?token=AAC4D47CPZYU755NP2XV6CDBFF75K

BUGS:
the track with uid 3rlluu6zEZ8ttXNEch00cA from spotify is pulling in a super long video, which is not what we want.
Do we not compare length of the track from spotify from the length of the youtube videos because we should? In this case, there just isnt a good video.

