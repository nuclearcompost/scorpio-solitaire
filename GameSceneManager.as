package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				Drawing logic for a game session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameSceneManager extends MovieClip
	{
		// Constants //
		
		private static const BUILD_DOWN_PILE_LOCATIONS:Array = [ new Point2D(570, 115),
																 new Point2D(690, 115),
																 new Point2D(810, 115),
																 new Point2D(930, 115)
															   ];
		
		private static const BUILD_UP_PILE_LOCATIONS:Array = [ new Point2D(70, 115),
															   new Point2D(190, 115),
															   new Point2D(310, 115),
															   new Point2D(430, 115)
															 ];

		private static const STACK_LOCATIONS:Array = [ new Point2D(140, 305),
													   new Point2D(260, 305),
													   new Point2D(380, 305),
													   new Point2D(500, 305),
													   new Point2D(620, 305),
													   new Point2D(740, 305),
													   new Point2D(860, 305),
													   new Point2D(140, 495),
													   new Point2D(260, 495),
													   new Point2D(380, 495),
													   new Point2D(620, 495),
													   new Point2D(740, 495),
													   new Point2D(860, 495)
													 ];
		
		private static const DEAL_DECK_LOCATION:Point2D = new Point2D(500, 685);
		private static const DRAW_PILE_LOCATION:Point2D = new Point2D(500, 495);
		public static const HAND_START_LOCATION:Point2D = new Point2D(80, 685);
		
		public static const SCREEN_WIDTH:int = 1000;
		public static const SCREEN_HEIGHT:int = 800;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get movingCardGraphics():MovieClip
		{
			return _movingCardGraphics;
		}
		
		public function get readyToDealFromDrawPile():Boolean
		{
			return _readyToDealFromDrawPile;
		}
		
		public function set readyToDealFromDrawPile(value:Boolean):void
		{
			_readyToDealFromDrawPile = value;
		}
		
		public function get underMovingCardGraphics():MovieClip
		{
			return _underMovingCardGraphics;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _model:GameSession;
		
		private var _backgroundGraphics:MovieClip;
		private var _buildUpGraphics:MovieClip;
		private var _buildDownGraphics:MovieClip;
		private var _dealDeckGraphics:MovieClip;
		private var _drawPileGraphics:MovieClip;
		private var _graphics:MovieClip;
		private var _handGraphics:MovieClip;
		private var _movingCardGraphics:MovieClip;
		private var _nextCardGraphics:MovieClip;
		private var _readyToDealFromDrawPile:Boolean;
		private var _skipDealButtonGraphics:MovieClip;
		private var _stackGraphics:MovieClip;
		private var _underMovingCardGraphics:MovieClip;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameSceneManager(model:GameSession)
		{
			_model = model;
			
			_readyToDealFromDrawPile = true;
			
			InitializeGraphics();
		}
		
		public function InitializeGraphics():void
		{
			_graphics = new MovieClip();
			
			_backgroundGraphics = new MovieClip();
			_graphics.addChild(_backgroundGraphics);
			
			_skipDealButtonGraphics = new MovieClip();
			_graphics.addChild(_skipDealButtonGraphics);
			
			_buildUpGraphics = new MovieClip();
			_graphics.addChild(_buildUpGraphics);
			
			_buildDownGraphics = new MovieClip();
			_graphics.addChild(_buildDownGraphics);
			
			_stackGraphics = new MovieClip();
			_graphics.addChild(_stackGraphics);
			
			_drawPileGraphics = new MovieClip();
			_graphics.addChild(_drawPileGraphics);
			
			_handGraphics = new MovieClip();
			_graphics.addChild(_handGraphics);
			
			_dealDeckGraphics = new MovieClip();
			_graphics.addChild(_dealDeckGraphics);
			
			_nextCardGraphics = new MovieClip();
			_graphics.addChild(_nextCardGraphics);
			
			_underMovingCardGraphics = new MovieClip();
			_graphics.addChild(_underMovingCardGraphics);
			
			_movingCardGraphics = new MovieClip();
			_graphics.addChild(_movingCardGraphics);
		}
		
		//- Initialization -//
		
		
		// Public Methods //
		
		public function EraseSkipDealButton():void
		{
			ClearGraphics(_skipDealButtonGraphics);
		}
		
		public function GetGraphics():MovieClip
		{
			return _graphics;
		}
		
		public function PaintBackground():void
		{
			var mcBackground:Background_MC = new Background_MC();
			mcBackground.x = GameSceneManager.SCREEN_WIDTH / 2;
			mcBackground.y = GameSceneManager.SCREEN_HEIGHT / 2;
			_backgroundGraphics.addChild(mcBackground);
		}
		
		public function PaintBuildDownPiles():void
		{
			for (var i:int = 0; i < _model.buildDownPiles.length; i++)
			{
				var oBuildDownPile:BuildDownPile = BuildDownPile(_model.buildDownPiles[i]);
				var mcBuildDownPile:MovieClip = oBuildDownPile.Paint();
				var oLocation:Point2D = Point2D(GameSceneManager.BUILD_DOWN_PILE_LOCATIONS[i]);
				
				mcBuildDownPile.x = oLocation.x;
				mcBuildDownPile.y = oLocation.y;
				_buildDownGraphics.addChild(mcBuildDownPile);
			}
		}
		
		public function PaintBuildUpPiles():void
		{
			for (var i:int = 0; i < _model.buildUpPiles.length; i++)
			{
				var oBuildUpPile:BuildUpPile = BuildUpPile(_model.buildUpPiles[i]);
				var mcBuildUpPile:MovieClip = oBuildUpPile.Paint();
				var oLocation:Point2D = Point2D(GameSceneManager.BUILD_UP_PILE_LOCATIONS[i]);
				
				mcBuildUpPile.x = oLocation.x;
				mcBuildUpPile.y = oLocation.y;
				_buildUpGraphics.addChild(mcBuildUpPile);
			}
		}
		
		public function PaintDealDeck():void
		{
			var mcDealDeck:MovieClip = _model.dealDeck.Paint();
			var oLocation:Point2D = GameSceneManager.DEAL_DECK_LOCATION;
			
			mcDealDeck.x = oLocation.x;
			mcDealDeck.y = oLocation.y;
			_dealDeckGraphics.addChild(mcDealDeck);
		}
		
		public function PaintDrawPile():void
		{
			var mcDrawPile:MovieClip = _model.drawPile.Paint();
			var oLocation:Point2D = GameSceneManager.DRAW_PILE_LOCATION;
			
			mcDrawPile.x = oLocation.x;
			mcDrawPile.y = oLocation.y;
			_drawPileGraphics.addChild(mcDrawPile);
		}
		
		public function PaintHand():void
		{
			var mcHand:MovieClip = _model.hand.Paint();
			mcHand.x = 0;
			mcHand.y = 0;
			
			_handGraphics.addChild(mcHand);
		}
		
		public function PaintSkipDealButton(controller:GameController):void
		{
			var btnSkip:Skip_Btn = new Skip_Btn();
			btnSkip.x = 850;
			btnSkip.y = 700;
			btnSkip.addEventListener(MouseEvent.CLICK, controller.OnSkipButtonClick, false, 0, true);
			_skipDealButtonGraphics.addChild(btnSkip);
		}
		
		public function PaintStacks():void
		{
			for (var i:int = 0; i < _model.stacks.length; i++)
			{
				var oStack:Stack = Stack(_model.stacks[i]);
				var mcStack:MovieClip = oStack.Paint();
				var oLocation:Point2D = Point2D(GameSceneManager.STACK_LOCATIONS[i]);
				
				mcStack.x = oLocation.x;
				mcStack.y = oLocation.y;
				_stackGraphics.addChild(mcStack);
			}
		}
		
		public function GetBuildDownPileDrawLocation(index:int):Point2D
		{
			var iNumCards:int = _model.stacks[index].cards.length + 1;
			var iNumCardsToDraw:int = Math.floor(iNumCards / 5);
			var oBaseLocation:Point2D = Point2D(GameSceneManager.BUILD_DOWN_PILE_LOCATIONS[index]);
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public function GetBuildUpPileDrawLocation(index:int):Point2D
		{
			var iNumCards:int = _model.stacks[index].cards.length + 1;
			var iNumCardsToDraw:int = Math.floor(iNumCards / 5);
			var oBaseLocation:Point2D = Point2D(GameSceneManager.BUILD_UP_PILE_LOCATIONS[index]);
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public function GetDealDeckDrawLocation():Point2D
		{
			var iNumCards:int = _model.dealDeck.cards.length + 1;
			var iNumCardsToDraw:int = Math.floor(iNumCards / 5);
			var oBaseLocation:Point2D = GameSceneManager.DEAL_DECK_LOCATION;
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public function GetDrawPileDrawLocation():Point2D
		{
			var iNumCards:int = _model.drawPile.cards.length + 1;
			var iNumCardsToDraw:int = Math.floor(iNumCards / 5);
			var oBaseLocation:Point2D = GameSceneManager.DRAW_PILE_LOCATION;
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public static function GetHandCardDrawLocation(handSize:int, index:int):Point2D
		{
			var iOverflow:int = handSize - 8;
			var iGap:int = 120;
			
			if (iOverflow > 0)
			{
				iGap = 840 / (handSize - 1);  // total distance between the fixed centers of the first card and last card = 840.  Distribute that space evenly between remaining cards.
			}
			
			var oBaseLocation:Point2D = GameSceneManager.HAND_START_LOCATION;
			var iX:int = oBaseLocation.x + (iGap * index);
			var iY:int = oBaseLocation.y;
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public function GetStackCardDrawLocation(stack:int, card:int):Point2D
		{
			var iNumCardsToDraw:int = Math.floor((card + 1) / 5);
			var oBaseLocation:Point2D = Point2D(GameSceneManager.STACK_LOCATIONS[stack]);
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		public function GetStackDrawLocation(index:int):Point2D
		{
			var iNumCards:int = _model.stacks[index].cards.length + 1;
			var iNumCardsToDraw:int = Math.floor(iNumCards / 5);
			var oBaseLocation:Point2D = Point2D(GameSceneManager.STACK_LOCATIONS[index]);
			var iX:int = oBaseLocation.x - (2 * iNumCardsToDraw);
			var iY:int = oBaseLocation.y - (2 * iNumCardsToDraw);
			var oDrawLocation:Point2D = new Point2D(iX, iY);
			
			return oDrawLocation;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function ClearGraphics(container:MovieClip):void
		{
			var iNumChildren:int = container.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				container.removeChildAt(0);
			}
		}
		
		//- Private Methods -//
	}
}