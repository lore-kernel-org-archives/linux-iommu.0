Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D9DC43460
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFF760FF3
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFF760FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39AB560D66;
	Fri,  2 Apr 2021 01:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDUe14v74Oe7; Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA69E60D63;
	Fri,  2 Apr 2021 01:35:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 298B8C0021;
	Fri,  2 Apr 2021 01:35:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F27C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 1C5C341900
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id jZqcS4K0cil9 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 01:35:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 0B19A4193E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617327317; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4vSdLv/IpykZS90dqqKxHDl04QodGwunJjcyPM1cbsA=;
 b=WT2RH1Q9vPkGrzUV7QpQuaYvka2S+gPgnXjHGXNUVgt0a43thCnclPcZeNjZJkfctxdZbEJf
 rbJniq7XgXvs38rwJbYDSZRnBQh6p3LW0qir9azY7rjWZTBxhvbMVwLcmvYEjh8WFB5ZLFIf
 6gJIpe2Tf5QfVs2/7xoQC77x1P4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 606674d0febcffa80f984f26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 01:35:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BF7CAC43465; Fri,  2 Apr 2021 01:35:12 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A7F22C433CA;
 Fri,  2 Apr 2021 01:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7F22C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/12] iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
Date: Thu,  1 Apr 2021 18:34:49 -0700
Message-Id: <20210402013452.4013-11-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210402013452.4013-1-isaacm@codeaurora.org>
References: <20210402013452.4013-1-isaacm@codeaurora.org>
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
Suggested-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 95 +++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index fc63d57b8037..b8464305f1c2 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -355,20 +355,35 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
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
+	int ret = 0;
 
 	/* Find our entry at the current level */
 	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
 
-	/* If we can install a leaf entry at this level, then do so */
-	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
+	/* If we can install leaf entries at this level, then do so */
+	if (size == block_size) {
+		while (pgcount--) {
+			ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
+			if (ret)
+				return ret;
+
+			iova += size;
+			paddr += size;
+			ptep++;
+			if (mapped)
+				*mapped += size;
+		}
+
+		return ret;
+	}
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -397,7 +412,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	}
 
 	/* Rinse, repeat */
-	return __arm_lpae_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
+	return __arm_lpae_map(data, iova, paddr, size, pgcount, prot, lvl + 1, cptep,
+			      gfp, mapped);
 }
 
 static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
@@ -487,7 +503,71 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 		return 0;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
+	ret = __arm_lpae_map(data, iova, paddr, size, 1, prot, lvl, ptep, gfp,
+			     NULL);
+	/*
+	 * Synchronise all PTE updates for the new mapping before there's
+	 * a chance for anything to kick off a table walk for the new iova.
+	 */
+	wmb();
+
+	return ret;
+}
+
+static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int iommu_prot, gfp_t gfp, size_t *mapped)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int ret, lvl = data->start_level, last_lvl;
+	arm_lpae_iopte prot;
+	long iaext = (s64)iova >> cfg->ias;
+	size_t table_size, pages, tbl_offset, max_entries;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
+		return -EINVAL;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return -ERANGE;
+
+	prot = arm_lpae_prot_to_pte(data, iommu_prot);
+
+	/*
+	 * Calculating the page table size here helps avoid situations where
+	 * a page range that is being mapped may be mapped at the same level
+	 * but not mapped by the same tables. Allowing such a scenario to
+	 * occur can complicate the logic in __arm_lpae_map().
+	 */
+	last_lvl = ARM_LPAE_BLOCK_SIZE_LVL(pgsize, data);
+
+	if (last_lvl == data->start_level)
+		table_size = ARM_LPAE_PGD_SIZE(data);
+	else
+		table_size = ARM_LPAE_GRANULE(data);
+
+	max_entries = table_size / sizeof(*ptep);
+
+	while (pgcount) {
+		tbl_offset = ARM_LPAE_LVL_IDX(iova, last_lvl, data);
+		pages = min_t(size_t, pgcount, max_entries - tbl_offset);
+		ret = __arm_lpae_map(data, iova, paddr, pgsize, pages, prot,
+				     lvl, ptep, gfp, mapped);
+		if (ret)
+			break;
+
+		iova += pages * pgsize;
+		paddr += pages * pgsize;
+		pgcount -= pages;
+	}
+
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -833,6 +913,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 
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
