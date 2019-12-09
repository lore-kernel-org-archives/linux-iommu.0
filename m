Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05388C47409
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1CA20836
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zECKqP57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1CA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BECF586A90;
	Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EVTOKVb9BiA; Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49FF185FD6;
	Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38F3FC1796;
	Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEF7C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64373877D4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFVs+-V+ZHr6 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2EE698777D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id p17so300126wmi.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4SmIhNyhH1ZvD9U1NbZBEKXRDYfCu5B8DYhEY+IOh7Q=;
 b=zECKqP57s/Ub2s0rdbLBhyBu719hh7rbyeuo5qgFWFCBa1eRCGCT1QxOaAIJVIjeTZ
 2VqbggAid+t9XWWJy9OCVrBHX9dxm2Esz+tJIq+nG+7/5AZMwDRDdthjd7WLShv/827o
 Sr9YZA5n0oo7LsuaHPCrHH5yB2B0peN9X+ufAc+mQtz7XodiQgyuoSTCHrkrzaPeLdfq
 kRS/AgiERRdtwtvWQPv+CHZXZzJl68J3GSnZhqZK1H8GSz7561nNhUSOSbYxBVUdMdpQ
 CXn9XYhNERRZCEGYkJxiTNseY7tBsOwkpa0gMVk9sc2Vl+ligt9r2x3vsr5LkpIjeEfB
 DVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4SmIhNyhH1ZvD9U1NbZBEKXRDYfCu5B8DYhEY+IOh7Q=;
 b=aPoesaf0yU0698Y0W1DErPKP8KxKvqnpzXLNTOtBROwvxPP7My6jNp4EnrVA2yHpIz
 Szvge4MJdUgSAgXGhXT50PZ2BMO7ZFXrjjOWElElkRNz2xV01Au4lsCxLudYxnifvaVS
 tdrFkSkz7HELZktirT/XgKb+g72Bmuh6pVeMD4gghguKzHfL+KmjhC7yENIuYEvwCS5f
 5hDyAX8mT6f80amxziYjg/Z3CuiL7/OGkH8JFZFyzoL4oYI2PihxLmMTG3WV1UFKx3bG
 lamgs+8N+VG2yYYYxDYKzofGYvJ3zBJ/xuSrxTxNtOwLn5q25BCFLNjJLC4sf+IAAuBs
 Q9Wg==
X-Gm-Message-State: APjAAAVV0pERHLr2o7d7SVN0F2/Kdqo68LnoMattK3Cdeq+7QE2Jjg6V
 CbXRmwv19B0r/CERCw8gvnkRog==
X-Google-Smtp-Source: APXvYqy3WfN7DdcofGPnqQTkPmW4bWrAQwoyDmeVrrbNjjd56os+78JBLhrDMEAB/cskG/ngtwLznA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr309623wmi.149.1575915121541; 
 Mon, 09 Dec 2019 10:12:01 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:12:01 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 05/13] iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID
 support
Date: Mon,  9 Dec 2019 19:05:06 +0100
Message-Id: <20191209180514.272727-6-jean-philippe@linaro.org>
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

When adding SSID support to the SMMUv3 driver, we'll need to manipulate
leaf pasid tables and context descriptors. Extract the context
descriptor structure and introduce a new table structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 44 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 837b4283b4dc..b287e303b1d7 100644
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
+struct arm_smmu_cd_table {
+	__le64				*ptr;
+	dma_addr_t			ptr_dma;
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
+	struct arm_smmu_cd_table	table;
+	struct arm_smmu_ctx_desc	cd;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1471,6 +1476,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 				    struct arm_smmu_s1_cfg *cfg)
 {
 	u64 val;
+	__le64 *cdptr = cfg->table.ptr;
 
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
+		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
 	}
 
@@ -2138,11 +2144,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->cdptr) {
+		if (cfg->table.ptr) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
 					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdptr,
-					   cfg->cdptr_dma);
+					   cfg->table.ptr,
+					   cfg->table.ptr_dma);
 
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
@@ -2167,9 +2173,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma, GFP_KERNEL);
-	if (!cfg->cdptr) {
+	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+					     &cfg->table.ptr_dma, GFP_KERNEL);
+	if (!cfg->table.ptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto out_free_asid;
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
