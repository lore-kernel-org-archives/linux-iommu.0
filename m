From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704
Date: Mon, 16 Jan 2017 08:16:07 +0100
Message-ID: <1484550967-6328-1-git-send-email-tn@semihalf.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Linu.Cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The goal of erratum #27704 workaround was to make sure that ASIDs and VMIDs
are unique across all SMMU instances on affected Cavium systems.

Currently, the workaround code partitions ASIDs and VMIDs by increasing
global cavium_smmu_context_count which in turn becomes the base ASID and VMID
value for the given SMMU instance upon the context bank initialization.

For systems with multiple SMMU instances this approach implies the risk
of crossing 8-bit ASID, like for 1-socket CN88xx capable of 4 SMMUv2,
128 context banks each:
SMMU_0 (0-127 ASID RANGE)
SMMU_1 (127-255 ASID RANGE)
SMMU_2 (256-383 ASID RANGE) <--- crossing 8-bit ASID
SMMU_3 (384-511 ASID RANGE) <--- crossing 8-bit ASID

Since now we use 8-bit ASID (SMMU_CBn_TCR2.AS = 0) we effectively misconfigure
ASID[15:8] bits of SMMU_CBn_TTBRm register for SMMU_2/3. Moreover, we still
assume non-zero ASID[15:8] bits upon context invalidation. In the end,
except SMMU_0/1 devices all other devices under other SMMUs will fail on guest
power off/on. Since we try to invalidate TLB with 16-bit ASID but we actually
have 8-bit zero padded 16-bit entry.

This patch adds 16-bit ASID support for stage-1 AArch64 contexts so that
we use ASIDs consistently for all SMMU instances.

Signed-off-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Tirumalesh Chalamarla  <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded..476fab9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,6 +260,7 @@ enum arm_smmu_s2cr_privcfg {
 
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_AS			(1 << 4)
 
 #define TTBRn_ASID_SHIFT		48
 
@@ -778,6 +779,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
 			reg2 |= TTBCR2_SEP_UPSTREAM;
+			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
+				reg2 |= TTBCR2_AS;
 		}
 		if (smmu->version > ARM_SMMU_V1)
 			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
-- 
2.7.4
