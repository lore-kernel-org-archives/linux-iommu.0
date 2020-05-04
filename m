Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DC7C47262
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98422075B
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98422075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A1A6B88390;
	Mon,  4 May 2020 12:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8d0L-TTaA81; Mon,  4 May 2020 12:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BFB3288A59;
	Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6092C088F;
	Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA72BC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA0CF22EDD
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfL4PK54HSI5 for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 81D35203C3
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 300465BB; Mon,  4 May 2020 14:54:15 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 5/5] iommu/amd: Do not flush Device Table in iommu_map_page()
Date: Mon,  4 May 2020 14:54:13 +0200
Message-Id: <20200504125413.16798-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The flush of the Device Table Entries for the domain has already
happened in increase_address_space(), if necessary. Do no flush them
again in iommu_map_page().

Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2ae1daac888a..1dc3718560d0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1446,15 +1446,18 @@ static bool increase_address_space(struct protection_domain *domain,
 {
 	struct domain_pgtable pgtable;
 	unsigned long flags;
-	bool ret = false;
+	bool ret = true;
 	u64 *pte, root;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
-	if (address <= PM_LEVEL_SIZE(pgtable.mode) ||
-	    WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
+	if (address <= PM_LEVEL_SIZE(pgtable.mode))
+		goto out;
+
+	ret = false;
+	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
@@ -1499,19 +1502,15 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		bool upd = increase_address_space(domain, address, gfp);
-
-		/* Read new values to check if update was successful */
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
-
 		/*
 		 * Return an error if there is no memory to update the
 		 * page-table.
 		 */
-		if (!upd && (address > PM_LEVEL_SIZE(pgtable.mode)))
+		if (!increase_address_space(domain, address, gfp))
 			return NULL;
 
-		*updated = *updated || upd;
+		/* Read new values to check if update was successful */
+		amd_iommu_domain_get_pgtable(domain, &pgtable);
 	}
 
 
@@ -1719,7 +1718,13 @@ static int iommu_map_page(struct protection_domain *dom,
 		unsigned long flags;
 
 		spin_lock_irqsave(&dom->lock, flags);
-		update_domain(dom);
+		/*
+		 * Flush domain TLB(s) and wait for completion. Any Device-Table
+		 * Updates and flushing already happened in
+		 * increase_address_space().
+		 */
+		domain_flush_tlb_pde(dom);
+		domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
