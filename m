Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43841429E
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:15:28 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-56942442eb0so69380867b3.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514927; x=1692119727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHC0KhIFpW5NTjYdIfQpCvuClzcsgZwi0HrA23/4P2Y=;
        b=JvC5MZkolQL3+jANntlSYMOylNcISlimU/y0d4N3dr5wEcjfYYgltrYjhiES7mOl2Y
         Ov/twqwpI1VT7nGpJ10HSecukMP7JjhRsaHzoTuSY1uHllGHq5QV8Dw8VcjFc88LHfCC
         yvqIHBD+L229K+5h3r44DhySpf/5xangjP4KGU7gIWLnEP6tyARGBxNLrJMIGnVEuNVD
         FCnzoPQw6nydn60CxXmNoDtrQ4g4D19DCMYPAeY/N+hStGbwQ6GR2qztXJI3fp3Gq5iA
         1URmWGqiUKNT6EzYQz+0P5dUXpiIABYzrYuZYvbAnw9bFLBRsz++gB5gDsabSg8x1Dg7
         wP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514927; x=1692119727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHC0KhIFpW5NTjYdIfQpCvuClzcsgZwi0HrA23/4P2Y=;
        b=iPGCL+EY4Cc8hM7Xm7clLHuxe/gCIuxsTadDAMmyvbbdR/+BUwCfPAeFouQc7J+fGq
         BDFc82ryrUhIaWYtrclvkwRohZJyU68TsMwVv3T89DsU+8cAFKjqgCtOgrY4nWcU6PU2
         +OsSOiElmlKmfY7MrfhQyblfg3xTL8c6KPVOkzQH4nDFwdjnpwfQzmnBwra96c4psKmD
         BbjggDHgt5anb06ITVUHjl2nm3s4QZP4e6O65CAGvRsJM1aw6iuWgduPvGgzWLQ+bBGQ
         GHB4eMXiFliNIjb20X89+7Hdbho9FAFNDVg420qKdnHUp/50KCotJxDYYbrzqpPfEXt0
         1JAg==
X-Gm-Message-State: AOJu0YxhqqIxTaZaLUOmZXNgKLK/8G733/uuUZeJh2vtjMVRFHxbynfR
	d5zVz0cflTBbgg6K2ARCTFGlkgyQ/ycvLuzHArSgSpchuzYdnWe1bFJSs48IceTB9nsOyqOOnkD
	y7C/9bFcMylAKD/p0z29I0vDczKoc9m3v4GZTx0ti1kN7iWTRErQ2ViNEd8f1BEc=
X-Google-Smtp-Source: AGHT+IG7laxc61w6Ym0eBdUMWuNThcVfKU8hYxqNr7YAQlpUKSbawwC1KUfs2n737hePYJJZMC7AEV8t5FYY
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a25:e70a:0:b0:cb1:918b:d19b with SMTP id
 e10-20020a25e70a000000b00cb1918bd19bmr2934ybh.0.1691514927517; Tue, 08 Aug
 2023 10:15:27 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:12:03 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v5 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused master parameter now that the CD table is allocated
elsewhere.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3f32f9a191a5f..f5ad386cc8760 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2092,7 +2092,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2130,7 +2129,6 @@ static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2155,8 +2153,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2164,7 +2161,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2216,7 +2212,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2428,7 +2424,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.41.0.640.ga95def55d0-goog

