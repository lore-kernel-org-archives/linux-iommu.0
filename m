Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFF8476
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 16:34:12 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5618857518dso64571717b3.2
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994052; x=1691598852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SX+2RilXbghvKGSDcU4l4pSTUg8nkB5V07mKjGHD9zU=;
        b=m5N8z0r21Dzz3Syd0qnpDwlI7ZnyANKQkgLec3a5KAlrOA5uzglKADwMlP/VVeAEmX
         cTchFEw4z1pOUhzrEchB2Jo71NUHyRlo/CbU44FjOvAc67/iYiuOzSvo0RJunPdXhX37
         TE5i5LlaeWWKND+ssw/n0S4T3/7bRhgsfC+nRk9xAo4ENuqNsvDYEJocJgiB20JY8Ugq
         49Lg1UlvYQbv2J7ZGDG5mBgTfMJ10Eh6MUHbjbjryKz8qVB30GvfBrGzroZsvM88vw6M
         d8cz9ce3mw6D1soKMEQnovtuUMv6lf0QsRM/Bu98r4JuJtP0+vNNTXtKBA8S7MPtoyLH
         uc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994052; x=1691598852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX+2RilXbghvKGSDcU4l4pSTUg8nkB5V07mKjGHD9zU=;
        b=hsMngcMSxSU3B4cNDuz/6hc1keLgbY2F7lAYzbqzh4oa9gBk8ddVAO9ThE9PNBdJh7
         Zb/usMtAZrb/4YQf00/IuucUBnBPObiuHvseiydkajmh7pj/oDPyWQuoXzIa4c9/uQuT
         vRENwr+IGRLNN//Dtbd8xQHPrTjMTemiJmYMIdcaTJD3vx4xOw5ZFrBOP3a7rvnCDFW7
         t07JbN+uSs3jxGLj+SRumHpy0AwoHS84le9VW2sGfmH3cWGK6UhKQqQcXwG3Zx8GMq0c
         kv6/cmQoEYxStyt3I0K/NOziiUNptcIyeT5jKhMqXO5j9IAvZK8pmkGXyHcw2QwSAd2Z
         /ldA==
X-Gm-Message-State: ABy/qLZBd3gSneJEpF8VSE0jekXhP2CLQhQ9rLSqRgQ8l5ocfk7hQbpq
	GpPRLsIR7mxjSIfnW21sjhgkzWqq2GrfMwHS/V9BFT2o2F+sAGlb4PKbMH5YpGriMLhKfjV4MuE
	tH8zIF/FQTxzMRhZfV0TyA0Pv/ua8qo+7qoM051UK8J9L118Hs5Go23CLSQjXPcQ=
X-Google-Smtp-Source: APBJJlH+p33kyoFFDof3hVEcZBsvq//wMVZT//zNeOrqEMZM0ygVocCT4AvqB+44uOX7f+sfkJFHZDM7OKl4
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:af0e:0:b0:579:fa4c:1f22 with SMTP id
 n14-20020a81af0e000000b00579fa4c1f22mr137586ywh.6.1690994051697; Wed, 02 Aug
 2023 09:34:11 -0700 (PDT)
Date: Thu,  3 Aug 2023 00:32:36 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Subject: [PATCH v4 8/8] iommu/arm-smmu-v3: Rename cdcfg to cd_table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

cdcfg is a confusing name, especially given other variables with the cfg
suffix in this driver. cd_table more clearly describes what is being
operated on.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v3)

Changes in v3:
- Commit message update

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++-----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 00b602ae9636..61de66d17a5d 100644
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
2.41.0.585.gd2178a4bd4-goog

