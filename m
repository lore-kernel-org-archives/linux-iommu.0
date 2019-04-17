Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF8C282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54D62064B
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54D62064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 34E01E67;
	Wed, 17 Apr 2019 18:28:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B8012E50
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 1F15314D
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01CBC15AB;
	Wed, 17 Apr 2019 11:28:27 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 530C63F59C; 
	Wed, 17 Apr 2019 11:28:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: will.deacon@arm.com,
	lorenzo.pieralisi@arm.com,
	bhelgaas@google.com
Subject: [PATCH v3 6/9] iommu/arm-smmu-v3: Add a master->domain pointer
Date: Wed, 17 Apr 2019 19:24:45 +0100
Message-Id: <20190417182448.12382-7-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417182445.NmYTeHJK4HY6o_JHODsnlJFhl7KrhFdDthemMaTv0rk@z>

As we're going to track domain-master links more closely for ATS and CD
invalidation, add pointer to the attached domain in struct
arm_smmu_master. As a result, arm_smmu_strtab_ent is redundant and can be
removed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
