From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 04/10] iommu/sva: Add a mm_exit callback for device drivers
Date: Thu, 20 Sep 2018 18:00:40 +0100
Message-ID: <20180920170046.20154-5-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When an mm exits, devices that were bound to it must stop performing DMA
on its PASID. Let device drivers register a callback to be notified on mm
exit. Add the callback to the sva_param structure attached to struct
device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu-sva.c | 10 +++++++++-
 include/linux/iommu.h     |  8 ++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index a486bc947335..08da479dad68 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -436,6 +436,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
  * @features: bitmask of features that need to be initialized
  * @min_pasid: min PASID value supported by the device
  * @max_pasid: max PASID value supported by the device
+ * @mm_exit: callback for process address space release
  *
  * Users of the bind()/unbind() API must call this function to initialize all
  * features required for SVA.
@@ -447,13 +448,19 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
  * overrides it. Similarly, @min_pasid overrides the lower PASID limit supported
  * by the IOMMU.
  *
+ * @mm_exit is called when an address space bound to the device is about to be
+ * torn down by exit_mmap. After @mm_exit returns, the device must not issue any
+ * more transaction with the PASID given as argument. The handler gets an opaque
+ * pointer corresponding to the drvdata passed as argument to bind().
+ *
  * The device should not be performing any DMA while this function is running,
  * otherwise the behavior is undefined.
  *
  * Return 0 if initialization succeeded, or an error.
  */
 int iommu_sva_init_device(struct device *dev, unsigned long features,
-		       unsigned int min_pasid, unsigned int max_pasid)
+			  unsigned int min_pasid, unsigned int max_pasid,
+			  iommu_mm_exit_handler_t mm_exit)
 {
 	int ret;
 	struct iommu_sva_param *param;
@@ -472,6 +479,7 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	param->features		= features;
 	param->min_pasid	= min_pasid;
 	param->max_pasid	= max_pasid;
+	param->mm_exit		= mm_exit;
 	INIT_LIST_HEAD(&param->mm_list);
 
 	mutex_lock(&dev->iommu_param->sva_lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6a3ced6a5aa1..c95ff714ea66 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -60,6 +60,7 @@ struct iommu_fault_event;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
+typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -216,6 +217,7 @@ struct iommu_sva_param {
 	unsigned int min_pasid;
 	unsigned int max_pasid;
 	struct list_head mm_list;
+	iommu_mm_exit_handler_t mm_exit;
 };
 
 /**
@@ -967,7 +969,8 @@ static inline void iommu_debugfs_setup(void) {}
 #ifdef CONFIG_IOMMU_SVA
 extern int iommu_sva_init_device(struct device *dev, unsigned long features,
 				 unsigned int min_pasid,
-				 unsigned int max_pasid);
+				 unsigned int max_pasid,
+				 iommu_mm_exit_handler_t mm_exit);
 extern void iommu_sva_shutdown_device(struct device *dev);
 extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 				   int *pasid, unsigned long flags,
@@ -978,7 +981,8 @@ extern void iommu_sva_unbind_device_all(struct device *dev);
 static inline int iommu_sva_init_device(struct device *dev,
 					unsigned long features,
 					unsigned int min_pasid,
-					unsigned int max_pasid)
+					unsigned int max_pasid,
+					iommu_mm_exit_handler_t mm_exit)
 {
 	return -ENODEV;
 }
-- 
2.18.0
