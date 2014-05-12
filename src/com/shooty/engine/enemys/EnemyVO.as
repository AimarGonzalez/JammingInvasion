package com.shooty.engine.enemys
{
	import flash.geom.Point;

	public class EnemyVO
	{
		public static const ALIEN:int = 0;
		public static const BALL_1:int = 1;
		public static const BALL_2:int = 2;
		public static const BALL_3:int = 3;
		public static const BALL_4:int = 4;
		
		
		public var type			:int;
		
		public var life			:int;
		public var isDead		:Boolean;
		public var speed		:Number;
		public var offset		:Number;
		public var sign			:Number;
		
		public var frequency	:Number = 100;
		public var waveLength	:Number = 100;
		
		public var startX			:Number;
		public var startY			:Number;
		
		public function EnemyVO()
		{
		}
	}
}