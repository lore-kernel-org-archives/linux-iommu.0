From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 10 Mar 2015 11:41:47 +0800
Message-ID: <1425958907.4871.102.camel@mtksdaap41>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
	<1425912389.4871.19.camel@mtksdaap41>
	<CAAFQd5DpXxyoNiTGC4YYnpXeKo43XXrC+my6KWOV1pGq1jw6Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5DpXxyoNiTGC4YYnpXeKo43XXrC+my6KWOV1pGq1jw6Aw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-03-10 at 02:00 +0900, Tomasz Figa wrote:
> On Mon, Mar 9, 2015 at 11:46 PM, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > On Mon, 2015-03-09 at 20:11 +0900, Tomasz Figa wrote:
> > <...>
> >> > +/*
> >> > + * pimudev is a global var for dma_alloc_coherent.
> >> > + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> >> > + */
> >> > +static struct device *pimudev;
> >>
> >> This is indeed not acceptable. Could you replace dma_alloc_coherent()
> >> with something that doesn't require device pointer, e.g.
> >> alloc_pages()? (Although that would require you to handle cache
> >> maintenance in the driver, due to cached memory allocated.) I need to
> >> think about a better solution for this.
> >
> > Hi,
> >
> > For 2nd level page table, we use cached memory now. Currently we are
> > using __dma_flush_range to flush the cache, which is also unacceptable.
> >
> > For proper cache management, we'll need to use dma_map_single or
> > dma_sync_*, which still need a deivce*.
> 
> Looking at how already mainlined drivers do this, they either use
> dmac_flush_range()
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/msm_iommu.c?id=refs/tags/v4.0-rc3#n80)
> or directly __cpuc_flush_dcache_area() and outer_flush_range()
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/rockchip-iommu.c?id=refs/tags/v4.0-rc3#n93).

Hi,

These only exist in arch/arm, not arm64. I think we should avoid using
API start with __ in drivers. This driver might be used in both
arm/arm64, I think the only option for us is DMA APIs.

Actually, I'm thinking that we should change to use coherent memory for
2nd level page table as well and totally skip the cache flush. It seems
dma_pool_create is suitable to replace kmem_cache we are using right
now. However it still need a device*, which we have to fix anyway.

Joe.C
