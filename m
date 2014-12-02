From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Tue, 02 Dec 2014 13:47:36 +0200
Message-ID: <3393414.BkWUUqodng@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<2303317.ZEDe4Fptcu@avalon> <20141202094156.GB9917@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141202094156.GB9917-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tuesday 02 December 2014 09:41:56 Will Deacon wrote:
> On Mon, Dec 01, 2014 at 08:21:58PM +0000, Laurent Pinchart wrote:
> > On Monday 01 December 2014 17:23:15 Will Deacon wrote:
> > > On Sun, Nov 30, 2014 at 11:29:46PM +0000, Laurent Pinchart wrote:
> > > > On Thursday 27 November 2014 11:51:16 Will Deacon wrote:
> > > > > +     /* Looking good; allocate a pgd */
> > > > > +     data->pgd = alloc_pages_exact(1UL << data->pg_shift,
> > > > > +                                   GFP_KERNEL | __GFP_ZERO);
> > > > 
> > > > data->pg_shift is computed as __ffs(cfg->pgsize_bitmap). 1UL <<
> > > > data->pg_shift will thus be equal to the smallest page size supported
> > > > by the IOMMU. This will thus allocate 4kB, 16kB or 64kB depending on
> > > > the IOMMU configuration. However, if I'm not mistaken the top-level
> > > > directory needs to store one entry per largest supported page size.
> > > > That's 4, 128 or 8 entries depending on the configuration. You're thus
> > > > over-allocating.
> > > 
> > > Yeah, I'll take a closer look at this. The size of the pgd really
> > > depends on the TxSZ configuration, which in turn depends on the ias and
> > > the page size. There are also alignment constraints to bear in mind, but
> > > I'll see what I can do (as it stands, over-allocating will always work).
> > 
> > Beside wasting memory, the code also doesn't reflect the requirements. It
> > works by chance, meaning it could break later.
> 
> It won't break, as the maximum size *is* bounded by a page for stage-1
> and we already handle stage-2 concatenation correctly.

What I mean is that there's no correlation between the required size and the 
allocated size in the current code. It happens to work, but if the driver gets 
extended later to support more IOMMU configurations subtle bugs may crop up.

> > That's why I'd like to see this
> > being fixed. Can't the size be computed with something like
> > 
> > 	size = (1 << (ias - data->levels * data->pg_shift))
> > 	
> > 	     * sizeof(arm_lpae_iopte);
> > 
> > (please add a proper detailed comment to explain the computation, as the
> > meaning is not straightforward)
> 
> That's actually the easy part. The harder part is getting the correct
> alignment, which means managing by own kmem_cache on a per-ops basis. That
> feels like overkill to me and we also need to make sure that we don't screw
> up the case of concatenated pgds at stage-2. On top of that, since each
> cache would be per-ops, I'm not even sure we'd save anything (the slab
> allocators all operate on pages afaict).
> 
> If I use alloc_page_exact, we'll still have some wasteage, but it would
> be less for the case where the CPU page size is smaller than the SMMU page
> size. Do you think that's worth the extra complexity? We allocate full pages
> at all levels after the pgd, so the wasteage is relatively small.
> 
> An alternative would be preinitialising some caches for `likely' pgd sizes,
> but that's also horrible, especially if the kernel decides that it doesn't
> need a bunch of the configurations at runtime.

How about just computing the right size, align it to a page size, and using 
alloc_page_exact ? The waste is small, so it doesn't justify anything more 
complex than that.

-- 
Regards,

Laurent Pinchart
