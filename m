Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7602C35243
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EB224671
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4KJ/UDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB224671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 829C8862DE;
	Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDWRfTvdY9uo; Wed, 15 Jan 2020 12:53:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5C8085FC4;
	Wed, 15 Jan 2020 12:53:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8037C1D82;
	Wed, 15 Jan 2020 12:53:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80369C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D5D584B75
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9v-pwq_yjPZL for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:53:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E971984558
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:34 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q6so15560098wro.9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K6CSSuB6nIgGj1j0dtfzDyCMzgzvK2deYX3HdVqg7mU=;
 b=K4KJ/UDXF+XRt36wtLUHXD1FivcHN0LNsYHSdz3wzfJ6eZ2Rvsu0h3ikSVmt+psJay
 DMgDu5MB5+bb3S7d5Jmjh2+0WR50qwZZu4wArTK7jaQ11taCtpnDOuLS4HdHdnTb3E00
 ixhKZE7tQ+047OFbSyvHEPCscnIFqsbIgvdng7p2Km3d+C/yyaeFjTG8n+uLXh5VaHZY
 kJMY1xF/TlH5kaYyZYt2KmtjpAHzVrXDkw0oLPixNXrmvm2NnxZfLkP7dDSLdEt1zaoC
 AICaf8xdbKGlJIyYWh0obqVPzd/mNV0gPuCzm4jP8EY99+dV+kGfPCqybyYbma0shiix
 2VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K6CSSuB6nIgGj1j0dtfzDyCMzgzvK2deYX3HdVqg7mU=;
 b=dXmyxC9Ql8and62yf9hP8VinBXbVb8QZpGFCyEH9pw9K6n1MoNdBddTdeGdbijOBrW
 4SgwfMtg8SH5sBAmO4ztiUyJP/YHzCSmFS7PCxm3JhrggWIqXNs2E/qbBi5HzczuuyTe
 0G8ZdmEp2U8st3Lz4zmJB0yn+7XowsFCR5WqdgKovOWEt3a3afoOeju8ViiGP36UonWM
 l1QTCJJdUyz17xp0LRzSn4dSBKz8b4GHEJL2cWfaupuBWYv+sdFk/EMYHgB1JvejccJy
 1w/EbkSuB9e5BLe09W9nsZhIsoPkdOc+SF7RESwFO7ZS9/OmaC0hcFG1MjeWSeDwZgk5
 wTOQ==
X-Gm-Message-State: APjAAAWeW2IHRzoY7mlRKpe2wW/5eTf5w5gm/2yZrUbwvOtcREZihOXb
 34Ia4Tb+E8dPMdUm6qWTwnFHJQ==
X-Google-Smtp-Source: APXvYqyjYUJDyqw5fP5RmGWdo3rZKdkTRbxjHr7iti208dwREaMeQn8r2ydm2Ou0/U52o5/nrrd+iA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr32550295wrv.79.1579092813387; 
 Wed, 15 Jan 2020 04:53:33 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:53:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
Subject: [PATCH v5 05/13] iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID
 support
Date: Wed, 15 Jan 2020 13:52:31 +0100
Message-Id: <20200115125239.136759-6-jean-philippe@linaro.org>
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

When adding SSID support to the SMMUv3 driver, we'll need to manipulate
leaf pasid tables and context descriptors. Extract the context
descriptor structure and align with the way stream tables are handled.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 46 ++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 837b4283b4dc..e7c7e34d385f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -553,16 +553,21 @@ struct arm_smmu_strtab_l1_desc {
 	dma_addr_t			l2ptr_dma;
 };
 
+struct arm_smmu_ctx_desc {
+	u16				asid;
+	u64				ttbr;
+	u64				tcr;
+	u64				mair;
+};
+
+struct arm_smmu_ctx_desc_cfg {
+	__le64				*cdtab;
+	dma_addr_t			cdtab_dma;
+};
+
 struct arm_smmu_s1_cfg {
-	__le64				*cdptr;
-	dma_addr_t			cdptr_dma;
-
-	struct arm_smmu_ctx_desc {
-		u16	asid;
-		u64	ttbr;
-		u64	tcr;
-		u64	mair;
-	}				cd;
+	struct arm_smmu_ctx_desc_cfg	cdcfg;
+	struct arm_smmu_ctx_desc	cd;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1471,6 +1476,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 				    struct arm_smmu_s1_cfg *cfg)
 {
 	u64 val;
+	__le64 *cdptr = cfg->cdcfg.cdtab;
 
 	/*
 	 * We don't need to issue any invalidation here, as we'll invalidate
@@ -1488,12 +1494,12 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		val |= CTXDESC_CD_0_S;
 
-	cfg->cdptr[0] = cpu_to_le64(val);
+	cdptr[0] = cpu_to_le64(val);
 
 	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
-	cfg->cdptr[1] = cpu_to_le64(val);
+	cdptr[1] = cpu_to_le64(val);
 
-	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair);
+	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
 /* Stream table manipulation functions */
@@ -1624,7 +1630,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
 	}
 
@@ -2138,11 +2144,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->cdptr) {
+		if (cfg->cdcfg.cdtab) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
 					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdptr,
-					   cfg->cdptr_dma);
+					   cfg->cdcfg.cdtab,
+					   cfg->cdcfg.cdtab_dma);
 
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
@@ -2167,9 +2173,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma, GFP_KERNEL);
-	if (!cfg->cdptr) {
+	cfg->cdcfg.cdtab = dmam_alloc_coherent(smmu->dev,
+					       CTXDESC_CD_DWORDS << 3,
+					       &cfg->cdcfg.cdtab_dma,
+					       GFP_KERNEL);
+	if (!cfg->cdcfg.cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto out_free_asid;
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
