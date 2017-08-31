From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
	STE.S1STALLD and CD.S
Date: Thu, 31 Aug 2017 16:20:42 +0800
Message-ID: <1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
means we should not disable stall mode if stall/terminate mode is not
configuable.

Meanwhile, it is also ILLEGAL when STALL_MODEL==0b10 && CD.S==0 which
means if stall mode is force we should always set CD.S.

This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
TERMINATE feature checking to ensue above ILLEGAL cases from happening.

Signed-off-by: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dbda2eb..0745522 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -55,6 +55,7 @@
 #define IDR0_STALL_MODEL_SHIFT		24
 #define IDR0_STALL_MODEL_MASK		0x3
 #define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
+#define IDR0_STALL_MODEL_NS		(1 << IDR0_STALL_MODEL_SHIFT)
 #define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
 #define IDR0_TTENDIAN_SHIFT		21
 #define IDR0_TTENDIAN_MASK		0x3
@@ -766,6 +767,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_SVM		(1 << 15)
 #define ARM_SMMU_FEAT_HA		(1 << 16)
 #define ARM_SMMU_FEAT_HD		(1 << 17)
+#define ARM_SMMU_FEAT_TERMINATE		(1 << 18)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1402,6 +1404,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	u64 val;
 	bool cd_live;
 	__u64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	/*
 	 * This function handles the following cases:
@@ -1468,9 +1471,11 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		      CTXDESC_CD_0_V;
 
 		/*
-		 * FIXME: STALL_MODEL==0b10 && CD.S==0 is ILLEGAL
+		 * STALL_MODEL==0b10 && CD.S==0 is ILLEGAL
 		 */
-		if (ssid && smmu_domain->s1_cfg.can_stall)
+		if ((ssid && smmu_domain->s1_cfg.can_stall) ||
+		    (!(smmu->features & ARM_SMMU_FEAT_TERMINATE) &&
+		    smmu->features & ARM_SMMU_FEAT_STALLS))
 			val |= CTXDESC_CD_0_S;
 
 		cdptr[0] = cpu_to_le64(val);
@@ -1690,12 +1695,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			dst[1] |= STRTAB_STE_1_PPAR;
 
 		/*
-		 * FIXME: it is illegal to set S1STALLD if STALL_MODEL=0b10
-		 * (force). But according to the spec, it *must* be set for
+		 * According to spec, it is illegal to set S1STALLD if
+		 * STALL_MODEL is not 0b00. And it *must* be set for
 		 * devices that aren't capable of stalling (notably pci!)
-		 * So we need a "STALL_MODEL=0b00" feature bit.
 		 */
-		if (smmu->features & ARM_SMMU_FEAT_STALLS && !ste->can_stall)
+		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
+		    smmu->features & ARM_SMMU_FEAT_TERMINATE &&
+		    !ste->can_stall)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
@@ -4577,9 +4583,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
 	case IDR0_STALL_MODEL_STALL:
+		smmu->features |= ARM_SMMU_FEAT_TERMINATE;
 		/* Fallthrough */
 	case IDR0_STALL_MODEL_FORCE:
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
+		break;
+	case IDR0_STALL_MODEL_NS:
+		smmu->features |= ARM_SMMU_FEAT_TERMINATE;
 	}
 
 	if (reg & IDR0_S1P)
-- 
1.7.12.4
