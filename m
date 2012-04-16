From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Mon, 16 Apr 2012 12:10:59 +0200
Message-ID: <20120416.131059.331282986467061278.hdoyu@nvidia.com>
References: <20120413.132205.1766846402066131036.hdoyu@nvidia.com><4F887F9B.700@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F887F9B.700-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Fri, 13 Apr 2012 21:33:47 +0200
Message-ID: <4F887F9B.700-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 04/13/2012 04:22 AM, Hiroshi Doyu wrote:
> > From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > Add device tree support for Tegra30 IOMMU(SMMU).
> 
> > +++ b/Documentation/devicetree/bindings/arm/tegra/tegra30-smmu.txt
> 
> I personally like the documentation to be named after the full
> compatible value, so nvidia,tegra30-smmu.txt.

OK

> > @@ -0,0 +1,19 @@
> > +NVIDIA Tegra 30 IOMMU H/W, SMMU (System Memory Management Unit)
> > +
> > +Required properties:
> > +- compatible : "nvidia,tegra30-smmu"
> > +- reg : Should contain MC registers location and length
> > +- reg : Should contain AHB Arbitration registers and length
> > +- reg : Should contain virtual address space range
> 
> This looks like 3 properties with the same name. It seems common to
> write something more like:
> 
> reg : Should contain the register address and length for each fo the MC
> and AHB arbitration registers.

OK, this looks better.

> But why does the SMMU driver expect to control the AHB arbitration
> registers? They seem unrelated to the SMMU.

It's necessary to inform AHB that SMMU is ready to use. There's a
dedicated bit for SMMU in this AHB arbitration register.

> As I said in my previous email, I think the VA space size should be a
> separate property.

OK, I'll update.
