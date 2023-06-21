Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634C8834
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:43:57 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-bcef239a9fbso13159720276.1
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329836; x=1689921836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vzESexuWCV4LLT4ZlWlOvb8u8164/HANB5QcSOGct0=;
        b=svmsiobx2Wo1tGVdmspzGY8XKIT2RMMfZsVIGP8+D0VskhD3W00QvnB74yg6w3Znfg
         FF0PHmvC5XVe190m9JDChplAtynZBkJ4zmC/GZXSj4PHFQu9Po+4/dccCy/wbGuWhmxh
         se005ZBXaisFJn7BGyDl48Svnfz+/u/MRUw7ZsoPofZBjic/m2iZTrsM/fqSlADWGFY/
         De6MKp6cEBEd3qxpL6wwFrJQp9hAuRrVmgyq3yIR5w/vn99QHwt8yL/0Jng0DUo0EAV9
         NZlsTatB05xTsImbbonTm96Wvoi3kQc1kObhyM6VDa93ATuNWP6gZ4K7nJlIb1va4fXm
         sPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329836; x=1689921836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vzESexuWCV4LLT4ZlWlOvb8u8164/HANB5QcSOGct0=;
        b=kjDck6JEjlf/LR3M7WY3JOnK8NejM49Gkz6CG9EMAhTUDjkLdyIzuIvRnQS1gSAH3I
         xsR+byvgSVFZx1jC68UDUND6/N/VU7PHedih1sfse9MtonuIZfzZgrISz6i/7sOCxvuO
         L9bDhzFx3P97gD2spMMnwEwrEEnh70Riwe+TK43qVyadD0g5ia3WuMTm+bF7wtozZpDR
         DfDMk5IjawFW+bdzTGsYReA8DfwQX8CvnhhnEvBFGcakJWVXRo6IxiBYNla6s37lQHHt
         KWvWxMbTXtQrfnmXE7oak8zRKy2Uo3BN1XDuuunGM2FU3BHsejDGXyO+gIBaHkFOID4l
         zujg==
X-Gm-Message-State: AC+VfDxgObA7Rz44AYs9b/BCqwXaybwWF9anqpkzVKlaVNqcLks7vgkQ
	3al6vz/yLtNhS98sStWzZKA6walY/bhu
X-Google-Smtp-Source: ACHHUZ5OSHRehe3DXZzs9l8Ry/Fyn0ESmjipNH2+kktnVhz8AkYddX0OFhLKRoI4AmtAbrv6Hza5MotMUTju
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:abee:0:b0:ba8:4ff5:3214 with SMTP id
 v101-20020a25abee000000b00ba84ff53214mr3393703ybi.2.1687329836534; Tue, 20
 Jun 2023 23:43:56 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:17 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-6-mshavit@google.com>
Subject: [PATCH v4 05/13] iommu/arm-smmu-v3: Use the master-owned s1_cfg
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Insert CDs for STAGE_1 domains into a CD table owned by the
arm_smmu_master. Remove the CD table that was owned by arm_smmu_domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 ++++++---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b6f7cf60f8f3d..08f440fe1da6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2065,12 +2065,8 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2082,14 +2078,13 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2102,10 +2097,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = arm_smmu_init_s1_cfg(master, cfg);
-	if (ret)
-		goto out_free_asid;
-
 	cd->asid	= (u16)asid;
 	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
@@ -2117,19 +2108,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	ret = arm_smmu_write_ctx_desc(smmu, cfg,
-				      NULL /*Not attached to a master yet */,
-				      0, cd);
-	if (ret)
-		goto out_free_cd_tables;
-
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
-out_free_asid:
-	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
@@ -2192,7 +2173,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+		finalise_stage_fn = arm_smmu_domain_finalise_cd;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2439,20 +2420,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->smmu != smmu) {
 		ret = -EINVAL;
 		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->s1_cfg.stall_enabled !=
-			   master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		master->s1_cfg = &smmu_domain->s1_cfg;
+		master->s1_cfg = &master->owned_s1_cfg;
+		ret = arm_smmu_write_ctx_desc(
+			smmu,
+			master->s1_cfg, NULL /*Not attached to a master yet */,
+			0, &smmu_domain->cd);
+		if (ret) {
+			master->s1_cfg = NULL;
+			master->domain = NULL;
+			goto out_unlock;
+		}
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
 		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
 		master->s2_cfg = &smmu_domain->s2_cfg;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 00a493442d6f9..dff0fa8345462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -718,10 +718,7 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage		stage;
 	union {
-		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s1_cfg		s1_cfg;
-		};
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
-- 
2.41.0.162.gfafddb0af9-goog

