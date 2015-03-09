From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 5/5] dts: mt8173: Add iommu/smi nodes for mt8173
Date: Mon, 9 Mar 2015 20:18:34 +0800
Message-ID: <1425903514.13300.35.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-6-git-send-email-yong.wu@mediatek.com>
	 <CAGS+omDotK45t5a4FKpU9z2Bg=e9aWDpXt+mCX92CM-2ZMQGNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omDotK45t5a4FKpU9z2Bg=e9aWDpXt+mCX92CM-2ZMQGNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Dear Daniel,

     Thanks very much. I will fix this in next version.

On Sat, 2015-03-07 at 23:20 +0800, Daniel Kurtz wrote:
> Hi Yong,
> 
> On Fri, Mar 6, 2015 at 6:48 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > This patch add the iommu/larbs nodes for mt8173
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  60 ++++++++++++
> >  include/dt-bindings/iommu/mt8173-iommu-port.h | 127 ++++++++++++++++++++++++++
> >  2 files changed, 187 insertions(+)
> >  create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index c2a057f..805a7cd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -16,6 +16,7 @@
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >  #include "mt8173-pinfunc.h"
> >  #include <dt-bindings/clock/mt8173-clk.h>
> > +#include <dt-bindings/iommu/mt8173-iommu-port.h>
> >
> >  / {
> >         compatible = "mediatek,mt8173";
> > @@ -249,6 +250,65 @@
> >                         interrupts = <0 86 8>;
> >                         clocks = <&uart_clk>;
> >                 };
> > +
> > +               iommu: mmsys_iommu@10205000 {
> > +                       compatible = "mediatek,mt8173-iommu";
> > +                       reg = <0 0x10205000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infrasys INFRA_M4U>;
> > +                       clock-names = "infra_m4u";
> > +                       larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
> > +                       #iommu-cells = <1>;
> > +               };
> > +
> > +               larb0:larb@14021000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14021000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB0>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb1:larb@16010000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x16010000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vdecsys VDEC_CKEN>,
> > +                                       <&vdecsys VDEC_LARB_CKEN>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> > +
> > +               larb2:larb@16010000 {
> 
> I think this one should be:
>    larb2: larb@15001000 {
> 
> Also, I am not a devicetree expert, but I believe nodes are usually
> arranged in register order.
> If that is the case, the order, as unfortunate as this looks, should be:
> 
>  larb0: larb@14021000
>  larb4: larb@14027000
>  larb2: larb@15001000
>  larb1: larb@16010000
>  larb3: larb@18001000
>  larb5: larb@19001000
> 
> -Dan
> 
> 
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x15001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&imgsys IMG_LARB2_SMI>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb3:larb@18001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x18001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vencsys VENC_CKE0>,
> > +                                       <&vencsys VENC_CKE1>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> > +
> > +               larb4:larb@14027000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14027000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB4>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb5:larb@19001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x19001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vencltsys VENCLT_CKE0>,
> > +                                       <&vencltsys VENCLT_CKE1>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> >         };
> >
> >  };
> > --
> > 1.8.1.1.dirty


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
