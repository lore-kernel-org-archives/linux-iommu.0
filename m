Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075BFC01
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:20:05 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58cb845f2f2so7026957b3.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192004; x=1692796804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe3w6+O946qsePdEyrZWPsnq8o2zMwaWjfIN0ZcKH7g=;
        b=S5WZxqs5GurMEnLD1F7xsEeJ3tP2Kjuz5EYWQubEoDvUsMOETXpYFnHhpejZcqD7e3
         NnqWI6nvnfYfN6AtL5sITmgzJP+ke6hgMwZB017TfhXOEWXnqIwu0jOz0oQjjGKp4C/T
         a728LmBL2d02Fj0um4QLEXYUWECa7WxmgIfaKyY0mPb0AiODM+afsc/EdvphdxJVgsoP
         2Jd6L/4pY3GLCnuuZysv7bVyLcbRgx6oif+p+eOOIuOzekpKHS6LMiCE4UV4eR0XMejy
         FM6qp9VQKzLIhKN4odMqomAmMv6C3xplAcrPxnnCGvyny0VolV0k96Yqa1QkeZ8/6WY8
         i6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192004; x=1692796804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe3w6+O946qsePdEyrZWPsnq8o2zMwaWjfIN0ZcKH7g=;
        b=GaZW+1lcoePXqZUJNBtaxFjLy1qwD38trjDnbDjNRPWMdrt+c8k3GH3xPShMrQOHWE
         xzxKwNoOMlVyWgvgbOWIXlyJW3PsWCqoO4wlF0yJ8Bv3pjotOvp3egTyJpbHqpeeFnKi
         QlXBoY9oi6a6Ry821LOcCR1nhrxcy5eKFKpPPdIkjLJDd/Ae4SeftbkO1TSsS6px+xiJ
         M+tbiHlZgbedh1YtwgSO2p8VRCGS3ZtJeUBrJmK2TjhFsB7qt1XYqx7fqIr6s5vc4v85
         iaWyaMh6eYvpXCRhmPiFnROelpzq35BFIZkHrJ8HGJZIdxtdHoe73hX6fj5PqnK0stu3
         fOfw==
X-Gm-Message-State: AOJu0YwMI1liMC7ZdQBc33DUkZu7YyHxK79wePld7tpbF9eMtk2657IW
	y4uagy0swxrS1Y8D8Y/ZcC2BaUlAvxWwtTYh/NW3S1ISWTGzjjWC3p9sv/k+7g2oVmL0hfSb5VU
	TC8Pp8lJx8oAN1RR0VueDQK0Lwb5VzvYb1spkB9DamhBCPhVrNQCRqneD4eWUIeU=
X-Google-Smtp-Source: AGHT+IEYlUp8zL7/YW8IE7Aj5eC7FeumYYXwQXcXhER6oHbUSHFFKPGxfH2qQQJIIq2tOTEWY90Zp1X+mIjw
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a25:748e:0:b0:d06:cbd:1f3e with SMTP id
 p136-20020a25748e000000b00d060cbd1f3emr26993ybc.3.1692192004153; Wed, 16 Aug
 2023 06:20:04 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:47 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v6 07/10] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused master parameter now that the CD table is allocated
elsewhere.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8c5e5fcd55713..de87150cd0242 100644
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
@@ -2426,7 +2422,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.41.0.694.ge786442a9b-goog

