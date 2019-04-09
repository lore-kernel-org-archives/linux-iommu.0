From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/7] iommu/arm-smmu-v3: Add a master->domain pointer
Date: Tue,  9 Apr 2019 17:52:42 +0100
Message-ID: <20190409165245.26500-5-jean-philippe.brucker@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

As we're going to track domain-master links more closely for ATS and CD
invalidation, add pointer to the attached domain in struct
arm_smmu_master. As a result, arm_smmu_strtab_ent is redundant and can be
removed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 92 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 25ba546cae7f..7b425483f4b6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -505,19 +505,6 @@ struct arm_smmu_s2_cfg {
 	u64				vtcr;
 };
 
-struct arm_smmu_strtab_ent {
-	/*
-	 * An STE is "assigned" if the master emitting the corresponding SID
-	 * is attached to a domain. The behaviour of an unassigned STE is
-	 * determined by the disable_bypass parameter, whereas an assigned
-	 * STE behaves according to s1_cfg/s2_cfg, which themselves are
-	 * configured according to the domain type.
-	 */
-	bool				assigned;
-	struct arm_smmu_s1_cfg		*s1_cfg;
-	struct arm_smmu_s2_cfg		*s2_cfg;
-};
-
 struct arm_smmu_strtab_cfg {
 	__le64				*strtab;
 	dma_addr_t			strtab_dma;
@@ -593,7 +580,7 @@ struct arm_smmu_device {
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
-	struct arm_smmu_strtab_ent	ste;
+	struct arm_smmu_domain		*domain;
 	u32				*sids;
 	unsigned int			num_sids;
 };
@@ -1087,8 +1074,8 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
-static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
-				      __le64 *dst, struct arm_smmu_strtab_ent *ste)
+static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
+				      __le64 *dst)
 {
 	/*
 	 * This is hideously complicated, but we only really care about
@@ -1108,6 +1095,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	 */
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_s1_cfg *s1_cfg = NULL;
+	struct arm_smmu_s2_cfg *s2_cfg = NULL;
+	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1115,6 +1106,25 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		},
 	};
 
+	if (master) {
+		smmu_domain = master->domain;
+		smmu = master->smmu;
+	}
+
+	if (smmu_domain) {
+		switch (smmu_domain->stage) {
+		case ARM_SMMU_DOMAIN_S1:
+			s1_cfg = &smmu_domain->s1_cfg;
+			break;
+		case ARM_SMMU_DOMAIN_S2:
+		case ARM_SMMU_DOMAIN_NESTED:
+			s2_cfg = &smmu_domain->s2_cfg;
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (val & STRTAB_STE_0_V) {
 		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
 		case STRTAB_STE_0_CFG_BYPASS:
@@ -1135,8 +1145,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!ste->assigned || !(ste->s1_cfg || ste->s2_cfg)) {
-		if (!ste->assigned && disable_bypass)
+	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
+		if (!smmu_domain && disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1154,7 +1164,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		return;
 	}
 
-	if (ste->s1_cfg) {
+	if (s1_cfg) {
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1169,22 +1179,22 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
 	}
 
-	if (ste->s2_cfg) {
+	if (s2_cfg) {
 		BUG_ON(ste_live);
 		dst[2] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_2_S2VMID, ste->s2_cfg->vmid) |
-			 FIELD_PREP(STRTAB_STE_2_VTCR, ste->s2_cfg->vtcr) |
+			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
+			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
 #ifdef __BIG_ENDIAN
 			 STRTAB_STE_2_S2ENDI |
 #endif
 			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
 			 STRTAB_STE_2_S2R);
 
-		dst[3] = cpu_to_le64(ste->s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
 
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
 	}
@@ -1201,10 +1211,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
 {
 	unsigned int i;
-	struct arm_smmu_strtab_ent ste = { .assigned = false };
 
 	for (i = 0; i < nent; ++i) {
-		arm_smmu_write_strtab_ent(NULL, -1, strtab, &ste);
+		arm_smmu_write_strtab_ent(NULL, -1, strtab);
 		strtab += STRTAB_STE_DWORDS;
 	}
 }
@@ -1706,13 +1715,16 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
-		arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
+		arm_smmu_write_strtab_ent(master, sid, step);
 	}
 }
 
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
-	master->ste.assigned = false;
+	if (!master->domain)
+		return;
+
+	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -1723,18 +1735,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
-	struct arm_smmu_strtab_ent *ste;
 
 	if (!fwspec)
 		return -ENOENT;
 
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
-	ste = &master->ste;
 
-	/* Already attached to a different domain? */
-	if (ste->assigned)
-		arm_smmu_detach_dev(master);
+	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1754,19 +1762,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
-	ste->assigned = true;
+	master->domain = smmu_domain;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
-		ste->s1_cfg = NULL;
-		ste->s2_cfg = NULL;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		ste->s1_cfg = &smmu_domain->s1_cfg;
-		ste->s2_cfg = NULL;
-		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
-	} else {
-		ste->s1_cfg = NULL;
-		ste->s2_cfg = &smmu_domain->s2_cfg;
-	}
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
 
 	arm_smmu_install_ste_for_dev(master);
 out_unlock:
@@ -1921,8 +1920,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
-	if (master && master->ste.assigned)
-		arm_smmu_detach_dev(master);
+	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
-- 
2.21.0
