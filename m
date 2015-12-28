From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH 0/7] Intel IOMMU scalability improvements
Date: Mon, 28 Dec 2015 18:14:21 +0200
Message-ID: <20151228161421.GA27829@cs.technion.ac.il>
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
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset improves the scalability of the Intel IOMMU code by
resolving two spinlock bottlenecks, yielding up to ~10x performance
improvement and approaching iommu=off performance.

For example, here's the throughput obtained by 16 memcached instances
running on a 16-core Sandy Bridge system, accessed using memslap on
another machine that has iommu=off, using the default memslap config
(64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):

    stock iommu=off:
       1,088,996 memcached transactions/sec (=100%, median of 10 runs).
    stock iommu=on:
       123,760 memcached transactions/sec (=11%).
       [perf: 43.56%    0.86%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
    patched iommu=on:
       1,067,586 memcached transactions/sec (=98%).
       [perf: 0.75%     0.75%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]

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
Annual Technical Conference) contains many more details and experiments:

  https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf


Omer Peleg (7):
  iommu: refactoring of deferred flush entries
  iommu: per-cpu deferred invalidation queues
  iommu: correct flush_unmaps pfn usage
  iommu: only unmap mapped entries
  iommu: avoid dev iotlb logic in intel-iommu for domains with no dev
    iotlbs
  iommu: change intel-iommu to use IOVA frame numbers
  iommu: introduce per-cpu caching to iova allocation

 drivers/iommu/intel-iommu.c | 264 +++++++++++++++++++++-------------
 drivers/iommu/iova.c        | 334 +++++++++++++++++++++++++++++++++++++-------
 include/linux/iova.h        |  23 ++-
 3 files changed, 470 insertions(+), 151 deletions(-)

-- 
1.9.1
