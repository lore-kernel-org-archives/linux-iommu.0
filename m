From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA
Date: Fri, 18 Sep 2015 16:18:18 +0100
Message-ID: <1442589498-31355-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

Stage-2 TLBI by IPA takes a 48-bit address field, as opposed to the
64-bit field used by the VA-based invalidation commands.

This patch re-jigs the SMMUv3 command construction code so that the
address field is correctly masked.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a24f359fa0d0..286e890e7d64 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -343,7 +343,8 @@
 #define CMDQ_TLBI_0_VMID_SHIFT		32
 #define CMDQ_TLBI_0_ASID_SHIFT		48
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
-#define CMDQ_TLBI_1_ADDR_MASK		~0xfffUL
+#define CMDQ_TLBI_1_VA_MASK		~0xfffUL
+#define CMDQ_TLBI_1_IPA_MASK		0xfffffffff000UL
 
 #define CMDQ_PRI_0_SSID_SHIFT		12
 #define CMDQ_PRI_0_SSID_MASK		0xfffffUL
@@ -771,11 +772,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
 		cmd[0] |= (u64)ent->tlbi.asid << CMDQ_TLBI_0_ASID_SHIFT;
-		/* Fallthrough */
+		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
+		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
+		break;
 	case CMDQ_OP_TLBI_S2_IPA:
 		cmd[0] |= (u64)ent->tlbi.vmid << CMDQ_TLBI_0_VMID_SHIFT;
 		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
-		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_ADDR_MASK;
+		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
 		break;
 	case CMDQ_OP_TLBI_NH_ASID:
 		cmd[0] |= (u64)ent->tlbi.asid << CMDQ_TLBI_0_ASID_SHIFT;
-- 
2.1.4
