From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 1/4] iommu: iova: Move iova cache management to the iova library
Date: Fri, 21 Nov 2014 13:11:40 +0200
Message-ID: <1416568303-677-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1416568303-677-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1416568303-677-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

alloc_iova_mem() and free_iova_mem() are moved to iova.c and made static as
well. printk(KERN_ERR, ...) is also replaced by pr_err().

This is done in order to separate intel-iommu from the iova library. As a
result, the user of the IOVA library must use iova_cache_get() before using
alloc_iova_mem() or free_iova_mem(), and correspondingly iova_cache_put()
after using the IOVA library.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 34 +++-----------------------------
 drivers/iommu/iova.c        | 48 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iova.h        |  4 ++--
 3 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a27d6cb..e7673df 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -490,7 +490,6 @@ __setup("intel_iommu=", intel_iommu_setup);
 
 static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
-static struct kmem_cache *iommu_iova_cache;
 
 static inline void *alloc_pgtable_page(int node)
 {
@@ -528,16 +527,6 @@ static inline void free_devinfo_mem(void *vaddr)
 	kmem_cache_free(iommu_devinfo_cache, vaddr);
 }
 
-struct iova *alloc_iova_mem(void)
-{
-	return kmem_cache_alloc(iommu_iova_cache, GFP_ATOMIC);
-}
-
-void free_iova_mem(struct iova *iova)
-{
-	kmem_cache_free(iommu_iova_cache, iova);
-}
-
 static inline int domain_type_is_vm(struct dmar_domain *domain)
 {
 	return domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE;
@@ -3429,27 +3418,10 @@ static inline int iommu_devinfo_cache_init(void)
 	return ret;
 }
 
-static inline int iommu_iova_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_iova_cache = kmem_cache_create("iommu_iova",
-					 sizeof(struct iova),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-					 NULL);
-	if (!iommu_iova_cache) {
-		printk(KERN_ERR "Couldn't create iova cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
 static int __init iommu_init_mempool(void)
 {
 	int ret;
-	ret = iommu_iova_cache_init();
+	ret = iova_cache_get();
 	if (ret)
 		return ret;
 
@@ -3463,7 +3435,7 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	kmem_cache_destroy(iommu_iova_cache);
+	iova_cache_put();
 
 	return -ENOMEM;
 }
@@ -3472,7 +3444,7 @@ static void __init iommu_exit_mempool(void)
 {
 	kmem_cache_destroy(iommu_devinfo_cache);
 	kmem_cache_destroy(iommu_domain_cache);
-	kmem_cache_destroy(iommu_iova_cache);
+	iova_cache_put();
 
 }
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f6b17e6..6bc7022 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/slab.h>
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long pfn_32bit)
@@ -196,6 +197,53 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova)
 	rb_insert_color(&iova->node, root);
 }
 
+static struct kmem_cache *iova_cache;
+static unsigned int iova_cache_users;
+static DEFINE_MUTEX(iova_cache_mutex);
+
+static struct iova *alloc_iova_mem(void)
+{
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+}
+
+static void free_iova_mem(struct iova *iova)
+{
+	kmem_cache_free(iova_cache, iova);
+}
+
+int iova_cache_get(void)
+{
+	mutex_lock(&iova_cache_mutex);
+	if (!iova_cache_users) {
+		iova_cache = kmem_cache_create(
+			"iommu_iova", sizeof(struct iova), 0,
+			SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_cache) {
+			mutex_unlock(&iova_cache_mutex);
+			pr_err("Couldn't create iova cache\n");
+			return -ENOMEM;
+		}
+	}
+
+	iova_cache_users++;
+	mutex_unlock(&iova_cache_mutex);
+
+	return 0;
+}
+
+void iova_cache_put(void)
+{
+	mutex_lock(&iova_cache_mutex);
+	if (WARN_ON(!iova_cache_users)) {
+		mutex_unlock(&iova_cache_mutex);
+		return;
+	}
+	iova_cache_users--;
+	if (!iova_cache_users)
+		kmem_cache_destroy(iova_cache);
+	mutex_unlock(&iova_cache_mutex);
+}
+
 /**
  * alloc_iova - allocates an iova
  * @iovad: - iova domain in question
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 19e81d5..8572031 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -39,8 +39,8 @@ static inline unsigned long iova_size(struct iova *iova)
 	return iova->pfn_hi - iova->pfn_lo + 1;
 }
 
-struct iova *alloc_iova_mem(void);
-void free_iova_mem(struct iova *iova);
+int iova_cache_get(void);
+void iova_cache_put(void);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
-- 
2.1.0.231.g7484e3b
