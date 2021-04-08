Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C49C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC18610CB
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC18610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9743340107;
	Thu,  8 Apr 2021 17:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1m_1JOIHLQrD; Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B699402AB;
	Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66D33C000A;
	Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79018C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 4F90883C43
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 0OZaf3ihIF31 for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:14:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 7184B83D61
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617902074; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=h9hdjSfOKSSR1Oxkz8ZrG0p7YsZRUvI07eXyhf3RlEo=;
 b=J2ViB0/zZ2bszQUiTBoVcZIs0Td46QSAoFld4ssd0dzXwZf9S6P+MrHWBgmd93YcYUs70Hac
 tv4sNefpp5bjpJuWvZuU0yzV3yLX9S8F1gGHIW7IBCxHSyqV+3jboBDOKGHlVBd6iEd2tQem
 IHMSgnWOV07gec8b6M7hDVs6pag=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606f39eb8807bcde1db9b4e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:14:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B8C38C4346F; Thu,  8 Apr 2021 17:14:19 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3914DC4346A;
 Thu,  8 Apr 2021 17:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3914DC4346A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 09/15] iommu/io-pgtable-arm: Prepare PTE methods for
 handling multiple entries
Date: Thu,  8 Apr 2021 10:13:56 -0700
Message-Id: <20210408171402.12607-10-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
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

The PTE methods currently operate on a single entry. In preparation
for manipulating multiple PTEs in one map or unmap call, allow them
to handle multiple PTEs.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 78 +++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..ea66b10c04c4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -232,20 +232,23 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	free_pages((unsigned long)pages, get_order(size));
 }
 
-static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
+static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				struct io_pgtable_cfg *cfg)
 {
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep), DMA_TO_DEVICE);
+				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
 static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
-			       struct io_pgtable_cfg *cfg)
+			       int num_entries, struct io_pgtable_cfg *cfg)
 {
-	*ptep = pte;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte;
 
 	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -255,47 +258,54 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
-				int lvl, arm_lpae_iopte *ptep)
+				int lvl, int num_entries, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte pte = prot;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
 
 	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	pte |= paddr_to_iopte(paddr, data);
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
+	if (!cfg->coherent_walk)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     unsigned long iova, phys_addr_t paddr,
-			     arm_lpae_iopte prot, int lvl,
+			     arm_lpae_iopte prot, int lvl, int num_entries,
 			     arm_lpae_iopte *ptep)
 {
-	arm_lpae_iopte pte = *ptep;
-
-	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
-		/* We require an unmap first */
-		WARN_ON(!selftest_running);
-		return -EEXIST;
-	} else if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
-		/*
-		 * We need to unmap and free the old table before
-		 * overwriting it with a block entry.
-		 */
-		arm_lpae_iopte *tblp;
-		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
-			WARN_ON(1);
-			return -EINVAL;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
+			/* We require an unmap first */
+			WARN_ON(!selftest_running);
+			return -EEXIST;
+		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
+			/*
+			 * We need to unmap and free the old table before
+			 * overwriting it with a block entry.
+			 */
+			arm_lpae_iopte *tblp;
+			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
+					     lvl, tblp) != sz) {
+				WARN_ON(1);
+				return -EINVAL;
+			}
 		}
-	}
 
-	__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
 	return 0;
 }
 
@@ -323,7 +333,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 		return old;
 
 	/* Even if it's not ours, there's no point waiting; just kick it */
-	__arm_lpae_sync_pte(ptep, cfg);
+	__arm_lpae_sync_pte(ptep, 1, cfg);
 	if (old == curr)
 		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
 
@@ -344,7 +354,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 
 	/* If we can install a leaf entry at this level, then do so */
 	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
+		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, 1, ptep);
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -361,7 +371,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (pte)
 			__arm_lpae_free_pages(cptep, tblsz, cfg);
 	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
 
 	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
@@ -543,7 +553,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		if (i == unmap_idx)
 			continue;
 
-		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
 	}
 
 	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
@@ -585,7 +595,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
+		__arm_lpae_set_pte(ptep, 0, 1, &iop->cfg);
 
 		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
