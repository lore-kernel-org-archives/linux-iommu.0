Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB213FEE
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:15:37 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-585f254c41aso69438517b3.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514936; x=1692119736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeLSMOOGvL9cO3G8G5G5v8LLBetvrU+vq+cAagyUyl8=;
        b=njzC62ovLLfM2KxOGhwyeZ8Qka978mzw0kBCsOl1hL2xkVyqyFT2ivyrjY+v4/5KHb
         RaSJFTGmWLuNpAev2OAHSfd+a5jG6kZGOQmRj7m/w1WAT129c9IIEkvP4K3f6ZQd7QTJ
         MPvs4HcDv4e7Hn52LQxS7zlw9T2pFmV5aps0z74KRuQmefy62CCE28TS2jmozF32gIfz
         1A+TDvawajYrLI/KtknfJkDFhA8Qp/XP+zu8Ol76lj/TVXilNH6XTpQeIhqfBJCamaTf
         oLdQ/0LXTgdHc/8cbV0xNZgt7/vgYN9SKl6hgfrkyiXjvVTMTQ9BU+8NFAU96J3WjN4C
         fQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514936; x=1692119736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeLSMOOGvL9cO3G8G5G5v8LLBetvrU+vq+cAagyUyl8=;
        b=lF87ltW0YYGBc9djdVaLRUGa9ugV1hKcSRAs4fCIa9iDuydglYlYQ7VUbyCpzmGhLo
         GM5qvYK5OixnlMBauiE7H2gOziHESFHyPLLszoEWUiZQTHwiD74nzqpcqShyZ7QK45Yw
         oAH2+WRxYODIuYUjqW8pLpmpkktb/iEgH/C7c5nB23qepS6wnNUo5UCbEHX9RzXryIA3
         nMcs2hIvxf9mlCEDL0BGvWLF5EFwGPX93E4KTnG0b0yIOpUwbM1JsXFnYYNyX+T+691h
         yTm6pT2ak9we2Urr6WpQ2H2MxZ/gpnA3J9DUFsQpK5wiBi3z8fjiIfkwQSVP5EFlsNSY
         HXIA==
X-Gm-Message-State: AOJu0Yw+M+eC4PcnqKecyU+HYlUPxa8GzASNATlAMFXT3yaxWIZ4n5mo
	nd86xYUsF49oMihyr6CknPy5D/yVnWz87r7xqWWItdqG1zRa4TkZTDwZzm9OOQA8UykpGc+7CCN
	YPEVinTtahw7Pojh0gnz9OqB2UPJ6521l74E2K38A9dcIiYeWo/5w2Gi4eDg9R+Y=
X-Google-Smtp-Source: AGHT+IEltyUMOjx4CqY3It2Vu3ogrRSkm9aKOByuvAMMav1KZjJ5jW4KHWKVXTd7SskTfZ37E4b6sPNIVOKS
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a81:ac66:0:b0:583:529d:1b9d with SMTP id
 z38-20020a81ac66000000b00583529d1b9dmr4111ywj.5.1691514936613; Tue, 08 Aug
 2023 10:15:36 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:12:05 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.9.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Subject: [PATCH v5 9/9] iommu/arm-smmu-v3: Rename cdcfg to cd_table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++-----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 488d12dd2d4aa..e29e548776c1d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1028,18 +1028,18 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	if (!cdcfg->l1_desc)
-		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
+	if (!cd_table->l1_desc)
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
@@ -1134,33 +1134,33 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cdcfg->stall_enabled = master->stall_enabled;
-	cdcfg->max_cds_bits = master->ssid_bits;
-	max_contexts = 1 << cdcfg->max_cds_bits;
+	cd_table->stall_enabled = master->stall_enabled;
+	cd_table->max_cds_bits = master->ssid_bits;
+	max_contexts = 1 << cd_table->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cdcfg->num_l1_ents = max_contexts;
+		cd_table->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
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
@@ -1169,9 +1169,9 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
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
@@ -1181,30 +1181,30 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
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
2.41.0.640.ga95def55d0-goog

