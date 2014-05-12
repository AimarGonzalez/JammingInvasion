package com.shooty.engine.enemys 
{
	import com.conedog.math.Math2;
	import com.conedog.media.sound.SoundPlus;
	import com.conedog.net.SwfAsset;
	import com.shooty.engine.GameObjectPool;
	import com.shooty.engine.ShootyEngine;
	import com.shooty.engine.spectrum.Cnst;
	import com.shooty.engine.spectrum.ISpectrumDispatcher;
	import com.shooty.engine.spectrum.SpectrumEvent;
	import com.shooty.engine.spectrum.SpectrumVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.net.getClassByAlias;

	/**
	 * @author matgroves
	 */
	 
	public class EnemyManager 
	{
		// E V E N T S ---------------------------------------------------//
			
		// P R O P E R T I E S ---------------------------------------------//
		
		
		private var engine : ShootyEngine;
		
		public var deadEnemies	:Vector.<Enemy>;
		public var enemies	:Vector.<Enemy>;
		public var newEnemiesBuffer	:Vector.<EnemyVO>;
		public var spawnCount	:int = 0;
		
		public var spawnRate		:Number;
		
		public var booms			:Vector.<SoundPlus>;
		public var alienPool		:GameObjectPool;
		public var ball1Pool		:GameObjectPool;
		public var ball2Pool		:GameObjectPool;
		public var ball3Pool		:GameObjectPool;
		public var ball4Pool		:GameObjectPool;
		
		public var startRange		:Number = 0;
		public var startPoint		:Number = 600/2;
		
		public var spread			:Number = 500;
		
		public var speedRange		:Number;
		public var speed			:Number;
		// 
		private var county 			:Number;
		private var changeUp		:Number;
		private var frequency		:Number = 100;
		private var waveLength		:Number = 100;
		
		private var maxSpeed		:Number; 
		private var maxSpeedCount	:Number;
		private var maxSpeedUpgrade :Number;
		private var waveRatio 		:Number;
		public var canSpawn			:Boolean;
		private var easeInMode		:int = 0;
		public var level			:Number;
		
		private var positionShift 	:Number = 0;
		private var positionShiftSpeed :Number;
		
		private var spectrumDispatchers:Vector.<EventDispatcher> = new Vector.<EventDispatcher>();
		
		// G E T T E R S / S E T T E R S -------------------------------------//
		
		public function addSpectrumDispatcher(dispatcher:EventDispatcher):void{
			
			dispatcher.addEventListener(SpectrumEvent.SPECTRUM_DATA, spectrumDataHandler);
			
			
			spectrumDispatchers.push(dispatcher);
		
		}
		
		public function spectrumDataHandler(event:SpectrumEvent):void{
			var evo:EnemyVO = spectrumToEnemy(event.data);
			this.newEnemiesBuffer.push(evo);
		}
	
		
		// C O N S T R U C T O R  ---------------------------------------//
		
		
		
		function EnemyManager(engine:ShootyEngine)
		{
			this.engine = engine;
			enemies = new Vector.<Enemy>();
			newEnemiesBuffer = new Vector.<EnemyVO>();
			deadEnemies = new Vector.<Enemy>();
			
			reset();
			
			
			canSpawn = false;
			booms = new Vector.<SoundPlus>();
			
			booms.push(SwfAsset.getSound("bang1"),
				 	SwfAsset.getSound("bang2"),
					 SwfAsset.getSound("bang3"),
				 	SwfAsset.getSound("bang4"),
				 	SwfAsset.getSound("bang5"));
					
			alienPool = new GameObjectPool(AlienEnemy);
			ball1Pool = new GameObjectPool(Ball1Enemy);
			ball2Pool = new GameObjectPool(Ball2Enemy);
			ball3Pool = new GameObjectPool(Ball3Enemy);
			ball4Pool = new GameObjectPool(Ball4Enemy);
			
			
		}

		
		// P U B L I C ---------------------------------------------------//
		
		public function update() : void
		{
			if(engine.canSpawn){
				addEnemies();
			}
			
			killEnemiesOutOfTheMap();
			
			destroyDeadEnemies();
		}
	
		
		private function addEnemies():void{
			while (this.newEnemiesBuffer.length !=0){
				addEnemy(this.newEnemiesBuffer.pop());
			}
		}
		
		/*private function addRandomEnemy(seed:Number):void{
			var type = 1 + seed%4;
			addEnemy(type);
		}*/
		
		/*
		 *  adds a new enemy to the world and randomly sets it properties based on the
		 *  current wave settings
		 */
		private function addEnemy(evo:EnemyVO) : void
		{
			if(engine.player.isDead)return;
			
			var enemy:Enemy = buildNewEnemy(evo);
			
			//engine.shootyView.actionLayer.addChild(enemy);
			engine.shootyView.customEnemyLayer.addChild(enemy);
			enemies.push(enemy);
			
			//trace("spawn: "+enemy.toString());
		}
		
		private function buildNewEnemy(evo:EnemyVO):Enemy{
			var newEnemy:Enemy;
			switch(evo.type){
				case EnemyVO.ALIEN:
					newEnemy = alienPool.getObject();
					break;
				case EnemyVO.BALL_1:
					newEnemy =  ball1Pool.getObject();
					break;
				case EnemyVO.BALL_2:
					newEnemy =  ball2Pool.getObject();
					break;
				case EnemyVO.BALL_3:
					newEnemy =  ball3Pool.getObject();
					break;
				case EnemyVO.BALL_4:
					newEnemy =  ball4Pool.getObject();
					break;
				default:
					return alienPool.getObject();
			}
			
			configureNewEnemy(evo, newEnemy);
			
			return newEnemy;
		}
		
		
		
		private function spectrumToEnemy(svo:SpectrumVO):EnemyVO{
			var evo:EnemyVO = new EnemyVO();
			//trace("enemy type-flt: "+Math2.convert(svo.frequencia,Cnst.MIN_FREQ,Cnst.MAX_FREQ,1,5));
			
			evo.type = Math.max(1,Math.min(4,Math2.convert(svo.frequencia,Cnst.MIN_FREQ,Cnst.MAX_FREQ-2,1,5)));
			//trace("enemy type-int: "+evo.type);
			evo.speed = 5;
			//evo.speed = Math2.convert(svo.amplitud,0,1,2,5) + evo.type;
			//evo.speed = svo.amplitud;
			
			evo.startY = 40;
			
			var padding:int = 15;
			//var padding:int = 40;
			evo.startX = 10+Math2.convert(svo.frequencia,Cnst.MIN_FREQ,Cnst.MAX_FREQ,padding,Cnst.SCREEN_WIDTH-padding);
			//evo.startX = getRandomStartX();
			
			evo.frequency = Math2.convert(svo.frequencia,Cnst.MIN_FREQ,Cnst.MAX_FREQ,90,110);
			evo.waveLength = Math2.convert(svo.amplitud,0,1,0,100);
			
			return evo;
		}
		
		private function getRandomStartX():Number{
			var halfSpread:Number = spread/2;
			var min:Number = 300-(halfSpread);
			var max:Number = 300+(halfSpread);
			startPoint = Math2.random(min, max);
			startRange = 50 + Math2.random() * 450;
			
			positionShiftSpeed = (Math.random() * 0.8) - 0.4;
			
			// make sure the range is within the maximum and minim start range..
			if(startPoint-(startRange/2) < min)startPoint = min + startRange/2;
			if(startPoint+(startRange/2) > max)startPoint = max - startRange/2;
			
			
			var startX:Number = startPoint + Math2.random(-startRange/2, startRange/2);
			return startX;
		}
		
		private function configureNewEnemy(evo:EnemyVO, enemy:Enemy):void{
			enemy.reset();
			
			enemy.sizeScale = Math2.random(0.5, 1.5);
			
			enemy.position = new Point(evo.startX, evo.startY);
			enemy.startX = evo.startX;
			enemy.speed = evo.speed;
			enemy.frequency = evo.frequency;
			enemy.waveLength = evo.waveLength;
			
			enemy.frequency = evo.frequency;
			enemy.waveLength = evo.waveLength;
		}
		
		
	/*	private function configureNewEnemy(enemy:Enemy):void{
			
			enemy.sizeScale = Math2.random(0.5, 1.5);
			
			enemy.position.y = 10;
			enemy.startX = startPoint + Math2.random(-startRange/2, startRange/2);
			enemy.speed = speed +  Math2.random(-speedRange/2, speedRange/2);
			enemy.frequency = frequency;
			enemy.waveLength = waveLength;
		}*/
		
		private function killEnemiesOutOfTheMap():void{
			for (var i : int = 0; i < enemies.length; i++) 
			{
				enemies[i].update();
				if(enemies[i].position.y > 870)deadEnemies.push(enemies[i]);
			}
		}
		
		private function destroyDeadEnemies():void{
			// its now safe to loop through any dead enemies without breaking :) 
			for (var j : int = 0; j < deadEnemies.length; j++) 
			{
				destroyEnemy(deadEnemies[j]);
			}
			
			deadEnemies.length = 0;
		}
		
		/*
		 * called when an enemy is hit by a bullet
		 */
		public function hitEnemy(enemie : Enemy, power:int = 10) : void
		{
			if(enemie.life < 0) return;
			
			enemie.life -= power;
			
			if(enemie.life < 0)
			{
				booms[Math2.randomInt(0, 4)].start(0.3);
				engine.score += 10 * engine.multiplier;
				enemie.isDead = true;
				
				// add them to dead eenmy que 
				// removing them from the vector now would break the code as most
				// likely it is being looped through 
				deadEnemies.push(enemie);
				engine.explosionsManager.addExplosion(enemie.position);
			}
		}
		
		
		// P R I V A T E -------------------------------------------------//
		
		/*
		 * destroys an enemy, removing them from the array and returning them to the object pool
		 */
		public function destroyEnemy(enemy : Enemy) : void
		{
			for (var i : int = 0; i < enemies.length; i++) 
			{
				if(enemies[i] == enemy)
				{
					enemies.splice(i, 1);
					returnToPool(enemy);
					//engine.shootyView.actionLayer.removeChild(enemy);
					engine.shootyView.customEnemyLayer.removeChild(enemy);
					break;
				}
			}
		}
		
		private function returnToPool(enemy:Enemy):void{
			switch(Object(enemy).constructor ){
				case AlienEnemy:
					alienPool.returnObject(enemy);
					break;
				case Ball1Enemy:
					ball1Pool.returnObject(enemy);
					break;
				case Ball2Enemy:
					ball2Pool.returnObject(enemy);
					break;
				case Ball3Enemy:
					ball3Pool.returnObject(enemy);
					break;
				case Ball4Enemy:
					ball4Pool.returnObject(enemy);
					break;
				default:
					alienPool.returnObject(enemy);
			}
			
		}
	
		/*
		 * resets the level to its default settings ready for another round!
		 */
		public function reset() : void
		{
			level = 0;
			county = 0;
			waveRatio = 0;
			changeUp = 0;
			maxSpeed = 8;
			maxSpeedCount = 0;
			maxSpeedUpgrade = 60 * 8;
			speedRange = 0;
			speed = 10;
			spawnRate = 100;
			easeInMode = 0;
			//changeWave();
		}
		
		// H A N D L E R S -----------------------------------------------//
	}
}