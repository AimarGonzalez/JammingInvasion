package com.shooty.engine.enemys 
{
	import com.conedog.math.Math2;
	import com.pixi.PixiMovieClip;
	import com.pixi.PixiResourceManager;
	import com.pixi.SpriteFrameData;
	/**
	 * @author matgroves
	 */
	 
	public class Enemy extends PixiMovieClip
	{

		public var life			:int;
		public var isDead		:Boolean;
		public var speed		:Number;
		public var offset		:Number;
		public var sign			:Number;
		
		public var frequency	:Number = 100;
		public var waveLength	:Number = 100;
		public var startX		:Number = 0;
		
		public var sizeScale	:Number = 1;
		
		public function toString():String{
			var s:String = Object(this).constructor + "[";
			s += "x: "+position.x;
			s += ", y: "+position.y;
			s += ", speed: "+speed;
			s += ", startX: "+startX;
			s += ", frequency: "+frequency;
			s += ", waveLength: "+waveLength;
			s +="]"
			return s;
		}
		
		
	
		// E V E N T S ---------------------------------------------------//
			
		// P R O P E R T I E S ---------------------------------------------//
	
		// G E T T E R S / S E T T E R S -------------------------------------//
		
		// C O N S T R U C T O R  ---------------------------------------//
		
		function Enemy(enemyFrames:Vector.<SpriteFrameData>)
		{
			
			super(enemyFrames);
		}
		
		public function reset():void
		{
			offset = Math.random() * 100;
			isDead = false;
			realOrigin.y = 0.8;
			currentFrame = Math2.randomInt(0, 39);
			life = 4;
			sign = Math2.randomPlusMinus();
			speed = 3 + Math.random() * 6;
		}

		public function update() : void
		{
			position.y += speed;
			position.x = startX + Math.sin(position.y / frequency) * waveLength;
			
			angle = Math.sin((position.y*0.02) + offset) * 0.1 * sign;

			if(angle < 0)angle *= -1;
			
			if(position.y<70){
				scale = 1 + angle * 0.5+ Math.max(0,Math.min(2,Math2.convert(position.y,50,70,0,2)));
			}else{
				scale = 1 + angle * 0.5+ Math.max(0,Math.min(2,Math2.convert(position.y,70,100,2,0)));
			}
			
			
			
			
			//trace("enemy.update(): angle: "+angle);
			//trace("enemy.update(): scale: "+offset);
		}
		
		// P U B L I C ---------------------------------------------------//
		
		// P R I V A T E -------------------------------------------------//
		
		// H A N D L E R S -----------------------------------------------//
	}
}