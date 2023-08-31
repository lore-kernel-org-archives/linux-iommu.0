Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1F11CB6
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:46:18 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58e4d2b7d16so14055147b3.0
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503978; x=1694108778; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUyVKDl0lhQ7W0ufBBYFd9SmCuZO/76W4U+SUNg412A=;
        b=Fbh6GnDqtkWZSEiidw29WQgaTnezRgyAkXWnKThYSXvzEjFHe3jtbqLNw3IgNAL2D4
         J8ATiGe8FjYX5BXFUBUdzp7uhEfmvDoySSC0Qq+B4b7iyJRSbSsPnfzm3N6Stw9q+u1W
         moWL0EMf4wrdDiII9BqRGgMg7SbSgtbb2fqnqncmC2dZANfuKcAxFApVWeW1GC5vrHNC
         GdEHW34k1WfxXDiPzLq13NZXhp0UpsdYaauJzkVjnqzCzwyUjxaL1oWvZfoAKHq3RF1b
         uVJhsWPlAZCyuYEQ/7aJzmq4QyQZtQUVyqF/IAiozeh5y8bufS0ClsndSywES8H+wUbT
         UvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503978; x=1694108778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUyVKDl0lhQ7W0ufBBYFd9SmCuZO/76W4U+SUNg412A=;
        b=bAji9KvWxSevaKRAzJzN3vkb9gRM4y1Ku6fqkUt67YNtjPVE8N9iO6ufGohfaUjsxm
         CABvu6r+UrYB/9XAvS0dDwAApUTVfIkMHHq7Fx3kWI9G0HBWRMHe3GKnrM2rZuHBqSXc
         Ya9LzWKROdmouEdgCTwTZoDVmjdgljkA8zVA44WjIdJvV+gH2rGBRfNSKT1Q74tf8vhC
         BcF6lxlbFKn/Z+2elC7bEi7myTYatbvSvVp+7FVYAelt/L1Yw/xNQqB25hH6NuevTy3b
         sWmd4P8wdAu1dpXWfC3rFCj5BfqURj0coavM3GIB2RXTrUDEoPuv0Wv2pwWj/i/SrsVn
         oiiw==
X-Gm-Message-State: AOJu0YyyT8zJoUo/6LhxaOWKfTJkkzfIzO5o9ahVEfg6fPHaXZlkQcG1
	gnxyi7Ew7m0OXMGuM0tvvFGW8b7ZlIj7n9wgx/IW7kKoPe8jDWej+8/StFyDIs72k5hFEcwJYUq
	qB/w5s9QsUJ/yyqXNyIn3eXH4QPsb1xBYOeAG+A3TkSjI9nGwAEUlLd9q0XMIm7M=
X-Google-Smtp-Source: AGHT+IEMJF3dc+25Kv4DjBVppSk/8Bx2EoVHGZaHW80P0+xgsookLYMJvqJ8CPuNFyU7AvC8AVo2BLS8XijP
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:ae1f:0:b0:592:7a39:e4b4 with SMTP id
 m31-20020a81ae1f000000b005927a39e4b4mr3028ywh.6.1693503977969; Thu, 31 Aug
 2023 10:46:17 -0700 (PDT)
Date: Fri,  1 Sep 2023 01:44:36 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v7 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused master parameter now that the CD table is allocated
elsewhere.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bcc94a67640d6..8d177ed550054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2090,7 +2090,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2128,7 +2127,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2153,8 +2151,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2162,7 +2159,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2214,7 +2210,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2424,7 +2420,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.283.g2d96d420d3-goog

