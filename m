Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5B101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:43:43 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-bc502a721b1so1707617276.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757423; x=1689349423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vic1ayWBGr79y9f6y1FKqdm9/OskuVUCQ3Tr10KopQ=;
        b=qhhtV69WKH2JluNtYemjQLj4d4hfClGTE//m6T+O7FE46Wo3W/vrmENSH/WtXfrT48
         8a5S07rhQ59AKc8+BgfzUy5Bj2swQlHUnRk3ucu69XFSSsZ+AomWUEn1sB396DApLgAe
         0adprdBEbSVUxQQfd4dT6RDzrQc6KTQN6bsgOYjw9CUc9dhFHYC2qWnzn+HRn1UPA9aH
         kjf90LWp0yxILw0IiPJOuiriOeSoOMmi9XkZKcrRXV97WwWsR1pNdEew2aR6B2qrQLUm
         3F+WX1+FcFiI+9BtyS27Rf8odZ0hD84gSWCl+MLkesx9GDJcjrjG+T0HGly7ZGRIuVWx
         6KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757423; x=1689349423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vic1ayWBGr79y9f6y1FKqdm9/OskuVUCQ3Tr10KopQ=;
        b=TYa1CZNf8KR3guGEJhankOwYnWd9FFnoCYFnmXjdhsDwSweRWpHgQtefp+PJlE24Uj
         xSivt1TjHoMLp2bEPKofxSDQeKKGks0tcAmO/CSnumBjpn/j6Y21LLccUm/vxlj55L6V
         Icfl8dpVMwfqWi/TSOLyww6g84KW7JaKx/wF7of0x5A/EHMUSGcKjsLkMTcRUaz3a3he
         KdItI9dunC5Lo335ucy2wE05LXCP/wAIW7Nosn6+hsTmuvaM6zi2zGrcGE2I0ifg4M3e
         pXuPotAECWBTQt/J4a60b+NE++e5cAA1v3ek1xHzUXUKatf3IlqGmD0kfTovr+VWUZ3+
         K+DA==
X-Gm-Message-State: AC+VfDyACF20IvY3Dpq1LcK4iDEL1C3yykxHpKJcyCyN+3XIZUaDZEuI
	2bOqCafW2EI3UrQvMY/5pPHFCf7DebmC
X-Google-Smtp-Source: ACHHUZ7dqpkyX9QIV+ua1DgHJ+4Gpjcw5QzgmZIv8lQZIXKZNkPkBQS62jzmn2be9tvs4Kd2TECXDYFsL+z8
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:e6c4:0:b0:bc7:f6af:8cfe with SMTP id
 d187-20020a25e6c4000000b00bc7f6af8cfemr880044ybh.4.1686757422932; Wed, 14 Jun
 2023 08:43:42 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:41:54 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-3-mshavit@google.com>
Subject: [PATCH v3 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Except for Nested domains, arm_smmu_master will own the STEs that are
inserted into the arm_smmu_device's STE table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index beff04b897718..023769f5ca79a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1126,15 +1126,16 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_init_s1_cfg(struct arm_smmu_master *master,
+				struct arm_smmu_s1_cfg *cfg)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
+	cfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -1175,12 +1176,11 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cdcfg)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -2076,7 +2076,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
+			arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2108,11 +2108,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cfg->s1cdmax = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_init_s1_cfg(master, cfg);
 	if (ret)
 		goto out_free_asid;
 
@@ -2140,7 +2138,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	return 0;
 
 out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
+	arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 out_free_asid:
 	arm_smmu_free_asid(cd);
 out_unlock:
@@ -2704,6 +2702,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	ret = arm_smmu_init_s1_cfg(master, &master->owned_s1_cfg);
+	if (ret) {
+		arm_smmu_disable_pasid(master);
+		arm_smmu_remove_master(master);
+		goto err_free_master;
+	}
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2719,6 +2724,7 @@ static void arm_smmu_release_device(struct device *dev)
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
+	arm_smmu_free_cd_tables(master->smmu, &master->owned_s1_cfg.cdcfg);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	kfree(master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 68d519f21dbd8..053cc14c23969 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -688,6 +688,7 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_s1_cfg		owned_s1_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
-- 
2.41.0.162.gfafddb0af9-goog

