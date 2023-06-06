Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436C15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:09:33 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-565a33c35b1so89766237b3.0
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053372; x=1688645372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tYLIcPaSiiyZHuB/nJJEFPBa3OnAACeS9baH6iUupo=;
        b=22Yh0QrehWwX8i9ZY6o2wrXkvcH70GK73SeCmuwBZwKKIBgf4Y/t35VFAUZIJ/leF9
         ConLKIZYFWTFR9V/OVafYZ02wvG46i5Vcp14Qf81Xm5C2Hs2dD7L/2ySTOOyN1a8I9os
         4KkwnWaTT0rZuSQh804kQxJBizMU3MoLg1EUBgrAqB0y5FsizZiprrl0hrnBZdZijww+
         D5N9/JQY4pwY47dUeXjE6rWyX9nbabwmJ92YYT9x/UhrcwjJqa7OCH1M1+uppz53YBcW
         j19D9te7IclkE5OlyAyd0o1t6I3Pab7vT1wTIv76Y26ZCgau5H3C7rRmBE3W4ahxmoaC
         L1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053372; x=1688645372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tYLIcPaSiiyZHuB/nJJEFPBa3OnAACeS9baH6iUupo=;
        b=Ect7SGVtM6B502OkJB/IFbOGQwQnENkfntW6MblhiSWO7ScdpAsCuIjPwprW9VAYH+
         lt7D8Xx6jXF3cvKS/JGbJ6+eEYLKKQ3fJwJb7wOhBkGQAZMQkWPk+gCYcLuO4Yw3eY48
         13CLEEon71zm3quBkJq5pm/Uf2+6ialc2B8oZODQa2OKai+GS8bVsowrP7e3XLuJ6iZ4
         171aHW/VE/moa8+rsTNAcveH6XjF3vWbemDlwsEtTpueLPdWI9C9XH432MkO8Fy9HDRr
         DAYlOMsixjnQ7lTtBJE2mBGn1bAWMEqSn64JEMZNFzNUHA+A/snCHni/DTcEYR6lxUgX
         vayA==
X-Gm-Message-State: AC+VfDwMmIRvqUHeyb0aIGrB3giT6r2abt9JEPF18xNdQSeVJNqzguM5
	2l9s/OH7h6wi34nzsfftegiSQTkBQ6S+
X-Google-Smtp-Source: ACHHUZ5p0pzhcVx3L9ve0S1GT3stb9FRLoqqHMUTFR2YglDAkPr5FcqBbOdhuAE/cItzugQg9zWvZoV8vR6i
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:8d4d:0:b0:561:81b:7369 with SMTP id
 w13-20020a818d4d000000b00561081b7369mr949415ywj.8.1686053372788; Tue, 06 Jun
 2023 05:09:32 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:38 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-3-mshavit@google.com>
Subject: [PATCH v2 02/18] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
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
2.41.0.rc0.172.g3f132b7071-goog

