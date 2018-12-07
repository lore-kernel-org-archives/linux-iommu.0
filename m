From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v5 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
	tables
Date: Fri,  7 Dec 2018 14:16:17 +0800
Message-ID: <20181207061620.107881-1-drinkcat@chromium.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Christoph Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is a follow-up to the discussion in [1], [2].

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For L1 tables that are bigger than a page, we can just use __get_free_pages
with GFP_DMA32 (on arm64 systems only, arm would still use GFP_DMA).

For L2 tables that only take 1KB, it would be a waste to allocate a full
page, so we considered 3 approaches:
 1. This series, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2 page
    tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable to reuse
    freed fragments until the whole page is freed. [3]

This series is the most memory-efficient approach.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031696.html
[3] https://patchwork.codeaurora.org/patch/671639/

Changes since v1:
 - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
 - iommu/io-pgtable-arm-v7s (patch 3):
   - Changed approach to use SLAB_CACHE_DMA32 added by the previous
     commit.
   - Use DMA or DMA32 depending on the architecture (DMA for arm,
     DMA32 for arm64).

Changes since v2:
 - Reworded and expanded commit messages
 - Added cache_dma32 documentation in PATCH 2/3.

v3 used the page_frag approach, see [3].

Changes since v4:
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH v4 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH v5 3/3, so that maintainer can decide whether
   to pick the change independently.

Nicolas Boichat (3):
  mm: Add support for kmem caches in DMA32 zone
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
  mm: Add /sys/kernel/slab/cache/cache_dma32

 Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 drivers/iommu/io-pgtable-arm-v7s.c          | 19 +++++++++++++++----
 include/linux/slab.h                        |  2 ++
 mm/slab.c                                   |  2 ++
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 16 ++++++++++++++++
 tools/vm/slabinfo.c                         |  7 ++++++-
 8 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog
