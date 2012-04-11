From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 12:12:14 -0600
Message-ID: <4F85C97E.50203@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1334146230-1795-5-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
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

On 04/11/2012 06:10 AM, Thierry Reding wrote:
> This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> currently has rudimentary GEM support and can run a console on the
> framebuffer as well as X using the xf86-video-modesetting driver.
> Only the RGB output is supported. Quite a lot of things still need
> to be worked out and there is a lot of room for cleanup.

I'll let Jon Mayo comment on the actual driver implementation, since
he's a lot more familiar with Tegra's display hardware. However, I have
some general comments below.

>  .../devicetree/bindings/gpu/drm/tegra.txt          |   24 +
>  arch/arm/mach-tegra/board-dt-tegra20.c             |    3 +
>  arch/arm/mach-tegra/tegra2_clocks.c                |    8 +-
>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/tegra/Kconfig                      |   10 +
>  drivers/gpu/drm/tegra/Makefile                     |    5 +
>  drivers/gpu/drm/tegra/tegra_drv.c                  | 2241 ++++++++++++++++++++
>  drivers/gpu/drm/tegra/tegra_drv.h                  |  184 ++
>  include/drm/tegra_drm.h                            |   44 +

Splitting this patch into two, between arch/arm and drivers/gpu would be
a good idea.

> diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt

> +	drm@54200000 {
> +		compatible = "nvidia,tegra20-drm";

This doesn't seem right; there isn't a "DRM" hardware module on Tegra,
since "DRM" is a Linux/software-specific term.

I'd at least expect to see this compatible flag be renamed to something
more like "nvidia,tegra20-dc" (dc==display controller).

Since Tegra has two display controller modules (I believe identical?),
and numerous other independent(?) blocks, I'd expect to see multiple
nodes in device tree, one per hardware block, such that each block gets
its own device and driver. That said, I'm not familiar enough with
Tegra's display and graphics HW to know if this makes sense. Jon, what's
your take here? The clock change below, and in particular the original
code there that we use downstream, lends weight to my argument.

> +		reg = < 0x54200000 0x00040000    /* display A */
> +		        0x54240000 0x00040000    /* display B */
> +		        0x58000000 0x02000000 >; /* GART aperture */
> +		interrupts = < 0 73 0x04    /* display A */
> +		               0 74 0x04 >; /* display B */
> +
> +		lvds {
> +			type = "rgb";

These sub-nodes probably want a "compatible" property rather than a
"type" property.

> +			size = <345 194>;
> +
> +			default-mode {
> +				pixel-clock = <61715000>;
> +				vertical-refresh = <50>;
> +				resolution = <1366 768>;
> +				bits-per-pixel = <16>;
> +				horizontal-timings = <4 136 2 36>;
> +				vertical-timings = <2 4 21 10>;
> +			};
> +		};

I imagine that quite a bit of thought needs to be put into the output
part of the binding in order to:

* Model the outputs/connectors separately from display controllers.
* Make sure that the basic infra-structure for representing an output is
general enough to be extensible to all the kinds of outputs we support,
not just the LVDS output.
* We were wondering about putting an EDID into the DT to represent the
display modes, so that all outputs had EDIDs rather than "real" monitors
having EDIDs, and fixed internal displays having some other
representation of capabilities.

I'm hoping that Jon will drive this.

> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c

> -	PERIPH_CLK("disp1",	"tegradc.0",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> -	PERIPH_CLK("disp2",	"tegradc.1",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> +	PERIPH_CLK("disp1",	"tegra-drm",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> +	PERIPH_CLK("disp2",	"tegra-drm",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */

This doesn't seem right, and couples back to my assertion above that the
two display controller modules probably deserve separate device objects,
named e.g. tegradc.*.

> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> new file mode 100644
> index 0000000..f3382c9
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -0,0 +1,10 @@
> +config DRM_TEGRA
> +	tristate "NVIDIA Tegra"
> +	depends on DRM && ARCH_TEGRA

Jon, do you think we'll end up eventually having a unified
Tegra20/Tegra30 DRM driver, or separate top-level DRM drivers?

In other words, should this depend on ARCH_TEGRA_2x_SOC rather than
ARCH_TEGRA?

> diff --git a/drivers/gpu/drm/tegra/tegra_drv.c b/drivers/gpu/drm/tegra/tegra_drv.c

> +#define DRIVER_NAME "tegra"
> +#define DRIVER_DESC "NVIDIA Tegra graphics"

Similarly, I wonder if these should be "tegra20" and "NVIDIA Tegra20
graphics", or not?

> +static int tegra_drm_parse_dt_mode(struct device *dev,
...
> +	err = of_property_read_u32(node, "pixel-clock", &value);
> +	if (err < 0)
> +		return err;

Is it useful to call dev_err() when the DT is present but can't be
parsed, to give some clue what the problem is?

> +static int tegra_drm_parse_dt(struct platform_device *pdev)
> +{
...
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
...
> +	dev->platform_data = pdata;

I don't think you should assign to dev->platform_data. If you do, then I
think the following could happen:

* During first probe, the assignment above happens
* Module is removed, hence device removed, hence dev->platform_data
freed, but not zero'd out
* Module is re-inserted, finds that dev->platform_data!=NULL and
proceeds to use it.

Instead, the active platform data should probably be stored in a
tegra_drm struct that's stored in the dev's private data.
tegra_drm_probe() might then look more like:

struct tegra_drm *tdev;

tdev = devm_kzalloc();
tdev->pdata = pdev->dev.platform_data;
if (!tdev->pdata)
    tdev->pdata = tegra_drm_parse_dt();
if (!tdev->pdata)
    return -EINVAL;

dev_set_drvdata(dev, tdev);

This is safe, since probe() will never assume that dev_get_drvdata()
might contain something valid before probe() sets it.
