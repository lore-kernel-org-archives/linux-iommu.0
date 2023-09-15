Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CE101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:21:07 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-59beea5ce93so32555467b3.0
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784066; x=1695388866; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EU1Si1F7aTAo9xp++d4lKHIxYUyhJxgoV5nScBXhwgg=;
        b=bprX1QT5Uu4thv2YPg1pgndKGDsl5MsHavhEFxSOe08s74khCOAfmRNWMxiAg787nq
         +NjQO6OFYmzhSAHmj0aw9HmQZ5cD1uhF29uo5LAOBaEpriwe4GmkzzpOecmMMx9XpjKR
         o0WjGGZylJw//PYCMvfpwBwbKsFfAA+i9+AQYQymPYGWD4GWuf6cvDEQLejfCNOf8ZMl
         y+E4NOEjpy10uEQvHj6sjYFUfEXKcQIdZAtL1Jo//UwcIFEM7uSP1B5f3yu/eA7j/oFE
         uB8Z9eUVSDBrsGs0EQJ63dRzTCLDGlXHuGgn3Xmk445lQH+BLoPbgBE/6mQpDT3jcK3f
         TpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784066; x=1695388866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU1Si1F7aTAo9xp++d4lKHIxYUyhJxgoV5nScBXhwgg=;
        b=dnmWh5sSD3JdGAilhcva2GrHUv83LqgARioDcbSfTwlWgxxco6k4D8Kq83RNqJNeCq
         Ywk0bmbvhx+79YGGhe+o3aEw8av/LbaLvnIAWC7DLrOIzSphaoSoloqGMirmlrq1cfCa
         PMlGcRJrUN+K8iC9sWaiT49BdrPoQQ4CKCMMa+w5fyEaSnWQeD7wMLdCG76DmTRmbIyY
         DMpTYjGwSgYboWFgmMpVYLzp32UojUICEiR7RP0TZZkGs6F2o3S4ACvu5X//TtciChXq
         vp193v0oS9sJA/wIjQOcXUu/oKSPGiV2uNj904FidczeQqZcoz4L4RVzy3dMJtLTReQt
         y5nQ==
X-Gm-Message-State: AOJu0Yx9OCAdczka5hm8PLBHay/Gl6Xg0qGFj9MgHkslRsTqdTnEppan
	S8XXMix44B3eHNZvepDSv5eBcSKla8yK3ERlmyRh3oawAte8cSc3wEWYo00MRp5Sjlxf43axiI9
	2fuI/DKNJISaidaJDNWowTVqw2orzUOgQcQv++6MxSoxp4dwNrfbTkdEh5tG3/Uw=
X-Google-Smtp-Source: AGHT+IGl4lWmgSHSxliQgwDDUHKpMbPC1ZDQaVK+zljg1T6tRKX9I0v7K5wZOW3hYZnhWdgE9r+fCt3XQkUk
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a05:690c:2c07:b0:595:7304:68e5 with SMTP
 id eo7-20020a05690c2c0700b00595730468e5mr131784ywb.0.1694784066369; Fri, 15
 Sep 2023 06:21:06 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:33 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
Subject: [PATCH v8 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org, 
	robin.murphy@arm.com, will@kernel.org, Michael Shavit <mshavit@google.com>, 
	Alistair Popple <apopple@nvidia.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Tomas Krcka <krckatom@amazon.de>
Content-Type: text/plain; charset="UTF-8"

Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
bit of extra information. Move other attributes of the CD table that
were held there into the existing CD table structure, struct
arm_smmu_ctx_desc_cfg, and replace all usages of arm_smmu_s1_cfg with
arm_smmu_ctx_desc_cfg.

For clarity, use the name "cd_table" for the variables pointing to
arm_smmu_ctx_desc_cfg in the new code instead of cdcfg. A later patch
will make this fully consistent.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v6)

Changes in v6:
- Undo removal of s1fmt and renaming of s1cdmax

Changes in v3:
- Updated commit messages again
- Replace more usages of cdcfg with cdtable (lines that were already
  touched by this commit anyways).

Changes in v2:
- Updated commit message

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 ++++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 +---
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6ddc23332a1a8..1ccff6d87edf7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1033,9 +1033,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (cdcfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -1071,7 +1071,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	bool cd_live;
 	__le64 *cdptr;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << smmu_domain->cd_table.s1cdmax)))
 		return -E2BIG;
 
 	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
@@ -1138,19 +1138,18 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	max_contexts = 1 << cfg->s1cdmax;
+	max_contexts = 1 << cdcfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cdcfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
 		cdcfg->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cdcfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
 		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
@@ -1186,7 +1185,7 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1276,7 +1275,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
 	struct arm_smmu_device *smmu = NULL;
-	struct arm_smmu_s1_cfg *s1_cfg = NULL;
+	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
@@ -1294,7 +1293,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
+			cd_table = &smmu_domain->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -1325,7 +1324,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
+	if (!smmu_domain || !(cd_table || s2_cfg)) {
 		if (!smmu_domain && disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
@@ -1344,7 +1343,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		return;
 	}
 
-	if (s1_cfg) {
+	if (cd_table) {
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
@@ -1360,10 +1359,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
-			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
-			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
+			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
+			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
 	}
 
 	if (s2_cfg) {
@@ -2064,11 +2063,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+		struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
+		if (cd_table->cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -2088,7 +2087,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2101,7 +2100,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cfg->s1cdmax = master->ssid_bits;
+	cd_table->s1cdmax = master->ssid_bits;
 
 	smmu_domain->stall_enabled = master->stall_enabled;
 
@@ -2441,7 +2440,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		   master->ssid_bits != smmu_domain->cd_table.s1cdmax) {
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9389780db1f34..def1de62a59c6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -595,11 +595,8 @@ struct arm_smmu_ctx_desc_cfg {
 	dma_addr_t			cdtab_dma;
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
-};
-
-struct arm_smmu_s1_cfg {
-	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	u8				s1fmt;
+	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
 };
 
@@ -725,7 +722,7 @@ struct arm_smmu_domain {
 	union {
 		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s1_cfg		s1_cfg;
+		struct arm_smmu_ctx_desc_cfg	cd_table;
 		};
 		struct arm_smmu_s2_cfg	s2_cfg;
 	};
-- 
2.42.0.459.ge4e396fd5e-goog

