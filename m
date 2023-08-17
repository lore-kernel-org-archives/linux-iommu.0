Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A614AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:28 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58d428d4956so1443087b3.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296488; x=1692901288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbN8hteG6YSwFJxRxYYT0MEpu8iWEUW9NUmuxxHFuvs=;
        b=kHPI9Y/2OLIq1IezsOjgaNLACQy/H1IWioiHLWNmq5gIW7AQ8n96Dt9uwuGmtdo+Xs
         8T6sSYEvRYCbSl4H0QH4toDfHzWpldZkjXd6eO9TSSvRJzbAvFL9WnqXakKATWkXpF7L
         x5VQwfO/iHHCHQJt4hs/Sz+MVeeOrRGRMviqGQvHynVjjGKv8UQ+hlveWbMhzsryZpiO
         O1WQ+YU95d40q/OY1CZSAtXurXO/li8py4gk4d5uvnogtRJh5ngzlDRkzJFxuYs+GMgt
         TZyfinteSRzeo8vFPnOTYihjwDSeoMY0Wp8hvJ/EbuoDKdkGYFWlE7zYR/NvzHykDYLX
         /ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296488; x=1692901288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbN8hteG6YSwFJxRxYYT0MEpu8iWEUW9NUmuxxHFuvs=;
        b=QiPCQqz/h7thnX9aI0nTHF3+qiocR4xf4Z2wkKbi262Q9/T27vsTOOfa20mQLiGrDf
         He/D3Qt1D6u6DUND/ApLY9ZgB3QGfLAn3KVyS30TM5RH4l108zttEs0UwwqhODbWUHOS
         BWrxpD8lv1PmWp/JYKhqMxOeYaHOFvzqRG42qBzp60WnDPdTMQKFZZPg+K8l9/Nc+3BR
         qoFij9+6uyfUm6g4xfQgJt5zDObLcORv22hXIdYVVMMi5JGhPkDEiwl6Wvkr9lbVFXZb
         L4NP8y8y2X80UHKjj0NfznQ0fsGgiGgs0dtE1iI6YGQ1rH4UapT3lyWk5spSVEFzZpY+
         7GfQ==
X-Gm-Message-State: AOJu0YxP7dI9Q6fXGe0LFiLm9gZ45+kADGPIWGANBYPbkqJoFj181+EN
	S4NHi6lp9ONkqU5QghsPYPOCuAcYYoJ/zh0JK1qmcyn+eC+oNAVJ1+mx+c51R1O/0L22nDszFWI
	1Y6+ZteXapxgqJ9Ab4NmHu9e+wz1niSkU8cmNru78/cz0iB3N7M1AWvk8PFECwSQ=
X-Google-Smtp-Source: AGHT+IGTAACVuz6ZInq7S1tmwe0PZqsqwSGF8b8sGnN43WrsM/3yciEvcFsY+UaDmtHr5pX+49suRdb9CKv9
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a05:6902:168a:b0:d49:e117:3a17 with SMTP
 id bx10-20020a056902168a00b00d49e1173a17mr6554ybb.4.1692296487005; Thu, 17
 Aug 2023 11:21:27 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:26 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
Subject: [RFC PATCH v1 4/8] iommu/arm-smmu-v3: check smmu compatibility on attach
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Record the domain's pgtbl_cfg when it's being prepared so that it can
later be compared to the features an smmu supports.
Verify a domain's compatibility with the smmu when it's being attached
to a master belong to a different smmu device.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 103 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
 2 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 447af74dbe280..c0943cf3c09ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2195,17 +2195,48 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
+				      enum arm_smmu_domain_stage stage,
+				      struct io_pgtable_cfg *pgtbl_cfg)
+{
+	unsigned long ias, oas;
+
+	switch (stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
+		ias = min_t(unsigned long, ias, VA_BITS);
+		oas = smmu->ias;
+		break;
+	case ARM_SMMU_DOMAIN_NESTED:
+	case ARM_SMMU_DOMAIN_S2:
+		ias = smmu->ias;
+		oas = smmu->oas;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= smmu->pgsize_bitmap,
+		.ias		= ias,
+		.oas		= oas,
+		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
+		.tlb		= &arm_smmu_flush_ops,
+		.iommu_dev	= smmu->dev,
+	};
+	return 0;
+}
+
 static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
-	unsigned long ias, oas;
 	enum io_pgtable_fmt fmt;
-	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_cfg *pgtbl_cfg = &smmu_domain->pgtbl_cfg;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
@@ -2220,16 +2251,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1:
-		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
-		ias = min_t(unsigned long, ias, VA_BITS);
-		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
-		ias = smmu->ias;
-		oas = smmu->oas;
 		fmt = ARM_64_LPAE_S2;
 		finalise_stage_fn = arm_smmu_domain_finalise_s2;
 		break;
@@ -2237,24 +2263,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -EINVAL;
 	}
 
-	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= smmu->pgsize_bitmap,
-		.ias		= ias,
-		.oas		= oas,
-		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
-		.tlb		= &arm_smmu_flush_ops,
-		.iommu_dev	= smmu->dev,
-	};
+	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, pgtbl_cfg);
+	if (ret)
+		return ret;
 
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
+	pgtbl_ops = alloc_io_pgtable_ops(fmt, pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
-	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
+	domain->pgsize_bitmap = pgtbl_cfg->pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << pgtbl_cfg->ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2406,6 +2427,46 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int
+arm_smmu_verify_domain_compatible(struct arm_smmu_device *smmu,
+				  struct arm_smmu_domain *smmu_domain)
+{
+	struct io_pgtable_cfg pgtbl_cfg;
+	int ret;
+
+	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
+		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+			return -EINVAL;
+		if (smmu_domain->s2_cfg.vmid >> smmu->vmid_bits)
+			return -EINVAL;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+			return -EINVAL;
+		if (smmu_domain->cd.asid >> smmu->asid_bits)
+			return -EINVAL;
+	}
+
+	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, &pgtbl_cfg);
+	if (ret)
+		return ret;
+
+	if (smmu_domain->pgtbl_cfg.ias > pgtbl_cfg.ias ||
+	    smmu_domain->pgtbl_cfg.oas > pgtbl_cfg.oas ||
+	    /*
+	     * The supported pgsize_bitmap must be a superset of the domain's
+	     * pgsize_bitmap.
+	     */
+	    (smmu_domain->pgtbl_cfg.pgsize_bitmap ^ pgtbl_cfg.pgsize_bitmap) &
+		    smmu_domain->pgtbl_cfg.pgsize_bitmap ||
+	    smmu_domain->pgtbl_cfg.coherent_walk != pgtbl_cfg.coherent_walk)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void arm_smmu_installed_smmus_remove_device(
 	struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_master *master)
@@ -2449,6 +2510,10 @@ arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
 		}
 	}
 	if (!list_entry_found) {
+		ret = arm_smmu_verify_domain_compatible(smmu, smmu_domain);
+		if (ret)
+			goto unlock;
+
 		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
 		if (!installed_smmu) {
 			ret = -ENOMEM;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2ab23139c796e..143b287be2f8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -9,6 +9,7 @@
 #define _ARM_SMMU_V3_H
 
 #include <linux/bitfield.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
@@ -729,6 +730,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
+	struct io_pgtable_cfg		pgtbl_cfg;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.42.0.rc1.204.g551eb34607-goog

