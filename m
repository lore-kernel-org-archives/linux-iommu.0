From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Date: Wed,  5 Dec 2018 13:48:27 +0800
Message-ID: <20181205054828.183476-3-drinkcat@chromium.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181205054828.183476-1-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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

In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
data structures smaller than a page with GFP_DMA32 flag.

This change makes it possible to create a custom cache in DMA32 zone
using kmem_cache_create, then allocate memory using kmem_cache_alloc.

We do not create a DMA32 kmalloc cache array, as there are currently
no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
ensures that such calls still fail (as they do before this change).

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes since v2:
 - Clarified commit message
 - Add entry in sysfs-kernel-slab to document the new sysfs file

(v3 used the page_frag approach)

Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 include/linux/slab.h                        |  2 ++
 mm/internal.h                               |  8 ++++++--
 mm/slab.c                                   |  4 +++-
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 18 +++++++++++++++++-
 7 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 29601d93a1c2ea..d742c6cfdffbe9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -106,6 +106,15 @@ Description:
 		are from ZONE_DMA.
 		Available when CONFIG_ZONE_DMA is enabled.
 
+What:		/sys/kernel/slab/cache/cache_dma32
+Date:		December 2018
+KernelVersion:	4.21
+Contact:	Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
+Description:
+		The cache_dma32 file is read-only and specifies whether objects
+		are from ZONE_DMA32.
+		Available when CONFIG_ZONE_DMA32 is enabled.
+
 What:		/sys/kernel/slab/cache/cpu_slabs
 Date:		May 2007
 KernelVersion:	2.6.22
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
diff --git a/mm/internal.h b/mm/internal.h
index a2ee82a0cd44ae..fd244ad716eaf8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 #include <linux/tracepoint-defs.h>
 
 /*
@@ -34,9 +35,12 @@
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
 /* Check for flags that must not be used with a slab allocator */
-static inline gfp_t check_slab_flags(gfp_t flags)
+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
 {
-	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+	gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
+		bug_mask |= __GFP_DMA32;
 
 	if (unlikely(flags & bug_mask)) {
 		gfp_t invalid_mask = flags & bug_mask;
diff --git a/mm/slab.c b/mm/slab.c
index 65a774f05e7836..2fd3b9a996cbe6 100644
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
@@ -2643,7 +2645,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, cachep->flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
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
index 21a3f6866da472..6d47765a82d150 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1685,7 +1685,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, s->flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
@@ -3577,6 +3577,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5095,6 +5098,14 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 SLAB_ATTR_RO(cache_dma);
 #endif
 
+#ifdef CONFIG_ZONE_DMA32
+static ssize_t cache_dma32_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA32));
+}
+SLAB_ATTR_RO(cache_dma32);
+#endif
+
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", s->usersize);
@@ -5435,6 +5446,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	&cache_dma32_attr.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&remote_node_defrag_ratio_attr.attr,
 #endif
@@ -5665,6 +5679,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.20.0.rc1.387.gf8505762e3-goog
