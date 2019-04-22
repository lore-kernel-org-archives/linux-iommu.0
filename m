Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1719C282E1
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC8521738
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLRPjSdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC8521738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 701A3DB2;
	Mon, 22 Apr 2019 18:01:03 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 029CBD3D
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id A51BB1DCEE
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=okbFxXfNKNaQjt6lzYa3wLe4NxRRH13KfvdwGJ0BXa8=;
	b=OLRPjSdSYWd3P2UJKtWZ7KDYBV
	omFTTWWimpxccOptRWbQJ81OTy0KooQ51gps6emkEtzhQvTB84/TM2xpU7Hp83KCeufXSZQEtC96D
	j06zXmNzmhsvom6p5zCcLVZ/zuLCsADkRcgnMGmhVExPtk5JieybiovfD78JIvsce9GQX8rbWxY15
	9UEfg4q2x4lwApoFWNNpF2h7BbmzD5uy+9HuRDBkgeE1SufxAA8pNLuiOQt23MQh9ShSB4qEo4BCU
	wpp9hssSojmjn8ADYyUKpXanz7yY1O5uo4ccXHpc4JSVal4n15WRVvqPhavfP6TyRs4IuwUE1KVqE
	irF5JgKA==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIdFP-0002Oy-7j; Mon, 22 Apr 2019 18:00:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 18/26] iommu/dma: Split iommu_dma_free
Date: Mon, 22 Apr 2019 19:59:34 +0200
Message-Id: <20190422175942.18788-19-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422175934.Lw5UevklIeoRJr4Yf5mpo0HMiSU3iolCXIbCccWWZ5g@z>

From: Robin Murphy <robin.murphy@arm.com>

Most of it can double up to serve the failure cleanup path for
iommu_dma_alloc().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a1b8c232ad42..95a12e975994 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -916,15 +916,12 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(dev, handle, size);
 }
 
-static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
+static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 {
 	size_t alloc_size = PAGE_ALIGN(size);
 	int count = alloc_size >> PAGE_SHIFT;
 	struct page *page = NULL;
 
-	__iommu_dma_unmap(dev, handle, size);
-
 	/* Non-coherent atomic allocation? Easy */
 	if (dma_free_from_pool(cpu_addr, alloc_size))
 		return;
@@ -951,6 +948,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		__free_pages(page, get_order(alloc_size));
 }
 
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_free(dev, size, cpu_addr);
+}
+
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
