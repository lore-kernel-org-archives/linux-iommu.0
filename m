Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398EC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:02:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB56F23372
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB56F23372
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 73CD5871DA;
	Mon,  7 Dec 2020 12:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4rJ8ylUQlU0B; Mon,  7 Dec 2020 12:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBBA687110;
	Mon,  7 Dec 2020 12:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D345CC0893;
	Mon,  7 Dec 2020 12:02:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9641AC013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8495587110
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPS0QS+EG6SQ for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 12:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 07F00871DA
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:02:29 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqMNv6JCwzhntJ;
 Mon,  7 Dec 2020 20:01:51 +0800 (CST)
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.137) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 20:02:15 +0800
From: Kunkun Jiang <jiangkunkun@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, "moderated list:ARM SMMU DRIVERS"
 <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] iommu/io-pgtalbe-arm: Remove "iopte_type(pte,
 l)" extra parameter "l"
Date: Mon, 7 Dec 2020 20:01:50 +0800
Message-ID: <20201207120150.1891-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.137]
X-CFilter-Loop: Reflected
Cc: wanghaibin.wang@huawei.com, Kunkun Jiang <jiangkunkun@huawei.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
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

Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
parameter "l" (level). So we'd better to remove it.

Fixes: e1d3c0fd701df(iommu: add ARM LPAE page table allocator)
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a7a9bc08dcd1..e58ba5759b80 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -130,7 +130,7 @@
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
-#define iopte_type(pte,l)					\
+#define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
@@ -151,9 +151,9 @@ static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
 			      enum io_pgtable_fmt fmt)
 {
 	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
-		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
+		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
 
-	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
+	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
 }
 
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
@@ -280,7 +280,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
-	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
+	} else if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
 		/*
 		 * We need to unmap and free the old table before
 		 * overwriting it with a block entry.
@@ -548,7 +548,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		 * block, but anything else is invalid. We can't misinterpret
 		 * a page entry here since we're never at the last level.
 		 */
-		if (iopte_type(pte, lvl - 1) != ARM_LPAE_PTE_TYPE_TABLE)
+		if (iopte_type(pte) != ARM_LPAE_PTE_TYPE_TABLE)
 			return 0;
 
 		tablep = iopte_deref(pte, data);
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
