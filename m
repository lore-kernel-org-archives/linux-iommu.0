From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 04/13] iommu/arm-smmu: Use incoming shareability attributes in
	bypass mode
Date: Thu, 17 Dec 2015 12:12:04 +0000
Message-ID: <1450354333-27256-5-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When we initialise a bypass STE, we memset the structure to zero and
set the Valid and Config fields to indicate that the stream should
bypass the SMMU. Unfortunately, this results in an SHCFG field of 0
which means that the shareability of any incoming transactions is
overridden with non-shareable, leading to potential coherence problems
down the line.

This patch fixes the issue by initialising bypass STEs to use the
incoming shareability attributes. When translation is in effect at
either stage 1 or stage 2, the shareability is determined by the
page tables.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 86480480895d..2e3e235f509c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -253,6 +253,9 @@
 #define STRTAB_STE_1_STRW_EL2		2UL
 #define STRTAB_STE_1_STRW_SHIFT		30
 
+#define STRTAB_STE_1_SHCFG_INCOMING	1UL
+#define STRTAB_STE_1_SHCFG_SHIFT	44
+
 #define STRTAB_STE_2_S2VMID_SHIFT	0
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
@@ -1041,6 +1044,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		val |= disable_bypass ? STRTAB_STE_0_CFG_ABORT
 				      : STRTAB_STE_0_CFG_BYPASS;
 		dst[0] = cpu_to_le64(val);
+		dst[1] = cpu_to_le64(STRTAB_STE_1_SHCFG_INCOMING
+			 << STRTAB_STE_1_SHCFG_SHIFT);
 		dst[2] = 0; /* Nuke the VMID */
 		if (ste_live)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
-- 
2.1.4
