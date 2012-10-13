class WelcomeController < ApplicationController

  def about
    @team_members = [
      {
        name: "bitboxer",
        github: "https://github.com/bitboxer",
        desc: %q{Bodobodododo is not Frododododo},
        img: 'bitboxer.jpg'
      },
      {
        name: "klaustopher",
        github: "https://github.com/klaustopher",
        desc: "Chocolate for the mob",
        img: 'klaustopher.jpg'
      },
      {
        name: "moonglum",
        github: "https://github.com/moonglum",
        desc: "Replaced his hair with <3",
        img: 'moonglum.jpg'
      },
      {
        name: "EinLama",
        github: "https://github.com/EinLama",
        desc: "Trying to minimize visual catastrophies",
        img: 'EinLama.jpg'
      }
    ]
  end
end
