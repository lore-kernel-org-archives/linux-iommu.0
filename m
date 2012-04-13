From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Fri, 13 Apr 2012 13:19:48 -0600
Message-ID: <4F887C54.6030306@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de> <4F85C97E.50203@wwwdotorg.org> <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de> <4F86F97C.8010508@wwwdotorg.org> <20120412174429.GB10042@avionic-0098.adnet.avionic-design.de> <4F8753A0.6040907@wwwdotorg.org> <20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120413091457.GB617-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/13/2012 03:14 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 04/12/2012 11:44 AM, Thierry Reding wrote:
> [...]
>> And given that, I don't think we should name the node after some
>> OS-specific software concept. Device tree is intended to model hardware.
> [...]
>>> Maybe one solution would be to have a top-level DRM device with a register
>>> map from 0x54000000 to 0x547fffff, which the TRM designates as "host
>>> registers". Then subnodes could be used for the subdevices.
>>
>> Ah yes, just what I was thinking above:-)
> 
> I came up with the following:
> 
> 	/* host1x */
> 	host1x : host1x@50000000 {
> 		reg = <0x50000000 0x00024000>;
> 		interrupts = <0 64 0x04   /* cop syncpt */
> 			      0 65 0x04   /* mpcore syncpt */
> 			      0 66 0x04   /* cop general */
> 			      0 67 0x04>; /* mpcore general */
> 	};
> 
> 	/* graphics host */
> 	graphics@54000000 {
> 		compatible = "nvidia,tegra20-graphics";
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0 0x54000000 0x08000000>;
> 
> 		host1x = <&host1x>;
> 
> 		/* video-encoding/decoding */
> 		mpe@54040000 {
> 			reg = <0x54040000 0x00040000>;
> 			interrupts = <0 68 0x04>;
> 		};
... [a bunch of nodes for graphics-related HW modules]

That all looks reasonable.

> 		display-controllers = <&disp1 &disp2>;
> 		outputs = <&lvds &hdmi &tvo &dsi>;

I don't think you need both the child nodes and those two properties.

In other words, I think you either want:

	graphics@54000000 {
		... a bunch of child nodes
	};

or you want:

	disp1 : dc@54200000 {
		...
	};
	disp2 : dc@54240000 {
		...
	};
	... all the other graphics nodes

	graphics@54000000 {
		display-controllers = <&disp1 &disp2>;
		outputs = <&lvds &hdmi &tvo &dsi>;
	};

In the former case, presumably the drivers for the child nodes would
make some API call into the parent node and just register themselves
directly as a certain type of driver, so avoiding the
display-controllers/outputs properties.

> 		/* initial configuration */
> 		configuration {
> 			lvds {
> 				display-controller = <&disp1>;
> 				output = <&lvds>;
> 			};
> 
> 			hdmi {
> 				display-controller = <&disp2>;
> 				output = <&hdmi>;
> 			};
> 		};
> 	};
> 
> I added an additional node for the initial configuration so that the driver
> knows which mapping to setup at boot.

Isn't that kind of thing usually set up by the video= KMS-related kernel
command-line option? See Documentation/fb/modedb.txt. Again here, I
think the actual display controllers would be allocated to whichever
outputs get used on a first-come first-serve based, so no need for the
display-controller property above either way.

> What I don't quite see yet is where to
> attach EDID data or pass the phandle to the I2C controller for DDC/EDID
> probing.

I think there's a third node type.

1) Nodes for the display controllers in Tegra (Also known as CRTCs I
believe)

2) Nodes for the video outputs from the Tegra chips (what you have as
outputs above)

3) Connectors, which aren't represented in your DT above yet.

I think you need to add additional nodes for (3). These are where you'd
represent all the EDID/I2C/... stuff. Then, the nodes for the outputs
will point at the nodes for the connectors using phandles, or vice-versa.

(IIRC, although I didn't look at them in detail, the sdrm patches
recently mentioned something about splitting up the various object types
in DRM and allowing them to be represented separately, and I vaguely
recall something along the lines of the types I mention above. I might
expect to have a 1:1 mapping between the DRM object types and DT nodes.)

> The initial configuration is certainly not the right place. Perhaps
> the outputs property should be made a node instead:
> 
> 	outputs {
> 		lvds_out {
> 			output = <&lvds>;
> 			edid = <&edid>;
> 		};
> 
> 		hdmi_out {
> 			output = <&hdmi>;
> 			ddc = <&i2c2>;
> 		};
> 	};
> 
> But then "outputs" should probably become something like "connectors"
> instead and the initial configuration refers to the "_out" phandles.
