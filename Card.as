package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Card
	{
		// Constants //
		
		public static const RANK_NAMES:Array = new Array("0", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K");
		public static const SUIT_NAMES:Array = new Array("None", "Clubs", "Diamonds", "Hearts", "Spades");
		
		private static const NODES:Array = new Array(new Point2D(0, 0),
													   new Point2D(-36, -40),
													   new Point2D(-14, -56.25),
													   new Point2D(0, -36.75),
													   new Point2D(14, -56.25),
													   new Point2D(-14, -18.75),
													   new Point2D(14, -18.75),
													   new Point2D(-14, 0),
													   new Point2D(0, 0),
													   new Point2D(14, 0),
													   new Point2D(-14, 18.75),
													   new Point2D(14, 18.75),
													   new Point2D(0, 36.75),
													   new Point2D(-14, 56.25),
													   new Point2D(14, 56.25),
													   new Point2D(36, 40)
													   );
		
		private static const SUIT_LOCATIONS:Array = new Array(new Array(NODES[1], NODES[15]),
																new Array(NODES[8]),
																new Array(NODES[3], NODES[12]),
																new Array(NODES[3], NODES[8], NODES[12]),
																new Array(NODES[2], NODES[4], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[4], NODES[8], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[4], NODES[7], NODES[9], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[3], NODES[4], NODES[8], NODES[12], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[4], NODES[5], NODES[6], NODES[10], NODES[11], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[4], NODES[5], NODES[6], NODES[8], NODES[10], NODES[11], NODES[13], NODES[14]),
																new Array(NODES[2], NODES[3], NODES[4], NODES[5], NODES[6], NODES[10], NODES[11], NODES[12], NODES[13], NODES[14]),
																new Array(NODES[8]),
																new Array(NODES[8]),
																new Array(NODES[8])
																);
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get parent():CardCollection
		{
			return _parent;
		}
		
		public function set parent(value:CardCollection):void
		{
			_parent = value;
		}
		
		public function get rank():int
		{
			return _rank;
		}
		
		public function set rank(value:int):void
		{
			_rank = value;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get suit():int
		{
			return _suit;
		}
		
		public function set suit(value:int):void
		{
			_suit = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _faceUp:Boolean;
		private var _handIndex:int;
		private var _parent:CardCollection;
		private var _rank:int;  // 1 = ace, 11 = jack, 12 = queen, 13 = king
		private var _selected:Boolean;
		private var _suit:int;  // 1 = clubs, 2 = diamonds, 3 = hearts, 4 = spades
		
		private var _background:MovieClip;
		private var _container:MovieClip;
		private var _selectedGraphics:MovieClip;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Card(parent:CardCollection, rank:int, suit:int)
		{
			_parent = parent;
			_rank = rank;
			_suit = suit;
			
			_selected = false;
			_faceUp = true;
			
			_selectedGraphics = new MovieClip();
			_handIndex = -1;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function AddHighlight():void
		{
			if (_background == null)
			{
				return;
			}
			
			if (_faceUp == true)
			{
				_background.gotoAndStop(2);
			}
			else
			{
				_background.gotoAndStop(4);
			}
		}
		
		public function RemoveHighlight():void
		{
			if (_background == null)
			{
				return;
			}
			
			if (_faceUp == true)
			{
				_background.gotoAndStop(1);
			}
			else
			{
				_background.gotoAndStop(3);
			}
		}
		
		public function Select():void
		{
			var mcSelected:CardSelected_MC = new CardSelected_MC();
			_selectedGraphics.addChild(mcSelected);
			
			_selected = true;
		}
		
		public function Deselect():void
		{
			var iNumChildren:int = _selectedGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_selectedGraphics.removeChildAt(0);
			}
			
			_selected = false;
		}
		
		public function Paint(faceUp:Boolean = true, handIndex:int = -1):MovieClip
		{
			_container = new MovieClip();
			
			_faceUp = faceUp;
			_handIndex = handIndex;
			
			_background = new CardBackground_MC();
			
			if (_faceUp == false)
			{
				_background.gotoAndStop(3);
			}
			
			if (_selected == true)
			{
				_background.gotoAndStop(2);
			}
			
			_container.addChild(_background);
			
			if (_faceUp == true)
			{
				var iX:int = _background.width / 2;
				var iY:int = _background.height / 2;
				
				var mcFace:CardFace_MC = new CardFace_MC();
				mcFace.x = 0;
				mcFace.y = 0;
				mcFace.UpperNumeral.text = String(Card.RANK_NAMES[_rank]);
				mcFace.LowerNumeral.text = String(Card.RANK_NAMES[_rank]);
				_container.addChild(mcFace);
				
				// Attach suit for small icons on the sidebars.
				// Use rank 0 into the SUIT_LOCATIONS array.
				var mcSuit:Suit_Standard_MC = new Suit_Standard_MC();
				mcSuit.width = 20;
				mcSuit.height = 20;
				mcSuit.x = SUIT_LOCATIONS[0][0].x;
				mcSuit.y = SUIT_LOCATIONS[0][0].y;
				mcSuit.gotoAndStop(_suit);
				_container.addChild(mcSuit);
				
				mcSuit = new Suit_Standard_MC();
				mcSuit.width = 20;
				mcSuit.height = 20;
				mcSuit.x = SUIT_LOCATIONS[0][1].x;
				mcSuit.y = SUIT_LOCATIONS[0][1].y;
				mcSuit.gotoAndStop(_suit);
				_container.addChild(mcSuit);
				
				// attach suit icons for the normal size icons on the card
				for (var i:int = 0; i < SUIT_LOCATIONS[_rank].length; i++)
				{
					var iSize:int = 16;
					
					if (_rank == 1 || _rank == 11 || _rank == 12 || _rank == 13)
					{
						iSize = 50;
					}
					
					mcSuit = new Suit_Standard_MC();
					mcSuit.width = iSize;
					mcSuit.height = iSize;
					mcSuit.x = SUIT_LOCATIONS[_rank][i].x;
					mcSuit.y = SUIT_LOCATIONS[_rank][i].y;
					mcSuit.gotoAndStop(_suit);
					_container.addChild(mcSuit);
				}
			}
			
			_container.addChild(_selectedGraphics);
			
			if (_parent is BuildDownPile)
			{
				_container.addEventListener(MouseEvent.CLICK, OnBuildDownPileClick, false, 0, true);
			}
			if (_parent is BuildUpPile)
			{
				_container.addEventListener(MouseEvent.CLICK, OnBuildUpPileClick, false, 0, true);
			}
			if (_parent is CardHand)
			{
				_container.addEventListener(MouseEvent.CLICK, OnHandCardClick, false, 0, true);
				_container.addEventListener(MouseEvent.ROLL_OUT, OnRollOut, false, 0, true);
				_container.addEventListener(MouseEvent.ROLL_OVER, OnRollOver, false, 0, true);
			}
			if (_parent is DrawPile)
			{
				_container.addEventListener(MouseEvent.CLICK, OnDrawPileClick, false, 0, true);
			}
			if (_parent is Stack)
			{
				_container.addEventListener(MouseEvent.CLICK, OnStackClick, false, 0, true);
				_container.addEventListener(MouseEvent.ROLL_OUT, OnRollOut, false, 0, true);
				_container.addEventListener(MouseEvent.ROLL_OVER, OnRollOver, false, 0, true);
			}
			
			return _container;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function OnBuildDownPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			BuildDownPile(_parent).BuildDownPileClick();
		}
		
		private function OnBuildUpPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			BuildUpPile(_parent).BuildUpPileClick();
		}
		
		private function OnDrawPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			DrawPile(_parent).DrawPileClick();
		}
		
		private function OnHandCardClick(event:MouseEvent):void
		{
			event.stopPropagation();
			CardHand(_parent).ToggleHandCardSelected(_handIndex);
		}
		
		private function OnRollOut(event:MouseEvent):void
		{
			event.stopPropagation();
			RemoveHighlight();
		}
		
		private function OnRollOver(event:MouseEvent):void
		{
			event.stopPropagation();
			AddHighlight();			
		}
		
		private function OnStackClick(event:MouseEvent):void
		{
			event.stopPropagation();
			Stack(_parent).ToggleStackSelected();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}