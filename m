Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0B4DC89
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 18:39:11 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d114bc2057fso6188107276.3
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915151; x=1691519951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAM03TrWnx19tFyGEZeiC8ZPNwQCzRz5upWzC+FfDMU=;
        b=OftJkNgT+x1gVeSK4HnkKJ+94STSUMDUAg2Vgf7gXTOvV4grGHbQnccHEKIEi+teRV
         /1jlGe861Jn0SIju1fW+73XDflU79SsxPIrOEgfC0QNq+7R6U2WJVtnQhMkz0JRkee7c
         ItgX3TTqMKJknHREZYDQhVQQm6AoLp3y9Jqb2a8I+7myGma6tA95WcR71YMA9Bi0VuzU
         RsAOi/P8QsASK1wk6x10xKMPeLc4+1HYfvIXOKExsnpYOMoFXWBVKRjIXFbefsRNwV+l
         oK1T98Hq8oQ7+r71BhTz+4JxRGV8vXRd0buk2frYswCgU4C8w1iKknKRg81wI3Pi3VFd
         43LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915151; x=1691519951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAM03TrWnx19tFyGEZeiC8ZPNwQCzRz5upWzC+FfDMU=;
        b=Wjs8yx39v+OxJEUaDgXvxhfsJwyETj/Ldn08NZK3ZEwGu0YrVAC2JWMTIvaxyUz/Zg
         ZXx32BwZE2/hJDFIGVMViMh6TGXryTzRGKLF1QGJ2UCG5djc9vbwEvS2kYJo2KtbWWtL
         +W9QURMyeHWksAOhimssn16NnyJ0lwRTHRy9GWCbLWTymJ2R/mWPTzZRkelhG4Kr9jk/
         LYAJk4R67Czrgoc+iuO49qOLfmZpmqzRakENayGRUzEGPsP3bMzy3b8R0aqD78bkErvg
         yeeq0K0Y1VqKs2mKMZfp8GahrIcjN/Z/hypZj6sPFGvD0dQG8RvEuSdgYlxA9nHGZXnl
         Q2Hg==
X-Gm-Message-State: ABy/qLaF/Mm2OmyC950dHO66ns+J3WE0MFwnH12uLWeBw6J3fXlb0/4s
	m2gPKILF5w7dcCVQe9mi0khFGJjp/XIbLjcSh5eykzCA9TPkwh09h1z//oW7w93DAzl8XSBZX99
	/ZJ/NXpQd//3pkgo4BJnvTNKSPN+BSrYYOp7xGY4Ur/H2mrmD18NTdbxF8AMj4oU=
X-Google-Smtp-Source: APBJJlELAdnlXVRI73meTrkv0tFhH71JQ7/kij7cS8tztEz4dJhJ4HmsuRl7WLAvqGssIbMBx5is4LmVBjRt
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:7493:0:b0:d09:17f2:d3b0 with SMTP id
 p141-20020a257493000000b00d0917f2d3b0mr94958ybc.9.1690915150758; Tue, 01 Aug
 2023 11:39:10 -0700 (PDT)
Date: Wed,  2 Aug 2023 02:35:21 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v3 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This controls whether CD entries will have the stall bit set when
writing entries into the table.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v2)

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fe4b19c3b8dee..c01023404c26c 100644
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

