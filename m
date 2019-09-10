Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F794C49ED9
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:55:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C908121479
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XOaEKOg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C908121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 91C71D7C;
	Tue, 10 Sep 2019 17:55:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 41931CC4
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:55:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
	[207.171.190.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC9D181A
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568138118; x=1599674118;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=5yiSH1P7n2W7mCPI9uGMIVbUj0mvk5Zc+6ydi+2zbgE=;
	b=XOaEKOg857a6JT4XH5GGRO/1Y4X8dZlFi02aL1hgLNyUMekHX7TrnVVD
	lrIlbyfnIbJTa4cOP2Ix6yhsfAD3IP0j7AWUpgcB8Aa7TSUpPcC7Ox53e
	A4czEdrAlYPacsPT39/Y8nNoB40dtPV7j16Ef8wvEO4TAgoBqUZJeCPR0 U=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; d="scan'208";a="829946140"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
	email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.34])
	by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
	10 Sep 2019 17:49:47 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
	by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with
	ESMTPS id 5922AA1E98; Tue, 10 Sep 2019 17:49:45 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with
	ESMTP id x8AHnhmW023829; Tue, 10 Sep 2019 19:49:43 +0200
Received: (from sironi@localhost)
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8AHnhvi023828; Tue, 10 Sep 2019 19:49:43 +0200
To: sironi@amazon.de, joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/amd: Hold the domain lock when calling
	__unmap_single
Date: Tue, 10 Sep 2019 19:49:23 +0200
Message-Id: <1568137765-20278-4-git-send-email-sironi@amazon.de>
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

__unmap_single makes several calls to __domain_flush_pages, which
traverses the device list that is protected by the domain lock.
__attach_device and __detach_device).

Also, this is in line with the comment on top of __unmap_single, which
says that the domain lock should be held when calling.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8e3664821b3c..d4f25767622e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2508,6 +2508,7 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 {
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
+	unsigned long flags;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2515,7 +2516,9 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 
 	dma_dom = to_dma_ops_domain(domain);
 
+	spin_lock_irqsave(&domain->lock, flags);
 	__unmap_single(dma_dom, dma_addr, size, dir);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static int sg_num_pages(struct device *dev,
@@ -2645,6 +2648,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
 	int npages;
+	unsigned long flags;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2654,7 +2658,9 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	dma_dom   = to_dma_ops_domain(domain);
 	npages    = sg_num_pages(dev, sglist, nelems);
 
+	spin_lock_irqsave(&domain->lock, flags);
 	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 /*
@@ -2726,6 +2732,7 @@ static void free_coherent(struct device *dev, size_t size,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
+	unsigned long flags;
 
 	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
@@ -2736,7 +2743,9 @@ static void free_coherent(struct device *dev, size_t size,
 
 	dma_dom = to_dma_ops_domain(domain);
 
+	spin_lock_irqsave(&domain->lock, flags);
 	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
