package com.shooty.engine.enemys 
{
	import com.conedog.math.Math2;
	import com.pixi.PixiMovieClip;
	import com.pixi.PixiResourceManager;
	import com.pixi.SpriteFrameData;

	/**
	 * @author matgroves
	 */
	 
	public class Ball1Enemy extends Enemy
	{
		// only really need one set of frame data!
		public static var enemyFrames:Vector.<SpriteFrameData>;
		
		function Ball1Enemy()
		{
			// if enemy frames dont exist then create them all!
			if(!enemyFrames)
			{
				enemyFrames = new Vector.<SpriteFrameData>();
				
				enemyFrames.push(PixiResourceManager.instance.spriteFrames["invader_green.png"]);
				//enemyFrames.push(PixiResourceManager.instance.spriteFrames["circle_green.png"]);
				//enemyFrames.push(PixiResourceManager.instance.spriteFrames["ball_1.png"]);
				//enemyFrames.push(PixiResourceManager.instance.spriteFrames["ball_1.png"]);
				//enemyFrames.push(PixiResourceManager.instance.spriteFrames["ball_1.png"]);
			}
			
			super(enemyFrames);
		}
		
		
	}
}