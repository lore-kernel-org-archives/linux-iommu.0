Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB32714D
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 18:28:10 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-583c1903ad3so12806187b3.2
        for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482490; x=1691087290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgcyt5y/dNvgYr+I59gSYy8uZYCuHE8SsbBE8BLO/+A=;
        b=3Nrdg64Jp1Fk4+nsJ0e3mF4mpowW2zPYwgPa0etM70umfyC0gsTNVkY2wf8iVAAS9r
         1jfsWxRhBQA7aAuwQ0oPo0tyw0/Pquj6BleF32/uNyvXiT/YkRb024F74kARcgT6fOhO
         XTgXos9JH1HTTTOv9/OLLVlCZMJ9briI5qCVps0NKukAIGrkJzhPMif8WOJjeBSAPF35
         JEh5p21egjNVgkPcN27u80Vcg49zX5i3zRxdjOYVRpNEjZFdzEug6fPwkUew8yMtdo5O
         /9q7sVIDTbtvU1/tSwUDyvdelwtvnfsn8SrVcFIVKRrOZx1TAQ5nyLT9BjL2yoI6vSD0
         xatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482490; x=1691087290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgcyt5y/dNvgYr+I59gSYy8uZYCuHE8SsbBE8BLO/+A=;
        b=aMYpjo+jAisf/x9rSrr/YLmFRNfTkzzZuc1ngWDdtAnHpixVZnyoGN5ZZ2SR+f9+ee
         vgmSrb3KVUO/kPh5faxfRDJ5NForTswSiefH5IZRwyGPk8mXg58/FuJEbYZt4TzwNJHz
         DGg8JnbPYUeELlS59FtctbFHod+LlYysOmJkbkmvyBnIdTJxWRE4pn9NPzlNJYiuPtaQ
         nR1n1+/RWkZGs0MFnkDsIfw5J3oDTf/jUNQyoTpx4gzhrqo+D8fN6yR//Q3lXtdlCkHS
         iKLwbkNBzuCeV22YibnCZ44TryszVE+eAVSC8OhxGG2nHj+oYgOBwmHXv+SCv3W1oHLY
         hYiw==
X-Gm-Message-State: ABy/qLZqK6H5kUoFsTS0B9k8PCVgDaadj0AzxAJcxTGnpVxZ2xQxGoF4
	9brOn5wtARJOv0vxpP5OdKHGcQ6UlfOt
X-Google-Smtp-Source: APBJJlGsJYf4ifb2rmxcjNl/8iF8h9GDIBgUTiYwC6EAO5C4iTqLG6JvLObD622nsvv4kmkQHDN+B+D7ZlF9
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a05:6902:10ce:b0:d0a:86fc:536c with SMTP
 id w14-20020a05690210ce00b00d0a86fc536cmr1213ybu.2.1690482489899; Thu, 27 Jul
 2023 11:28:09 -0700 (PDT)
Date: Fri, 28 Jul 2023 02:26:17 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-2-mshavit@google.com>
Subject: [PATCH v1 1/7] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

s1_cfg describes the CD table that is inserted into an SMMU's STEs. It's
weird for s1_cfg to also own ctx_desc which describes a CD that is
inserted into that table. It is more appropriate for arm_smmu_domain to
own ctx_desc.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 23 +++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 28 ++++++++++---------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947eb..968559d625c40 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -62,7 +62,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 		return cd;
 	}
 
-	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu_domain = container_of(cd, struct arm_smmu_domain, cd);
 	smmu = smmu_domain->smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc35056019..bb277ff86f65f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1869,7 +1869,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -1957,7 +1957,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2088,7 +2088,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-		arm_smmu_free_asid(&cfg->cd);
+		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2107,13 +2107,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	refcount_set(&cfg->cd.refs, 1);
+	refcount_set(&cd->refs, 1);
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
 	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, &cfg->cd,
+	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
@@ -2126,23 +2127,23 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_free_asid;
 
-	cfg->cd.asid	= (u16)asid;
-	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-	cfg->cd.tcr	= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
+	cd->asid	= (u16)asid;
+	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() before
 	 * the master has been added to the devices list for this domain.
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2152,7 +2153,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_free_asid(&cfg->cd);
+	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e2..5347be54584bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,7 +599,6 @@ struct arm_smmu_ctx_desc_cfg {
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
 };
@@ -715,25 +714,28 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct arm_smmu_device			*smmu;
+	struct mutex				init_mutex; /* Protects smmu pointer */
 
-	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
-	atomic_t			nr_ats_masters;
+	struct io_pgtable_ops			*pgtbl_ops;
+	bool					stall_enabled;
+	atomic_t				nr_ats_masters;
 
-	enum arm_smmu_domain_stage	stage;
+	enum arm_smmu_domain_stage		stage;
 	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct {
+		struct arm_smmu_ctx_desc	cd;
+		struct arm_smmu_s1_cfg		s1_cfg;
+		};
+		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
-	struct iommu_domain		domain;
+	struct iommu_domain			domain;
 
-	struct list_head		devices;
-	spinlock_t			devices_lock;
+	struct list_head			devices;
+	spinlock_t				devices_lock;
 
-	struct list_head		mmu_notifiers;
+	struct list_head			mmu_notifiers;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-- 
2.41.0.585.gd2178a4bd4-goog

