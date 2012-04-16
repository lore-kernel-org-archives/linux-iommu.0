From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Mon, 16 Apr 2012 10:00:59 -0600
Message-ID: <4F8C423B.8050609@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
	<4F86F97C.8010508@wwwdotorg.org>
	<20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
	<4F8753A0.6040907@wwwdotorg.org>
	<20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
	<4F887C54.6030306@wwwdotorg.org>
	<20120415083905.GA15207@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120415083905.GA15207-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/15/2012 02:39 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 04/13/2012 03:14 AM, Thierry Reding wrote:
>>> 		display-controllers = <&disp1 &disp2>;
>>> 		outputs = <&lvds &hdmi &tvo &dsi>;
>>
>> I don't think you need both the child nodes and those two properties.
>>
>> In other words, I think you either want:
>>
>> 	graphics@54000000 {
>> 		... a bunch of child nodes
>> 	};
>>
>> or you want:
>>
>> 	disp1 : dc@54200000 {
>> 		...
>> 	};
>> 	disp2 : dc@54240000 {
>> 		...
>> 	};
>> 	... all the other graphics nodes
>>
>> 	graphics@54000000 {
>> 		display-controllers = <&disp1 &disp2>;
>> 		outputs = <&lvds &hdmi &tvo &dsi>;
>> 	};
>>
>> In the former case, presumably the drivers for the child nodes would
>> make some API call into the parent node and just register themselves
>> directly as a certain type of driver, so avoiding the
>> display-controllers/outputs properties.
> 
> I think I like the former better. The way I understand it the children of the
> graphics node will have to be registered explicitly by the DRM driver because
> of_platform_populate() doesn't work recursively. That would ensure that the
> DRM driver can setup the CRTC and output registries before the other devices
> call back into the DRM to register themselves.

Yes, with the first way, the DRM driver will have to call
of_platform_populate() recursively to make this work.

The thing here is that the device tree should model hardware, not be
designed purely to match the device registration needs of the DRM
driver. I'm not sure that it's correct to model all those devices as
children of the top-level graphics object; I /think/ all the devices are
flat on a single bus, and hence not children of each-other. That all
said, I guess having the nodes as children isn't too far off how the HW
is designed (even if the register accesses aren't on a child bus, the
modules at least logically are grouped together in an umbrella
situation), so I wouldn't push back on the first option above that you
prefer.

>>> 		/* initial configuration */
>>> 		configuration {
>>> 			lvds {
>>> 				display-controller = <&disp1>;
>>> 				output = <&lvds>;
>>> 			};
>>>
>>> 			hdmi {
>>> 				display-controller = <&disp2>;
>>> 				output = <&hdmi>;
>>> 			};
>>> 		};
>>> 	};
>>>
>>> I added an additional node for the initial configuration so that the driver
>>> knows which mapping to setup at boot.
>>
>> Isn't that kind of thing usually set up by the video= KMS-related kernel
>> command-line option? See Documentation/fb/modedb.txt. Again here, I
>> think the actual display controllers would be allocated to whichever
>> outputs get used on a first-come first-serve based, so no need for the
>> display-controller property above either way.
> 
> Boards should still be able to boot and display a console on the "standard"
> output even if the user doesn't provide a video= option. Shouldn't there be a
> way for a board DTS to specify what the default (or even allowed) connections
> are?

Why wouldn't the default be to light up all outputs that have an
attached display, or an algorithm something like:

* If internal LCD is present, use that
* Else, if HDMI display plugged in, use that
...

> Evaluation hardware like the Harmony might have LVDS, HDMI and VGA connectors
> to provide for a wide range of use cases. The Plutux for instance has only an
> HDMI connector and the Medcom has only LVDS. For the Medcom it would be quite
> confusing for people to suddenly see an HDMI-1 connector pop up f.e. in
> xrandr. It would be equally useless for the Plutux to show up as supporting
> an LVDS or VGA connector.

So the device tree for those devices would disable (or not include) the
connectors that were not present on the board.

...
> I see. Maybe this could be used for board-specific configuration? For
> example, the Plutux could have something like this:
> 
> 	connectors {
> 		hdmi {
> 			output = <&hdmi>;
> 			ddc = <&i2c2>;
> 		};
> 	};
> 
> The Medcom could have:
> 
> 	connectors {
> 		lvds {
> 			output = <&lvds>;
> 			edid = <&edid>;
> 		};
> 	};
> 
> While Harmony could be more generic and provide more outputs:
> 
> 	connectors {
> 		lvds {
> 			output = <&lvds>;
> 			ddc = <&i2c1>;
> 		};
> 
> 		vga {
> 			/* which output is used for VGA? */
> 			output = <...>;
> 			ddc = <&i2c2>;
> 
> 		hdmi {
> 			output = <&hdmi>;
> 			ddc = <&i2c3>;
> 		};
> 	};

That looks like a reasonable start.

> Has there been any discussion as to how EDID data would best be represented
> in DT? Should it just be a binary blob or rather some textual representation?

I think a binary blob makes sense - that's the exact same format it'd
have if read over the DDC I2C bus.
