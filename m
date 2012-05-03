From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Thu, 03 May 2012 15:22:10 -0600
Message-ID: <4FA2F702.6040701@wwwdotorg.org>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de> <1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335347102-14905-6-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?ISO-8859-1?Q?Terje_Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/25/2012 03:45 AM, Thierry Reding wrote:
> This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> currently has rudimentary GEM support and can run a console on the
> framebuffer as well as X using the xf86-video-modesetting driver. Only
> the RGB output is supported.
> 
> HDMI support was taken from NVIDIA's Linux kernel tree but it doesn't
> quite work. EDID data can be retrieved but the output doesn't properly
> activate the connected TV.
> 
> The DSI and TVO outputs and the HOST1X driver are just stubs that setup
> the corresponding resources but don't do anything useful yet.

I'm mainly going to comment on the device tree bindings here; hopefully
Jon and Terje can chime in on the code itself.

> diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt

> +Example:
> +
> +/memreserve/ 0x0e000000 0x02000000;
> +
> +...
> +
> +/ {
> +	...
> +
> +	/* host1x */
> +	host1x: host1x@50000000 {
> +		compatible = "nvidia,tegra20-host1x";
> +		reg = <0x50000000 0x00024000>;
> +		interrupts = <0 64 0x04   /* cop syncpt */
> +			      0 65 0x04   /* mpcore syncpt */
> +			      0 66 0x04   /* cop general */
> +			      0 67 0x04>; /* mpcore general */
> +	};

The host1x module is apparently a register bus, behind which all the
other modules sit. According to the address map in the TRM, "all the
other modules" appears to include all of MPE, VI, CSI, EPP, ISP, GR2D,
GR3D, DISPLAY A/B, HDMI, TVO, DSI, plus VG, VS, VCI, DSIB on Tegra30.

That said, I believe Terje wasn't convinced that all those modules are
really host1x children, just some. Can you check please, Terje?

Also, I wonder if host1x is really the parent of these modules,
register-bus-access-wise, or whether the bus covers the "graphic host
registers" at 0x50000000-0x50023fff?

As such, I think the DT nodes for all those modules should be within the
host1x node (or perhaps graphics host node, pending above discussion):

    host1x: host1x@50000000 {
        mpe@54040000 { ... };
        vi@54080000 { ... };
        ...
    };

host1x can easily instantiate all the child nodes simply by calling
of_platform_populate() at the end of its probe; see
sound/soc/tegra/tegra30_ahub.c for an example.

> +	/* video-encoding/decoding */
> +	mpe@54040000 {
> +		reg = <0x54040000 0x00040000>;
> +		interrupts = <0 68 0x04>;
> +	};

We'll probably end up needing a phandle from each of these nodes to
host1x, and a channel ID, so the drivers for these nodes can register
themselves with host1x. However, I it's probably OK to defer the DT
binding for this until we actually start working on command-channels.

> +	/* graphics host */
> +	graphics@54000000 {
> +		compatible = "nvidia,tegra20-graphics";
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

I don't think those 3 properties are needed, unless there are child
nodes with registers.

> +		display-controllers = <&disp1 &disp2>;
> +		carveout = <0x0e000000 0x02000000>;
> +		host1x = <&host1x>;
> +		gart = <&gart>;
> +
> +		connectors {

I'm not sure that it makes sense to put the connectors nodes underneath
the graphics host node; the connectors aren't objects with registers
that are accessed through a bus managed by the graphics node. Equally,
the connectors could be useful outside of the graphics driver - e.g. the
audio driver might need to refer to an HDMI connector.

Instead, I'd probably put the connector nodes at the top level of the
device tree, and have graphics contain a property that lists the
phandles of all available connectors.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			connector@0 {
> +				reg = <0>;
> +				edid = /incbin/("machine.edid");
> +				output = <&lvds>;
> +			};

I think each of these needs some kind of compatible value to indicate
their type. Also, the ability to represent both HDMI video and audio
streams so that a sound card binding could use the HDMI connector too. I
see that drivers/extcon/ has appeared recently, and I wonder if the
connector nodes in DT shouldn't be handled by that subsystem?

> +			connector@1 {
> +				reg = <1>;
> +				output = <&hdmi>;
> +				ddc = <&i2c2>;
> +
> +				hpd-gpio = <&gpio 111 0>; /* PN7 */
> +			};
> +		};
> +	};
> +};

> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c

> +	{ "host1x",     "pll_c",        144000000,      true },
> +	{ "disp1",      "pll_p",        600000000,      true },
> +	{ "disp2",      "pll_p",        600000000,      true },

Can we use these tables /just/ to set up the clock parent relationships,
and rely on the drivers to enable/disable the clocks as needed? I'm
hoping to replace these tables with DT once Tegra support common clock
and bindings, but I don't want to see the ability to turn clocks on
there, just set the parenting relationships, and perhaps initial rates.

> diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
> index 7e76da7..3e80f3f 100644
> --- a/arch/arm/mach-tegra/include/mach/iomap.h
> +++ b/arch/arm/mach-tegra/include/mach/iomap.h
> @@ -56,6 +56,12 @@
>  #define TEGRA_HDMI_BASE			0x54280000
>  #define TEGRA_HDMI_SIZE			SZ_256K
>  
> +#define TEGRA_TVO_BASE			0x542c0000
> +#define TEGRA_TVO_SIZE			SZ_256K
> +
> +#define TEGRA_DSI_BASE			0x54300000
> +#define TEGRA_DSI_SIZE			SZ_256K

Perhaps we can just hard-code the addresses into the AUXDATA in
board-dt-tegra20.c to save defining more entries in this file. Hopefully
this file is going away ASAP when we get rid of board files.
