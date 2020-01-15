Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D1C33CB8
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC1B207FF
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYkxSNqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC1B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 158F586294;
	Wed, 15 Jan 2020 12:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YH07akkRDBD9; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A04F862A0;
	Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 748C6C1D8E;
	Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB28C1D82
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7D2D38531D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dKSab4TWrSqD for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:53:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3CF385549
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:35 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id q9so17757240wmj.5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=in26yMaZg6abF2yqvUJjPFZYANziWWa0eLADh6G3Ifo=;
 b=KYkxSNqGoykHOtMF+QyweVPd8z8QHaDFJVOOc82qJ9FI/2oPuBi1AFY3YgT9l6pkPL
 ynQwh/VbngNEoEnwC9LmKtcklVpWETBB2Ha8Kd8oI7sx82tx8Udfgc5ZjFjeFwD1/Wuh
 clU032RmX0bz4skodakrFBabzvmrj4eyUSoIpbKPqu5YLQ5MPO9VrstW/PZAR14aI920
 MHgh+jcXHtVnEEms5hTJ3MtiNE3Ffl3TxLuRiYRGWbxq15sDaKrIZU0y8HgNBJxGoKa6
 s2gU7h9se5LnGBCRJKbKaBCC/0VH8TTIhEHK/BWjyF3CwfAMX2My9A7j1V6uDO5lvMEq
 Ginw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=in26yMaZg6abF2yqvUJjPFZYANziWWa0eLADh6G3Ifo=;
 b=kLLpQdmcFUEE2dM3lg/TeyPx5K6JaGb2wKUtgcjd9H/NkESUwt+FCt3zFgNwnxbp6t
 2tF0nZSaMLgd8oKNVlGtiZ1SqVp4CWBSyK4fMoBdO+AbpYNDNMUYv9BBEw9YMNzXiTmV
 2RgkIj0xM4BypG1AbkxvR8WLQGf3gmri0H0intU0tSAa+0mIrUmsfSCLVOc3t5eGASsA
 7jVArb6mYkxRjPxBPDbQZITHklPnsicC7KS/HEivhJocVpbmRe82hSg2jFSv92VAUuno
 fVq6l53LUV43ZssUKQoe1mLoSpmS7d4Rxvp9YBJuDg1f0f46IZo8NTcPuGjg63O8v5gN
 U41g==
X-Gm-Message-State: APjAAAWGNTilRFDp9q+XdY2KiVETlE8mAyDuxlwoRfaw9W7BnqmD1tk9
 wfe9eWsYR8iua+cbwrd7JmqLLA==
X-Google-Smtp-Source: APXvYqyohJNdvB6MKflgoRReAN7/MUNP/x8LeCEXk7CBOIMa+UpMWhsowT73ysRp4ydr7ualZQdvEg==
X-Received: by 2002:a1c:a702:: with SMTP id q2mr34068062wme.6.1579092814518;
 Wed, 15 Jan 2020 04:53:34 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:53:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
Subject: [PATCH v5 06/13] iommu/arm-smmu-v3: Add context descriptor tables
 allocators
Date: Wed, 15 Jan 2020 13:52:32 +0100
Message-Id: <20200115125239.136759-7-jean-philippe@linaro.org>
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

Support for SSID will require allocating context descriptor tables. Move
the context descriptor allocation to separate functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 47 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e7c7e34d385f..a3438e256bd0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -563,11 +563,13 @@ struct arm_smmu_ctx_desc {
 struct arm_smmu_ctx_desc_cfg {
 	__le64				*cdtab;
 	dma_addr_t			cdtab_dma;
+	unsigned int			num_l1_ents;
 };
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	struct arm_smmu_ctx_desc	cd;
+	u8				s1cdmax;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1502,6 +1504,35 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	size_t l1size;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+
+	cdcfg->num_l1_ents = 1UL << cfg->s1cdmax;
+	l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+					   GFP_KERNEL);
+	if (!cdcfg->cdtab) {
+		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	size_t l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
+	cdcfg->cdtab_dma = 0;
+	cdcfg->cdtab = NULL;
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2145,11 +2176,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->cdcfg.cdtab) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdcfg.cdtab,
-					   cfg->cdcfg.cdtab_dma);
-
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -2173,15 +2200,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdcfg.cdtab = dmam_alloc_coherent(smmu->dev,
-					       CTXDESC_CD_DWORDS << 3,
-					       &cfg->cdcfg.cdtab_dma,
-					       GFP_KERNEL);
-	if (!cfg->cdcfg.cdtab) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
