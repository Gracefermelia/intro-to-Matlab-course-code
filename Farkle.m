function Farkle()
    % Farkle - A dice game where players compete to reach 10,000 points
    % No input/output variables; displays game progress in the command window

    clc;  % Clear the command window
    fprintf('Welcome to the game of Farkle!\n\n');

    % Ask for the number of players
    numPlayers = input('Enter the number of players: ');
    
    % Validate input
    while isempty(numPlayers) || numPlayers < 2 || mod(numPlayers,1) ~= 0
        numPlayers = input('Invalid input. Please enter a valid number of players (integer >=2): ');
    end

    % Initialize player scores and round counter
    scores = zeros(1, numPlayers);  % Store scores for each player
    roundCount = 0;
    winningScore = 10000;  % Target score to win

    % Game Loop - continues until one player reaches 10,000 points
    while all(scores < winningScore)
        roundCount = roundCount + 1;
        fprintf('\n--- Round %d ---\n', roundCount);
        
        % Each player takes a turn
        for player = 1:numPlayers
            fprintf('Player %d, it is your turn!\n', player);
            
            % Simulate a turn (custom function to roll dice and calculate points)
            points = takeTurn();
            scores(player) = scores(player) + points;
            
            fprintf('Player %d scored %d points this round. Total: %d\n', player, points, scores(player));
            
            % Check if the player has won
            if scores(player) >= winningScore
                fprintf('\n*** Player %d has reached 10,000 points and wins the game! ***\n', player);
                break;  % Exit the loop
            end
        end
    end

    % Display final scores
    fprintf('\n--- Final Scores ---\n');
    for player = 1:numPlayers
        fprintf('Player %d: %d points\n', player, scores(player));
    end
    
    % Display total rounds played
    fprintf('\nThe game lasted for %d rounds.\n', roundCount);
end

%% Subfunction: Take a Turn (Rolling Dice)
function score = takeTurn()
    % Simulates a player's turn by rolling dice and scoring points

    numDice = 6; % Start with 6 dice
    score = 0;
    farkle = false; % Flag to track a "Farkle" (a turn with no scoring)

    while numDice > 0
        % Roll the dice
        roll = randi([1,6], 1, numDice);
        fprintf('You rolled: ');
        disp(roll);

        % Calculate points based on common Farkle rules
        points = calculateScore(roll);
        
        if points == 0
            fprintf('FARKLE! No points scored this turn.\n');
            farkle = true;
            break; % End turn with no points
        else
            score = score + points;
            fprintf('Points earned this roll: %d | Total this turn: %d\n', points, score);
            
            % Ask if player wants to continue rolling (risk losing points)
            choice = input('Do you want to roll again? (1 = Yes, 0 = No): ');
            if choice == 0
                break;
            end
        end
    end

    % If the player Farkled, they lose all points from this turn
    if farkle
        score = 0;
    end
end

%% Subfunction: Calculate Score Based on Roll
function points = calculateScore(roll)
    % Assigns point values based on Farkle scoring rules

    points = 0;
    counts = histcounts(roll, 1:7); % Count occurrences of each number (1-6)

    % Check for scoring combinations
    if counts(1) >= 3
        points = points + 1000 + (counts(1) - 3) * 100; % Three 1s = 1000, extra 1s = 100 each
    elseif counts(1) > 0
        points = points + counts(1) * 100; % Each single 1 = 100
    end

    if counts(5) >= 3
        points = points + 500 + (counts(5) - 3) * 50; % Three 5s = 500, extra 5s = 50 each
    elseif counts(5) > 0
        points = points + counts(5) * 50; % Each single 5 = 50
    end

    % Three-of-a-kind rules (other than 1s and 5s)
    for num = 2:6
        if counts(num) >= 3
            points = points + num * 100; % Three 2s = 200, Three 3s = 300, etc.
        end
    end
end
