From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 5/8] iommu/io-pgtable-arm: Support lockless operation
Date: Tue, 27 Jun 2017 10:41:55 +0530
Message-ID: <20170627051155.GA9525@virtx40>
References: <cover.1498145008.git.robin.murphy@arm.com>
	<af61929e3984a31588cab08ed84a237602b5263e.1498145008.git.robin.murphy@arm.com>
	<20170623055326.GA2949@virtx40> <20170623085607.GC3718@virtx40>
	<7a8da378-19e2-2f35-877a-cc6ce389301a@arm.com>
	<20170623113405.GA5221@virtx40>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170623113405.GA5221@virtx40>
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
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri Jun 23, 2017 at 05:04:05PM +0530, Linu Cherian wrote:
> On Fri Jun 23, 2017 at 11:35:25AM +0100, Robin Murphy wrote:
> > On 23/06/17 09:56, Linu Cherian wrote:
> > > On Fri Jun 23, 2017 at 11:23:26AM +0530, Linu Cherian wrote:
> > >>
> > >> Robin,
> > >> Was trying to understand the new changes. Had few questions on 
> > >> arm_lpae_install_table. 
> > >>
> > >> On Thu Jun 22, 2017 at 04:53:54PM +0100, Robin Murphy wrote:
> > >>> For parallel I/O with multiple concurrent threads servicing the same
> > >>> device (or devices, if several share a domain), serialising page table
> > >>> updates becomes a massive bottleneck. On reflection, though, we don't
> > >>> strictly need to do that - for valid IOMMU API usage, there are in fact
> > >>> only two races that we need to guard against: multiple map requests for
> > >>> different blocks within the same region, when the intermediate-level
> > >>> table for that region does not yet exist; and multiple unmaps of
> > >>> different parts of the same block entry. Both of those are fairly easily
> > >>> solved by using a cmpxchg to install the new table, such that if we then
> > >>> find that someone else's table got there first, we can simply free ours
> > >>> and continue.
> > >>>
> > >>> Make the requisite changes such that we can withstand being called
> > >>> without the caller maintaining a lock. In theory, this opens up a few
> > >>> corners in which wildly misbehaving callers making nonsensical
> > >>> overlapping requests might lead to crashes instead of just unpredictable
> > >>> results, but correct code really does not deserve to pay a significant
> > >>> performance cost for the sake of masking bugs in theoretical broken code.
> > >>>
> > >>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > >>> ---
> > >>>
> > >>> v2:
> > >>>  - Fix barriers in install_table
> > >>>  - Make a few more PTE accesses with {READ,WRITE}_ONCE() just in case
> > >>>  - Minor cosmetics
> > >>>
> > >>>  drivers/iommu/io-pgtable-arm.c | 72 +++++++++++++++++++++++++++++++++---------
> > >>>  1 file changed, 57 insertions(+), 15 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > >>> index 6334f51912ea..52700fa958c2 100644
> > >>> --- a/drivers/iommu/io-pgtable-arm.c
> > >>> +++ b/drivers/iommu/io-pgtable-arm.c
> > >>> @@ -20,6 +20,7 @@
> > >>>  
> > >>>  #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
> > >>>  
> > >>> +#include <linux/atomic.h>
> > >>>  #include <linux/iommu.h>
> > >>>  #include <linux/kernel.h>
> > >>>  #include <linux/sizes.h>
> > >>> @@ -99,6 +100,8 @@
> > >>>  #define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
> > >>>  #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
> > >>>  					 ARM_LPAE_PTE_ATTR_HI_MASK)
> > >>> +/* Software bit for solving coherency races */
> > >>> +#define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
> > >>>  
> > >>>  /* Stage-1 PTE */
> > >>>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
> > >>> @@ -249,15 +252,20 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
> > >>>  	free_pages_exact(pages, size);
> > >>>  }
> > >>>  
> > >>> +static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
> > >>> +				struct io_pgtable_cfg *cfg)
> > >>> +{
> > >>> +	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
> > >>> +				   sizeof(*ptep), DMA_TO_DEVICE);
> > >>> +}
> > >>> +
> > >>>  static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
> > >>>  			       struct io_pgtable_cfg *cfg)
> > >>>  {
> > >>>  	*ptep = pte;
> > >>>  
> > >>>  	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
> > >>> -		dma_sync_single_for_device(cfg->iommu_dev,
> > >>> -					   __arm_lpae_dma_addr(ptep),
> > >>> -					   sizeof(pte), DMA_TO_DEVICE);
> > >>> +		__arm_lpae_sync_pte(ptep, cfg);
> > >>>  }
> > >>>  
> > >>>  static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> > >>> @@ -314,16 +322,30 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
> > >>>  
> > >>>  static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
> > >>>  					     arm_lpae_iopte *ptep,
> > >>> +					     arm_lpae_iopte curr,
> > >>>  					     struct io_pgtable_cfg *cfg)
> > >>>  {
> > >>> -	arm_lpae_iopte new;
> > >>> +	arm_lpae_iopte old, new;
> > >>>  
> > >>>  	new = __pa(table) | ARM_LPAE_PTE_TYPE_TABLE;
> > >>>  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
> > >>>  		new |= ARM_LPAE_PTE_NSTABLE;
> > >>>  
> > >>> -	__arm_lpae_set_pte(ptep, new, cfg);
> > >>> -	return new;
> > >>> +	/* Ensure the table itself is visible before its PTE can be */
> > >>> +	wmb();
> > >>
> > >> Could you please give more hints on why this is required.
> > 
> > In theory it's possible for the write to ptep to become visible before
> > the previous writes filling out the PTEs in table - if the IOMMU
> > happened to speculatively walk ptep while parts of table were still sat
> > in a write buffer somewhere, it could see the old contents of that page
> > and potentially allocate bogus TLB entries if the stale data happened to
> > look like valid PTEs. In the non-coherent case the DMA cache maintenance
> > is sufficient, but otherwise we need a barrier to order writing the
> > next-level PTEs strictly before writing the table PTE pointing to them,
> > such that the IOMMU cannot at any point see a partially-initialised table.
> 
> Got it. Thanks a lot for explainig that.
> 
> > 
> > >>> +
> > >>> +	old = cmpxchg64_relaxed(ptep, curr, new);
> > >>> +
> > >>> +	if ((cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) ||
> > >>> +	    (old & ARM_LPAE_PTE_SW_SYNC))
> > >>> +		return old;
> > >>> +
> > >>> +	/* Even if it's not ours, there's no point waiting; just kick it */
> > >>> +	__arm_lpae_sync_pte(ptep, cfg);
> > >>> +	if (old == curr)
> > >>> +		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
> > >>
> > >> How is it ensured that the cache operations are completed before we flag them with
> > >> 	ARM_LPAE_PTE_SW_SYNC. The previous version had a wmb() after the sync operation.
> > 
> > The wmb() here was a silly oversight on my part - as Will reminded me,
> > dma_sync_*() already has its own barrier to ensure completion, which is
> > pretty obvious in retrospect because the entire streaming DMA would be
> > totally broken otherwise.
> > 
> > >>> +
> > >>> +	return old;
> > >>>  }
> > >>>
> > >>
> > > 
> > > 
> > > Observed a performance drop of close to 1G, 
> > > while testing on the 10G network interface with this patch series compared to v1.
> > 
> > Is that consistent over multiple runs? I wouldn't expect many workloads
> > to be thrashing table and hugepage mappings in the same IOVA region, so
> > after a point we should tend to reach a fairly steady state where we're
> > only changing leaf PTEs.
> > 
> > > Moving the wmb() as in v1 restores it back.
> > 
> > Note that on a coherent platform like ThunderX that's as good as just
> > deleting it, because you'll never execute the case below. However, on
> > reflection I think it can at least safely be downgraded to dma_wmb()
> > (i.e. DMB) rather than a full DSB - would you be able to test what
> > difference that makes?
> 
> The testing was done on Thunderx 1, which has a non coherent page table walk.
> Yes, downgrading to dma_wmb() helps. With this change, performance is back to v1.
> 
> 
> 

Should i send a patch for this ?

Thanks.



-- 
Linu cherian
