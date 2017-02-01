From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 1/3] iommu: introduce stall/resume support
Date: Wed,  1 Feb 2017 10:23:39 -0500
Message-ID: <20170201152341.29142-2-robdclark@gmail.com>
References: <20170201152341.29142-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170201152341.29142-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

A new flag when registering the fault handler indicates that the user
supports stalling, and will call iommu_domain_resume() at some point
later, potentially from a workqueue.  (This would allow the user to do
mm related operations that could not be done from irq context.)

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c    |  2 +-
 drivers/gpu/drm/msm/msm_iommu.c          | 12 +++++++++---
 drivers/infiniband/hw/usnic/usnic_uiom.c |  2 +-
 drivers/iommu/iommu.c                    | 24 +++++++++++++++++++++++-
 drivers/remoteproc/remoteproc_core.c     |  2 +-
 include/linux/iommu.h                    |  5 ++++-
 6 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 169ac96..a8819bc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -303,7 +303,7 @@ struct etnaviv_iommu *etnaviv_iommu_new(struct etnaviv_gpu *gpu)
 		    mmu->domain->geometry.aperture_end -
 		    mmu->domain->geometry.aperture_start + 1);
 
-	iommu_set_fault_handler(mmu->domain, etnaviv_fault_handler, gpu->dev);
+	iommu_set_fault_handler(mmu->domain, etnaviv_fault_handler, gpu->dev, false);
 
 	return mmu;
 }
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 48e79d0..7521582 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -29,9 +29,15 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
 	struct msm_iommu *iommu = arg;
+	int ret = 0;
+
 	if (iommu->base.handler)
-		return iommu->base.handler(iommu->base.arg, iova, flags);
-	pr_warn_ratelimited("*** fault: iova=%08lx, flags=%d\n", iova, flags);
+		ret = iommu->base.handler(iommu->base.arg, iova, flags);
+	else
+		pr_warn_ratelimited("*** fault: iova=%08lx, flags=%d\n", iova, flags);
+
+	iommu_domain_resume(domain, false);
+
 	return 0;
 }
 
@@ -172,7 +178,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 
 	iommu->domain = domain;
 	msm_mmu_init(&iommu->base, dev, &funcs);
-	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
+	iommu_set_fault_handler(domain, msm_fault_handler, iommu, true);
 
 	if (of_find_compatible_node(NULL, NULL, "qcom,msm-smmu-v2") ||
 			of_find_compatible_node(NULL, NULL, "qcom,msm-mmu-500"))
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 1ccee6e..0613701 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -476,7 +476,7 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
+	iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL, false);
 
 	spin_lock_init(&pd->lock);
 	INIT_LIST_HEAD(&pd->devs);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f196..65257cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1029,6 +1029,7 @@ EXPORT_SYMBOL_GPL(iommu_capable);
  * @domain: iommu domain
  * @handler: fault handler
  * @token: user data, will be passed back to the fault handler
+ * @can_stall: the user can support stalling on iommu fault
  *
  * This function should be used by IOMMU users which want to be notified
  * whenever an IOMMU fault happens.
@@ -1038,12 +1039,14 @@ EXPORT_SYMBOL_GPL(iommu_capable);
  */
 void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler,
-					void *token)
+					void *token,
+					bool can_stall)
 {
 	BUG_ON(!domain);
 
 	domain->handler = handler;
 	domain->handler_token = token;
+	domain->can_stall = can_stall;
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
@@ -1546,6 +1549,25 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+/**
+ * iommu_domain_resume() - resume a stalled transaction after fault
+ * @domain: iommu domain
+ * @resume: if true, resume the transaction, else abort it
+ *
+ * Users that pass can_stall=true to iommu_set_fault_handler() must
+ * call this function to resume (or terminate) the stalled iommu
+ * transaction.  It may either be called directly from the fault
+ * handler, or at some point later from a thread context (ie. if the
+ * fault handler needs to do anything that cannot be done from atomic
+ * context, ie. use any mm related API)
+ */
+void iommu_domain_resume(struct iommu_domain *domain, bool resume)
+{
+	if (domain->ops->domain_resume)
+		domain->ops->domain_resume(domain, resume);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_resume);
+
 void iommu_get_dm_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c6bfb349..5f1aa4c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -110,7 +110,7 @@ static int rproc_enable_iommu(struct rproc *rproc)
 		return -ENOMEM;
 	}
 
-	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
+	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc, false);
 
 	ret = iommu_attach_device(domain, dev);
 	if (ret) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..c428a07 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -82,6 +82,7 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
 	void *handler_token;
+	bool can_stall;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
 };
@@ -183,6 +184,7 @@ struct iommu_ops {
 			       enum iommu_attr attr, void *data);
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
+	void (*domain_resume)(struct iommu_domain *domain, bool resume);
 
 	/* Request/Free a list of direct mapping requirements for a device */
 	void (*get_dm_regions)(struct device *dev, struct list_head *list);
@@ -231,7 +233,7 @@ extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long io
 				int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
-			iommu_fault_handler_t handler, void *token);
+			iommu_fault_handler_t handler, void *token, bool can_stall);
 
 extern void iommu_get_dm_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_dm_regions(struct device *dev, struct list_head *list);
@@ -266,6 +268,7 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern void iommu_domain_resume(struct iommu_domain *domain, bool resume);
 struct device *iommu_device_create(struct device *parent, void *drvdata,
 				   const struct attribute_group **groups,
 				   const char *fmt, ...) __printf(4, 5);
-- 
2.9.3
