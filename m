Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF52714D
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 18:28:17 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso1206887276.0
        for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482496; x=1691087296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/r4+zLDU9vZzLuCIiAZ82J06iXzyYNh68XEq9Qz2vI=;
        b=nBu7v1oKIKeVy7s9ZNbfgZKPLgqCtLEbp6pPeXFiUyLH/xp9TSqIfPjv7bfWP0tWe8
         /FYTbj4Y3PLg8gHlw+AkBqjfctz13eaWm4PZ+KZ9pjsop2YHcF7Fcwvat56cDpDT+3/U
         bvIf4totqij0/5nsJer7C0kcTJ2VVTgqAFhOxuzFGEGhakXRaDGH5565Jx6+pWsVd9iv
         lJB5BRASCTO8XXn1D0XLlWiBhH9NCkWHGFxyykEB6fq4u6FMr6SbzsCGuIxLtt7tSHyv
         xKTEjVC9k38q1LXuBYouizrtn6yaKumP81IUgY12Kq7u+2Lqfxoc/eAFvyLCDpvQilkI
         GC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482496; x=1691087296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/r4+zLDU9vZzLuCIiAZ82J06iXzyYNh68XEq9Qz2vI=;
        b=jvsxbikcZYzdaP+7Kw2WlP55kO6XBEURSxsbTPZR7IriJzsaEOumA4DmhyqRtMLIbu
         tY99KLb3hXk8/j1Gf0dZ+jeTdV4p5HlXl1Puhw3uTYblk/q2xuik3yrsEZ+ZPYXcQhaF
         /OsgLeDUgLw/QA0JyUagHmtiVGks2fiAKRpd4odP2IjWHXIX1cZiiChNlm/WsSvyt043
         G9Gt+cBnCaaXxnO6GgSLWBXfHWLcal/GLYsO7rsoLmKfleB0SHt8CRWBsHQ7uF9oFQRO
         QxHC2G4Xjt6ZMPg40qe+VkeKPVbGh/4PjG9/J3ctj8GcxXWrYpNlS9b6nOh5TgtXBdpk
         c+ig==
X-Gm-Message-State: ABy/qLYC2AK2mukZdlQfUvl0Kl9ppCkoNz+J+Tl75xi5eTF/zDdJm9nE
	C0rA/iLYrZcVBPK//qVeu/xrZ3uLzDLV
X-Google-Smtp-Source: APBJJlH9VJf2cDbJ+7e01SUekxsi8NfQxyNBGghOLQbtU5IfDQN31Sz0rCqeb0BkW45RRn9YCmvEnwXb0A/M
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1615:b0:ce4:b328:7966 with SMTP
 id bw21-20020a056902161500b00ce4b3287966mr1818ybb.7.1690482496783; Thu, 27
 Jul 2023 11:28:16 -0700 (PDT)
Date: Fri, 28 Jul 2023 02:26:18 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-3-mshavit@google.com>
Subject: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove or move s1_cfg fields that are redundant with those found in
arm_smmu_ctx_desc_cfg. The arm_smmu_ctx_desc_cfg member is named
cd_table to make it more obvious that it represents a cd table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++---
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bb277ff86f65f..8cf4987dd9ec7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1033,9 +1033,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (!cdcfg->l1_desc)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -1071,7 +1071,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	bool cd_live;
 	__le64 *cdptr;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << smmu_domain->cd_table.max_cds_bits)))
 		return -E2BIG;
 
 	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
@@ -1138,19 +1138,16 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	max_contexts = 1 << cfg->s1cdmax;
+	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
 		cdcfg->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
 		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
@@ -1186,7 +1183,7 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1276,7 +1273,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
 	struct arm_smmu_device *smmu = NULL;
-	struct arm_smmu_s1_cfg *s1_cfg = NULL;
+	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
@@ -1294,7 +1291,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
+			cd_table = &smmu_domain->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -1325,7 +1322,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
+	if (!smmu_domain || !(cd_table || s2_cfg)) {
 		if (!smmu_domain && disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
@@ -1344,7 +1341,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		return;
 	}
 
-	if (s1_cfg) {
+	if (cd_table) {
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
@@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
-			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
-			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
-			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
+		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
+		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
+				  cd_table->max_cds_bits) |
+		       FIELD_PREP(STRTAB_STE_0_S1FMT,
+				  cd_table->l1_desc ?
+					  STRTAB_STE_0_S1FMT_64K_L2 :
+					  STRTAB_STE_0_S1FMT_LINEAR);
 	}
 
 	if (s2_cfg) {
@@ -2082,11 +2083,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+		struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
+		if (cdcfg->cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -2106,7 +2107,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2119,7 +2120,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cfg->s1cdmax = master->ssid_bits;
+	cdcfg->max_cds_bits = master->ssid_bits;
 
 	smmu_domain->stall_enabled = master->stall_enabled;
 
@@ -2457,7 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		   master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5347be54584bc..006a724ee9230 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -595,12 +595,8 @@ struct arm_smmu_ctx_desc_cfg {
 	dma_addr_t			cdtab_dma;
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
-};
-
-struct arm_smmu_s1_cfg {
-	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	u8				s1fmt;
-	u8				s1cdmax;
+	/* log2 of the maximum number of CDs supported by this table */
+	u8				max_cds_bits;
 };
 
 struct arm_smmu_s2_cfg {
@@ -725,7 +721,7 @@ struct arm_smmu_domain {
 	union {
 		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s1_cfg		s1_cfg;
+		struct arm_smmu_ctx_desc_cfg	cd_table;
 		};
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
-- 
2.41.0.585.gd2178a4bd4-goog

