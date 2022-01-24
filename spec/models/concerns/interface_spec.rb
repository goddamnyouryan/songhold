require 'rails_helper'

describe Interface do
  describe '.like_all_album_songs' do
    let(:token) {'BQCFXLipKATPyeoWDmbcy0cu8QsIa_qwUMPwNtawVmhTswxore4XcWYWN3n6PpyFq_SJYJyDqQv1CJcVRXBiGlwkl9CXazvpR6t8PNF9gwEXMeTDHDYNeg-m1YxLnjKI8MtBmkEaC4NWbgnUF1p4E0Jq5xxm3AaJw1XMoeAn62QjQ-MAwFae2HNyYXw0iTQxBU8W' }
    let(:interface) { Interface.new(token) }

    it 'likes all the songs from the albums' do
      interface.like_all_album_songs
    end
  end
end
