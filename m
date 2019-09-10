Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1BC49ED7
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E802171F
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="aFmZqC2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E802171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D9DF2E42;
	Tue, 10 Sep 2019 17:50:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AF08FE21
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
	[207.171.184.29])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6007E8AC
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568137809; x=1599673809;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=9g2f9965/AguN0jWvC9vxXzWh+98n2Npj805hP9BUAk=;
	b=aFmZqC2k6LnNARawoZIxZDXDIiLvgYIuREUH9e25Rzi9z88x5w+cq+Pq
	WoFTDBoRg/l44rcY31tMGw+tSP564Yp9BdwAY//73EqkufQB1UXb0lWxS
	ym/VlvFI/iZ6kargTqoQjJQdvRJA5PhsuY8cf/KExfqmPJXuMQt8drwTn 8=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; d="scan'208";a="701858170"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
	email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.38])
	by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
	10 Sep 2019 17:49:46 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
	by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with
	ESMTPS id 1E290A219D; Tue, 10 Sep 2019 17:49:43 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with
	ESMTP id x8AHnfdW023824; Tue, 10 Sep 2019 19:49:41 +0200
Received: (from sironi@localhost)
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8AHnfnG023822; Tue, 10 Sep 2019 19:49:41 +0200
To: sironi@amazon.de, joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/amd: Hold the domain lock when calling __map_single
Date: Tue, 10 Sep 2019 19:49:22 +0200
Message-Id: <1568137765-20278-3-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
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
From: Filippo Sironi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Filippo Sironi <sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

__map_single makes several calls to __domain_flush_pages, which
traverses the device list that is protected by the domain lock.

Also, this is in line with the comment on top of __map_single, which
says that the domain lock should be held when calling.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f026a8c2b218..8e3664821b3c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2482,6 +2482,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	u64 dma_mask;
+	unsigned long flags;
+	dma_addr_t dma_addr;
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL)
@@ -2492,7 +2494,10 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	spin_lock_irqsave(&domain->lock, flags);
+	dma_addr = __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return dma_addr;
 }
 
 /*
@@ -2663,6 +2668,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
+	unsigned long flags;
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL) {
@@ -2692,8 +2698,10 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
+	spin_lock_irqsave(&domain->lock, flags);
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
