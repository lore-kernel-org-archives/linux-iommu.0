Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CAC31E4B
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 13:49:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E3320866
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 13:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cf3JZA+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E3320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 815581029;
	Fri, 14 Jun 2019 13:48:42 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6CB1ECB
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 13:48:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 695FC1DAA7
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gz4Xhr4GKX8cgnBiH4+BILh020IQOylUizPJRjDHE/E=;
	b=cf3JZA+ZRH3KX860kHpnPR8oA/
	bqAxf2wdh/kYQFTTiXQ/cfGIHFtkzi1Q6IAe9eh8VXYnYOyFEmHCCu4FhR+BvSXtpAx5ApdhZC2tL
	eqsB5EioSDc9+R5gTT7rMPzafsusILIBU05BomvsIAKlHCVNuXOq2PanGax2oHqCJpo1ef3+4E/WO
	eAvSS6Dx80B05dalPw/wekrBppUw3IEJLxzJHpuSGlVG4QM3kKSs6MrdGwLQEd0MHw3LaJPiqt54p
	Ec8ghntYydM0pKm2+mAy/RaUMsAIhlCtQMD+RUDzu5uz1USZRuoH2TqfwRFQkKEzx7x86HBrZfST/
	CbsAG57g==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbmZ3-0005hB-Ky; Fri, 14 Jun 2019 13:48:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 14/16] mm: use alloc_pages_exact_node to implement
	alloc_pages_exact
Date: Fri, 14 Jun 2019 15:47:24 +0200
Message-Id: <20190614134726.3827-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	Intel Linux Wireless <linuxwifi@intel.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	linux-media@vger.kernel.org
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

No need to duplicate the logic over two functions that are almost the
same.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/gfp.h |  5 +++--
 mm/page_alloc.c     | 39 +++++++--------------------------------
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 4274ea6bc72b..c616a23a3f81 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -530,9 +530,10 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
 void free_pages_exact(void *virt, size_t size);
-void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask);
+void *alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask);
+#define alloc_pages_exact(size, gfp_mask) \
+	alloc_pages_exact_node(NUMA_NO_NODE, size, gfp_mask)
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd2fed66b656..dec68bd21a71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4859,34 +4859,6 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 	return (void *)addr;
 }
 
-/**
- * alloc_pages_exact - allocate an exact number physically-contiguous pages.
- * @size: the number of bytes to allocate
- * @gfp_mask: GFP flags for the allocation, must not contain __GFP_COMP
- *
- * This function is similar to alloc_pages(), except that it allocates the
- * minimum number of pages to satisfy the request.  alloc_pages() can only
- * allocate memory in power-of-two pages.
- *
- * This function is also limited by MAX_ORDER.
- *
- * Memory allocated by this function must be released by free_pages_exact().
- *
- * Return: pointer to the allocated area or %NULL in case of error.
- */
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
-{
-	unsigned int order = get_order(size);
-	unsigned long addr;
-
-	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
-		gfp_mask &= ~__GFP_COMP;
-
-	addr = __get_free_pages(gfp_mask, order);
-	return make_alloc_exact(addr, order, size);
-}
-EXPORT_SYMBOL(alloc_pages_exact);
-
 /**
  * alloc_pages_exact_node - allocate an exact number of physically-contiguous
  *			   pages on a node.
@@ -4894,12 +4866,15 @@ EXPORT_SYMBOL(alloc_pages_exact);
  * @size: the number of bytes to allocate
  * @gfp_mask: GFP flags for the allocation, must not contain __GFP_COMP
  *
- * Like alloc_pages_exact(), but try to allocate on node nid first before falling
- * back.
+ * This function is similar to alloc_pages_node(), except that it allocates the
+ * minimum number of pages to satisfy the request while alloc_pages() can only
+ * allocate memory in power-of-two pages.  This function is also limited by
+ * MAX_ORDER.
  *
- * Return: pointer to the allocated area or %NULL in case of error.
+ * Returns a pointer to the allocated area or %NULL in case of error, memory
+ * allocated by this function must be released by free_pages_exact().
  */
-void * __meminit alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask)
+void *alloc_pages_exact_node(int nid, size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	struct page *p;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
