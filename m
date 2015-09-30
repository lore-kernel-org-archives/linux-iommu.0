From: Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH char-misc-next v2 01/22] iommu: iova: Move iova cache
	management to the iova library
Date: Tue, 29 Sep 2015 18:07:02 -0700
Message-ID: <40199221085e2c4a0ea5d4328b6457be99be0f09.1443573394.git.ashutosh.dixit@intel.com>
References: <cover.1443573394.git.ashutosh.dixit@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1443573394.git.ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nikhil Rao <nikhil.rao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This is necessary to separate intel-iommu from the iova library.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  6 ++--
 drivers/iommu/iova.c        | 83 ++++++++++++++++++++++++++-------------------
 include/linux/iova.h        |  4 +--
 3 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2d7349a..7b27bcd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3711,7 +3711,7 @@ static inline int iommu_devinfo_cache_init(void)
 static int __init iommu_init_mempool(void)
 {
 	int ret;
-	ret = iommu_iova_cache_init();
+	ret = iova_cache_get();
 	if (ret)
 		return ret;
 
@@ -3725,7 +3725,7 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	iommu_iova_cache_destroy();
+	iova_cache_put();
 
 	return -ENOMEM;
 }
@@ -3734,7 +3734,7 @@ static void __init iommu_exit_mempool(void)
 {
 	kmem_cache_destroy(iommu_devinfo_cache);
 	kmem_cache_destroy(iommu_domain_cache);
-	iommu_iova_cache_destroy();
+	iova_cache_put();
 }
 
 static void quirk_ioat_snb_local_iommu(struct pci_dev *pdev)
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7c3d92..400f4d1 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -20,40 +20,6 @@
 #include <linux/iova.h>
 #include <linux/slab.h>
 
-static struct kmem_cache *iommu_iova_cache;
-
-int iommu_iova_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_iova_cache = kmem_cache_create("iommu_iova",
-					 sizeof(struct iova),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-					 NULL);
-	if (!iommu_iova_cache) {
-		pr_err("Couldn't create iova cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-void iommu_iova_cache_destroy(void)
-{
-	kmem_cache_destroy(iommu_iova_cache);
-}
-
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
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn, unsigned long pfn_32bit)
@@ -242,6 +208,55 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova)
 	rb_insert_color(&iova->node, root);
 }
 
+static struct kmem_cache *iova_cache;
+static unsigned int iova_cache_users;
+static DEFINE_MUTEX(iova_cache_mutex);
+
+struct iova *alloc_iova_mem(void)
+{
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(alloc_iova_mem);
+
+void free_iova_mem(struct iova *iova)
+{
+	kmem_cache_free(iova_cache, iova);
+}
+EXPORT_SYMBOL(free_iova_mem);
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
+			printk(KERN_ERR "Couldn't create iova cache\n");
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
index 3920a19..92f7177 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -68,8 +68,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 	return iova >> iova_shift(iovad);
 }
 
-int iommu_iova_cache_init(void);
-void iommu_iova_cache_destroy(void);
+int iova_cache_get(void);
+void iova_cache_put(void);
 
 struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
-- 
2.0.0.rc3.2.g998f840
