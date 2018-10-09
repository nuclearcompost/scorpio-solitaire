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
	public class HandToStackAnimation extends MultiCardMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _stackIndex:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function HandToStackAnimation(gameController:GameController, canvas:MovieClip, sourceLocations:Array, destinations:Array, cards:Array, stackIndex:int, speed:int)
		{
			super(gameController, canvas, sourceLocations, destinations, cards, speed, true);
			
			_stackIndex = stackIndex;
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
			
			_gameController.ResolveHandToStack(_cards, _stackIndex);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}