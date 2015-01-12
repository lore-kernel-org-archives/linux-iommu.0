From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu: consolidate IOVA allocator code
Date: Mon, 12 Jan 2015 17:51:14 +0000
Message-ID: <37a6e61aba5c27f913a69f5ab0a882680a6ec4e5.1420822848.git.robin.murphy@arm.com>
References: <cover.1420822848.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1420822848.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In order to share the IOVA allocator with other architectures, break
the unnecssary dependency on the Intel IOMMU driver and move the
remaining IOVA internals to iova.c

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 33 ++-------------------------------
 drivers/iommu/iova.c        | 35 +++++++++++++++++++++++++++++++++++
 include/linux/iova.h        |  3 +++
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1232336..5699653 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -485,7 +485,6 @@ __setup("intel_iommu=", intel_iommu_setup);
 
 static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
-static struct kmem_cache *iommu_iova_cache;
 
 static inline void *alloc_pgtable_page(int node)
 {
@@ -523,16 +522,6 @@ static inline void free_devinfo_mem(void *vaddr)
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
@@ -3427,23 +3416,6 @@ static inline int iommu_devinfo_cache_init(void)
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
@@ -3461,7 +3433,7 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	kmem_cache_destroy(iommu_iova_cache);
+	iommu_iova_cache_destroy();
 
 	return -ENOMEM;
 }
@@ -3470,8 +3442,7 @@ static void __init iommu_exit_mempool(void)
 {
 	kmem_cache_destroy(iommu_devinfo_cache);
 	kmem_cache_destroy(iommu_domain_cache);
-	kmem_cache_destroy(iommu_iova_cache);
-
+	iommu_iova_cache_destroy();
 }
 
 static void quirk_ioat_snb_local_iommu(struct pci_dev *pdev)
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f6b17e6..520b8c8 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -18,6 +18,41 @@
  */
 
 #include <linux/iova.h>
+#include <linux/slab.h>
+
+static struct kmem_cache *iommu_iova_cache;
+
+int iommu_iova_cache_init(void)
+{
+	int ret = 0;
+
+	iommu_iova_cache = kmem_cache_create("iommu_iova",
+					 sizeof(struct iova),
+					 0,
+					 SLAB_HWCACHE_ALIGN,
+					 NULL);
+	if (!iommu_iova_cache) {
+		pr_err("Couldn't create iova cache\n");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+void iommu_iova_cache_destroy(void)
+{
+	kmem_cache_destroy(iommu_iova_cache);
+}
+
+struct iova *alloc_iova_mem(void)
+{
+	return kmem_cache_alloc(iommu_iova_cache, GFP_ATOMIC);
+}
+
+void free_iova_mem(struct iova *iova)
+{
+	kmem_cache_free(iommu_iova_cache, iova);
+}
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long pfn_32bit)
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 19e81d5..ad0507c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -39,6 +39,9 @@ static inline unsigned long iova_size(struct iova *iova)
 	return iova->pfn_hi - iova->pfn_lo + 1;
 }
 
+int iommu_iova_cache_init(void);
+void iommu_iova_cache_destroy(void);
+
 struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
-- 
1.9.1
