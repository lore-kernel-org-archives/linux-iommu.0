Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD57AC3F68F
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976AD2465B
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VibxK8E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976AD2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 618341FEED;
	Mon,  9 Dec 2019 18:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hpFglNhD7Zs; Mon,  9 Dec 2019 18:12:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 879CE21F65;
	Mon,  9 Dec 2019 18:12:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76287C1796;
	Mon,  9 Dec 2019 18:12:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B29D1C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99103877AD
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3KEdZoEacxD for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 14286877B4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id p17so300189wmi.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jdXrySEgrRfn+Z3Yzn3toiuPjUb15DophWycH8Ax2iM=;
 b=VibxK8E6UtBa3mBQgrNRNTK2Uy5EViAeROXBoZPkWAJV4yfISCkGICxBo48eLIOqXs
 bGV2zZUhEmFM/xw54TAEvQ/cskYCHlSWqlGKC5caVxRSN2qs3f9kL3LSE0UCpe8xd1mC
 6aCOO+L1vYRFsAm+kApqFs2gSfu5v9IQbfaLlokVl9cFoHtjtp7uwACvN65EJwkGDjuk
 lC1yJl11t5IdjXlA/MdgR461khqpf5lcssK2MIuKnK/YnUetoZ6d55ICNswmZ1Pam3eo
 M5BeNC5VwypX2kYYPk4/2g4I3/75MRHusrqAaPbSLILVqeozuANvUyAurMyuQk6BGOd1
 1QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jdXrySEgrRfn+Z3Yzn3toiuPjUb15DophWycH8Ax2iM=;
 b=Dsn5q5tscDf9DXaFTz6sNlGlrHr1xR7/Jcr0YvqXvm3+/j5OEM8DYeZtKrfJqG/spH
 JnT6Qu3cdNFP0Sap4due6Bfz+OPOaoalrEvpgZPvxodemV/jLJv8JC8SyObQEt32ulUQ
 loYVLugd6Jj6rTajASfLBBGpJSbBzo9g7iKRRH+o83wuAoeXuLzt3vsnX0pRDxz55AhE
 gkK4ng+i/qe2y9KBR/AnOQ+sZmeukTBeG6CnHWMzhWB0Yy/q21vDOW4OoZ4KBohkPdmM
 FVixuMRBIjFzp6FAZKOKAeMFpC/0gFvFnMQO98P4Ebm85s1j2vbyXmgXiliVmuYXlA/u
 VooQ==
X-Gm-Message-State: APjAAAVz3JuDl6holy8ZC1TXKfesPWx1lHFRZtc70/vYBbSQ6YOAWp6V
 pbSGRnXvkrKW4w/cWXhc+ByNYQ==
X-Google-Smtp-Source: APXvYqzKY0Spjw9amk9taywIHmgHfBpVJEx9dYQjLXVyXm/cYRHmvbeekPl/e5P3l+lPjG7Irrc6Xg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr327209wml.65.1575915122599;
 Mon, 09 Dec 2019 10:12:02 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:12:02 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 06/13] iommu/arm-smmu-v3: Add context descriptor tables
 allocators
Date: Mon,  9 Dec 2019 19:05:07 +0100
Message-Id: <20191209180514.272727-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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

Support for SSID will require allocating context descriptor tables. Move
the context descriptor allocation to separate functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b287e303b1d7..43d6a7ded6e4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -568,6 +568,7 @@ struct arm_smmu_cd_table {
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_cd_table	table;
 	struct arm_smmu_ctx_desc	cd;
+	u8				s1cdmax;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1455,6 +1456,31 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 }
 
 /* Context descriptor manipulation functions */
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
+					 GFP_KERNEL);
+	if (!table->ptr) {
+		dev_warn(smmu->dev,
+			 "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1502,6 +1528,23 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
+					    1 << cfg->s1cdmax);
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2145,11 +2188,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->table.ptr) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->table.ptr,
-					   cfg->table.ptr_dma);
-
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -2173,13 +2212,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					     &cfg->table.ptr_dma, GFP_KERNEL);
-	if (!cfg->table.ptr) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
