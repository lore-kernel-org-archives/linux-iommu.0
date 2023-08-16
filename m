Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E1DF60
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:20:18 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589a45c1b0fso86791997b3.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192018; x=1692796818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULiADrwuuyAPPSdtsv7UOpy5pMPTnatyz8i4B9Dtah0=;
        b=JCPjawwO0fDc/tPWH2pf6+st1doeLj9RMiU38a2Szh2nGo6BdwM2brgtHX+EEcG88b
         n3HS649Cy/5FZ12QfG1g+fGKDBl3KmwDr/WVSW7eEAiKZ4SO2MOUaTWIexFZPcZIIwIC
         HLplCZ5DLfrsuaL9o/S3Z/dOs2uc8niNVFAkqOJLwFYddXBngyPhXV/MUrhZ9/DGhJlo
         qdBQqniK1uYeUYX6kl3R/jUHQdUzuskz4B1yKewKffO53T3ofDWFHNT5Zr7rGpX3KyiF
         hgNYqsRd3jI6jTy7V4jMuKKILWuIV4TUDpmvi1YyNOJ7QvSx0hhIg83PeVxHMTXLz9m0
         3HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192018; x=1692796818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULiADrwuuyAPPSdtsv7UOpy5pMPTnatyz8i4B9Dtah0=;
        b=hbAcroV97H4cgXNRIFtLVAFgT8nnA8VHbDdrn/Z7LVn1iW/G48xc+YMrYUbZaJXPUG
         sXkgAecGbuwPB4DQNcWyDM8n90wr008N/y4guAbY7IypVf2bG2+mUqK5vM7B525riVKr
         +JDyVvGS5Qe933/G/qHJnaGLaDzJSWrSIAsX7WJJcP//wB6OJh++bbRKJ7VTUuqia2KW
         aDueA/IXaYAbZbN1FXHqXYmhIsHQF6gxzlvc49l7p62H3s8duTGX7e4yoaOI8lNPVSly
         +SadgUVHvBntIritrepnGms7tCYiaQMhn5rC+/wkyVM7qxbkXWQFW1vO7yxMknt3q6fy
         Hk/w==
X-Gm-Message-State: AOJu0YxhDnkQYgBlv7mdgCTM1fzhmjNtrn0bdH/UWzYsssXEudSIbx2V
	hIAQsKxUT/HpW+irBI2pLhnnj2KVsi3Ppq9LPO/v38VGg2caDiRGFOBvkEfht89+tNJq65P3Uxg
	+XS/lQg6ijgkhANTdt5wW2dD7xlKx2DyhN/LhsBCwk3GKXv8ozglLqafMDppnK9k=
X-Google-Smtp-Source: AGHT+IFmOt0mY8cA4WSeCxAz4F0m9qQ69xcRa9qrkhLnnEQxW5VsK9pri8S7NNbJFSEhmAJ5tHME784zCo/t
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:b245:0:b0:581:3939:59a2 with SMTP id
 q66-20020a81b245000000b00581393959a2mr24381ywh.3.1692192017627; Wed, 16 Aug
 2023 06:20:17 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:50 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.10.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Subject: [PATCH v6 10/10] iommu/arm-smmu-v3: Rename cdcfg to cd_table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

cdcfg is a confusing name, especially given other variables with the cfg
suffix in this driver. cd_table more clearly describes what is being
operated on.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v3)

Changes in v3:
- Commit message update

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 70 ++++++++++-----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 104b8d6ea5972..b27011b2bec9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1028,18 +1028,18 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	if (cdcfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
-		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
+	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
-	l1_desc = &cdcfg->l1_desc[idx];
+	l1_desc = &cd_table->l1_desc[idx];
 	if (!l1_desc->l2ptr) {
 		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
 			return NULL;
 
-		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
+		l1ptr = cd_table->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
 		arm_smmu_sync_cd(master, ssid, false);
@@ -1134,35 +1134,35 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cdcfg->stall_enabled = master->stall_enabled;
-	cdcfg->s1cdmax = master->ssid_bits;
-	max_contexts = 1 << cdcfg->s1cdmax;
+	cd_table->stall_enabled = master->stall_enabled;
+	cd_table->s1cdmax = master->ssid_bits;
+	max_contexts = 1 << cd_table->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cdcfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
-		cdcfg->num_l1_ents = max_contexts;
+		cd_table->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cd_table->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cdcfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
-		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
+		cd_table->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cd_table->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
-		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
-					      sizeof(*cdcfg->l1_desc),
+		cd_table->l1_desc = devm_kcalloc(smmu->dev, cd_table->num_l1_ents,
+					      sizeof(*cd_table->l1_desc),
 					      GFP_KERNEL);
-		if (!cdcfg->l1_desc)
+		if (!cd_table->l1_desc)
 			return -ENOMEM;
 
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}
 
-	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+	cd_table->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cd_table->cdtab_dma,
 					   GFP_KERNEL);
-	if (!cdcfg->cdtab) {
+	if (!cd_table->cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_l1;
@@ -1171,9 +1171,9 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	return 0;
 
 err_free_l1:
-	if (cdcfg->l1_desc) {
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
+	if (cd_table->l1_desc) {
+		devm_kfree(smmu->dev, cd_table->l1_desc);
+		cd_table->l1_desc = NULL;
 	}
 	return ret;
 }
@@ -1183,30 +1183,30 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	if (cdcfg->l1_desc) {
+	if (cd_table->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-		for (i = 0; i < cdcfg->num_l1_ents; i++) {
-			if (!cdcfg->l1_desc[i].l2ptr)
+		for (i = 0; i < cd_table->num_l1_ents; i++) {
+			if (!cd_table->l1_desc[i].l2ptr)
 				continue;
 
 			dmam_free_coherent(smmu->dev, size,
-					   cdcfg->l1_desc[i].l2ptr,
-					   cdcfg->l1_desc[i].l2ptr_dma);
+					   cd_table->l1_desc[i].l2ptr,
+					   cd_table->l1_desc[i].l2ptr_dma);
 		}
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
+		devm_kfree(smmu->dev, cd_table->l1_desc);
+		cd_table->l1_desc = NULL;
 
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	} else {
-		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}
 
-	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
-	cdcfg->cdtab_dma = 0;
-	cdcfg->cdtab = NULL;
+	dmam_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
+	cd_table->cdtab_dma = 0;
+	cd_table->cdtab = NULL;
 }
 
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
-- 
2.41.0.694.ge786442a9b-goog

