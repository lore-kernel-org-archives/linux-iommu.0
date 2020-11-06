Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EC4C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:32:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B4A2151B
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="rY/cLrzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B4A2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 249C32E136;
	Fri,  6 Nov 2020 17:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hb-9FHYLQulV; Fri,  6 Nov 2020 17:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9EC442E13F;
	Fri,  6 Nov 2020 17:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A589C1AD4;
	Fri,  6 Nov 2020 17:32:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03F8EC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D1FD2045A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKXBwipX+4-u for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by silver.osuosl.org (Postfix) with ESMTPS id E0A2A20422
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VLOfKPK+Zi2nLbPxB2RMFlp3vuqLnc2Fa5/3XSZoOkg=; b=rY/cLrzCiAzbq4ZIlHRpYwdkI6
 WqQYPcJFEOLZTMtY7YzVS5nKxRMAYBSmO1PqPdFS7hIq5M1Zx9aqk8kudHNloty/eBUsDetBOGtwo
 WVPRcquq607bgfsQZmvaozqmWVbkFzwBmFJ0wbhoE+FZnFUmVtHa+NcgtRHa0Vybx1th5NikUPGc0
 NXAtdqGsC5Ygfn7zy1iJg1it8qHpJvu85FILHZZJI1gBJ9gEZiFRnzN2XQOsl33s0J1c97PMr5oGv
 x2iFNr6WpFpmBb0KHX1xBldnhJBHO0Lc5vsS0jaQZqtjXpLUOMoybdNw6MqkZS8xtZ8+DxVTO/Y3b
 /VpCw86A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56i-0002PV-Cj; Fri, 06 Nov 2020 10:01:02 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004t8-Sl; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:28 -0700
Message-Id: <20201106170036.18713-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 07/15] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

When a PCI P2PDMA page is seen, set the IOVA length of the segment
to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
apply the appropriate bus address to the segment. The IOVA is not
created if the scatterlist only consists of P2PDMA pages.

Similar to dma-direct, DMA_ATTR_P2PDMA is used to indicate caller
support seeing the high bit of the dma_length is used as a flag
to indicate P2PDMA segments.

On unmap, P2PDMA segments are skipped over when determining the
start and end IOVA addresses.

With this change, the flags variable in the dma_map_ops is
set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 63 ++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5591d6593583..1c8402474376 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -872,13 +873,16 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
  * segment's start address to avoid concatenating across one.
  */
 static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
-		dma_addr_t dma_addr)
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct scatterlist *s, *cur = sg;
 	unsigned long seg_mask = dma_get_seg_boundary(dev);
 	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
 	int i, count = 0;
 
+	if (attrs & DMA_ATTR_P2PDMA && max_len >= SG_P2PDMA_FLAG)
+		max_len = SG_P2PDMA_FLAG - 1;
+
 	/*
 	 * The Intel graphic driver is used to assume that the returned
 	 * sg list is not combound. This blocks the efforts of converting
@@ -917,6 +921,19 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
+		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
+			if (i > 0)
+				cur = sg_next(cur);
+
+			sg_dma_address(cur) = sg_phys(s) + s->offset -
+				pci_p2pdma_bus_offset(sg_page(s));
+			sg_dma_len(cur) = s->length | SG_P2PDMA_FLAG;
+
+			count++;
+			cur_len = 0;
+			continue;
+		}
+
 		/*
 		 * Now fill in the real DMA data. If...
 		 * - there is a valid output segment to append to
@@ -1013,11 +1030,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
+	struct dev_pagemap *pgmap = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
-	int i;
+	int i, map = -1;
 
 	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
 		return 0;
@@ -1045,6 +1063,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		s_length = iova_align(iovad, s_length + s_iova_off);
 		s->length = s_length;
 
+		if (is_pci_p2pdma_page(sg_page(s))) {
+			if (sg_page(s)->pgmap != pgmap) {
+				pgmap = sg_page(s)->pgmap;
+				map = pci_p2pdma_should_map_bus(dev, pgmap);
+			}
+
+			if (map < 0 || !(attrs & DMA_ATTR_P2PDMA))
+				goto out_restore_sg;
+
+			if (map) {
+				s->length = 0;
+				continue;
+			}
+		}
+
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
 		 * depend on these assumptions about the segment boundary mask:
@@ -1067,6 +1100,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
+	if (!iova_len)
+		return __finalise_sg(dev, sg, nents, 0, attrs);
+
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
@@ -1078,7 +1114,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
-	return __finalise_sg(dev, sg, nents, iova);
+	return __finalise_sg(dev, sg, nents, iova, attrs);
 
 out_free_iova:
 	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
@@ -1090,7 +1126,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t start, end;
+	dma_addr_t end, start = DMA_MAPPING_ERROR;
 	struct scatterlist *tmp;
 	int i;
 
@@ -1106,14 +1142,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
 	 */
-	start = sg_dma_address(sg);
-	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
-		if (sg_dma_len(tmp) == 0)
+	for_each_sg(sg, tmp, nents, i) {
+		if ((attrs & DMA_ATTR_P2PDMA) && sg_dma_is_p2pdma(tmp))
+			continue;
+		if (sg_dma_p2pdma_len(tmp) == 0)
 			break;
-		sg = tmp;
+
+		if (start == DMA_MAPPING_ERROR)
+			start = sg_dma_address(tmp);
+
+		end = sg_dma_address(tmp) + sg_dma_len(tmp);
 	}
-	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+
+	if (start != DMA_MAPPING_ERROR)
+		__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
@@ -1334,6 +1376,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
