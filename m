Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A9FC33CBA
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA6F206D7
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLGOfJVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA6F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3022220528;
	Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3hBLvd1PSJD; Wed, 15 Jan 2020 12:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E0F6020523;
	Wed, 15 Jan 2020 12:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94DDC1D8B;
	Wed, 15 Jan 2020 12:53:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52D6FC1D8D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3891586C6D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbUr6nj8FkW4 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 92A4A865B8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:40 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id w5so4684968wmi.1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aAEmHGx6wUcbVA8TAXO2nZZ/b1/Tw4Vck92vCLfbzvg=;
 b=JLGOfJVfCZ44waAp9ES2XMnJ00bXfA3EYiUqq8kLa3OCpmxQw3AhflUZtVHLNfWyqU
 CDp8y73t1hrgePdaY1+LeQ1dZdrkCJASSVzij6xuzoT/eulPGnUBV3KrI45xXZI9f/iY
 mPB4Ydz9bhzcOtKbnFZXbTEPCXeos6oRaFO8WnS7aOHwV8QCeC+VkfOfRMUhJjxn+X2d
 PpaziJD94oQVA9V+1bt22VHuHVo3tS/ieruh+y1Gt7Bj+ddjfT8FY12nxiPl6cEzpMI8
 cfEwi1VTcm2TrONZumVJ4OKVcrRqQffWfxb+W2jDZQf/uT51qtdiobD5IU/sdeKm5F/L
 Yx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aAEmHGx6wUcbVA8TAXO2nZZ/b1/Tw4Vck92vCLfbzvg=;
 b=ucqKW96Qz3gxQQLDIQd/rMNGrQoLNWm5oKyoXEHIICX6phBHNxcxEL2eFkgt8hjRJP
 pKtn7cF8nVdxFei0jkmF6BZOy8+l3kSmNN3+d3mIXfTfRf4pB7hP0KZDKuGK/YJk7SEQ
 b2Ca3r+9BVnwfMKbJ27+YQgczjH3xZ3nA6lR/5/W9UeOPENvbLwTgBXt32cuH88LoQ8g
 ALFDkF0lESKRL7qPj81thYW4UYub7kUKeH+p4G5m01SLehAccFbg/rw9Zd2iIEhKfIvy
 NsSwnBcThnSnnFmS58s9PJG+o+08ADP2XI3/J3YusgryhwCYo6b8zVOO10eWUMcmy/Z9
 DLUg==
X-Gm-Message-State: APjAAAX6iKNCwA89Z9LogmyEvhvacgB1q1tRXq1/LtACK1sN586bLHv5
 UsQ4GmC2GnjVgqYCwlnDZQbUmQ==
X-Google-Smtp-Source: APXvYqytCcaOrer/7iQIE7Xhu4hBwGK2oRRuiNgcyKJchWET2/i8dI0GqIjnVnNvNNsYxpqPPQ/3Aw==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr34136253wmj.135.1579092819025; 
 Wed, 15 Jan 2020 04:53:39 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:53:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
Subject: [PATCH v5 10/13] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Date: Wed, 15 Jan 2020 13:52:36 +0100
Message-Id: <20200115125239.136759-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
 robh+dt@kernel.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices that support more than 1024 SSIDs now
have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
descriptors (64kB), allocated on demand.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 142 ++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c35863073ab3..04144b39c4ce 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -224,6 +224,7 @@
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
+#define STRTAB_STE_0_S1FMT_64K_L2	2
 #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
 
@@ -263,7 +264,20 @@
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
-/* Context descriptor (stage-1 only) */
+/*
+ * Context descriptors.
+ *
+ * Linear: when less than 1024 SSIDs are supported
+ * 2lvl: at most 1024 L1 entries,
+ *       1024 lazy entries per table.
+ */
+#define CTXDESC_SPLIT			10
+#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
+
+#define CTXDESC_L1_DESC_DWORDS		1
+#define CTXDESC_L1_DESC_V		(1UL << 0)
+#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
+
 #define CTXDESC_CD_DWORDS		8
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
@@ -569,9 +583,15 @@ struct arm_smmu_ctx_desc {
 	u64				mair;
 };
 
+struct arm_smmu_l1_ctx_desc {
+	__le64				*l2ptr;
+	dma_addr_t			l2ptr_dma;
+};
+
 struct arm_smmu_ctx_desc_cfg {
 	__le64				*cdtab;
 	dma_addr_t			cdtab_dma;
+	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
 };
 
@@ -1500,6 +1520,57 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_l1_ctx_desc *l1_desc)
+{
+	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
+
+	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	if (!l1_desc->l2ptr) {
+		dev_warn(smmu->dev,
+			 "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_l1_ctx_desc *l1_desc)
+{
+	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
+		  CTXDESC_L1_DESC_V;
+
+	WRITE_ONCE(*dst, cpu_to_le64(val));
+}
+
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+				   u32 ssid)
+{
+	__le64 *l1ptr;
+	unsigned int idx;
+	struct arm_smmu_l1_ctx_desc *l1_desc;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+
+	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	l1_desc = &cdcfg->l1_desc[idx];
+	if (!l1_desc->l2ptr) {
+		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
+			return NULL;
+
+		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
+		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
+		/* An invalid L1CD can be cached */
+		arm_smmu_sync_cd(smmu_domain, ssid, false);
+	}
+	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1531,9 +1602,15 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	 */
 	u64 val;
 	bool cd_live;
+	__le64 *cdptr;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	__le64 *cdptr = smmu_domain->s1_cfg.cdcfg.cdtab + ssid *
-			CTXDESC_CD_DWORDS;
+
+	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+		return -E2BIG;
+
+	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	if (!cdptr)
+		return -ENOMEM;
 
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
@@ -1589,29 +1666,78 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int ret;
 	size_t l1size;
+	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
-	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+	max_contexts = 1 << cfg->s1cdmax;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
+	    max_contexts <= CTXDESC_L2_ENTRIES) {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cdcfg->num_l1_ents = max_contexts;
+
+		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
+	} else {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
+						  CTXDESC_L2_ENTRIES);
+
+		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
+					      sizeof(*cdcfg->l1_desc),
+					      GFP_KERNEL);
+		if (!cdcfg->l1_desc)
+			return -ENOMEM;
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+	}
 
-	cdcfg->num_l1_ents = 1UL << cfg->s1cdmax;
-	l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
 					   GFP_KERNEL);
 	if (!cdcfg->cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_l1;
 	}
+
 	return 0;
+
+err_free_l1:
+	if (cdcfg->l1_desc) {
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
+	}
+	return ret;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int i;
+	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
-	size_t l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+
+	if (cdcfg->l1_desc) {
+		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
+
+		for (i = 0; i < cdcfg->num_l1_ents; i++) {
+			if (!cdcfg->l1_desc[i].l2ptr)
+				continue;
+
+			dmam_free_coherent(smmu->dev, size,
+					   cdcfg->l1_desc[i].l2ptr,
+					   cdcfg->l1_desc[i].l2ptr_dma);
+		}
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+	} else {
+		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+	}
 
 	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
 	cdcfg->cdtab_dma = 0;
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
