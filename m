Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C67C43461
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9D961107
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9D961107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E50C84DC1;
	Thu,  8 Apr 2021 17:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPF92OnCfz4o; Thu,  8 Apr 2021 17:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2724E84DF2;
	Thu,  8 Apr 2021 17:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF80AC0014;
	Thu,  8 Apr 2021 17:14:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21BEBC000B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 3554683AC6
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id XDTptbFHXHGB for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:14:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 89E9683B3A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617902073; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HGRyQe6DG9bJ2pCDNTtI+Hg4o9gug1ZPClF+KgaYVNg=;
 b=mujQ7MskbPC6Cae7CC++SnTJ5yp43qmsJ6oaDTMJ3p6weHocXdJTlXSpapNVa/l8ZoxQGEjb
 d7MmtHQzRO+LiC+P5glr0LHJVm8caABTj3rT3XwEWytXzbLtlP7u/ZCfXTcmi3OPvmuW+bLs
 kp5OUPE1kbNlnGky7kRNT/z3NXo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 606f39e92cc44d3aea986b28 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:14:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 26BBEC43470; Thu,  8 Apr 2021 17:14:17 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BAD8CC43464;
 Thu,  8 Apr 2021 17:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAD8CC43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 07/15] iommu: Hook up '->unmap_pages' driver callback
Date: Thu,  8 Apr 2021 10:13:54 -0700
Message-Id: <20210408171402.12607-8-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J . Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 Will Deacon <will@kernel.org>, pratikp@codeaurora.org
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

From: Will Deacon <will@kernel.org>

Extend iommu_pgsize() to populate an optional 'count' parameter so that
we can direct unmapping operation to the ->unmap_pages callback if it
has been provided by the driver.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/iommu.c | 60 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 624ce3c7ae33..1fc919ea95ac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2358,11 +2358,11 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
 static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
-			   phys_addr_t paddr, size_t size)
+			   phys_addr_t paddr, size_t size, size_t *count)
 {
-	unsigned int pgsize_idx;
+	unsigned int pgsize_idx, pgsize_idx_next;
 	unsigned long pgsizes;
-	size_t pgsize;
+	size_t offset, pgsize, pgsize_next;
 	unsigned long addr_merge = paddr | iova;
 
 	/* Page sizes supported by the hardware and small enough for @size */
@@ -2378,7 +2378,37 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	/* Pick the biggest page size remaining */
 	pgsize_idx = __fls(pgsizes);
 	pgsize = BIT(pgsize_idx);
+	if (!count)
+		return pgsize;
 
+
+	/* Find the next biggest support page size, if it exists */
+	pgsizes = domain->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
+	if (!pgsizes)
+		goto out_set_count;
+
+	pgsize_idx_next = __ffs(pgsizes);
+	pgsize_next = BIT(pgsize_idx_next);
+
+	/*
+	 * There's no point trying a bigger page size unless the virtual
+	 * and physical addresses are similarly offset within the larger page.
+	 */
+	if ((iova ^ paddr) & (pgsize_next - 1))
+		goto out_set_count;
+
+	/* Calculate the offset to the next page size alignment boundary */
+	offset = pgsize_next - (addr_merge & (pgsize_next - 1));
+
+	/*
+	 * If size is big enough to accommodate the larger page, reduce
+	 * the number of smaller pages.
+	 */
+	if (offset + pgsize_next <= size)
+		size = offset;
+
+out_set_count:
+	*count = size >> pgsize_idx;
 	return pgsize;
 }
 
@@ -2416,7 +2446,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova, paddr, size);
+		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
@@ -2467,6 +2497,19 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);
 
+static size_t __iommu_unmap_pages(struct iommu_domain *domain,
+				  unsigned long iova, size_t size,
+				  struct iommu_iotlb_gather *iotlb_gather)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize, count;
+
+	pgsize = iommu_pgsize(domain, iova, iova, size, &count);
+	return ops->unmap_pages ?
+	       ops->unmap_pages(domain, iova, pgsize, count, iotlb_gather) :
+	       ops->unmap(domain, iova, pgsize, iotlb_gather);
+}
+
 static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    struct iommu_iotlb_gather *iotlb_gather)
@@ -2476,7 +2519,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(ops->unmap == NULL ||
+	if (unlikely(!(ops->unmap || ops->unmap_pages) ||
 		     domain->pgsize_bitmap == 0UL))
 		return 0;
 
@@ -2504,10 +2547,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	 * or we hit an area that isn't mapped.
 	 */
 	while (unmapped < size) {
-		size_t pgsize;
-
-		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped);
-		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
+		unmapped_page = __iommu_unmap_pages(domain, iova,
+						    size - unmapped,
+						    iotlb_gather);
 		if (!unmapped_page)
 			break;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
