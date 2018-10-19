From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 4/6] iommu/sva: Support AUXD feature
Date: Fri, 19 Oct 2018 19:11:56 +0100
Message-ID: <20181019181158.2395-5-jean-philippe.brucker@arm.com>
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

Add IOMMU_SVA_FEAT_AUXD and small helpers to SVA, to setup PASID with
the sva_init_device() IOMMU op and allocate PASIDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu-sva.c | 33 ++++++++++++++++++++++++++++++++-
 include/linux/iommu.h     | 12 ++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 28eaa617b4f0..7c5176e2e113 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -117,6 +117,7 @@ struct iommu_bond {
 };
 
 static DECLARE_IOASID_SET(ioasid_shared);
+static DECLARE_IOASID_SET(ioasid_private);
 
 /*
  * For the moment this is an all-purpose lock. It serializes
@@ -663,6 +664,36 @@ struct mm_struct *iommu_sva_find(int pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
+int iommu_sva_alloc_pasid(struct device *dev)
+{
+	int ret;
+	struct iommu_sva_param *param;
+
+	if (!dev->iommu_param)
+		return -EINVAL;
+
+	mutex_lock(&dev->iommu_param->sva_lock);
+	param = dev->iommu_param->sva_param;
+	if (!param) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = ioasid_alloc(&ioasid_private, param->min_pasid,
+			   param->max_pasid + 1, NULL);
+out_unlock:
+	mutex_unlock(&dev->iommu_param->sva_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+void iommu_sva_free_pasid(int pasid)
+{
+	ioasid_free(pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
 /**
  * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
@@ -711,7 +742,7 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	if (!dev->iommu_param || !ops || !ops->sva_init_device)
 		return -ENODEV;
 
-	if (features & ~IOMMU_SVA_FEAT_IOPF)
+	if (features & ~(IOMMU_SVA_FEAT_IOPF | IOMMU_SVA_FEAT_AUXD))
 		return -EINVAL;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 67bbc5320c9d..bfa70b1f8897 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -66,6 +66,7 @@ typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 #define IOMMU_PASID_INVALID		(-1)
 
 #define IOMMU_SVA_FEAT_IOPF		(1 << 0)
+#define IOMMU_SVA_FEAT_AUXD		(1 << 1)
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -1035,6 +1036,8 @@ extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void iommu_sva_unbind_device_all(struct device *dev);
 extern struct mm_struct *iommu_sva_find(int pasid);
+extern int iommu_sva_alloc_pasid(struct device *dev);
+extern void iommu_sva_free_pasid(int pasid);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_init_device(struct device *dev,
@@ -1070,6 +1073,15 @@ static inline struct mm_struct *iommu_sva_find(int pasid)
 {
 	return NULL;
 }
+
+static inline int iommu_sva_alloc_pasid(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_sva_free_pasid(int pasid)
+{
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_PAGE_FAULT
-- 
2.19.1
