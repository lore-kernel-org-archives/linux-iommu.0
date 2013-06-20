From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
Date: Thu, 20 Jun 2013 10:24:39 +0200
Message-ID: <20130620.112439.1330557591655135630.hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com><1371707384-30037-3-git-send-email-hdoyu@nvidia.com><CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Nishanth,

Nishanth Peethambaran <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Thu, 20 Jun 2013 10:07:00 +0200:

> It would be better to define a prot flag bit in iommu API and convert
> the attrs to prot flag bit in dma-mapping aPI before calling the iommu
> API.

That's the 1st option.

> On Thu, Jun 20, 2013 at 11:19 AM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
....
> > @@ -1280,7 +1281,7 @@ ____iommu_create_mapping(struct device *dev, dma_addr_t *req,
> >                                 break;
> >
> >                 len = (j - i) << PAGE_SHIFT;
> > -               ret = iommu_map(mapping->domain, iova, phys, len, 0);
> > +               ret = iommu_map(mapping->domain, iova, phys, len, (int)attrs);
> 
> Use dma_get_attr and translate the READ_ONLY attr to a new READ_ONLY
> prot flag bit which needs to be defined in iommu.h

Both DMA_ATTR_READ_ONLY and IOMMU_READ are just logical bit in their
layers respectively and eventually it's converted to H/W dependent
bit.

If IOMMU is considered as one of specific case of DMA, sharing
dma_attr between IOMMU and DMA may not be so bad. IIRC, ARM:
dma-mapping API was implemented based on this concept(?).

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d8f98b1..161a1b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -755,7 +755,7 @@ int iommu_domain_has_cap(struct iommu_domain *domain,
 EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+	      phys_addr_t paddr, size_t size, struct dma_attr *attrs)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
