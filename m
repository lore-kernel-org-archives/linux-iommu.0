Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4A101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:21:02 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58f9db8bc1dso28010897b3.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784062; x=1695388862; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zoX4dad73SSUEMoQNn/GrkpIyMQ9J8oEr6LtT7r5eg=;
        b=333yzVAkw76/sY/rGl6hmjo6fQm/aNdeOrMEkT1FBacv6rQj9HU33HmJDHYZhj4CUk
         1X3SsV/GvyFGyinFM+Xe+ghyljVXcUR6p1xqy6PIdjwDbCKXkGRqHUR8QaPYoQ9Wxb8i
         R81t7X625EE+cKUDYFPWRomqO6Je0xG53tLcAzG/X3rrWHRcEl1GfVYEK1hCFGpk5v7O
         2GxQNbtkQWQ596kXv7/g+RXtBHYjftvCC3Jwn9CipY7XbSOAZBXgM7DPdTnbw2GlSdvC
         5eFQuFyRhBbgRyQoeON9AHGQ8G5KpuwLipXXgOzupHqM9Ih0w5b1n5wrPHb3t58zRGXY
         +LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784062; x=1695388862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zoX4dad73SSUEMoQNn/GrkpIyMQ9J8oEr6LtT7r5eg=;
        b=TwXJzJ+aoCTuG8Q/fbjaUH48AwhWMussMUUCRz1uKKTinaewHRrJNRDafAG+t8kNpp
         JM6VOux4IRrFAt7CosSntTALRJWxHOTcO2kXGl/uywZ/FqK8YQaf8GnbCsMd1dtJ0nTH
         Qxq2Z2y9USleQ62BIuv1YoU59m/3nSzzu7RM9PCj8o5Ih4xFcwAvOEZrbj0Vm5DFdHSq
         +0PmXT4R8begGwZ6denO55YwXb440VBuk0caGEt1Bsq4qPfGWm4Thow1A6Z/rg9icG6N
         ERQT5gWedpGtMJwiYhuFFMb2b2U7tYxMcaUYkqNdYBVCPpeXregfv2Y/jmX/Svn2f4/w
         7Kuw==
X-Gm-Message-State: AOJu0YwPcQu8ADqSDuAZjg3Qnn2INR64s4dGzy1vYmwJz/M/4YSdXLou
	JgSBNHzOZJni/G+EkINXorXyjHldKXN/+jPQYTRbcEMmYus5LJ42h9R9Chtn0zB7zmMcs0dLkQB
	c72mUrVtvlqnvGV1W5TUZ2v/jdCOBpj9yg81q6drAwZX5gY/Bp/6CdDTKqKuOVmE=
X-Google-Smtp-Source: AGHT+IE9HUjUCMiwWMf+vuUTlkzmWHLx1XcztFEYD7dW92CVuOpnJlg8f6UpoXvjRvdyW+SyerNKqxSMV8kH
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a25:42cf:0:b0:d80:19e5:76c8 with SMTP id
 p198-20020a2542cf000000b00d8019e576c8mr33447yba.12.1694784061704; Fri, 15 Sep
 2023 06:21:01 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:32 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.1.I67ab103c18d882aedc8a08985af1fba70bca084e@changeid>
Subject: [PATCH v8 1/9] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
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

arm_smmu_s1_cfg (and by extension arm_smmu_domain) owns both a CD table
and the CD inserted into that table's non-pasid CD entry. This limits
arm_smmu_domain's ability to represent non-pasid domains, where multiple
domains need to be inserted into a common CD table. Rather than describing
an STE entry (which may have multiple domains installed into it with
PASID), a domain should describe a single CD entry instead. This is
precisely the role of arm_smmu_ctx_desc. A subsequent commit will also
move the CD table outside of arm_smmu_domain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v8:
- Update "Move ctx_desc out of s1_cfg" commit message to be less vague

Changes in v2:
- Undo over-reaching column alignment change

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 23 ++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 +++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 4d83edc2be994..edb5aaa8cb028 100644
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
index e82bf1c449a35..6ddc23332a1a8 100644
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
@@ -2070,7 +2070,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-		arm_smmu_free_asid(&cfg->cd);
+		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2089,13 +2089,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
@@ -2108,23 +2109,23 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
-	ret = arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, &cfg->cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2134,7 +2135,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_free_asid(&cfg->cd);
+	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9915850dd4dbf..9389780db1f34 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,7 +599,6 @@ struct arm_smmu_ctx_desc_cfg {
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
 };
@@ -724,7 +723,10 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
+		struct {
+		struct arm_smmu_ctx_desc	cd;
+		struct arm_smmu_s1_cfg		s1_cfg;
+		};
 		struct arm_smmu_s2_cfg	s2_cfg;
 	};
 
-- 
2.42.0.459.ge4e396fd5e-goog

