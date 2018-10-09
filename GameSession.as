package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				State for the main gameplay session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameSession
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get buildDownPiles():Array
		{
			return _buildDownPiles;
		}
		
		public function set buildDownPiles(value:Array):void
		{
			_buildDownPiles = value;
		}
		
		public function get buildUpPiles():Array
		{
			return _buildUpPiles;
		}
		
		public function set buildUpPiles(value:Array):void
		{
			_buildUpPiles = value;
		}
		
		public function get cards():CardStack
		{
			return _cards;
		}
		
		public function get dealDeck():DealDeck
		{
			return _dealDeck;
		}
		
		public function set dealDeck(value:DealDeck):void
		{
			_dealDeck = value;
		}
		
		public function get dealState():DealState
		{
			return _dealState;
		}
		
		public function set dealState(value:DealState):void
		{
			_dealState = value;
		}
		
		public function get drawPile():DrawPile
		{
			return _drawPile;
		}
		
		public function set drawPile(value:DrawPile):void
		{
			_drawPile = value;
		}
		
		public function get finalPlayIndex():int
		{
			return _finalPlayIndex;
		}
		
		public function set finalPlayIndex(value:int):void
		{
			_finalPlayIndex = value;
		}
		
		public function get hand():CardHand
		{
			return _hand;
		}
		
		public function set hand(value:CardHand):void
		{
			_hand = value;
		}
		
		public function get selectedCard():Card
		{
			return _selectedCard;
		}
		
		public function set selectedCard(value:Card):void
		{
			_selectedCard = value;
		}
		
		public function get stacks():Array
		{
			return _stacks;
		}
		
		public function set stacks(value:Array):void
		{
			_stacks = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _buildDownPiles:Array;
		private var _buildUpPiles:Array;
		private var _cards:CardStack;
		private var _controller:GameController;
		private var _dealDeck:DealDeck;
		private var _dealState:DealState;
		private var _drawPile:DrawPile;
		private var _finalPlayIndex:int;
		private var _hand:CardHand;
		private var _parent:Application;
		private var _sceneManager:GameSceneManager;
		private var _selectedCard:Card;
		private var _stacks:Array;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameSession(parent:Application)
		{
			_parent = parent;
			
			_sceneManager = new GameSceneManager(this);
			_controller = new GameController(this, _sceneManager);
			
			_selectedCard = null;
			_finalPlayIndex = 0;
			
			InitializeCards();
			InitializeStacks();
			_finalPlayIndex = 0;
			
			InitializeGraphics();
			
			_controller.DealNewGame();
		}
		
		private function InitializeCards():void
		{
			_cards = new CardStack(null);

			for (var deck:int = 0; deck < 2; deck++)
			{
				for (var suit:int = 1; suit < 5; suit++)
				{
					for (var rank:int = 1; rank < 14; rank++)
					{
						_cards.cards.push(new Card(null, rank, suit));
					}
				}
			}
		}
		
		private function InitializeGraphics():void
		{
			_sceneManager.PaintBackground();
			_sceneManager.PaintSkipDealButton(_controller);
			_sceneManager.PaintBuildUpPiles();
			_sceneManager.PaintBuildDownPiles();
			_sceneManager.PaintStacks();
			_sceneManager.PaintDrawPile();
			_sceneManager.PaintDealDeck();
			_sceneManager.PaintHand();
		}
		
		private function InitializeStacks():void
		{
			_buildDownPiles = new Array(4);
			_buildUpPiles = new Array(4)
			for (var pile:int = 0; pile < 4; pile++)
			{
				_buildDownPiles[pile] = new BuildDownPile(_controller, pile + 1);
				_buildUpPiles[pile] = new BuildUpPile(_controller, pile + 1);
			}
			
			_stacks = new Array(13);
			for (pile = 0; pile < 13; pile++)
			{
				_stacks[pile] = new Stack(_controller, pile + 1);
			}
			
			_hand = new CardHand(_controller);
			
			_drawPile = new DrawPile(_controller);
			_dealDeck = new DealDeck(_controller);
			
			GameService.ShuffleCards(_cards, _dealDeck);
		}
		
		//- Initialization -//
		
		
		// Public Methods //
		
		public function EndGame():void
		{
			var oScoreState:ScoreState = new ScoreState();
			GameService.SetGameScore(this, oScoreState);
			
			_parent.ModeSwapGameToGameOver(oScoreState);
		}
		
		public function GetGraphics():MovieClip
		{
			if (_sceneManager == null)
			{
				return new MovieClip();
			}
			
			var mcGraphics:MovieClip = _sceneManager.GetGraphics();
			
			return mcGraphics;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}