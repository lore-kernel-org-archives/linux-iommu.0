From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 6/7] iommu/arm-smmu: fix corner cases in address size
	calculations
Date: Fri, 29 Aug 2014 15:47:44 +0100
Message-ID: <1409323665-9605-7-git-send-email-will.deacon@arm.com>
References: <1409323665-9605-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409323665-9605-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: vladimir.murzin-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Working out the usable address sizes for the SMMU is surprisingly tricky.
We must take into account both the limitations of the hardware for VA,
IPA and PA sizes but also any restrictions imposed by the Linux page
table code, particularly when dealing with nested translation (where the
IPA size is limited by the input address size at stage-2).

This patch fixes a few corner cases in our address size handling so that
we correctly deal with 40-bit addresses in TTBCR2 and restrict the IPA
size differently depending on whether or not we have support for nested
translation.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7fec50bb54c3..98bb1b746517 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -763,6 +763,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg = (TTBCR2_ADDR_36 << TTBCR2_SEP_SHIFT);
 			break;
 		case 39:
+		case 40:
 			reg = (TTBCR2_ADDR_40 << TTBCR2_SEP_SHIFT);
 			break;
 		case 42:
@@ -784,6 +785,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg |= (TTBCR2_ADDR_36 << TTBCR2_PASIZE_SHIFT);
 			break;
 		case 39:
+		case 40:
 			reg |= (TTBCR2_ADDR_40 << TTBCR2_PASIZE_SHIFT);
 			break;
 		case 42:
@@ -1811,11 +1813,16 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	 * Stage-1 output limited by stage-2 input size due to pgd
 	 * allocation (PTRS_PER_PGD).
 	 */
+	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
 #ifdef CONFIG_64BIT
-	smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
+		smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
 #else
-	smmu->s1_output_size = min(32UL, size);
+		smmu->s1_output_size = min(32UL, size);
 #endif
+	} else {
+		smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT,
+					     size);
+	}
 
 	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-- 
2.1.0
