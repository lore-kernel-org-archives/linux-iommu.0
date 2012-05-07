From: =?ISO-8859-1?Q?Terje_Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Mon, 7 May 2012 11:50:05 +0300
Message-ID: <4FA78CBD.5010606@nvidia.com>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de> <1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335347102-14905-6-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 25.04.2012 12:45, Thierry Reding wrote:

> +/ {
> +       ...
> +
> +       /* host1x */
> +       host1x: host1x@50000000 {
> +               compatible = "nvidia,tegra20-host1x";
> +               reg = <0x50000000 0x00024000>;
> +               interrupts = <0 64 0x04   /* cop syncpt */
> +                             0 65 0x04   /* mpcore syncpt */
> +                             0 66 0x04   /* cop general */
> +                             0 67 0x04>; /* mpcore general */
> +       };
> +
> +       /* video-encoding/decoding */
> +       mpe@54040000 {
> +               reg = <0x54040000 0x00040000>;
> +               interrupts = <0 68 0x04>;
> +       };
> +

(...)

Hi Thierry,

I have still lots of questions regarding how device trees work. I'm now
just trying to match the device tree structure with hardware - let me
know if that goes wrong.

There's a hierarchy in the hardware, which should be represented in the
device trees. All of the hardware are client modules for host1x - with
the exception of host1x obviously. CPU has two methods for accessing the
hardware: clients' register aperture and host1x channels. Both of these
operate via host1x hardware.

We should define host1x bus in the device tree, and move all nodes
except host1x under that bus. This will help us in the long run, as we
will have multiple drivers (drm, v4l2) each accessing hardware under
host1x. We will need to model the bus and the bus_type will need to take
over responsibilities of managing the common resources.

When we are clocking hardware, whenever we want to access display's
register aperture, host1x needs to be clocked.

> +       /* graphics host */

> +       graphics@54000000 {
> +               compatible = "nvidia,tegra20-graphics";
> +
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               display-controllers = <&disp1 &disp2>;
> +               carveout = <0x0e000000 0x02000000>;
> +               host1x = <&host1x>;
> +               gart = <&gart>;
> +
> +               connectors {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       connector@0 {
> +                               reg = <0>;
> +                               edid = /incbin/("machine.edid");
> +                               output = <&lvds>;
> +                       };
> +
> +                       connector@1 {
> +                               reg = <1>;
> +                               output = <&hdmi>;
> +                               ddc = <&i2c2>;
> +
> +                               hpd-gpio = <&gpio 111 0>; /* PN7 */
> +                       };
> +               };
> +       };
> +};


I'm not sure what this node means. The register range from 54000000
onwards is actually the one that you just described in the nodes of the
individual client modules. Why is it represented here again?

Terje
