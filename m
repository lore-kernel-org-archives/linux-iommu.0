Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5A944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:17 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d745094c496so4896678276.1
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701897; x=1693306697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=058zW3MOZIvxq/mgODQOiyKY2M7mNXQxp9+nR9ONw0Q=;
        b=fJQQCLTK+LuIKAHVqnRUz38pOLWkq9vaA/vSY9bE8tyxD9XAyHRa0/chr4eUDiojzE
         33B4LRLYBQdIDC3LmZmkDG1pcDU6UCCB/tiCh7nvDCHwakcMX/xdwgY1alpjaUVKivPZ
         I0ZUCkMGj4wTY/9t5EMbAN69spK+piVV2nsAfWLR3KzMl2CwMXBs+dZMfu6pxEor9oDv
         KyWK2YBKLQICWCdbJ7YkpTyVRJRspgEZ8GmcmUZzyHP+Fq/yyjSyZcx3vtzZczL2jjKK
         TrK60bTUlLEw9YzL4uDBIV5Nhyge5RzMcrSpMvAd/uEcac3KjKw7D6HnK0m674xVEtOp
         7iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701897; x=1693306697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=058zW3MOZIvxq/mgODQOiyKY2M7mNXQxp9+nR9ONw0Q=;
        b=EwK8gNX7ZA4/ue+pLnB7zDOT/ZhxTdM8C2NMtoRR3bQgTaWTRsYgYxuFsIDRc38gGp
         pVr71jp6RP8Q0YPsHqlPIlluw/TMiz5IeDbxT1n8EyLCjCiMWLy2S0yQZKL4PvvZstMt
         XqDHhMT8CylqZlImFPoil5REmSmQ2yV1EkNvFvTuwUtwM/+PrbPxxjJDqhi5rqHczhoJ
         CSs+dbs2ftyyN05p33hzqUGxWIgu5qyWWK7lJ+civdxftoYpKxe6/mLB/Fwi9tL5hjDl
         dREOZCivsp9g80RtRg0SaS4mu0d999iN/tlwceBm0NmDpy1gNUNiRqHRhan8DqRk+MrT
         YJgg==
X-Gm-Message-State: AOJu0Yy1puxC5QaCQNIlQVvBjuXMaWZ1MxXm+hzhjKutV19N95PamRdK
	wkqUeTTA3PDCXLFlMjFU15omFafieggqlTyLBdzNy9d9BXFR0BkVoMZz8TrxNK/2UhtknMta6Vr
	JbVug4SRT57NfgOdF4wPUJkBFv7WKPQNKY25PqyBBt5z13tMfSP2jRrcJCKXBboI=
X-Google-Smtp-Source: AGHT+IHIKqF9VBejqCdz69o9Z+MqzhDnO89Uie4GHPeRpguVq2z8h+BipHm6eAM5P0OGBfj4WYuHrcJO+NHT
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a25:81c5:0:b0:d63:8364:328 with SMTP id
 n5-20020a2581c5000000b00d6383640328mr77169ybm.5.1692701896632; Tue, 22 Aug
 2023 03:58:16 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:57:03 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.7.Ia591869e7a4b88af16a57e09c92df21599d3312c@changeid>
Subject: [RFC PATCH v2 7/9] iommu/arm-smmu-v3: Add arm_smmu_device as a
 parameter to domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org, 
	will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
	Michael Shavit <mshavit@google.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Remove the usage of arm_smmu_domain->smmu in arm_smmu_domain_finalise as
it will be removed in a subsequent commit.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2f305037b9250..7c9897702bcde 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2150,11 +2150,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2187,10 +2187,10 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
@@ -2245,16 +2245,17 @@ static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_device *smmu)
 {
 	int ret;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_device *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
@@ -2293,7 +2294,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, smmu, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2565,7 +2566,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, smmu);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu ||
-- 
2.42.0.rc1.204.g551eb34607-goog

