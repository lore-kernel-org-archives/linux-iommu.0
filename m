From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/13] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Thu, 17 Aug 2017 18:17:05 +0100
Message-ID: <20170817171704.GD30719@arm.com>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<1502974596-23835-3-git-send-email-joro@8bytes.org>
	<20170817163234.GB30719@arm.com> <20170817165040.GK2853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817165040.GK2853-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, Aug 17, 2017 at 06:50:40PM +0200, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 05:32:35PM +0100, Will Deacon wrote:
> > I really like the idea of this, but I have a couple of questions and
> > comments below.
> 
> Great, this together with the common iova-flush it should make it
> possible to solve the performance problems of the dma-iommu code.
> 
> > > +int iommu_map_sync(struct iommu_domain *domain, unsigned long iova,
> > > +		   phys_addr_t paddr, size_t size, int prot)
> > > +{
> > > +	int ret = iommu_map(domain, iova, paddr, size, prot);
> > > +
> > > +	iommu_tlb_range_add(domain, iova, size);
> > > +	iommu_tlb_sync(domain);
> > 
> > Many IOMMUs don't need these callbacks on ->map operations, but they won't
> > be able to distinguish them easily with this API. Could you add a flags
> > parameter or something to the iommu_tlb_* functions, please?
> 
> Yeah, this is only needed for virtualized IOMMUs that have a non-present
> cache. My idea was to let the iommu-drivers tell the common code whether
> the iommu needs it and the code above just checks a flag and omits the
> calls to the flush-functions then.
> 
> Problem currently is how to get this information from
> 'struct iommu_device' to 'struct iommu_domain'. As a workaround I
> consider a per-domain flag in the iommu drivers which checks whether any
> unmap has happened and just do nothing on the flush-call-back if there
> were none.

Given that this can all happen concurrently, I really don't like the idea of
having to track things with a flag. We'd end up introducing atomics and/or
over-invalidating the TLBs.

> > I think we will struggle to implement this efficiently on ARM SMMUv3. The
> > way invalidation works there is that there is a single in-memory command
> > queue into which we can put TLB invalidation commands (they are inserted
> > under a lock). These are then processed asynchronously by the hardware, and
> > you can complete them by inserting a SYNC command and waiting for that to
> > be consumed by the SMMU. Sounds like a perfect fit, right?
> 
> Yes, its basically the same as way as it works on AMD-Vi and Intel VT-d.
> 
> > The problem is that we want to add those invalidation commands as early
> > as possible, so that they can be processed by the hardware concurrently
> > with us unmapping other pages.
> 
> I think that's a bad idea, because then you re-introduce the performance
> problems again because everyone will spin on the cmd-queue lock in the
> unmap path of the dma-api.

We don't actually tend to see issues adding the TLB invalidation commands
under the lock -- the vast majority of the overhead comes from the SYNC.
Besides, I don't see how adding the commands in the ->iotlb_range_add
callback is any better: it still happens on unmap and it still needs to
take the lock.

If we had something like an ->unmap_all_sync callback, we could incorporate
the TLB invalidation into that.

> > That means adding the invalidation commands in the ->unmap callback
> > and not bothering to implement ->iotlb_range_add callback at all.
> > Then, we will do the sync in ->iotlb_sync. This falls apart if
> > somebody decides to use iommu_flush_tlb_all(), where we would prefer
> > not to insert all of the invalidation commands in unmap and instead
> > insert a single invalidate-all command, followed up with a SYNC.
> 
> This problem can be solved with the deferred iova flushing code I posted
> to the ML. When a queue fills up, iommu_flush_tlb_all() is called and
> every entry that was unmapped before can be released. This works well on
> x86, are there reasons it wouldn't on ARM?

There are a few reasons I'm not rushing to move to the deferred flushing
code for ARM:

  1. The performance numbers we have suggest that we can achieve near-native
     performance without needing to do that.

  2. We can free page-table pages in unmap, but that's not safe if we defer
     flushing

  3. Flushing the whole TLB is undesirable and not something we currently
     need to do

  4. There are security implications of deferring the unmap and I'm aware
     of a security research group that use this to gain root privileges.

  5. *If* performance figures end up showing that deferring the flush is
     worthwhile, I would rather use an RCU-based approach for protecting
     the page tables, like we do on the CPU.

Will
