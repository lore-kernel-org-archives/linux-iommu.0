Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC4101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:21:30 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58c8b2d6784so27252177b3.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784090; x=1695388890; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJc+j08yY490Vv/eC62RVS7PByOeYuEaCKVM2vlNjBk=;
        b=YYniyfxHjMKVYk11hew6CzOdKEir+xgA7SYdLCfO1USpwtJuj4rd05nIpadfhCgJq3
         gI2kJ0Y2aB1gFMUtFIR5tlCAwJQVvbd91LhhziM+oqDUyEY8+l6p8R0Ky9yBSswm71jV
         JhGQZMsZXWyssuJEYgX2+2qdT9CFoS9JwJNeyStwjLafczBqzyec3L3UKLpKH3wYlJMV
         e86URfLXFuC9Z5zPIWu2sNtwI2UIrVGgShkHwE2aelBv8mYIaEtk8V1DwVFxCnNL5wEC
         3I0YJvha8+LLYqBBLZolwE0CdNRi/n8kO9Y0uVXFZdxDCtb6xPfvV09WJ2wqezMt8rqY
         lcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784090; x=1695388890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJc+j08yY490Vv/eC62RVS7PByOeYuEaCKVM2vlNjBk=;
        b=XOvaRD6LNFMGrZZdFNNrAbBCVEhrODSfgd00iaR91puo7+AfYE98WN3IAPr9ZLNUmR
         SY0b3Ol8lv+L650pkOOMagUScMztnGVsY0b67rlJ1Dvs1NwrJooSdeX1X/GJo/oYWLhn
         s1jpkw4j7gM9I6v7zITpuRKEXs6kO7WWP3WxK1TERRNkN6wqek+6Jvr4o+p4BeX98Jhq
         oEwrz9+G46cS1lEO49+7bedf4eH8X7duhX3WvjzBYi2UYpRqbZ7F+hCuBm0fKFcT2gG6
         mzrKzY4g92wJi0zarYw526fZ43LqjVBdo+57yjkvCD/2wq98Ktj/f0e1nDfcbJrNilv/
         dVEA==
X-Gm-Message-State: AOJu0YyLttTPjfgjEVDe2cCmqrmEa1vYD0XYwUAGpmS0Km92wjrAEzRY
	jiRBIa5QHz8kHhmRHVM1o+BMmaeQ+NJXgb1jWNWOd8zpj3LubAEGuQBn4jHDBvXF0HfbE8EAPBw
	Yp2CKSK5Pch7hPluW+KUQTt+AeYT7FjxZXB9QnVoWEPpT8PNJwV4ZdKvdNGK3Yos=
X-Google-Smtp-Source: AGHT+IEuJ5KcwfdedexvLlz7riXbSm41Db7pn05pdZl1N5uV4Svr00phOyLnhZeuePRuFFcvJm2feFAxCAND
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a5b:b03:0:b0:d81:6927:d806 with SMTP id
 z3-20020a5b0b03000000b00d816927d806mr35071ybp.0.1694784089726; Fri, 15 Sep
 2023 06:21:29 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:38 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v8 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
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
index 25ce62d25732c..f9bfa2c8ab1e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2072,7 +2072,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2110,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2137,8 +2135,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2146,7 +2143,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2198,7 +2194,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2408,7 +2404,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.459.ge4e396fd5e-goog

