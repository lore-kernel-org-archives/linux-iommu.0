From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Defer TLB flush in case of unmap op
Date: Wed,  2 Aug 2017 15:23:18 +0530
Message-ID: <1501667598-16404-1-git-send-email-vivek.gautam@codeaurora.org>
References: <CAFp+6iFfu2-qrDDim7fzKKLqMcSVMmOr7esqBZ-xEeLTOOTNLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iFfu2-qrDDim7fzKKLqMcSVMmOr7esqBZ-xEeLTOOTNLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We don't want to touch the TLB when smmu is suspended.
Defer it until resume.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

Hi all,

Here's the small patch in response of suggestion to defer tlb operations
when smmu is in suspend state.
The patch stores the TLB requests in 'unmap' when the smmu device is
suspended. On resume, it checks all the pending TLB requests, and
performs the unmap over those.

Right now, I have applied the patch on top of the pm runtime series.
Let me know what you think of the change. It will also be helpful if
somebody can please test a valid use case with this.

regards
Vivek

 drivers/iommu/arm-smmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fe8e7fd61282..1f9c2b16aabb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -51,6 +51,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 #include <linux/amba/bus.h>
 
@@ -151,6 +152,14 @@ struct arm_smmu_master_cfg {
 #define for_each_cfg_sme(fw, i, idx) \
 	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
 
+struct arm_smmu_tlb_req_info {
+	struct iommu_domain *domain;
+	unsigned long iova;
+	size_t size;
+	bool tlb_flush_pending;
+	struct list_head list;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 
@@ -182,6 +191,7 @@ struct arm_smmu_device {
 	u32				num_s2_context_banks;
 	DECLARE_BITMAP(context_map, ARM_SMMU_MAX_CBS);
 	atomic_t			irptndx;
+	struct list_head		domain_list;
 
 	u32				num_mapping_groups;
 	u16				streamid_mask;
@@ -1239,17 +1249,32 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
-	size_t ret;
+	struct arm_smmu_tlb_req_info *tlb_info;
 
 	if (!ops)
 		return 0;
 
-	pm_runtime_get_sync(smmu_domain->smmu->dev);
-	ret = ops->unmap(ops, iova, size);
-	pm_runtime_put_sync(smmu_domain->smmu->dev);
+	/* if the device is suspended; we can't unmap, defer any tlb operations */
+	if (pm_runtime_suspended(smmu->dev)) {
+		tlb_info = devm_kzalloc(smmu->dev, sizeof(*tlb_info), GFP_ATOMIC);
+		if (!tlb_info)
+			return -ENOMEM;
 
-	return ret;
+		tlb_info->domain = domain;
+		tlb_info->iova = iova;
+		tlb_info->size = size;
+		tlb_info->tlb_flush_pending = true;
+		INIT_LIST_HEAD(&tlb_info->list);
+
+		/* XXX: We need locks here, but that again introduce the slowpath ? */
+		list_add_tail(&tlb_info->list, &smmu->domain_list);
+
+		return size;
+	}
+
+	return ops->unmap(ops, iova, size);
 }
 
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
@@ -2166,6 +2191,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	INIT_LIST_HEAD(&smmu->domain_list);
+
 	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		return err;
@@ -2268,8 +2295,28 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 static int arm_smmu_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct arm_smmu_tlb_req_info  *tlb_info, *temp;
+	int ret;
+
+	ret = arm_smmu_enable_clocks(smmu);
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(tlb_info, temp, &smmu->domain_list, list) {
+		printk("\n\n %s %d :: iterating over pending tlb request\n\n", __func__, __LINE__);
+		if (tlb_info->tlb_flush_pending) {
+			ret = arm_smmu_unmap(tlb_info->domain, tlb_info->iova, tlb_info->size);
+			if (!ret)
+				return -EINVAL;
 
-	return arm_smmu_enable_clocks(smmu);
+			tlb_info->tlb_flush_pending = false;
+
+			/* we are done with this request; delete it */
+			list_del(&tlb_info->list);
+		}
+	}
+
+	return 0;
 }
 
 static int arm_smmu_suspend(struct device *dev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
