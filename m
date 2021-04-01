Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8710FC43460
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 16:48:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABDE6120D
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABDE6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10C424023E;
	Thu,  1 Apr 2021 16:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MwQEO61r0Ng; Thu,  1 Apr 2021 16:48:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83F641844;
	Thu,  1 Apr 2021 16:48:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98482C0016;
	Thu,  1 Apr 2021 16:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD79FC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB5A241844
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3g7jxGcWm2J for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 16:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAD2841868
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 16:48:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6738C61389;
 Thu,  1 Apr 2021 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617295722;
 bh=m+QOtK4MBnW2L0WweNAXI08Q1Wjuv41DugP348K1TW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KS94AAUr/WbiLXrpHLRYc4VWJiMwix2aQ1o6JIJ17PhemR9TIwjtwD7/clEb8GS0x
 10aQlthgJR8DPT6EQe8r+DH69DdqWx1yA1qTZLRUxrxA/Mlt8xgSWPtEm5uROVn7Pu
 eJ18hz8j/aN6DcgkDZt7+Jf975cRFo1Pa1TbgTCIBabCcBC9z5EdLYwgG1w1XdFxYE
 d39LF7XGXBa5AlqPRRbTqyLuYznr6y2niVDSSSm/DAwkCzk098q9c0+OqfZThd/P0u
 vrTar44pZxuoxmIEztfv6NpN/8B4ufvHuPh7Xp4f//atqCRQmvElnj47lqJ1MUjZXB
 u64Er8zWs32oA==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH 6/6] iommu: Accomodate larger pages in iommu_pgsize()
 'count' calculation
Date: Thu,  1 Apr 2021 17:47:38 +0100
Message-Id: <20210401164738.9513-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401164738.9513-1-will@kernel.org>
References: <20210401164738.9513-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Pratik Patel <pratikp@codeaurora.org>,
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

Extend the calculation of 'count' in iommu_pgsize() so that it takes
larger page sizes into consideration and returns a value which will
allow a larger page size to be used on the next call.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fe186691fc21..0572a4dcd9e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2360,9 +2360,9 @@ EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 			   phys_addr_t paddr, size_t size, size_t *count)
 {
-	unsigned int pgsize_idx;
+	unsigned int pgsize_idx, pgsize_idx_next;
 	unsigned long pgsizes;
-	size_t pgsize;
+	size_t offset, pgsize, pgsize_next;
 	phys_addr_t addr_merge = paddr | iova;
 
 	/* Page sizes supported by the hardware and small enough for @size */
@@ -2378,9 +2378,37 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	/* Pick the biggest page size remaining */
 	pgsize_idx = __fls(pgsizes);
 	pgsize = BIT(pgsize_idx);
+	if (!count)
+		return pgsize;
 
-	if (count)
-		*count = size >> pgsize_idx;
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
+	 * If size is big enough to accomodate the larger page, reduce
+	 * the number of smaller pages.
+	 */
+	if (offset + pgsize_next <= size)
+		size = offset;
+
+out_set_count:
+	*count = size >> pgsize_idx;
 	return pgsize;
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
