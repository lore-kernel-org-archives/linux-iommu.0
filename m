From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 11:21:06 +0200
Message-ID: <20120412092106.GU3852@pengutronix.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <4F85C97E.50203@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F85C97E.50203-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2012 at 12:12:14PM -0600, Stephen Warren wrote:
> On 04/11/2012 06:10 AM, Thierry Reding wrote:
> > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> > currently has rudimentary GEM support and can run a console on the
> > framebuffer as well as X using the xf86-video-modesetting driver.
> > Only the RGB output is supported. Quite a lot of things still need
> > to be worked out and there is a lot of room for cleanup.
> 
> I'll let Jon Mayo comment on the actual driver implementation, since
> he's a lot more familiar with Tegra's display hardware. However, I have
> some general comments below.
> 
> >  .../devicetree/bindings/gpu/drm/tegra.txt          |   24 +
> >  arch/arm/mach-tegra/board-dt-tegra20.c             |    3 +
> >  arch/arm/mach-tegra/tegra2_clocks.c                |    8 +-
> >  drivers/gpu/drm/Kconfig                            |    2 +
> >  drivers/gpu/drm/Makefile                           |    1 +
> >  drivers/gpu/drm/tegra/Kconfig                      |   10 +
> >  drivers/gpu/drm/tegra/Makefile                     |    5 +
> >  drivers/gpu/drm/tegra/tegra_drv.c                  | 2241 ++++++++++++++++++++
> >  drivers/gpu/drm/tegra/tegra_drv.h                  |  184 ++
> >  include/drm/tegra_drm.h                            |   44 +
> 
> Splitting this patch into two, between arch/arm and drivers/gpu would be
> a good idea.
> 
> > diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
> 
> > +	drm@54200000 {
> > +		compatible = "nvidia,tegra20-drm";
> 
> This doesn't seem right; there isn't a "DRM" hardware module on Tegra,
> since "DRM" is a Linux/software-specific term.
> 
> I'd at least expect to see this compatible flag be renamed to something
> more like "nvidia,tegra20-dc" (dc==display controller).
> 
> Since Tegra has two display controller modules (I believe identical?),
> and numerous other independent(?) blocks, I'd expect to see multiple
> nodes in device tree, one per hardware block, such that each block gets
> its own device and driver. That said, I'm not familiar enough with
> Tegra's display and graphics HW to know if this makes sense. Jon, what's
> your take here? The clock change below, and in particular the original
> code there that we use downstream, lends weight to my argument.
> 
> > +		reg = < 0x54200000 0x00040000    /* display A */
> > +		        0x54240000 0x00040000    /* display B */
> > +		        0x58000000 0x02000000 >; /* GART aperture */
> > +		interrupts = < 0 73 0x04    /* display A */
> > +		               0 74 0x04 >; /* display B */
> > +
> > +		lvds {
> > +			type = "rgb";
> 
> These sub-nodes probably want a "compatible" property rather than a
> "type" property.
> 
> > +			size = <345 194>;
> > +
> > +			default-mode {
> > +				pixel-clock = <61715000>;
> > +				vertical-refresh = <50>;
> > +				resolution = <1366 768>;
> > +				bits-per-pixel = <16>;
> > +				horizontal-timings = <4 136 2 36>;
> > +				vertical-timings = <2 4 21 10>;
> > +			};
> > +		};
> 
> I imagine that quite a bit of thought needs to be put into the output
> part of the binding in order to:
> 
> * Model the outputs/connectors separately from display controllers.
> * Make sure that the basic infra-structure for representing an output is
> general enough to be extensible to all the kinds of outputs we support,
> not just the LVDS output.
> * We were wondering about putting an EDID into the DT to represent the
> display modes, so that all outputs had EDIDs rather than "real" monitors
> having EDIDs, and fixed internal displays having some other
> representation of capabilities.

You might want to have a look at the sdrm patches I recently posted to
dri-devel and arm Linux Kernel. Among other things they allow to
register crtcs/connectors/encoders seperately so that each of them can
have its own representation in the devicetree. I haven't looked into
devicetree support for DRM, but with or without devicetree the problem
that we do not have a single PCI card for registering all DRM components
is the same.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
