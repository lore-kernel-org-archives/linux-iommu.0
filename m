From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH v4 0/7] Intel IOMMU scalability improvements
Date: Wed, 20 Apr 2016 11:31:06 +0300
Message-ID: <cover.1461135861.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, shli-b10kYP2dOMg@public.gmane.org, gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset improves the scalability of the Intel IOMMU code by
resolving two spinlock bottlenecks and eliminating the linearity of
the IOVA allocator,, yielding up to ~5x performance improvement and
approaching iommu=off performance.

For example, here's the throughput obtained by 16 memcached instances
running on a 16-core Sandy Bridge system, accessed using memslap on
another machine that has iommu=off, using the default memslap config
(64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):

    stock iommu=off:
       990,803 memcached transactions/sec (=100%, median of 10 runs).
    stock iommu=on:
       221,416 memcached transactions/sec (=22%).
       [61.70%    0.63%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
    patched iommu=on:
       963,159 memcached transactions/sec (=97%).
       [1.29%     1.10%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]

The two resolved spinlocks:

 - Deferred IOTLB invalidations are batched in a global data structure
   and serialized under a spinlock (add_unmap() & flush_unmaps()); this
   patchset batches IOTLB invalidations in a per-CPU data structure.

 - IOVA management (alloc_iova() & __free_iova()) is serialized under
   the rbtree spinlock; this patchset adds per-CPU caches of allocated
   IOVAs so that the rbtree doesn't get accessed frequently. (Adding a
   cache above the existing IOVA allocator is less intrusive than dynamic
   identity mapping and helps keep IOMMU page table usage low; see
   Patch 7.)

The paper "Utilizing the IOMMU Scalably" (presented at the 2015 USENIX
Annual Technical Conference) contains many more details and
experiments highlighting the resolved lock contention:

  https://www.usenix.org/conference/atc15/technical-session/presentation/peleg

The resolved linearity of IOVA allocation:

 - The rbtree IOVA allocator (called by alloc_iova()) periodically traverses
   all previously allocated IOVAs in search for (the highest) unallocated
   IOVA; with the new IOVA cache, this code is usually bypassed as 
   allocations are satisfied from the cache in constant time.

The paper "Efficient intra-operating system protection against harmful
DMAs" (presented at the 2015 USENIX Conference on File and Storage
Technologies) contains details about the linearity of IOVA allocation:

  https://www.usenix.org/conference/fast15/technical-sessions/presentation/malka


v4:
 * Patch 7/7: Improve commit message and comment about iova_rcache_get().
 * Patch 5/7: Change placement of "has_iotlb_device" struct field.

v3:
 * Patch 7/7: Respect the caller-passed limit IOVA when satisfying an IOVA
   allocation from the cache.
 * Patch 7/7: Flush the IOVA cache if an rbtree IOVA allocation fails, and
   then retry the allocation.  This addresses the possibility that all
   desired IOVA ranges were in other CPUs' caches.
 * Patch 4/7: Clean up intel_unmap_sg() to use sg accessors. 

v2:

 * Extend IOVA API instead of modifying it, to not break the API's other 
   non-Intel callers.
 * Invalidate all per-cpu invalidations if one CPU hits its per-cpu limit,
   so that we don't defer invalidations more than before.
 * Smaller cap on per-CPU cache size, to consume less of the IOVA space.
 * Free resources and perform IOTLB invalidations when a CPU is hot-unplugged.


Omer Peleg (7):
  iommu/vt-d: refactoring of deferred flush entries
  iommu/vt-d: per-cpu deferred invalidation queues
  iommu/vt-d: correct flush_unmaps pfn usage
  iommu/vt-d: only unmap mapped entries
  iommu/vt-d: avoid dev iotlb logic in intel-iommu for domains with no dev
    iotlbs
  iommu/vt-d: change intel-iommu to use IOVA frame numbers
  iommu/vt-d: introduce per-cpu caching to iova allocation

 drivers/iommu/intel-iommu.c | 318 +++++++++++++++++++++++----------
 drivers/iommu/iova.c        | 417 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/iova.h        |  23 ++-
 3 files changed, 638 insertions(+), 120 deletions(-)

-- 
1.9.1
