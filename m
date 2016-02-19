From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/6] iommu/arm-smmu: Allow disabling unmatched stream bypass
Date: Fri, 19 Feb 2016 17:46:41 +0000
Message-ID: <1455904003-28069-5-git-send-email-will.deacon@arm.com>
References: <1455904003-28069-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455904003-28069-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Borrow the disable_bypass parameter from the SMMUv3 driver as a handy
debugging/security feature so that unmatched stream IDs (i.e. devices
not attached to an IOMMU domain) may be configured to fault.

Rather than introduce unsightly inconsistency, or repeat the existing
unnecessary use of module_param_named(), fix that as well in passing.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e8e7bcc4540c..7012531abe62 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -261,9 +261,13 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
-module_param_named(force_stage, force_stage, int, S_IRUGO);
+module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
+static bool disable_bypass;
+module_param(disable_bypass, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_bypass,
+	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
 enum arm_smmu_arch_version {
 	ARM_SMMU_V1 = 1,
@@ -1119,9 +1123,9 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
+		u32 reg = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS;
 
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			       gr0_base + ARM_SMMU_GR0_S2CR(idx));
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
 	arm_smmu_master_free_smrs(smmu, cfg);
@@ -1484,11 +1488,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 
-	/* Mark all SMRn as invalid and all S2CRn as bypass */
+	/* Mark all SMRn as invalid and all S2CRn as bypass unless overridden */
+	reg = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS;
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_SMR(i));
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			gr0_base + ARM_SMMU_GR0_S2CR(i));
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
@@ -1510,8 +1514,12 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Disable TLB broadcasting. */
 	reg |= (sCR0_VMIDPNE | sCR0_PTM);
 
-	/* Enable client access, but bypass when no mapping is found */
-	reg &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
+	/* Enable client access, handling unmatched streams as appropriate */
+	reg &= ~sCR0_CLIENTPD;
+	if (disable_bypass)
+		reg |= sCR0_USFCFG;
+	else
+		reg &= ~sCR0_USFCFG;
 
 	/* Disable forced broadcasting */
 	reg &= ~sCR0_FB;
-- 
2.1.4
