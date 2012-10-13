class WelcomeController < ApplicationController

  def about
    @team_members = [
      {
        name: "bitboxer",
        github: "https://github.com/bitboxer",
        twitter: "http://twitter.com/bitboxer",
        desc: %q{Owns a colorful collection of crayons},
        img: 'bitboxer.jpg'
      },
      {
        name: "klaustopher",
        github: "https://github.com/klaustopher",
        twitter: "http://twitter.com/klaustopher",
        desc: "Chocolate for the mob",
        img: 'klaustopher.jpg'
      },
      {
        name: "moonglum",
        github: "https://github.com/moonglum",
        twitter: "http://twitter.com/moonbeamlabs",
        desc: "Replaced his hair with <3",
        img: 'moonglum.jpg'
      },
      {
        name: "EinLama",
        github: "https://github.com/EinLama",
        twitter: "http://twitter.com/l_ama",
        desc: "Trying to minimize visual catastrophies",
        img: 'EinLama.jpg'
      }
    ]
  end
end
