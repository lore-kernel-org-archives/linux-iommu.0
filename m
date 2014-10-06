From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RFC][PATCH 2/2] Add support of the IOMMU_DEVICE flag.
Date: Mon, 6 Oct 2014 15:58:16 +0530
Message-ID: <1412591296-31934-2-git-send-email-Varun.Sethi@freescale.com>
References: <1412591296-31934-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412591296-31934-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This flag is used for specifying access to device memory. SMMU would apply
device memory attributes for a DMA transaction. This is required for setting
access to GIC registers, for generating message interrupts. This would ensure that 
transactions targetting device memory are not gathered or reordered.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d..f8338d6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1263,6 +1263,10 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 		if (prot & IOMMU_CACHE)
 			pteval |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
+
+		if (prot & IOMMU_DEVICE)
+			pteval |= (MAIR_ATTR_IDX_DEV <<
+				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
 	} else {
 		pteval |= ARM_SMMU_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
@@ -1273,6 +1277,9 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
 		else
 			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
+
+		if (prot & IOMMU_DEVICE)
+			pteval |= ARM_SMMU_PTE_MEMATTR_DEV;
 	}
 
 	/* If no access, create a faulting entry to avoid TLB fills */
-- 
1.7.9.5
