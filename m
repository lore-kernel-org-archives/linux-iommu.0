Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CCC4363C
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C706113D
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C706113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B40441993;
	Thu,  8 Apr 2021 17:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1rAOK_1liMG; Thu,  8 Apr 2021 17:01:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 541AA4195D;
	Thu,  8 Apr 2021 17:01:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 417AAC000C;
	Thu,  8 Apr 2021 17:01:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1431AC001B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0362607B5
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5C0-058t-vkC for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCBA760DF0
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=tlAUAM4FKdp5C5xhf+V1g45WbBrDWzP8fEWhlnVYrUo=; b=n1bSGXMx3FYhH1wzUo2jGEZ9ak
 pQQSQeBdx02fo7qz3c0uJZbUiLQuVUKGlgrY+2MYQhQXzs4WrKFiAJJBMygOY3za0UJZjQ71S5VO7
 kLVGt+EaaqTJ6C81L9qZoZgce96ZyjCKRWGhUJ8KwGKx8hfWUZiwsrQHcmYDgFDt2vtxZCDqwWlhh
 61udMmg/gv/fOKFrrOIuICZYqlicG0YgklOkg6Gwuh5kGrGuwA7QtnvcI7CDUkzAk3dN3vMe8KRfF
 AxcImGFGm7NKynTXZqly83Br1CgSG82zQ1LfEorx0W8mYIor6QjAa0KE0ZsRAY+VaJcL6/zSF4zhh
 jNFr+nFQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY2G-0002Lk-TI; Thu, 08 Apr 2021 11:01:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY25-0002Ix-Ig; Thu, 08 Apr 2021 11:01:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  8 Apr 2021 11:01:12 -0600
Message-Id: <20210408170123.8788-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

dma_map_sg() either returns a positive number indicating the number
of entries mapped or zero indicating that resources were not available
to create the mapping. When zero is returned, it is always safe to retry
the mapping later once resources have been freed.

Once P2PDMA pages are mixed into the SGL there may be pages that may
never be successfully mapped with a given device because that device may
not actually be able to access those pages. Thus, multiple error
conditions will need to be distinguished to determine weather a retry
is safe.

Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
convention from dma_map_sg(). The function will return a positive
integer on success or a negative errno on failure.

ENOMEM will be used to indicate a resource failure and EREMOTEIO to
indicate that a P2PDMA page is not mappable.

The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
level implementations that P2PDMA pages are allowed and to warn if a
caller introduces them into the regular dma_map_sg() interface.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-mapping.h | 15 +++++++++++
 kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2a984cb4d1e0..50b8f586cf59 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -60,6 +60,12 @@
  * at least read-only at lesser-privileged levels).
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
+/*
+ * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
+ * dma_map_sg_p2pdma() instead. Used internally to indicate that the
+ * caller is using the dma_map_sg_p2pdma() interface.
+ */
+#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
@@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
 				      unsigned long attrs);
@@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	return 0;
 }
+static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return 0;
+}
 static inline void dma_unmap_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
+#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
 #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b6a633679933..923089c4267b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
-/*
- * dma_maps_sg_attrs returns 0 on error and > 0 on success.
- * It should never return a value < 0.
- */
-int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs)
+static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	int ents;
@@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
+
+	return ents;
+}
+
+/*
+ * dma_maps_sg_attrs returns 0 on error and > 0 on success.
+ * It should never return a value < 0.
+ */
+int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	int ents;
+
+	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
@@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 }
 EXPORT_SYMBOL(dma_map_sg_attrs);
 
+/*
+ * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
+ * on success). This function must be used if PCI P2PDMA pages might
+ * be in the scatterlist.
+ *
+ * On error this function may return:
+ *    -ENOMEM indicating that there was not enough resources available and
+ *      the transfer may be retried later
+ *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
+ *      be mapped by the specified device, retries will always fail
+ *
+ * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
+ */
+int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int ents;
+
+	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
+				  attrs | __DMA_ATTR_PCI_P2PDMA);
+	if (!ents)
+		ents = -ENOMEM;
+
+	if (ents > 0)
+		debug_dma_map_sg(dev, sg, nents, ents, dir);
+
+	return ents;
+}
+EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
+
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
 				      unsigned long attrs)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
