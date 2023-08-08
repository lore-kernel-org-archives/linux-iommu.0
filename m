Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A91401A
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:15:10 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58440eb872aso76518277b3.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514910; x=1692119710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kAnQzEdZvwUszc/Yra8uu5YltC92ywc9EvJ8VT09LQ=;
        b=oI/dqHd30VJau7uUvo843Y9Abtz75Eci2/yr/d2MWGmRYaIF60x7Uo8BVsyA5UL+iv
         GvrSQZ+d3MFahwdi8bnSc7+Cqzxr8iZVBy9h3GD7ChJD4fZ9psjBnVnh8ZaD2d4JxO86
         x2QdqEYrZlm7bmKtB3dYzVaFtxnwPYQqpiREwDBE0j4CZ5Icp3P4hEdeYq+ZNurZstpC
         4LjRrQtNw09UPeWPtfpPMjMyKmATqeiI0IDLi61Iu8/xVs1eqr7TtVKOIICwnVElUlp1
         E7cCzyG/1JPWqrB1Rsnf61nL0pVh8Oajux04XTUcsEVJKFLrOxAD3BBXDRzWBxicH0AI
         kApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514910; x=1692119710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kAnQzEdZvwUszc/Yra8uu5YltC92ywc9EvJ8VT09LQ=;
        b=AxHzVUyonKvJoeKJI7T9BfIxvJ68cT2zFElTYfDm0XaU6vX8s6KeLVBidyXXUBl3kk
         TbvVp3vfB5dzIxOtlBgdxwSOnW4ltWO5erHe1mVDz3vFEoJIgIpcmlvi+LVoZBRCo713
         SaUQkxLrgAgQf7kgx1ZBkHMn6rtsR+/Mb2RWVWdzIvUtZu7G1wIdj54EvJJs/CNb35Kx
         h3xZjO9KP38fRx5ecKxxAPfPj5YQE4aILysxYeqbrLeTciarXhOLqEzrh+P+ZqXCj8W1
         0sorsYBXy5P0YouRlH46Z+6wFBM9Qz6Q3Q5nciGU8aLw9nNKnVPTvK5QiKL5RSXvqc1m
         syFQ==
X-Gm-Message-State: AOJu0YyXglJgFem+Nx9rQCGCOMPh+TwMVIhEfDgwIQJIL/ysLmI8ktL1
	0Ep8tg2TM4uu5MDD6NZdFoQqvV9O4frYaNsbBIxJMm016KXiWNLxKXnTnQIs3HWwVn0AZKtQXYB
	YIZJ6lQMNmmTeOhGvmQXdrRahZmZKkxaU/zG2UYj5mLiodAZSIgdksT6ZcxmTCUE=
X-Google-Smtp-Source: AGHT+IEMJeatprXvebM/DOZlLv0j3Dy4OuBMcAUr1GM1vtFLgnUQJaRUOVv2HdwNOFyJeYZpSyEmJg4bow4Z
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1345:b0:d5d:6bfe:76d6 with SMTP
 id g5-20020a056902134500b00d5d6bfe76d6mr3195ybu.8.1691514909886; Tue, 08 Aug
 2023 10:15:09 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:11:59 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v5 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ded613aedbb04..fe4b19c3b8dee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1132,7 +1132,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
@@ -1140,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2107,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.640.ga95def55d0-goog

