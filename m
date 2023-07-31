Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1811CBD
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 10:49:01 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-583c49018c6so51273567b3.0
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800540; x=1691405340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wCGxdM3vMHiwD5Hqt1d7Th7Pi/IDzxiPCnlsNf6ST4=;
        b=wvipL4WYLuG06Yh5YopeGwe+XP+zY71R/EbIkI2asNYrYY+npiquOLOKtTV2H4wE2V
         EaHCyurHW1OnBNBicb3akuqlgF4MJPoQognV8Zlk2nlY3F68isgainEajrK0YmO8BFKX
         v9uxGx2aUalsMGIWmLEXx77Qt9MTtXIWfIaXsQN9QhUdFKcBkreF2WgktcFBR6IE/uoH
         55LrshvxNW8mBQlz05AGY0+XgdTfXjNZFqKztaF2CceW22NfA18nxf+yKVrkIKH/GwA+
         awt3aG+Mo/+5YJJba+ZkC4K6v8Jqe+YiictB/4pRzc9kXU9nN1RKGk/pvbOiCaLhUeE+
         mn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800540; x=1691405340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wCGxdM3vMHiwD5Hqt1d7Th7Pi/IDzxiPCnlsNf6ST4=;
        b=EavlvqevKF348YpN3IAJoYFqGMMVrElRMnikX/wmh1Mbea6RZYD+Vak8B1oAYtqaec
         PqgX8LsMsvqS0kQwaT7M8XQwzEmJ18Nrbo81o4uy+uQJf+kZb+7MmrFNyYs/HBnoxewG
         K/lSI/SRc8Ro/qHu0Bx0+KsiUhietz8/Q2FjtBsTM+oXk83V/P8nOednDXsjJKLtoauH
         Fde1PTGvn0t+VxS1D/S8rRoLyoRhnmj9KCkV9fFNecPKNqylW/Lytx1C99dSiE3pjbMy
         5Oy7ksFUB1IHQH+jboviFUI76PW4pOTQM1I5tBWwDmVISbuLE8Xtsc7iTTMjTq0GYvRM
         7ScA==
X-Gm-Message-State: ABy/qLbj7IihyjSrvYLXokNHWtmhoNa3DNZ8h5JoZ3zHPJkBQOeLVc6a
	3ADnnGY4YbOBiR8J/AGkZ+OBd5MHST3P41LWTkmid68mwqaSR9YjDmBVgGBcJ9lqqiwfqEn7C3r
	VSycchCVN00Kv1fNpPFdzwWBiT4Fy8TVxjRMvHhebCzXunddZC8Uds75aVLgq1G4=
X-Google-Smtp-Source: APBJJlFQ7Qm2AbHHFTv+59ukHyucVUan8ZyEh930iZGIBXi3F+1k6wJAPucN7Z8mtOU9tmxewSWQWBEKDQ12
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a25:7341:0:b0:d0b:ca14:33fd with SMTP id
 o62-20020a257341000000b00d0bca1433fdmr49423ybc.8.1690800540379; Mon, 31 Jul
 2023 03:49:00 -0700 (PDT)
Date: Mon, 31 Jul 2023 18:48:14 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This controls whether CD entries will have the stall bit set when
writing entries into the table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a286e3838d70..654acf6002bf3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (smmu_domain->cd_table.stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1141,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
@@ -2121,8 +2122,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2461,7 +2460,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
+		   smmu_domain->cd_table.stall_enabled !=
+			   master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 35a93e8858872..05b1f0ee60808 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -597,6 +597,8 @@ struct arm_smmu_ctx_desc_cfg {
 	unsigned int			num_l1_ents;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				max_cds_bits;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -714,7 +716,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.41.0.585.gd2178a4bd4-goog

