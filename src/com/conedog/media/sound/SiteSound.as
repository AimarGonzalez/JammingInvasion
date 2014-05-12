/*	BLOC Lib for ActionScript 3.0	Copyright (c) 2009, The Bloc Development Team*/package com.conedog.media.sound 
{	import com.greensock.TweenLite;	import com.greensock.easing.Sine;	import flash.media.SoundMixer;	import flash.media.SoundTransform;	/*	SoundPlus is a wrapper for flash's sound class that adds more functionality 		and makes sounds much easier to use within flash				@author Mat Groves		@version 03/01/09		@example			<code>				package {					import com.bloc.media.sound										public class MyExample extends MovieClip {						public var mySound:SoundPlus;												public function MyExample() {							super();														mySound = new SoundPlus("soundInMyLibrary");							mySound.start(1, 0);														mySound.volume = 0.4;						}					}				}			</code>	*/	public class SiteSound	{						// P R O P E R T I E S //				private static var _volume			:Number = 1;		private static var _muted			:Boolean = false;						// G E T T E R S   /   S E T T E R S //				public static function set volume(n:Number):void		{			_volume = n;			SoundMixer.soundTransform = new SoundTransform(_volume, 0);		}				public static function get volume():Number		{			return _volume;		}				public static function mute(speed:Number = 1):void		{			if(_muted)return;						_muted = true;						TweenLite.to(SiteSound, speed, {volume:0, ease:Sine.easeOut});		}				public static function unMute(speed:Number = 1):void		{			if(!_muted)return;						_muted = false;						TweenLite.to(SiteSound, speed, {volume:1, ease:Sine.easeOut});		}		static public function get muted() : Boolean		{			return _muted;		}	}}