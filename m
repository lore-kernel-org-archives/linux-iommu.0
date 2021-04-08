Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80247C43462
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 04:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A46060FDA
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 04:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46060FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35D9F60909;
	Thu,  8 Apr 2021 04:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxS7an8JW7qj; Thu,  8 Apr 2021 04:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD58760ED6;
	Thu,  8 Apr 2021 04:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E33AFC0019;
	Thu,  8 Apr 2021 04:53:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED60C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id F1CEA60D8C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id yYviCz0uvsDZ for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 04:53:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 74B9460DA7
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:53:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617857593; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=umTSTvVt/iRiezzwkH2FClSnF/w9Dv+5vB9n1OwMIvs=;
 b=jdQQ1odBnUlnWZiFWN/M5ohaOShSEc6dnRcx0UFGP+/fmGPka/xpdyh+j0h7RLw+xBQ8RB/b
 z2EUgelLjwEWsKL/D+6vKcGoMQHzNClYV/rqpl732Z8fkx/4h5tYGo56vEFrdEOQyZxEqB4a
 OD61mUNsY2h52iTjYRyzV1TV4O8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 606e8c328166b7eff77e8455 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 04:53:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DF547C433ED; Thu,  8 Apr 2021 04:53:05 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BFE5BC43462;
 Thu,  8 Apr 2021 04:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFE5BC43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v4 11/15] iommu/io-pgtable-arm: Implement
 arm_lpae_map_pages()
Date: Wed,  7 Apr 2021 21:52:37 -0700
Message-Id: <20210408045241.27316-12-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408045241.27316-1-isaacm@codeaurora.org>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 will@kernel.org, pratikp@codeaurora.org
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

Implement the map_pages() callback for the ARM LPAE io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm.c | 42 ++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6700685f81d4..834481d3c7f3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -341,20 +341,30 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 }
 
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
-			  phys_addr_t paddr, size_t size, arm_lpae_iopte prot,
-			  int lvl, arm_lpae_iopte *ptep, gfp_t gfp)
+			  phys_addr_t paddr, size_t size, size_t pgcount,
+			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
+			  gfp_t gfp, size_t *mapped)
 {
 	arm_lpae_iopte *cptep, pte;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	int ret = 0, num_entries, max_entries, map_idx_start;
 
 	/* Find our entry at the current level */
-	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	ptep += map_idx_start;
 
 	/* If we can install a leaf entry at this level, then do so */
-	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, 1, ptep);
+	if (size == block_size) {
+		max_entries = (tblsz >> ilog2(sizeof(pte))) - map_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
+		if (!ret && mapped)
+			*mapped += num_entries * size;
+
+		return ret;
+	}
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -383,7 +393,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	}
 
 	/* Rinse, repeat */
-	return __arm_lpae_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
+	return __arm_lpae_map(data, iova, paddr, size, pgcount, prot, lvl + 1,
+			      cptep, gfp, mapped);
 }
 
 static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
@@ -450,8 +461,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	return pte;
 }
 
-static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
+static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int iommu_prot, gfp_t gfp, size_t *mapped)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
@@ -460,7 +472,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte prot;
 	long iaext = (s64)iova >> cfg->ias;
 
-	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
 		return -EINVAL;
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
@@ -473,7 +485,8 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 		return 0;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
+	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
+			     ptep, gfp, NULL);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -483,6 +496,14 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+
+static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
+			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
+{
+	return arm_lpae_map_pages(ops, iova, paddr, size, 1, iommu_prot, gfp,
+				  NULL);
+}
+
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 				    arm_lpae_iopte *ptep)
 {
@@ -779,6 +800,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
+		.map_pages	= arm_lpae_map_pages,
 		.unmap		= arm_lpae_unmap,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
