namespace :programs do
  desc "TODO"
  task share_each_group_member: :environment do
    i = 0
    ProgramParam.update_all status: ProgramParam.statuses['ok']
    loop do
      Program.share_each_group_member.each do |program|
        i+=1
        puts i
        sleep 3

        program_params = program.program_params.ok.order(:unipos_received_number)
        next if program_params.size < 2
        program_param_a = program_params[-1]
        program_param_b = program_params[0]

        data = {
          "jsonrpc":"2.0",
          "method":"Unipos.SendCard",
          "params": {
            "from_member_id": "#{program_param_a.unipos_user_id}",
            "to_member_id":"#{program_param_b.unipos_user_id}",
            "point": program.unipos_share_number,
            "message": [
              "#AppreciateTeamwork*1",
              "#AccurateOutput",
              "#Awesome",
              "#BeProfessional*6",
              "#BridgeBuilding",
              "#Congratulations",
              "#ContinuousThanks",
              "#Excellent",
              "#Fast&Furious",
              "#FocusOnThePoint*7",
              "#GoodJob",
              "#HaveTheGutsToChallenge*3",
              "#SoHappyForYou",
              "#SpeedUp*5",
              "#ThinkOutsideTheBox*2",
              "#ThinkPositive*4",
              "#UnsungHero"
            ].sample
          },
          "id":"Unipos.SendCard"
        }
        command = program_param_a.unipos_request.gsub(/--data-binary '.+'/, "--data-binary '#{data.to_json}'")

        puts "send #{program.unipos_share_number} point from #{program_param_a.unipos_user_id} to #{program_param_b.unipos_user_id}"

        response = begin
          JSON.parse(`#{command}`)
        rescue Exception => e
          { 'error' => e }
        end

        if response['error']
          puts response['error']
          program_param_a.error!
        else
          program_param_a.decrement!(:unipos_received_number, program.unipos_share_number)
          program_param_b.increment!(:unipos_received_number, program.unipos_share_number)
        end
      end
    end

    puts 'Exited!'
  end
end
