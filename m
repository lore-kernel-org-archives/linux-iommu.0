Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CAC433E6
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C47238EE
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C47238EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 47E652E0E5;
	Fri, 22 Jan 2021 11:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zfk2vGl2GOQb; Fri, 22 Jan 2021 11:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F411F2DE22;
	Fri, 22 Jan 2021 11:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E624AC08A1;
	Fri, 22 Jan 2021 11:56:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCDDCC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AC8E4870DC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHzINd1v4s0L for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1683C871EF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id a12so4821599wrv.8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0SgQac0tiwSnubcxGDua82/tHq+RVHRl87pjSP5itgM=;
 b=c/+lm4UV7z4yrpevZBw5MXVbSHJfG5GvTYXmR523SsGeYoSjX+jOx59hx0TYoUsns6
 Ict0mSd2fZU4yt/FVPoKw/R/mbLQ8F5Wem25jFZQVmCmSll0JDtLuUbhwlD0DVmoitZ1
 aj8CSe9+sfkxxiDLIynYlR5PUqgH3yj7sppaM7GwCdms7piu1hXvNh00PX9kvSScWCBQ
 RwKf/LiIAqjTHqz/PGpJu5oJltalvLPVZfYD0YAGhuGxe9j1+/39N7ejCX5yp47AiScG
 6HZ0DppJ5pDNc/r04nIS65fIXwrP1ALy7IRZjxbVA0gVJ/XXXs5wHnrG9SmT/5S9DUxW
 z/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0SgQac0tiwSnubcxGDua82/tHq+RVHRl87pjSP5itgM=;
 b=BvCJU5BcIc5lX+B2rIVcZRKgkj9RtcyWgrxnMQ5vLnaEvSPNgHTKog0UqPr7vtudgt
 bdRDZQOZxrp26fgebtEh+i9+CNh6OHB55+iAwJ/Ay+UOcr5wbecicCzix/Z87keFPr3I
 35aq2yOblJUGcS+4c6sBujsQ45NyZQTM/kWA8fJSfiMEgSd7UVj80VzJlxXzJ2XXhkvr
 LWS/eQAt76F7fChN5l5J7jEEewyhFabD6FG0N4GIIiWvNw7eIptmOmiMbE02zLXGNwp+
 YpNUxXS7ub5AzepcFnvahbF5t87pyWhV/23RN1RgqgY4pOr8iS0JKcIWyVW3RxtOmP7/
 vP6g==
X-Gm-Message-State: AOAM5312tEWHoOrpLXmbljwqhOTg+Ar1rSeupLGeuv4W9wB6W8sC7dsb
 Xo44kImD3NUAFhLLdZY0Ffoh9w==
X-Google-Smtp-Source: ABdhPJwQhy/pUuxgwb7y2QDYJj2WfJIWjTPpeXGb67NOjvpLAu1UsjCylvROLm7OF+CedXFEccK+Pg==
X-Received: by 2002:adf:9b92:: with SMTP id d18mr4293974wrc.170.1611316588567; 
 Fri, 22 Jan 2021 03:56:28 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s25sm13293901wrs.49.2021.01.22.03.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 03:56:28 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH 1/3] iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
Date: Fri, 22 Jan 2021 12:52:56 +0100
Message-Id: <20210122115257.2502526-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122115257.2502526-1-jean-philippe@linaro.org>
References: <20210122115257.2502526-1-jean-philippe@linaro.org>
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 62 ++++++++++++---------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 740a3d487591..a27b074d5c0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1934,40 +1934,27 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
-static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
-				   size_t granule, bool leaf,
+static void arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				   unsigned long iova, size_t size,
+				   size_t granule,
 				   struct arm_smmu_domain *smmu_domain)
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
-
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
@@ -1985,11 +1972,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 
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
@@ -1998,17 +1985,37 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
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
+	arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
@@ -2024,7 +2031,7 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range(iova, size, granule, false, cookie);
+	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -2622,8 +2629,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
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
