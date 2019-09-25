Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1917BC432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E935721D7C
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E935721D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE59FE39;
	Wed, 25 Sep 2019 13:23:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CE50DDAF
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 13:23:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4DF8A8B7
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 13:23:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 4CA4A57D; Wed, 25 Sep 2019 15:23:02 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/6] iommu/amd: Lock code paths traversing
	protection_domain->dev_list
Date: Wed, 25 Sep 2019 15:23:00 +0200
Message-Id: <20190925132300.3038-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925132300.3038-1-joro@8bytes.org>
References: <20190925132300.3038-1-joro@8bytes.org>
Cc: Filippo Sironi <sironi@amazon.de>, jroedel@suse.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The traversing of this list requires protection_domain->lock to be taken
to avoid nasty races with attach/detach code. Make sure the lock is held
on all code-paths traversing this list.

Reported-by: Filippo Sironi <sironi@amazon.de>
Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bac4e20a5919..9c26976a0f99 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1334,8 +1334,12 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		dma_addr_t iova, size_t size)
 {
 	if (unlikely(amd_iommu_np_cache)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
 		domain_flush_complete(domain);
+		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
 
@@ -1700,8 +1704,13 @@ static int iommu_map_page(struct protection_domain *dom,
 	ret = 0;
 
 out:
-	if (updated)
+	if (updated) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dom->lock, flags);
 		update_domain(dom);
+		spin_unlock_irqrestore(&dom->lock, flags);
+	}
 
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
@@ -1857,8 +1866,12 @@ static void free_gcr3_table(struct protection_domain *domain)
 
 static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->domain.lock, flags);
 	domain_flush_tlb(&dom->domain);
 	domain_flush_complete(&dom->domain);
+	spin_unlock_irqrestore(&dom->domain.lock, flags);
 }
 
 static void iova_domain_flush_tlb(struct iova_domain *iovad)
@@ -2414,6 +2427,7 @@ static dma_addr_t __map_single(struct device *dev,
 {
 	dma_addr_t offset = paddr & ~PAGE_MASK;
 	dma_addr_t address, start, ret;
+	unsigned long flags;
 	unsigned int pages;
 	int prot = 0;
 	int i;
@@ -2451,8 +2465,10 @@ static dma_addr_t __map_single(struct device *dev,
 		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
 	}
 
+	spin_lock_irqsave(&dma_dom->domain.lock, flags);
 	domain_flush_tlb(&dma_dom->domain);
 	domain_flush_complete(&dma_dom->domain);
+	spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
 
 	dma_ops_free_iova(dma_dom, address, pages);
 
@@ -2481,8 +2497,12 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 	}
 
 	if (amd_iommu_unmap_flush) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dma_dom->domain.lock, flags);
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
+		spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
 		dma_ops_free_iova(dma_dom, dma_addr, pages);
 	} else {
 		pages = __roundup_pow_of_two(pages);
@@ -3246,9 +3266,12 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_tlb_pde(dom);
 	domain_flush_complete(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
 static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
