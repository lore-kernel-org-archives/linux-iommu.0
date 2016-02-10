From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/arm-smmu: Allow disabling unmatched stream bypass
Date: Wed, 10 Feb 2016 14:25:33 +0000
Message-ID: <72d7de65c4ace47b55c31fc4e74ce4f1891eabb4.1455114028.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
	<10ebf5a136a787da54ffd1d6167953f82f01a834.1453830752.git.robin.murphy@arm.com>
	<20160209140631.GM22874@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160209140631.GM22874-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Borrow the disable_bypass parameter from the SMMUv3 driver as a handy
debugging/security feature so that unmatched stream IDs (i.e. devices
not attached to an IOMMU domain) may be configured to fault.

Rather than introduce unsightly inconsistency, or repeat the existing
unnecessary use of module_param_named(), fix that as well in passing.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2:
- Don't bother trying to report the fault specially.
- Realise that calling module_param_named() with identical variable
  and parameter names is silly.

 drivers/iommu/arm-smmu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1f9093d..cf1e330 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,9 +260,13 @@
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
@@ -1111,9 +1115,9 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
+		u32 reg = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS;
 
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			       gr0_base + ARM_SMMU_GR0_S2CR(idx));
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
 	arm_smmu_master_free_smrs(smmu, cfg);
@@ -1476,11 +1480,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -1502,8 +1506,12 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
2.7.0.25.gfc10eb5.dirty
