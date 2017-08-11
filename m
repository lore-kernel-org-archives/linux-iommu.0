From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v2 4/4] iommu/arm-smmu-v3: add CMD_TLBI_NH_VA_AM command for
	iova range invalidation
Date: Fri, 11 Aug 2017 15:45:30 +0200
Message-ID: <1502459130-6234-5-git-send-email-eric.auger@redhat.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502459130-6234-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org
Cc: mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When using a virtual SMMU and running the driver in TLBI_ON_MAP
mode we need invalidate large IOVA ranges. This typically happens
in DPDK use case where hugepages are used. In that case, invalidating
pages by page is really inefficient and we would need to invalidate
by iova range. Unfortunately there is no such command specified in the
SMMUv3 architecture spec. Let's add a new implementation defined command
that takes an address mask.

The CMD_TLBI_NH_VA_AM command format is inherited from CMD_TLBI_NH_VA's
one, replace the currently unused VMID field by the AM field.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a1c10af..9da2785 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -492,9 +492,15 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_S12_VMALL	0x28
 		#define CMDQ_OP_TLBI_S2_IPA	0x2a
 		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
+
+		/* vIOMMU ASID/IOVA Range Invalidation */
+		#define CMDQ_OP_TLBI_NH_VA_AM	0x8F
 		struct {
 			u16			asid;
-			u16			vmid;
+			union {
+				u16		vmid;
+				u16		am; /* address mask */
+			};
 			bool			leaf;
 			u64			addr;
 		} tlbi;
@@ -853,6 +859,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
 		break;
+	case CMDQ_OP_TLBI_NH_VA_AM:
+		cmd[0] |= (u64)ent->tlbi.asid << CMDQ_TLBI_0_ASID_SHIFT;
+		cmd[0] |= (u64)ent->tlbi.am << CMDQ_TLBI_0_VMID_SHIFT;
+		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
+		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
+		break;
 	case CMDQ_OP_TLBI_S2_IPA:
 		cmd[0] |= (u64)ent->tlbi.vmid << CMDQ_TLBI_0_VMID_SHIFT;
 		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
@@ -1402,8 +1414,14 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	};
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		if (smmu->options & ARM_SMMU_OPT_TLBI_ON_MAP) {
+			cmd.opcode	= CMDQ_OP_TLBI_NH_VA_AM;
+			cmd.tlbi.am   = size >> 12;
+			granule = size;
+		} else {
+			cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		}
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-- 
2.5.5
