Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5DC3F68F
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534FF24672
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YagIWdxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534FF24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A2DA87F83;
	Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3nq+p7u5a23; Thu, 19 Dec 2019 16:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A105F87F74;
	Thu, 19 Dec 2019 16:31:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DBEC1AE8;
	Thu, 19 Dec 2019 16:31:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9765C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92089886FC
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivg8nTEr9tet for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B268886F5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:20 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id p9so6079594wmc.2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=okmk+BI1MrI+rld+DNPC4brvepklr4RhuiyqBz4opVk=;
 b=YagIWdxnqZEYbzLOTomTEPehf1xvgF5XuPHQGU/XLL30WhRHxWutX4q3ifHo5xAtQ1
 ekOjUoXMXwawwN07pmCLeSmQHh3BBpftBOgfuk1jQfJNEVkDDepZAoBUyU6qgK39HVSS
 ROhucjwLOUUC//YK/84Rf2RDIJr35Louu9n21fsQjq2P3zkmXVwMTVN3VY5FqwvZfuqI
 NrXLHJw45Y2g9Dfxf3y/ofeU9p0tQtP/jQGEOm7Ko1CieRyMN7+I12hmj3EpYpjzb1Fd
 jSTKhUYEeSM3U6DjZwyjwFX6vO/TgkYgJ+nSyQV9u9Z6BOGaVEcOUqsAcd63OVBczCZs
 l/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=okmk+BI1MrI+rld+DNPC4brvepklr4RhuiyqBz4opVk=;
 b=jAawFhrxtotW96BN1Oupj1lbSOhpFjdxqDu3mxjctosMDp8PrshNt+3rsF7XieLKRM
 iHX7EEP2Bo658/eKvHFelewbwtjUeU3E/zFg3bD8fAhVwyc5bd+CQ6ezJ3z5LcFgWt+k
 Jduij4DWGe8+CraJhy5uci8tVCT9a2Vxganm1R+gcRhQ4mfpRVqMlEQccl3idXwFknTX
 Ke3Bx5sroE3PmsoXg9FIx/uXAvs/Z3N841R/u1V2LQmn5kbYaSq9axJj6Bhehc/RDYcE
 MzKnxC91aFALmef/eFyKzRrCbyx0F0Uli6L18zW/CYSRGo+KP81di74usGqQR5Ge2zzf
 oRtA==
X-Gm-Message-State: APjAAAXWnLCY96JN5GYAG9Mwbz7wjWiRdudTcNVAlR9aKNEJiaO3qKde
 ZDObLQINhjQzWCyOh9ccQ1zx8g==
X-Google-Smtp-Source: APXvYqyDpiGAd7nQQ2q/5btqSJSDJTY/kKmqQOHE8h/KWaNgKKEqspPoPutrYt+t26mJAZ1XjmXIYA==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr11282797wmi.107.1576773078800; 
 Thu, 19 Dec 2019 08:31:18 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:17 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 00/13] iommu: Add PASID support to Arm SMMUv3
Date: Thu, 19 Dec 2019 17:30:20 +0100
Message-Id: <20191219163033.2608177-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

Add support for Substream ID and PASIDs to the SMMUv3 driver. Since v3
[1], I added review and tested tags where appropriate and applied the
suggested changes, shown in the diff below. Thanks all!

I'm testing using the zip accelerator on the Hisilicon KunPeng920 and
Zhangfei's uacce module [2]. The full SVA support, which I'll send out
early next year, is available on my branch sva/zip-devel at
https://jpbrucker.net/git/linux/

[1] https://lore.kernel.org/linux-iommu/20191209180514.272727-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org/

Jean-Philippe Brucker (13):
  iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
  ACPI/IORT: Parse SSID property of named component node
  iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
  iommu/arm-smmu-v3: Add context descriptor tables allocators
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Propagate ssid_bits
  iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc()
    failure
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  PCI/ATS: Add PASID stubs
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 467 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 include/linux/pci-ats.h                       |   3 +
 6 files changed, 442 insertions(+), 60 deletions(-)

-- 
Diff since v3:
#diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index cde7af39681c..8e95ecad4c9a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -589,8 +589,10 @@ struct arm_smmu_cd_table {
 };

 struct arm_smmu_s1_cfg {
+	/* Leaf tables or linear table */
 	struct arm_smmu_cd_table	*tables;
 	size_t				num_tables;
+	/* First level tables, when two levels are used */
 	__le64				*l1ptr;
 	dma_addr_t			l1ptr_dma;
 	struct arm_smmu_ctx_desc	cd;
@@ -1561,27 +1563,22 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;

-	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
-		table = &cfg->tables[0];
-		idx = ssid;
-	} else {
-		idx = ssid >> CTXDESC_SPLIT;
-		if (idx >= cfg->num_tables)
-			return NULL;
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cfg->tables[0].ptr + ssid * CTXDESC_CD_DWORDS;

-		table = &cfg->tables[idx];
-		if (!table->ptr) {
-			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
-							 CTXDESC_L2_ENTRIES))
-				return NULL;
+	idx = ssid >> CTXDESC_SPLIT;
+	table = &cfg->tables[idx];
+	if (!table->ptr) {
+		if (arm_smmu_alloc_cd_leaf_table(smmu, table,
+						 CTXDESC_L2_ENTRIES))
+			return NULL;

-			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
-			arm_smmu_write_cd_l1_desc(l1ptr, table);
-			/* An invalid L1CD can be cached */
-			arm_smmu_sync_cd(smmu_domain, ssid, false);
-		}
-		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+		l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
+		arm_smmu_write_cd_l1_desc(l1ptr, table);
+		/* An invalid L1CD can be cached */
+		arm_smmu_sync_cd(smmu_domain, ssid, false);
 	}
+	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
 	return table->ptr + idx * CTXDESC_CD_DWORDS;
 }

@@ -1617,8 +1614,12 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	u64 val;
 	bool cd_live;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	__le64 *cdptr;

+	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+		return -E2BIG;
+
+	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
 	if (!cdptr)
 		return -ENOMEM;

@@ -1640,9 +1641,9 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		cdptr[3] = cpu_to_le64(cd->mair);

 		/*
-		 * STE is live, and the SMMU might fetch this CD at any
-		 * time. Ensure that it observes the rest of the CD before we
-		 * enable it.
+		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * order. Ensure that it observes valid values before reading
+		 * V=1.
 		 */
 		arm_smmu_sync_cd(smmu_domain, ssid, true);

@@ -1706,7 +1707,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	 * Only allocate a leaf table for linear case. With two levels, leaf
 	 * tables are allocated lazily.
 	 */
-	if (!cfg->l1ptr) {
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
 		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
 						   max_contexts);
 		if (ret)
@@ -2657,17 +2658,21 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)

 	features = pci_pasid_features(pdev);
 	if (features < 0)
-		return -ENODEV;
+		return features;

 	num_pasids = pci_max_pasids(pdev);
 	if (num_pasids <= 0)
-		return -ENODEV;
+		return num_pasids;

 	ret = pci_enable_pasid(pdev, features);
-	if (!ret)
-		master->ssid_bits = min_t(u8, ilog2(num_pasids),
-					  master->smmu->ssid_bits);
-	return ret;
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable PASID\n");
+		return ret;
+	}
+
+	master->ssid_bits = min_t(u8, ilog2(num_pasids),
+				  master->smmu->ssid_bits);
+	return 0;
 }

 static void arm_smmu_disable_pasid(struct arm_smmu_master *master)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
