From: Tom Murphy via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 2/9] iommu/dma-iommu: Add function to flush any cached not
	present IOTLB entries
Date: Tue, 16 Apr 2019 17:40:17 +0100
Message-ID: <CAPL0++7czbNnJAnn40GtkK2ojrWHMu60DfzVEn_EfYK_WCdYWw@mail.gmail.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-3-tmurphy@arista.com>
	<82ce70dc-b370-3bb0-bce8-2d32db4d6a0d@arm.com>
Reply-To: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <82ce70dc-b370-3bb0-bce8-2d32db4d6a0d-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>That said, I've now gone and looked and AFAICS both the Intel...
Ah, I missed that, you're right.

>...and AMD
It doesn't look like it. On AMD the cache is flushed during
iommu_ops::map only if the there are page table pages to free (if
we're allocating a large page and freeing the sub pages), right?
I guess this is a bug in the AMD iommu driver, as you said, it should
be handled in iommu_map(). I'll submit another patch to flush the np
cache on a call to amd iommu_ops::map if amd_iommu_np_cache is set.

>What might be
>worthwhile, though, is seeing if there's scope to refactor those drivers
>to push some of it into an iommu_ops::iotlb_sync_map callback to
>optimise the flushing for multi-page mappings.
I am working on a different patch series to improve the flushing and
page table page freeing for both amd and intel

On Tue, Apr 16, 2019 at 3:01 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On 11/04/2019 19:47, Tom Murphy wrote:
> > Both the AMD and Intel drivers can cache not present IOTLB entries. To
> > convert these drivers to the dma-iommu api we need a generic way to
> > flush the NP cache. IOMMU drivers which have a NP cache can implement
> > the .flush_np_cache function in the iommu ops struct. I will implement
> > .flush_np_cache for both the Intel and AMD drivers in later patches.
> >
> > The Intel np-cache is described here:
> > https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf#G7.66452
> >
> > And the AMD np-cache is described here:
> > https://developer.amd.com/wordpress/media/2012/10/34434-IOMMU-Rev_1.26_2-11-09.pdf#page=63
>
> Callers expect that once iommu_map() returns successfully, the mapping
> exists and is ready to use - if these drivers aren't handling this
> flushing internally, how are they not already broken for e.g. VFIO?
>
> > Signed-off-by: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 10 ++++++++++
> >   include/linux/iommu.h     |  3 +++
> >   2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1a4bff3f8427..cc5da30d6e58 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -594,6 +594,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >                       < size)
> >               goto out_free_sg;
> >
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, size);
> > +
>
> This doesn't scale. At the very least, it should be internal to
> iommu_map() and exposed to be the responsibility of every external
> caller now and forever after.
>
> That said, I've now gone and looked and AFAICS both the Intel and AMD
> drivers *do* appear to handle this in their iommu_ops::map callbacks
> already, so the whole patch does indeed seem bogus. What might be
> worthwhile, though, is seeing if there's scope to refactor those drivers
> to push some of it into an iommu_ops::iotlb_sync_map callback to
> optimise the flushing for multi-page mappings.
>
> Robin.
>
> >       *handle = iova;
> >       sg_free_table(&sgt);
> >       return pages;
> > @@ -652,6 +655,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >               iommu_dma_free_iova(cookie, iova, size);
> >               return DMA_MAPPING_ERROR;
> >       }
> > +
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, size);
> > +
> >       return iova + iova_off;
> >   }
> >
> > @@ -812,6 +819,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >       if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
> >               goto out_free_iova;
> >
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, iova_len);
> > +
> >       return __finalise_sg(dev, sg, nents, iova);
> >
> >   out_free_iova:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 75559918d9bd..47ff8d731d6a 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -173,6 +173,7 @@ struct iommu_resv_region {
> >    * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
> >    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> >    *            queue
> > + * @flush_np_cache: Flush the non present entry cache
> >    * @iova_to_phys: translate iova to physical address
> >    * @add_device: add device to iommu grouping
> >    * @remove_device: remove device from iommu grouping
> > @@ -209,6 +210,8 @@ struct iommu_ops {
> >                               unsigned long iova, size_t size);
> >       void (*iotlb_sync_map)(struct iommu_domain *domain);
> >       void (*iotlb_sync)(struct iommu_domain *domain);
> > +     void (*flush_np_cache)(struct iommu_domain *domain,
> > +                             unsigned long iova, size_t size);
> >       phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> >       int (*add_device)(struct device *dev);
> >       void (*remove_device)(struct device *dev);
> >
