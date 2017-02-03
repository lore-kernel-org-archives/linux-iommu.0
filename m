From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/10] iommu: Introduce new 'struct iommu_device'
Date: Fri,  3 Feb 2017 16:17:41 +0100
Message-ID: <1486135068-23994-4-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486135068-23994-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This struct represents one hardware iommu in the iommu core
code. For now it only has the iommu-ops associated with it,
but that will be extended soon.

The register/unregister interface is also added, as well as
making use of it in the Intel and AMD IOMMU drivers.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  4 ++--
 drivers/iommu/amd_iommu_init.c  |  5 +++++
 drivers/iommu/amd_iommu_types.h |  3 +++
 drivers/iommu/dmar.c            |  9 +++++++++
 drivers/iommu/intel-iommu.c     |  4 ++--
 drivers/iommu/iommu.c           | 19 +++++++++++++++++++
 include/linux/intel-iommu.h     |  2 ++
 include/linux/iommu.h           | 14 ++++++++++++++
 8 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3ef0f42..7c11c36 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -112,7 +112,7 @@ struct flush_queue {
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-static const struct iommu_ops amd_iommu_ops;
+const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -3217,7 +3217,7 @@ static void amd_iommu_apply_dm_region(struct device *dev,
 	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
 }
 
-static const struct iommu_ops amd_iommu_ops = {
+const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_free  = amd_iommu_domain_free,
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6799cf9..02a577b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -94,6 +94,8 @@
  * out of it.
  */
 
+extern const struct iommu_ops amd_iommu_ops;
+
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
  * or more ivhd_entrys.
@@ -1639,6 +1641,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 					       amd_iommu_groups, "ivhd%d",
 					       iommu->index);
 
+	iommu->iommu.ops = &amd_iommu_ops;
+	iommu_device_register(&iommu->iommu);
+
 	return pci_enable_device(iommu->dev);
 }
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0d91785..0683505 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -538,6 +538,9 @@ struct amd_iommu {
 	/* IOMMU sysfs device */
 	struct device *iommu_dev;
 
+	/* Handle for IOMMU core code */
+	struct iommu_device iommu;
+
 	/*
 	 * We can't rely on the BIOS to restore all values on reinit, so we
 	 * need to stash them
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8ccbd70..c55411e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -74,6 +74,8 @@ struct dmar_res_callback {
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
 
+extern const struct iommu_ops intel_iommu_ops;
+
 static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
@@ -1086,6 +1088,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 			err = PTR_ERR(iommu->iommu_dev);
 			goto err_unmap;
 		}
+
+		iommu->iommu.ops = &intel_iommu_ops;
+
+		err = iommu_device_register(&iommu->iommu);
+		if (err)
+			goto err_unmap;
 	}
 
 	drhd->iommu = iommu;
@@ -1104,6 +1112,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 static void free_iommu(struct intel_iommu *iommu)
 {
 	iommu_device_destroy(iommu->iommu_dev);
+	iommu_device_unregister(&iommu->iommu);
 
 	if (iommu->irq) {
 		if (iommu->pr_irq) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8a18525..ca22872 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -547,7 +547,7 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
-static const struct iommu_ops intel_iommu_ops;
+const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -5332,7 +5332,7 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
-static const struct iommu_ops intel_iommu_ops = {
+const struct iommu_ops intel_iommu_ops = {
 	.capable	= intel_iommu_capable,
 	.domain_alloc	= intel_iommu_domain_alloc,
 	.domain_free	= intel_iommu_domain_free,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e4e8a93..21061da 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -77,6 +77,25 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 #define to_iommu_group(_kobj)		\
 	container_of(_kobj, struct iommu_group, kobj)
 
+static LIST_HEAD(iommu_device_list);
+static DEFINE_SPINLOCK(iommu_device_lock);
+
+int iommu_device_register(struct iommu_device *iommu)
+{
+	spin_lock(&iommu_device_lock);
+	list_add_tail(&iommu->list, &iommu_device_list);
+	spin_unlock(&iommu_device_lock);
+
+	return 0;
+}
+
+void iommu_device_unregister(struct iommu_device *iommu)
+{
+	spin_lock(&iommu_device_lock);
+	list_del(&iommu->list);
+	spin_unlock(&iommu_device_lock);
+}
+
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d49e26c..99a65a3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -29,6 +29,7 @@
 #include <linux/dma_remapping.h>
 #include <linux/mmu_notifier.h>
 #include <linux/list.h>
+#include <linux/iommu.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -440,6 +441,7 @@ struct intel_iommu {
 	struct irq_domain *ir_msi_domain;
 #endif
 	struct device	*iommu_dev; /* IOMMU-sysfs device */
+	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
 	u32		flags;      /* Software defined flags */
 };
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 085e1f0..e981577 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -204,6 +204,20 @@ struct iommu_ops {
 	unsigned long pgsize_bitmap;
 };
 
+/**
+ * struct iommu_device - IOMMU core representation of one IOMMU hardware
+ *			 instance
+ * @list: Used by the iommu-core to keep a list of registered iommus
+ * @ops: iommu-ops for talking to this iommu
+ */
+struct iommu_device {
+	struct list_head list;
+	const struct iommu_ops *ops;
+};
+
+int  iommu_device_register(struct iommu_device *iommu);
+void iommu_device_unregister(struct iommu_device *iommu);
+
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
-- 
1.9.1
