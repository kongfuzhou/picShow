/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * This class is an update to Actionscript 3 of Robert Penner's Actionscript 2 easing equations
 * which are available under the following licence from http://www.robertpenner.com/easing/
 * 
 * TERMS OF USE - EASING EQUATIONS
 * 
 * Open source under the BSD License.
 * 
 * Copyright (c) 2001 Robert Penner
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are 
 * permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this list of 
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list 
 * of conditions and the following disclaimer in the documentation and/or other materials 
 * provided with the distribution.
 * Neither the name of the author nor the names of contributors may be used to endorse 
 * or promote products derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
 * SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * ==================================================
 * 
 * Modifications:
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2009
 * http://flintparticles.org
 * 
 * 
 * Used in the Flint Particle System which is licenced under the MIT license. As per the
 * original license for Robert Penner's classes, these specific classes are released under 
 * the BSD License.
 */

package org.flintparticles.common.easing
{

	public class Bounce
	{
		public static function easeOut( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			if ( ( t /= d ) < ( 1 / 2.75 ) )
			{
				return c * ( 7.5625 * t * t ) + b;
			}
			else if ( t < ( 2 / 2.75 ) )
			{
				return c * ( 7.5625 * ( t -= ( 1.5 / 2.75 ) ) * t + 0.75 ) + b;
			}
			else if ( t < ( 2.5 / 2.75 ) )
			{
				return c * ( 7.5625 * ( t -= ( 2.25 / 2.75 ) ) * t + 0.9375 ) + b;
			}
			else
			{
				return c * ( 7.5625 * ( t -= ( 2.625 / 2.75 ) ) * t + 0.984375 ) + b;
			}
		}

		public static function easeIn( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			return c - easeOut( d - t, 0, c, d ) + b;
		}

		public static function easeInOut( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			if ( t < d * 0.5 )
			{
				return easeIn( t * 2, 0, c, d ) * 0.5 + b;
			}
			else
			{
				return easeOut( t * 2 - d, 0, c, d ) * 0.5 + c * 0.5 + b;
			}
		}
	}
}
