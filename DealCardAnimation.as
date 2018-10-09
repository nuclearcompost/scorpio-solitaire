package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Animation for a card being dealt
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class DealCardAnimation extends CardMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function DealCardAnimation(gameController:GameController, canvas:MovieClip, source:Point2D, destination:Point2D, card:Card, speed:int, faceUp:Boolean)
		{
			super(gameController, canvas, source, destination, card, speed, faceUp);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		protected override function AnimationComplete():void
		{
			var iNumChildren:int = _canvas.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_canvas.removeChildAt(0);
			}
			
			_gameController.ResolveCardDealt(_card);
		}
		
		//- Protected Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}