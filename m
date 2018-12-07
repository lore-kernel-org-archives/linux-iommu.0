From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v5 1/3] mm: Add support for kmem caches in DMA32 zone
Date: Fri,  7 Dec 2018 14:16:18 +0800
Message-ID: <20181207061620.107881-2-drinkcat@chromium.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181207061620.107881-1-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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

IOMMUs using ARMv7 short-descriptor format require page tables
to be allocated within the first 4GB of RAM, even on 64-bit systems.
On arm64, this is done by passing GFP_DMA32 flag to memory allocation
functions.

For IOMMU L2 tables that only take 1KB, it would be a waste to allocate
a full page using get_free_pages, so we considered 3 approaches:
 1. This patch, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2
    page tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable
    to reuse freed fragments until the whole page is freed.

This change makes it possible to create a custom cache in DMA32 zone
using kmem_cache_create, then allocate memory using kmem_cache_alloc.

We do not create a DMA32 kmalloc cache array, as there are currently
no users of kmalloc(..., GFP_DMA32). These calls will continue to
trigger a warning, as we keep GFP_DMA32 in GFP_SLAB_BUG_MASK.

This implies that calls to kmem_cache_*alloc on a SLAB_CACHE_DMA32
kmem_cache must _not_ use GFP_DMA32 (it is anyway redundant and
unnecessary).

Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes since v2:
 - Clarified commit message
 - Add entry in sysfs-kernel-slab to document the new sysfs file

(v3 used the page_frag approach)

Changes since v4:
 - Added details to commit message
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH 3/3, so that maintainer can decide whether
   to pick the change independently.

 include/linux/slab.h | 2 ++
 mm/slab.c            | 2 ++
 mm/slab.h            | 3 ++-
 mm/slab_common.c     | 2 +-
 mm/slub.c            | 5 +++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae4057c..9449b19c5f107a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -32,6 +32,8 @@
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
 #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
+/* Use GFP_DMA32 memory */
+#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
 /* DEBUG: Store the last owner for bug hunting */
 #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
 /* Panic if kmem_cache_create() fails */
diff --git a/mm/slab.c b/mm/slab.c
index 73fe23e649c91a..124f8c556d27fb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2109,6 +2109,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	cachep->allocflags = __GFP_COMP;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->allocflags |= GFP_DMA;
+	if (flags & SLAB_CACHE_DMA32)
+		cachep->allocflags |= GFP_DMA32;
 	if (flags & SLAB_RECLAIM_ACCOUNT)
 		cachep->allocflags |= __GFP_RECLAIMABLE;
 	cachep->size = size;
diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9df..fcf717e12f0a86 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -127,7 +127,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
-#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | SLAB_PANIC | \
+#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
 
 #if defined(CONFIG_DEBUG_SLAB)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 70b0cc85db67f8..18b7b809c8d064 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -53,7 +53,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		SLAB_FAILSLAB | SLAB_KASAN)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
-			 SLAB_ACCOUNT)
+			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
 
 /*
  * Merge control. If this is set then no merging of slab caches will occur.
diff --git a/mm/slub.c b/mm/slub.c
index c229a9b7dd5448..4caadb926838ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3583,6 +3583,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5671,6 +5674,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.20.0.rc2.403.gdbc3b29805-goog
