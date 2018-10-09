package
{
	//-----------------------
	//Purpose:				Service logic for points in the 2D plane
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class PointService
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function PointService()
		{
			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public static function GetDistanceBetweenPoints(source:Point2D, target:Point2D):Number
		{
			var nDist:Number = Math.sqrt(Math.pow(source.x - target.x, 2) + Math.pow(source.y - target.y, 2));
			
			return nDist;
		}		
		
		public static function ClampAngleValue(angle:Number):Number
		{
			if (angle <= -180)
			{
				return angle + 360;
			}
			
			if (angle > 180)
			{
				return angle - 360;
			}
			
			return angle;
		}
		
		public static function GetPointAtDistanceInDirection(source:Point2D, distance:Number, direction:Number):Point2D
		{
			var newPoint:Point2D = new Point2D(0, 0);
			var facingRadians:Number = (direction) * (Math.PI / 180.0);
			
			newPoint.x = source.x + (Math.cos(facingRadians) * distance);
			newPoint.y = source.y + (Math.sin(facingRadians) * distance);
			
			return newPoint;
		}		
		
		public static function GetDirectionBetweenPoints(source:Point2D, target:Point2D):Number
		{
			var dx:Number = target.x - source.x;
			var dy:Number = target.y - source.y;
			
			var angleBetweenPoints:Number = Math.atan2(dy, dx);
			
			angleBetweenPoints = PointService.ClampAngleValue(angleBetweenPoints / (Math.PI / 180.0));
			
			return angleBetweenPoints;
		}		
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}