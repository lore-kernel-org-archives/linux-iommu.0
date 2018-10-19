From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 3/6] iommu/sva: Use external PASID allocator
Date: Fri, 19 Oct 2018 19:11:55 +0100
Message-ID: <20181019181158.2395-4-jean-philippe.brucker@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that the IOASID allocator is in place, use it to allocate shared
PASIDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/iommu-sva.c | 80 ++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e89f5a97d3c4..83a62634bbc4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -116,6 +116,7 @@ config IOMMU_SVA
 	bool
 	select IOMMU_API
 	select MMU_NOTIFIER
+	select IOASID
 
 config IOMMU_PAGE_FAULT
 	bool
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index ea34e7383ab4..28eaa617b4f0 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/idr.h>
+#include <linux/ioasid.h>
 #include <linux/iommu.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched/mm.h>
@@ -115,12 +116,7 @@ struct iommu_bond {
 	void			*drvdata;
 };
 
-/*
- * Because we're using an IDR, PASIDs are limited to 31 bits (the sign bit is
- * used for returning errors). In practice implementations will use at most 20
- * bits, which is the PCI limit.
- */
-static DEFINE_IDR(iommu_pasid_idr);
+static DECLARE_IOASID_SET(ioasid_shared);
 
 /*
  * For the moment this is an all-purpose lock. It serializes
@@ -163,18 +159,13 @@ static struct io_mm *io_mm_alloc(struct device *dev, struct mm_struct *mm,
 	INIT_LIST_HEAD(&io_mm->devices);
 	/* Leave kref as zero until the io_mm is fully initialized */
 
-	idr_preload(GFP_KERNEL);
-	spin_lock(&iommu_sva_lock);
-	pasid = idr_alloc(&iommu_pasid_idr, io_mm, param->min_pasid,
-			  param->max_pasid + 1, GFP_ATOMIC);
-	io_mm->pasid = pasid;
-	spin_unlock(&iommu_sva_lock);
-	idr_preload_end();
-
+	pasid = ioasid_alloc(&ioasid_shared, param->min_pasid,
+			     param->max_pasid + 1, io_mm);
 	if (pasid < 0) {
 		ret = pasid;
 		goto err_free_mm;
 	}
+	io_mm->pasid = pasid;
 
 	ret = mmu_notifier_register(&io_mm->notifier, mm);
 	if (ret)
@@ -201,7 +192,7 @@ static struct io_mm *io_mm_alloc(struct device *dev, struct mm_struct *mm,
 	 * 0 so no user could get a reference to it. Free it manually.
 	 */
 	spin_lock(&iommu_sva_lock);
-	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	ioasid_free(pasid);
 	spin_unlock(&iommu_sva_lock);
 
 err_free_mm:
@@ -231,7 +222,7 @@ static void io_mm_release(struct kref *kref)
 	io_mm = container_of(kref, struct io_mm, kref);
 	WARN_ON(!list_empty(&io_mm->devices));
 
-	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	ioasid_free(io_mm->pasid);
 
 	/*
 	 * If we're being released from mm exit, the notifier callback ->release
@@ -491,15 +482,44 @@ static struct mmu_notifier_ops iommu_mmu_notifier = {
 	.invalidate_range	= iommu_notifier_invalidate_range,
 };
 
+struct io_mm_bond_info {
+	struct device *dev;
+	struct mm_struct *mm;
+	struct io_mm *io_mm;
+};
+
+static int io_mm_compare_bond(ioasid_t pasid, void *priv, void *data)
+{
+	struct iommu_bond *bond;
+	struct io_mm *io_mm = priv;
+	struct io_mm_bond_info *info = data;
+
+	if (io_mm->mm != info->mm || !io_mm_get_locked(io_mm))
+		/* Keep looking */
+		return 0;
+
+	/* Is it already bound to this device? */
+	list_for_each_entry(bond, &io_mm->devices, mm_head) {
+		if (bond->dev == info->dev) {
+			io_mm_put_locked(io_mm);
+			return -EEXIST;
+		}
+	}
+	info->io_mm = io_mm;
+	return 1;
+}
+
 int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 			    unsigned long flags, void *drvdata)
 {
-	int i;
 	int ret = 0;
-	struct iommu_bond *bond;
-	struct io_mm *io_mm = NULL;
+	struct io_mm *io_mm;
 	struct iommu_sva_param *param;
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct io_mm_bond_info bond_info = {
+		.dev = dev,
+		.mm = mm,
+	};
 
 	if (!ops || !dev->iommu_param)
 		return -ENODEV;
@@ -511,25 +531,15 @@ int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid
 		goto out_unlock;
 	}
 
-	/* If an io_mm already exists, use it */
+	/* If an io_mm already exists, get a reference and use it */
 	spin_lock(&iommu_sva_lock);
-	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
-		if (io_mm->mm == mm && io_mm_get_locked(io_mm)) {
-			/* ... Unless it's already bound to this device */
-			list_for_each_entry(bond, &io_mm->devices, mm_head) {
-				if (bond->dev == dev) {
-					ret = -EEXIST;
-					io_mm_put_locked(io_mm);
-					break;
-				}
-			}
-			break;
-		}
-	}
+	ret = ioasid_for_each(&ioasid_shared, io_mm_compare_bond, &bond_info);
 	spin_unlock(&iommu_sva_lock);
-	if (ret)
+	if (ret < 0)
 		goto out_unlock;
 
+	io_mm = bond_info.io_mm;
+
 	/* Require identical features within an io_mm for now */
 	if (io_mm && (flags != io_mm->flags)) {
 		io_mm_put(io_mm);
@@ -640,7 +650,7 @@ struct mm_struct *iommu_sva_find(int pasid)
 	struct mm_struct *mm = NULL;
 
 	spin_lock(&iommu_sva_lock);
-	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	io_mm = ioasid_find(&ioasid_shared, pasid);
 	if (io_mm && io_mm_get_locked(io_mm)) {
 		if (mmget_not_zero(io_mm->mm))
 			mm = io_mm->mm;
-- 
2.19.1
