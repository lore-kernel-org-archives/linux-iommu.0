Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353CC433E6
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:15:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9692923AAC
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9692923AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 74DBF226F3;
	Fri, 22 Jan 2021 15:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgbLRO7ZDT6Q; Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D88EA2E106;
	Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE3E9C013A;
	Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87723C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68A8F230FB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lRMTJUBnnS1 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 15:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by silver.osuosl.org (Postfix) with ESMTPS id B1999226F3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:12 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id s24so6866883wmj.0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hv50NwnI5JQXYCrG4gaOLhtTzE+Oicn9RTVAG+xrbyk=;
 b=zcE8BkvErBzW52BekMyQ1KcH83Q6bvWtWUoEpBLMo2IZFgthu3v+BG3Bg6AGdzETOb
 cmrC+s+zERNDEvC7Wo+aYgrHpXtX8zerBqzLSpjPHBvH2S9msYMGHsC80rPL5xIuvYqC
 gllTq4Pz7CuFaIJ03hTf1p2OvWbLGjL0D8/bj3xNWXG6iJ13/svUMnBUzj/uNk6FDLhg
 4GIAcGo2wHvWB3QeykTr1TJXyhFK6IOUvT4lwvD9MtmL4r56lk0vNBpQVeA1s6aGSahE
 1SsTQH3ATQi17TMp5B40O6SiJjfDCO4D12FQfko07DtVhxb406ag+RSdi2g7TWmjhqkN
 6ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hv50NwnI5JQXYCrG4gaOLhtTzE+Oicn9RTVAG+xrbyk=;
 b=tMh2fL+fFVjXaQHHVU5ha51SQ85w0jxDsFwTIj51DPyJigl5VVg9R9tOJQ40rVXSJR
 puxuXkI2ZkIfVOxxEmqZLbCslu4YfXcpGg+eBrMbSSz6dOy9XW/2JWqimW+7GqkMl1Hn
 7wZI1HCq9U+io+DNnaBzr23DdB52h2CgwmpgiPAq1f3w+QL2U9p0aRMVy/fwTWLucDyX
 W5igem7kYXyCzRsTdhcyTKmi7wHpWmq/+552RGh3YDg0et7nS4GMNhxTX0lsNCcr7hda
 aIRTl9cPHVtn94vzJN7D5afMCtdk6qKZIo/rPSppgH0AAyFdFCWU3G6HkmCWHXh8D654
 NXNA==
X-Gm-Message-State: AOAM532cwYYriSjcpsXAleCYBhXyO/sWWOd9w443xrSqsYvjL3BFQygS
 DzNyYoCdzPwxIHzMmlNVnLxTiQ==
X-Google-Smtp-Source: ABdhPJya4n1VBNPdNoK10hNPD/KQaH3kaztygp5m7p5KhbhHJhKe7urI8UcN8URuMxRvHEaZ75m8iw==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr664764wml.110.1611328511019;
 Fri, 22 Jan 2021 07:15:11 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h1sm9001945wrr.73.2021.01.22.07.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 07:15:10 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH v2 1/3] iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
Date: Fri, 22 Jan 2021 16:10:54 +0100
Message-Id: <20210122151054.2833521-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122151054.2833521-1-jean-philippe@linaro.org>
References: <20210122151054.2833521-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

Extract some of the cmd initialization and the ATC invalidation from
arm_smmu_tlb_inv_range(), to allow an MMU notifier to invalidate a VA
range by ASID.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 63 ++++++++++++---------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f04c55a7503c..86cbac77c941 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1658,40 +1658,28 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
-static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
-				   size_t granule, bool leaf,
-				   struct arm_smmu_domain *smmu_domain)
+static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				     unsigned long iova, size_t size,
+				     size_t granule,
+				     struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
 	struct arm_smmu_cmdq_batch cmds = {};
-	struct arm_smmu_cmdq_ent cmd = {
-		.tlbi = {
-			.leaf	= leaf,
-		},
-	};
 
 	if (!size)
 		return;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
-		cmd.tlbi.tg = (tg - 10) / 2;
+		cmd->tlbi.tg = (tg - 10) / 2;
 
 		/* Determine what level the granule is at */
-		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		num_pages = size >> tg;
 	}
@@ -1709,11 +1697,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 
 			/* Determine the power of 2 multiple number of pages */
 			scale = __ffs(num_pages);
-			cmd.tlbi.scale = scale;
+			cmd->tlbi.scale = scale;
 
 			/* Determine how many chunks of 2^scale size we have */
 			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
-			cmd.tlbi.num = num - 1;
+			cmd->tlbi.num = num - 1;
 
 			/* range is num * 2^scale * pgsize */
 			inv_range = num << (scale + tg);
@@ -1722,17 +1710,37 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 			num_pages -= num << scale;
 		}
 
-		cmd.tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+		cmd->tlbi.addr = iova;
+		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
 		iova += inv_range;
 	}
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+}
+
+static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
+					  size_t granule, bool leaf,
+					  struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.tlbi = {
+			.leaf	= leaf,
+		},
+	};
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+	} else {
+		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+	}
+	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
@@ -1748,7 +1756,7 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range(iova, size, granule, false, cookie);
+	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -2271,8 +2279,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
-			       gather->pgsize, true, smmu_domain);
+	arm_smmu_tlb_inv_range_domain(gather->start,
+				      gather->end - gather->start,
+				      gather->pgsize, true, smmu_domain);
 }
 
 static phys_addr_t
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
