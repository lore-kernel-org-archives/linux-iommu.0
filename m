Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75694C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462CE21707
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RPxDxpCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462CE21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AB452F7D;
	Tue, 30 Apr 2019 10:53:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AAB9DF09
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A820711
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XitrVaRiJi30rZFNtgDd0cKu1pTDVrydXeW0TkMYMow=;
	b=RPxDxpCX2jETeVM10t1unLBGFF
	hJrJp/zLU41Pe/Fepn631ebXIDnIAYJiFUmvCcf6CAx2XLryWCpJRBR59G45Ca293/Up9H24OXU00
	WUZ3G3KBw7nX6VV97uVa+V3M3bwNmOoXqqRSCflTfrkw167HK5CCVhHJsilLNVww6Tt+mhyJARbGv
	uVJW1OMIP53KGolPjMOacrzmeYW5gfAR4fYI+trE90gruOjdTqVfmcEqpWa/Z4xd+PGxowJzQm+hH
	4IlpMTtndpWZgY7h7sjnCqQ7lIpIg2UEBpHzPH4w8KwygqRO/M2K/CgX0irKIRmd0d/c7933lI05z
	V1tLdLyg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNi-0007aw-La; Tue, 30 Apr 2019 10:53:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 07/25] iommu/dma: Move __iommu_dma_map
Date: Tue, 30 Apr 2019 06:51:56 -0400
Message-Id: <20190430105214.24628-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
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
Message-ID: <20190430105156._5092g_Id8its6gsaA9eztaZ_F0QTBgofqxZxHCVIrE@z>

Moving this function up to its unmap counterpart helps to keep related
code together for the following changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 089a13db919c..930398d3351a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -435,6 +435,29 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size);
 }
 
+static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
+		size_t size, int prot, struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	size_t iova_off = 0;
+	dma_addr_t iova;
+
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
+		iova_off = iova_offset(&cookie->iovad, phys);
+		size = iova_align(&cookie->iovad, size + iova_off);
+	}
+
+	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!iova)
+		return DMA_MAPPING_ERROR;
+
+	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
+		iommu_dma_free_iova(cookie, iova, size);
+		return DMA_MAPPING_ERROR;
+	}
+	return iova + iova_off;
+}
+
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -673,29 +696,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
-{
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	size_t iova_off = 0;
-	dma_addr_t iova;
-
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
-		iova_off = iova_offset(&cookie->iovad, phys);
-		size = iova_align(&cookie->iovad, size + iova_off);
-	}
-
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
-	if (!iova)
-		return DMA_MAPPING_ERROR;
-
-	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size);
-		return DMA_MAPPING_ERROR;
-	}
-	return iova + iova_off;
-}
-
 static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
