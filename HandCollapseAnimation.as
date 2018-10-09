package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class HandCollapseAnimation extends MultiCardMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function HandCollapseAnimation(gameController:GameController, canvas:MovieClip, sourceLocations:Array, destinations:Array, cards:Array, speed:int)
		{
			super(gameController, canvas, sourceLocations, destinations, cards, speed, true);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		protected override function AnimationComplete():void
		{
			var iNumChildren:int = _canvas.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_canvas.removeChildAt(0);
			}
			
			_gameController.ResolveHandCollapse(_cards);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}