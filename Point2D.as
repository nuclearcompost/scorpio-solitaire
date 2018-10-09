package
{
	//-----------------------
	//Purpose:				A point in the 2D plane
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Point2D
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _x:Number;
		private var _y:Number;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Point2D(x:Number, y:Number)
		{
			_x = x;
			_y = y;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}