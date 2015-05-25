From: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: mediatek: Add smi dts binding
Date: Mon, 25 May 2015 15:48:36 +0900
Message-ID: <CAAFQd5D_-FrVNNPfMTwaWgDHfOPWVnRCvBCV2JS6Q2xPUiEScA@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com> <1431683009-18158-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431683009-18158-3-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Please see my comments inline.

On Fri, May 15, 2015 at 6:43 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> This patch add smi binding document.
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../bindings/soc/mediatek/mediatek,smi-larb.txt    | 24 ++++++++++++++++++++++
>  .../bindings/soc/mediatek/mediatek,smi.txt         | 22 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> new file mode 100644
> index 0000000..c06c5b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> @@ -0,0 +1,24 @@
> +SMI(Smart Multimedia Interface) Local Arbiter
> +
> +The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> +
> +Required properties:
> +- compatible : must be "mediatek,mt8173-smi-larb"
> +- reg : the register and size of each local arbiter.

Shouldn't it be "of this local arbiter"?

> +- smi : must be "&smi_common". Refer to bindings/soc/mediatek,smi.txt.

This is incorrect. Device tree source authors are free to use any
labels for their nodes and documentation should not rely on the fact
that there is some node with some particular label. This should be
something like:

- smi : a phandle to node of XYZ

with proper description of that node in place of XYZ.

> +- clocks : must contain one entry for each clock-names.
> +       There are 2 clockes:
> +       APB clock : Advanced Peripheral Bus clock, It's the clock for setting
> +               the register.
> +       SMI clock : It's the clock for transfer data and command.

The description of each clock should go to "clock-names" property.
Please use some of already existing bindings as an example.

> +- clock-name: must be "apb" and "smi".

typo: Should be "clock-names".

I'd recommend describing this property as below:

- clock-names: must contain 2 entries, as follows:
  - "apb" : <here comes the description of APB clock>,
  - "smi" : <here comes the description of SMI clock>.

> +
> +Example:
> +       larb0:larb@14021000 {
> +               compatible = "mediatek,mt8173-smi-larb";
> +               reg = <0 0x14021000 0 0x1000>;
> +               smi = <&smi_common>;
> +               clocks = <&mmsys MM_SMI_LARB0>,
> +                        <&mmsys MM_SMI_LARB0>;
> +               clock-names = "apb", "smi";
> +       };
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> new file mode 100644
> index 0000000..c2389b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> @@ -0,0 +1,22 @@
> +SMI(Smart Multimedia Interface)
> +
> +The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> +
> +Required properties:
> +- compatible : must be "mediatek,mt8173-smi"
> +- reg : the register and size of the smi.

nit: s/smi/SMI block/

> +- clocks : must contain one entry for each clock-names.
> +       There are 2 clockes:
> +       APB clock : Advanced Peripheral Bus clock, It's the clock for setting
> +               the register.
> +       SMI clock : It's the clock for transfer data and command.
> +- clock-name: must be "apb" and "smi".

See my comment for those properties in the first binding.

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
