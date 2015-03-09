From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/5] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Mon, 9 Mar 2015 19:30:55 +0800
Message-ID: <1425900655.13300.5.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-5-git-send-email-yong.wu@mediatek.com>
	<20150306112137.GE8700@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150306112137.GE8700@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Dear Mark,

     Thanks very much for your review.
     I will fix them in the next verion.

On Fri, 2015-03-06 at 11:21 +0000, Mark Rutland wrote:
> On Fri, Mar 06, 2015 at 10:48:19AM +0000, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > This patch add mediatek iommu dts binding document.
> > 
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > new file mode 100644
> > index 0000000..db01c92
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > @@ -0,0 +1,41 @@
> > +/******************************************************/
> > +/*    Mediatek IOMMU Hardware block diagram           */
> > +/******************************************************/
> > +              EMI (External Memory Interface)
> > +               |
> > +              m4u (Multimedia Memory Management Unit)
> > +               |
> > +              smi (Smart Multimedia Interface)
> > +               |
> > +        +---------------+-------
> > +        |               |
> > +        |               |
> > +    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
> > +        |               |
> > +        |               |
> > +   +----+----+    +-----+-----+
> > +   |    |    |    |     |     |    ...
> > +   |    |    |    |     |     |    ...
> > +   |    |    |    |     |     |    ...
> > +  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mt8173-iommu"
> 
> s/iommu/m4u/ -- the name should match what the hardware is called.
> 
> > +- reg : m4u register base
> 
> ... and size
> 
> > +- interrupts : must contain the interrupts from each internal translation unit
> 
> How many "internal translation units" are there?
> 
> How should the interrupts be ordered?
> 
> How do these relate to the larbs?
   There is only one internal translation units in MT8173.(2 units in
MT8135)
   Because this patch is only for mt8173, so I will change it like this:

interrupts : the interrupt of the m4u.
    is it ok?
> 
> > +- clocks : must contain one entry for each clock-name
> > +- clock-name: m4u clock
> 
> This does not match the example.
> 
> s/clock-name/clock-names/
> 
> Please format this like a list, with names quoted, e.g.
> 
> - clock-names: must contain:
>   * "m4u" - The functional clock for the m4u
> 
> > +- larb : must contain the larbes of current platform
> 
> s/larbes/local arbiters/
> 
> How should these be ordered? Surely there's a relationship with
> registers/interrupts/etc in this unit?
> 
> > +- iommu-cells : must be 1. Specifies the client PortID as defined in
> > +dt-binding/iommu/mt**-iommu-port.h
> 
> Give the absolute filename.
> 
> The include file should be added in this patch (it's part of the
> binding). The whole patch should be moved earlier in the series.
> 
> Thanks,
> Mark.
> 
> > +
> > +Example:
> > +		iommu: mmsys_iommu@10205000 {
> > +			compatible = "mediatek,mt8173-iommu";
> > +			reg = <0 0x10205000 0 0x1000>;
> > +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&infrasys INFRA_M4U>;
> > +			clock-names = "infra_m4u";
> > +			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
> > +			#iommu-cells = <1>;
> > +		};
> > \ No newline at end of file
> > -- 
> > 1.8.1.1.dirty
> > 
> > 
