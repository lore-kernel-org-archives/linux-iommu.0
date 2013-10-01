From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/6] iommu/arm-smmu: Clear global and context bank fault
	status registers
Date: Tue,  1 Oct 2013 14:39:09 +0200
Message-ID: <1380631150-10783-6-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

After reset these registers have unknown values.
This might cause problems when evaluating SMMU_GFSR and/or SMMU_CB_FSR
in handlers for combined interrupts.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 579b6f8..b632bcd 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1562,9 +1562,13 @@ static struct iommu_ops arm_smmu_ops = {
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
-	void __iomem *sctlr_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB_SCTLR;
+	void __iomem *cb_base;
 	int i = 0;
-	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+	u32 reg;
+
+	/* clear global FSR */
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	writel(reg, gr0_base + ARM_SMMU_GR0_sGFSR);
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
@@ -1572,33 +1576,38 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		writel_relaxed(S2CR_TYPE_BYPASS, gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
-	/* Make sure all context banks are disabled */
-	for (i = 0; i < smmu->num_context_banks; ++i)
-		writel_relaxed(0, sctlr_base + ARM_SMMU_CB(smmu, i));
+	/* Make sure all context banks are disabled and clear CB_FSR  */
+	for (i = 0; i < smmu->num_context_banks; ++i) {
+		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
+		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
+		writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
+	}
 
 	/* Invalidate the TLB, just in case */
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+
 	/* Enable fault reporting */
-	scr0 |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
+	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
 
 	/* Disable TLB broadcasting. */
-	scr0 |= (sCR0_VMIDPNE | sCR0_PTM);
+	reg |= (sCR0_VMIDPNE | sCR0_PTM);
 
 	/* Enable client access, but bypass when no mapping is found */
-	scr0 &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
+	reg &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
 
 	/* Disable forced broadcasting */
-	scr0 &= ~sCR0_FB;
+	reg &= ~sCR0_FB;
 
 	/* Don't upgrade barriers */
-	scr0 &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
+	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
 
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
-	writel(scr0, gr0_base + ARM_SMMU_GR0_sCR0);
+	writel(reg, gr0_base + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
-- 
1.7.9.5
