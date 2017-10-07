From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] lib: Improve a size determination in seven functions
Date: Sat, 7 Oct 2017 19:50:15 +0200
Message-ID: <3a32f0e7-75a2-857e-c63c-10d4b5942622@users.sourceforge.net>
References: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Daniel Mentz <danielmentz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars Ellenberg <lars.ellenberg@linbit.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Philipp Reisner <philipp.reisner@linbit.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Oct 2017 19:19:45 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 lib/dma-debug.c                 | 2 +-
 lib/flex_array.c                | 4 ++--
 lib/genalloc.c                  | 2 +-
 lib/lru_cache.c                 | 2 +-
 lib/reed_solomon/reed_solomon.c | 2 +-
 lib/test_kmod.c                 | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index ea4cc3dde4f1..8b5c8fc76f8a 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -993,7 +993,7 @@ void dma_debug_add_bus(struct bus_type *bus)
 	if (dma_debug_disabled())
 		return;
 
-	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
+	nb = kzalloc(sizeof(*nb), GFP_KERNEL);
 	if (nb == NULL) {
 		pr_err("dma_debug_add_bus: out of memory\n");
 		return;
diff --git a/lib/flex_array.c b/lib/flex_array.c
index 2eed22fa507c..ebe0f366b6cb 100644
--- a/lib/flex_array.c
+++ b/lib/flex_array.c
@@ -102,7 +102,7 @@ struct flex_array *flex_array_alloc(int element_size, unsigned int total,
 	/* max_size will end up 0 if element_size > PAGE_SIZE */
 	if (total > max_size)
 		return NULL;
-	ret = kzalloc(sizeof(struct flex_array), flags);
+	ret = kzalloc(sizeof(*ret), flags);
 	if (!ret)
 		return NULL;
 	ret->element_size = element_size;
@@ -167,7 +167,7 @@ __fa_get_part(struct flex_array *fa, int part_nr, gfp_t flags)
 {
 	struct flex_array_part *part = fa->parts[part_nr];
 	if (!part) {
-		part = kmalloc(sizeof(struct flex_array_part), flags);
+		part = kmalloc(sizeof(*part), flags);
 		if (!part)
 			return NULL;
 		if (!(flags & __GFP_ZERO))
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 144fe6b1a03e..696cf1236b6c 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -153,7 +153,7 @@ struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 {
 	struct gen_pool *pool;
 
-	pool = kmalloc_node(sizeof(struct gen_pool), GFP_KERNEL, nid);
+	pool = kmalloc_node(sizeof(*pool), GFP_KERNEL, nid);
 	if (pool != NULL) {
 		spin_lock_init(&pool->lock);
 		INIT_LIST_HEAD(&pool->chunks);
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 28ba40b99337..4882ed22a8ce 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -116,7 +116,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;
 
-	slot = kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
+	slot = kcalloc(e_count, sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		goto out_fail;
 	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index 06d04cfa9339..2d0ec9f84322 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -70,7 +70,7 @@ static struct rs_control *rs_init(int symsize, int gfpoly, int (*gffunc)(int),
 	int i, j, sr, root, iprim;
 
 	/* Allocate the control structure */
-	rs = kmalloc(sizeof (struct rs_control), GFP_KERNEL);
+	rs = kmalloc(sizeof(*rs), GFP_KERNEL);
 	if (rs == NULL)
 		return NULL;
 
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 337f408b4de6..57f3337f2482 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1086,7 +1086,7 @@ static struct kmod_test_device *alloc_test_dev_kmod(int idx)
 	struct kmod_test_device *test_dev;
 	struct miscdevice *misc_dev;
 
-	test_dev = vzalloc(sizeof(struct kmod_test_device));
+	test_dev = vzalloc(sizeof(*test_dev));
 	if (!test_dev)
 		goto err_out;
 
-- 
2.14.2
