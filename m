From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 3/3] iommu/arm-smmu: Add support to use system cache
Date: Mon, 21 Jan 2019 11:23:35 +0530
Message-ID: <20190121055335.15430-4-vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190121055335.15430-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Few Qualcomm platforms, such as sdm845 have an additional outer
cache called as System cache, aka. Last level cache (LLC) that
allows non-coherent devices to upgrade to using caching.
This last level cache sits right before the DDR, and is tightly
coupled with the memory controller.
The cache is available to a number of devices - coherent and
non-coherent, present in the SoC system, and to CPUs.
The devices request their slices from this system cache, make it
active, and can then start using it.

Devices can set iommu domain attributes and page protection
while mapping the buffers to set the required memory attributes
to use system cache for buffers and page tables.
This change adds the support for iommu domain attributes and the
interaction with io page table driver.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 52b300dfc096..324f3bb54c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,7 +260,8 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
-#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
+#define ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE	BIT(1)
+#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT		BIT(0)
 	unsigned int			attr;
 };
 
@@ -910,6 +911,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_COHERENT;
 
+	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_QCOM_SYS_CACHE;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1592,6 +1596,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			*(int *)data = !!(smmu_domain->attr &
+					  ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE);
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1633,6 +1641,16 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			if (*(int *)data)
+				smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			else
+				smmu_domain->attr &= ~ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			break;
 		default:
 			ret = -ENODEV;
 		}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
