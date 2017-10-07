From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] lib/test: Delete five error messages for a failed memory
 allocation
Date: Sat, 7 Oct 2017 19:48:37 +0200
Message-ID: <410a4c5a-4ee0-6fcc-969c-103d8e496b78@users.sourceforge.net>
References: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Daniel Mentz <danielmentz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars Ellenberg <lars.ellenberg@linbit.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Philipp Reisner <philipp.reisner@linbit.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Oct 2017 17:34:23 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 lib/test_kasan.c     | 5 ++---
 lib/test_kmod.c      | 8 ++------
 lib/test_list_sort.c | 9 +++------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index a25c9763fce1..ef1a3ac1397e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -353,10 +353,9 @@ static noinline void __init memcg_accounted_kmem_cache(void)
 	 */
 	for (i = 0; i < 5; i++) {
 		p = kmem_cache_alloc(cache, GFP_KERNEL);
-		if (!p) {
-			pr_err("Allocation failed\n");
+		if (!p)
 			goto free_cache;
-		}
+
 		kmem_cache_free(cache, p);
 		msleep(100);
 	}
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index fba78d25e825..337f408b4de6 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -783,10 +783,8 @@ static int kmod_config_sync_info(struct kmod_test_device *test_dev)
 	free_test_dev_info(test_dev);
 	test_dev->info = vzalloc(config->num_threads *
 				 sizeof(struct kmod_test_device_info));
-	if (!test_dev->info) {
-		dev_err(test_dev->dev, "Cannot alloc test_dev info\n");
+	if (!test_dev->info)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -1089,10 +1087,8 @@ static struct kmod_test_device *alloc_test_dev_kmod(int idx)
 	struct miscdevice *misc_dev;
 
 	test_dev = vzalloc(sizeof(struct kmod_test_device));
-	if (!test_dev) {
-		pr_err("Cannot alloc test_dev\n");
+	if (!test_dev)
 		goto err_out;
-	}
 
 	mutex_init(&test_dev->config_mutex);
 	mutex_init(&test_dev->trigger_mutex);
diff --git a/lib/test_list_sort.c b/lib/test_list_sort.c
index 28e817387b04..5474f3f3e41d 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -76,17 +76,14 @@ static int __init list_sort_test(void)
 	pr_debug("start testing list_sort()\n");
 
 	elts = kcalloc(TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
-	if (!elts) {
-		pr_err("error: cannot allocate memory\n");
+	if (!elts)
 		return err;
-	}
 
 	for (i = 0; i < TEST_LIST_LEN; i++) {
 		el = kmalloc(sizeof(*el), GFP_KERNEL);
-		if (!el) {
-			pr_err("error: cannot allocate memory\n");
+		if (!el)
 			goto exit;
-		}
+
 		 /* force some equivalencies */
 		el->value = prandom_u32() % (TEST_LIST_LEN / 3);
 		el->serial = i;
-- 
2.14.2

