From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 29 Jul 2015 13:41:31 +0800
Message-ID: <1438148491.25925.89.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
	<55B630CE.4050803@arm.com>
	<20150727153148.GJ7557@n2100.arm.linux.org.uk>
	<55B6530A.9050903@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55B6530A.9050903-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-07-27 at 16:49 +0100, Robin Murphy wrote:
> On 27/07/15 16:31, Russell King - ARM Linux wrote:
> > On Mon, Jul 27, 2015 at 02:23:26PM +0100, Robin Murphy wrote:
> >> On 16/07/15 10:04, Yong Wu wrote:
> >>> This patch adds support for mediatek m4u (MultiMedia Memory Management
> >>> Unit).
> >>>
> >>> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> [...]
> >>> +static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> >>> +{
> >>> +       struct mtk_iommu_domain *domain = cookie;
> >>> +       unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
> >>> +
> >>> +       dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
> >>> +                    size, DMA_TO_DEVICE);
> >>
> >> Nit: this looks like it may as well be dma_map_single.
> >>
> >> It would probably be worth following it with a matching unmap too, just to
> >> avoid any possible leakage bugs (especially if this M4U ever appears in a
> >> SoC supporting RAM above the 32-bit boundary).
> >
> > Why not do the job properly?  Take a look at how I implemented the
> > streaming DMA API on Tegra SMMU (patch set recently sent out earlier
> > today).
> >
> > There's no need for hacks like dma_map_page() (and discarding it's
> > return value) or dma_map_page() followed by dma_unmap_page().
> 
> Indeed, as it happens I do have a branch where I prototyped that for the 
> long-descriptor io-pgtable-arm code a while ago; this discussion has 
> prompted me to dig it up again. Stay tuned, folks...

Hi Russell, Robin,

     From I see in arm-smmu-v3.c in v4.2-rc1, 
     
     The flush_pgtable seems like this:
//==========
	dma_addr_t dma_addr;

	dma_addr = dma_map_page(dev, ptr, size, DMA_TO_DEVICE);

	if (dma_mapping_error(dev, dma_addr))
		dev_err(dev, "failed to flush pgtable at %p\n", ptr);
	else
		dma_unmap_page(dev, dma_addr, size, DMA_TO_DEVICE);
//==========
       I will change map like this and use dma_map_single instead.

       Is this also seems to be not proper?

       Then how to do it?  add this before unmap? :
       dma_sync_single_for_device(dev, dma_addr, size, DMA_TO_DEVICE);

> 
> Robin.
> 
