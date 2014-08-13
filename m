From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 5/6] iommu/arm-smmu: support buggy implementations with
	invalidate-on-map
Date: Tue, 12 Aug 2014 17:51:38 -0700
Message-ID: <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a workaround for some buggy hardware that requires a TLB invalidate
operation to occur at map time. Activate the feature with the
qcom,smmu-invalidate-on-map boolean DT property.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt |  4 ++++
 drivers/iommu/arm-smmu.c                             | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index dbc1ddad79..aaebeaeda0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -48,6 +48,10 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- qcom,smmu-invalidate-on-map : Enable proper handling of buggy
+                  implementations that require a TLB invalidate
+                  operation to occur at map time.
+
 - clocks        : List of clocks to be used during SMMU register access. See
                   Documentation/devicetree/bindings/clock/clock-bindings.txt
                   for information about the format. For each clock specified
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 22e25f3172..73d056668b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -389,6 +389,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_INVALIDATE_ON_MAP (1 << 1)
 	u32				options;
 	int				version;
 
@@ -455,6 +456,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_INVALIDATE_ON_MAP, "qcom,smmu-invalidate-on-map" },
 	{ 0, NULL},
 };
 
@@ -1693,12 +1695,22 @@ out_unlock:
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
+	int ret;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 
 	if (!smmu_domain)
 		return -ENODEV;
 
-	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
+	ret = arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
+
+	if (!ret &&
+		(smmu_domain->smmu->options & ARM_SMMU_OPT_INVALIDATE_ON_MAP)) {
+		arm_smmu_enable_clocks(smmu_domain->smmu);
+		arm_smmu_tlb_inv_context(smmu_domain);
+		arm_smmu_disable_clocks(smmu_domain->smmu);
+	}
+
+	return ret;
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
