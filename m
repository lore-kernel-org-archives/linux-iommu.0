Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71DC3A5A5
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:41:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F111A20825
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ad7SlQ2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EC6EC177B;
	Thu,  5 Sep 2019 11:41:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 67FA11775
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:41:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02775831
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yblpSkBc51Fw0zd+3yeEyEvbp0oik6LLS+KZTp2OIZk=;
	b=ad7SlQ2tSsNYLM9s8LE2/Foz0u
	v/LFGD+KRjalx7Y10MuiNQ988TzQOl3hIx4XozEBrzxjYmvn/F2VbzhM3pMDVWI6TbTLxBo36xgT7
	QEHzW60Hk0eK7KYKG1zhYsIhaCex0AlwVHL7NDSYaA2BRUkowHDht8uHFUPfrLjuAxu1cplNoPY38
	2M9mFCfZeyMPZk6VCcFc5ICowlHls+EzxWBEBikvr3iAhl68RDZcdCoIdCatcmLB7H6znzhB/p5Qh
	a4iTYH298CEir9Fr+77qzrLexGmqWIe7WZwHL85VCrcxg6y3jAzLzuTeEWPnlPDgEpcuIfUf55H+a
	4Nf9b9Kg==;
Received: from [2001:4bb8:18c:1755:a4b2:9562:6bf1:4bb9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1i5q8P-00054e-6G; Thu, 05 Sep 2019 11:41:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, gross@suse.com,
	boris.ostrovsky@oracle.com
Subject: [PATCH 08/11] swiotlb-xen: use the same foreign page check everywhere
Date: Thu,  5 Sep 2019 13:34:05 +0200
Message-Id: <20190905113408.3104-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905113408.3104-1-hch@lst.de>
References: <20190905113408.3104-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

xen_dma_map_page uses a different and more complicated check for foreign
pages than the other three cache maintainance helpers.  Switch it to the
simpler pfn_valid method a well, and document the scheme with a single
improved comment in xen_dma_map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 include/xen/arm/page-coherent.h | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
index a840d6949a87..a8d9c0678c27 100644
--- a/include/xen/arm/page-coherent.h
+++ b/include/xen/arm/page-coherent.h
@@ -53,23 +53,17 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs)
 {
-	unsigned long page_pfn = page_to_xen_pfn(page);
-	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
-	unsigned long compound_pages =
-		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
-	bool local = (page_pfn <= dev_pfn) &&
-		(dev_pfn - page_pfn < compound_pages);
+	unsigned long pfn = PFN_DOWN(dev_addr);
 
 	/*
-	 * Dom0 is mapped 1:1, while the Linux page can span across
-	 * multiple Xen pages, it's not possible for it to contain a
-	 * mix of local and foreign Xen pages. So if the first xen_pfn
-	 * == mfn the page is local otherwise it's a foreign page
-	 * grant-mapped in dom0. If the page is local we can safely
-	 * call the native dma_ops function, otherwise we call the xen
-	 * specific function.
+	 * Dom0 is mapped 1:1, and while the Linux page can span across multiple
+	 * Xen pages, it is not possible for it to contain a mix of local and
+	 * foreign Xen pages.  Calling pfn_valid on a foreign mfn will always
+	 * return false, so if pfn_valid returns true the pages is local and we
+	 * can use the native dma-direct functions, otherwise we call the Xen
+	 * specific version.
 	 */
-	if (local)
+	if (pfn_valid(pfn))
 		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
 	else
 		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
@@ -79,14 +73,7 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long pfn = PFN_DOWN(handle);
-	/*
-	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
-	 * multiple Xen page, it's not possible to have a mix of local and
-	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
-	 * foreign mfn will always return false. If the page is local we can
-	 * safely call the native dma_ops function, otherwise we call the xen
-	 * specific function.
-	 */
+
 	if (pfn_valid(pfn))
 		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
 	else
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
