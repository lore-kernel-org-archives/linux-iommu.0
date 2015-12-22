From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/23] AMD IOMMU DMA-API Scalability Improvements
Date: Tue, 22 Dec 2015 23:21:05 +0100
Message-ID: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to improve scalability in the dma_ops
path of the AMD IOMMU driver. The current code doesn't scale
well because of the per-domain spin-lock which serializes
the DMA-API operations.

This lock protects the address allocator, the page-table
updates and the iommu tlb flushing.

As a first step these patches introduce a lock that only
protects the address allocator on a per-aperture basis. A
domain can have multiple apertures, each covering 128 MiB of
address space.

The page-table code is updated to work lock-less like the
Intel VT-d page-table code. Also the iommu tlb flushing is
not defered any longer to the end of the DMA-API operation,
but happens right before/after the address allocator is
updated (which is the point where we either own the
addresses or make them available to someone else). This also
removes the need to lock the iommu tlb flushing.

As a next step the patches change the address allocator path
to allocate from a non-contended aperture. This is done by
first using spin_trylock() on the available apertures. Only
of this fails it retrys with spinning.

To make this work, more than one aperture per device is
needed by default. Based on the dma_mask of the device the
code now allocates between 4 and 8 apertures in the
set_dma_mask call-back.

In my tests on a single-node AMD IOMMU machine this resolves
the lock contention issues. It is expected that on bigger
machines there will be lock-contention again, but still to a
smaller degree than without these patches.

I also did some measurements to show the difference. I ran a
test that generates network packets over a 10 GBit link in a
loop and measured the average packets that could be queued
per second. Here are the results:

	stock   v4.4-rc6 iommu disabled : 1465946 PPS (100%)
	stock   v4.4-rc6 iommu enabled  : 815089  PPS (55.6%)
	patched v4.4-rc6 iommu enabled  : 1426606 PPS (97.3%)

So with the current code there is a 44.4% performance drop,
with these patches the performance only drops by 2.7%.

This is only a start, the goal to resolve the lock
contention problem is to get rid of the address allocator
completly and implement dynamic identity mapping for 64bit
devices. But there are still some problems to solve with
that, so until this is ready these patches at least reduce
the problem.

Feedback welcome!

Thanks,

	Joerg


Joerg Roedel (23):
  iommu/amd: Warn only once on unexpected pte value
  iommu/amd: Move 'struct dma_ops_domain' definition to amd_iommu.c
  iommu/amd: Introduce bitmap_lock in struct aperture_range
  iommu/amd: Flush IOMMU TLB on __map_single error path
  iommu/amd: Flush the IOMMU TLB before the addresses are freed
  iommu/amd: Pass correct shift to iommu_area_alloc()
  iommu/amd: Add dma_ops_aperture_alloc() function
  iommu/amd: Move aperture_range.offset to another cache-line
  iommu/amd: Retry address allocation within one aperture
  iommu/amd: Flush iommu tlb in dma_ops_aperture_alloc()
  iommu/amd: Remove 'start' parameter from dma_ops_area_alloc
  iommu/amd: Rename dma_ops_domain->next_address to next_index
  iommu/amd: Flush iommu tlb in dma_ops_free_addresses
  iommu/amd: Iterate over all aperture ranges in dma_ops_area_alloc
  iommu/amd: Remove need_flush from struct dma_ops_domain
  iommu/amd: Optimize dma_ops_free_addresses
  iommu/amd: Allocate new aperture ranges in dma_ops_alloc_addresses
  iommu/amd: Build io page-tables with cmpxchg64
  iommu/amd: Initialize new aperture range before making it visible
  iommu/amd: Relax locking in dma_ops path
  iommu/amd: Make dma_ops_domain->next_index percpu
  iommu/amd: Use trylock to aquire bitmap_lock
  iommu/amd: Preallocate dma_ops apertures based on dma_mask

 drivers/iommu/amd_iommu.c       | 388 +++++++++++++++++++++++++---------------
 drivers/iommu/amd_iommu_types.h |  40 -----
 2 files changed, 244 insertions(+), 184 deletions(-)

-- 
1.9.1
