From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 16:13:52 -0600
Message-ID: <4F8753A0.6040907@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de> <4F85C97E.50203@wwwdotorg.org> <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de> <4F86F97C.8010508@wwwdotorg.org> <20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412174429.GB10042-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/12/2012 11:44 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 04/12/2012 12:50 AM, Thierry Reding wrote:
>>> 	drm {
>>> 		compatible = "nvidia,tegra20-drm";
>>
>> I'm don't think having an explicit "drm" node is the right approach; drm
>> is after all a SW term and the DT should be describing HW. Having some
>> kind of top-level node almost certainly makes sense, but naming it
>> something related to "tegra display" than "drm" would be appropriate.
> 
> In this case there really isn't a HW device that can be represented. But in
> the end it's still the DRM driver that needs to bind to the device. However
> the other graphics devices (MPE, VI/CSI, EPP, GR2D and GR3D) probably need
> to be bound against.

Well, everything graphics-related appears to be grouped within some
container. In the memory map, there's the range 0x54000000-547fffff, and
in the Tegra20 TRM, the first diagram in section 29 "Display Controller"
again lumps all the modules together into one box.

I'd say it's perfectly legitimate to create a device tree node to
represent this aggregate display/graphics-related engine. So, I think
that yes there is a real HW device to represent.

And given that, I don't think we should name the node after some
OS-specific software concept. Device tree is intended to model hardware.

> Would it be possible for someone at NVIDIA to provide some more details about
> what those other devices are? GR2D and GR3D seem obvious, MPE might be video
> decoding, VI/CSI video input and camera interface? As to EPP I have no idea.

MPE is something video encode/decode related. VI/CSI are indeed camera
related. I'm afraid I don't personally know any more details than that,
and even if I did, I'm only allowed to discuss what's in the TRM:-(

I don't think those modules should have much impact on the DRM driver
design if that's what you're worried about. I /believe/ they all just
interact directly with memory rather than the other components,
irrespective of what that first diagram in section 29 might imply.

> Maybe one solution would be to have a top-level DRM device with a register
> map from 0x54000000 to 0x547fffff, which the TRM designates as "host
> registers". Then subnodes could be used for the subdevices.

Ah yes, just what I was thinking above:-)

I don't think you'd /have/ to make the nodes sub-nodes; you could use
phandles to refer from the top-level node to the other components. One
might end up having to use phandles anyway to represent the routing from
DCA or DCB to MIPI or HDMI anyway, so it's possible that using phandles
everywhere might be simpler and more consistent than parent/child
relationships for some things and phandles for other things.

>>> 		lvds {
>>> 			compatible = "...";
>>> 			dc = <&disp1>;
>>> 		};
>>
>> Aren't the outputs separate HW blocks too, such that they would have
>> their own compatible/reg properties and their own drivers, and be
>> outside the top-level drm/display node?
> 
> The RGB output is programmed via the display controller registers. For HDMI,
> TVO and DSI there are indeed separate sets of registers in addition to the
> display controller's. So perhaps for those more nodes would be required:
> 
> 	hdmi : hdmi@54280000 {
> 		compatible = "nvidia,tegra20-hdmi";
> 		reg = <0x54280000 0x00040000>;
> 	};

Yes, looks reasonable.

> And hook that up with the HDMI output node of the "DRM" node:
> 
> 	drm {
> 		hdmi {
> 			compatible = "...";
> 			connector = <&hdmi>;
> 			dc = <&disp2>;
> 		};
> 	};
>
> Maybe with this setup we no longer need the "compatible" property since it
> will already be inherent in the "connector" property. There will have to be
> special handling for the RGB output, which could be the default if the
> "connector" property is missing.

I suspect you'd have something more like:

tegra-graphics {
    output-resources = <&hdmi &tvo &dsi ... >;
    display-controllers = <&disp1 &disp2>;
};

i.e. just a list of all extant devices. Each should provide some common
API so you could just map from phandle to of_node to device object, and
call the appropriate APIs on it.

Finally note that although I didn't really represent it correct above,
there are at least 3 levels of object/hierarchy here:

Display controllers reads from RAM and form a set of pixels to display.
I believe things like cursors, overlays, pan-scan, etc. are resolved
entirely at this level.

Output resources drive certain pins on Tegra in some specific format
such as HDMI, VGA, etc. I think all output resources can actually
display the data from either display controller. Probably even 2 ORs can
show an image from the same DC at once for mirrored display.

Finally, there are the user connectors. I suspect it's plausible for
muxes to exist between the ORs and user connectors, although that's
probably a lot less likely. I believe this is the level at which to
represent things like which I2C bus is used for EDID/DDC access, or
which GPIO is used for hotplug detect, etc.

>> I believe the mapping between the output this node represents and the
>> display controller ("dc" above) that it uses is not static; the
>> connectivity should be set up at runtime, and possibly dynamically
>> alterable via xrandr or equivalent.
> 
> I think the mapping is always static for a given board. There is no way to
> switch an HDMI port to LVDS at runtime. But maybe I misunderstand what you're
> saying.

I don't think disp2 is a property of a connector; the binding should
just specify which connectors and controllers exist, and the driver
should dynamically assign controllers to drive whichever connectors the
user wants lit up.

Note that there are more connectors than controllers, and it's quite
possible for a board to hook up 3 connectors and allow the user to
select which 1 or 2 of them to drive at run-time. That's where the
dynamic aspect comes in.
