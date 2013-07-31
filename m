From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu: arm smmu: tighten up global fault reporting
Date: Wed, 31 Jul 2013 19:21:26 +0100
Message-ID: <1375294888-10826-3-git-send-email-will.deacon@arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On systems which use a single, combined irq line for the SMMU, context
faults may result in us spuriously reporting global faults with zero
status registers.

This patch fixes up the fsr checks in both the context and global fault
interrupt handlers, so that we only report the fault if the fsr
indicates something did indeed go awry.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index da8af45..3a595bb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -305,7 +305,7 @@
 #define FSR_IGN				(FSR_AFF | FSR_ASF | FSR_TLBMCF |	\
 					 FSR_TLBLKF)
 #define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT |		\
-					 FSR_EF | FSR_PF | FSR_TF)
+					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
 
 #define FSYNR0_WNR			(1 << 4)
 
@@ -590,6 +590,9 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
 	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	if (!gfsr)
+		return IRQ_NONE;
+
 	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
 	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
 	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
@@ -601,7 +604,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 		gfsr, gfsynr0, gfsynr1, gfsynr2);
 
 	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
-- 
1.8.2.2
