Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F3154A0
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:14:31 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-585f254c41aso8318397b3.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057671; x=1691662471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLa2HUSCTWFTI0X2o3f102hvfCfHBN0tK5dUlzxCyIc=;
        b=JrADL5V5gPufySULNpViQJq8VZf4i2Xi9kKgG+gXSEq5dl7WHEj4qtvyY5aYJ/snka
         ag0tjYSeDrTtrOo55TkvX4dUyaBWTO/8rEJWaryRrgB9hrPYIY/UrAiiAQscH+CpdcZ7
         DQ2Wdc2MqEkApXTCB9m2SjueAOHUP3diimqz65i+w+h4s360piVZhXHNX+Lrs3KFnOT1
         sIocY3rlUB6yvvUlaFterExViklS0mWbjToJWPt/eKAwyGFKotsSrqTvCbCUPKGJmNQJ
         3Z+ZL9ws4GSgFssy2aycoUfi/sjkBzwy+hCKitkY951Ap4Bl3Ve21XLsG3MtapR+zbfM
         zt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057671; x=1691662471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLa2HUSCTWFTI0X2o3f102hvfCfHBN0tK5dUlzxCyIc=;
        b=P/GMJN2Kr76H3yh4nxqnRkOfoYZ8BerPME5QqlQXBA/HwtZtGqCRZmLL6a0cvEdL15
         lPe1CF1Icz28AEc7Bqa7wLCJd3jVDWc7cbarJ+NiY19Si5doBbxWyrFk1hjQ4nnNdV71
         VxDSqX7JkEjtP0ZdwMIwkob3UX7WeVVsWJsOIQ6GTIHgFfN6m1J448m6I3E5bC9lXf4v
         QO4xRuD7m4PRjoX+AK7rI6MyoDTI4PHmYwIHCU9gOJxm3iJlQOCUzMt5NhotFFZ1vXf3
         JXJpX9/IzFB2st0yGeak8slv9QP5GJYbpoz7GuiQ8e7KOsTutgX4vJCXsgU+pp13w3RC
         G4Lg==
X-Gm-Message-State: ABy/qLYz9NydiUInhl4hm11ee/2s4pWfy7KEqc6Dte8cnX8M9Yq9bcQ5
	RoyZGptPpCxADfnY+8OzRVY5UfChjoCaOCAOd8rZLJcbLzoDVRASp86WPPZRoKOmAIq3497+gE3
	0E9v/pXdV3+a+OQwpSOuGNzAmLsbSdwrU1hF4F4Ppg7x0tkODfSsBECo0LB5bYBY=
X-Google-Smtp-Source: APBJJlH6RK3TEtZXk1xM04qItMlyJrFzxnsOEH42ZDuBzo1V5QaUS9nSNVNbePa1fe9X8ZQRJ7o7+n5wLnH3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:b625:0:b0:586:50cf:e13f with SMTP id
 u37-20020a81b625000000b0058650cfe13fmr100164ywh.1.1691057670282; Thu, 03 Aug
 2023 03:14:30 -0700 (PDT)
Date: Thu,  3 Aug 2023 18:12:26 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v5 6/6] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused master parameter now that the CD table is allocated
elsewhere.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5fd6c4d4f0ae4..db8fd4b3591b5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2129,7 +2129,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2167,7 +2166,6 @@ static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2192,8 +2190,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2201,7 +2198,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2253,7 +2249,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2429,15 +2425,14 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 }
 
 static int arm_smmu_prepare_domain_for_smmu(struct arm_smmu_device *smmu,
-					    struct arm_smmu_domain *smmu_domain,
-					    struct arm_smmu_master *master)
+					    struct arm_smmu_domain *smmu_domain)
 {
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(&smmu_domain->domain, master);
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
@@ -2462,7 +2457,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
 	if (ret)
 		return ret;
 
@@ -2541,7 +2536,7 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
 	if (ret)
 		return ret;
 
-- 
2.41.0.585.gd2178a4bd4-goog

