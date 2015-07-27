From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 27 Jul 2015 12:24:31 +0800
Message-ID: <1437971071.25925.24.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
	 <20150721145910.GG31095@arm.com> <1437716593.23932.73.camel@mhfsdcap03>
	 <20150724165509.GD21177@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150724165509.GD21177-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>"arnd-r2nGTMty4D4@public.gmane.org" <a>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-07-24 at 17:55 +0100, Will Deacon wrote:
> On Fri, Jul 24, 2015 at 06:43:13AM +0100, Yong Wu wrote:
> > On Tue, 2015-07-21 at 15:59 +0100, Will Deacon wrote:
> > > On Thu, Jul 16, 2015 at 10:04:34AM +0100, Yong Wu wrote:
> > > > +static void mtk_iommu_tlb_flush_all(void *cookie)
> > > > +{
> > > > +       struct mtk_iommu_domain *domain = cookie;
> > > > +       void __iomem *base;
> > > > +
> > > > +       base = domain->data->base;
> > > > +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> > > > +       writel(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
> > > 
> > > This needs to be synchronous, so you probably want to call
> > > mtk_iommu_tlb_sync at the end.
> > 
> > From our spec, we have to wait until HW done after tlb flush range.
> > But it don't need wait after tlb flush all.
> > so It isn't necessary to add mtk_iommu_tlb_sync in tlb_flush_all here.
> 
> Okey doke, but I'm surprised you don't need a subsequent DSB or read-back.
> What if the writel is buffered on the way to the IOMMU?

Then I change to this:
 //==========
    writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
    writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);    
    dsb(ishst);
//===========
    dsb or mb(). which one is better here?

> 
> Will


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
