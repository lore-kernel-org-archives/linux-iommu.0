Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE284C43214
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735C60524
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A735C60524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89EAB60707;
	Sat, 28 Aug 2021 15:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6maG2zuv9Pk; Sat, 28 Aug 2021 15:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1FB2606C2;
	Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8205EC0020;
	Sat, 28 Aug 2021 15:38:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ABF8C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17FC3401B0
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Kk+gP5xG";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="wux3N48t"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2-HuS8OZ6QK for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E51A240229
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:25 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 60219580A6B;
 Sat, 28 Aug 2021 11:38:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 28 Aug 2021 11:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=ZrPBniwQgp/pT
 AmxZg5So6bgv4JfHLcME0E/PbntOfI=; b=Kk+gP5xG+AkV4vbMC5yQZarOx4tSl
 DuduF94PREcOnnpMvxeaLH4pLEhiPSN2dqJsgwJhicWbBr+WoAKemABMmkz5e70V
 2xApMkdNfyvIQfg5VATHUDgoajE+TMWThiEFLi/IaHkrrPl3XhRPllC3Sul6ISOD
 mRPuQ9RyvexcbljJuBTkmnG9ifIZrVTR4iQxDvffhFhNv44KCCoxdq8R+He017v0
 DEJ62SMgdEItZVXLT5Z34ORzxgjXG0P7Af9+GVbddw/RGyKOVBmFQq2fElnayhbp
 DGHi8d30gjorvNOgJcABq3v+6wVKYRZYUtmrgIuIundBKC1jg+F+vDXOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=ZrPBniwQgp/pTAmxZg5So6bgv4JfHLcME0E/PbntOfI=; b=wux3N48t
 0wP6OXfiLVB9Tq6MGzg0UNPI02CUottwzYPJu1s0h8wSo18uh++rsFpFY2xT9C4c
 m+f0as0X05tJtVS+9kTynWpa0K3770lB6TPAvvpFL7lddA5ZfIHvPeC9/qpRizcE
 s8VWmoG+2lFZQpyjHWnpvZL6zXEzl1hsqjXiTKp2W5oJTxWir0OLgWqfL5tDO9ao
 2SpPPsQiYzbh3tFGnClk+v02/KY/JqpOxuI4SSP5r+mKA9t79QT8yqA+mrFNqCox
 3IjqrF3w4EepNgsjTKDnoOoXE9xmgnqvyrTWgVKqiAPWAXqWlXM5I2JpU/Z2Y4EL
 z3Tj3Pg/Pgv+Yg==
X-ME-Sender: <xms:b1gqYWbBSB4mEYyw023w9GN_sAKEXVe5pRdlOaHKBTtH0lARpdALtQ>
 <xme:b1gqYZYYukgjlh9NdMOmWU9dZ1_muzbzJpeoVv7bJv0YfeJFker88oyUd4nSJmu-A
 tUHfMCAw2vQdyKwApQ>
X-ME-Received: <xmr:b1gqYQ-U-96Atj5BTQ6lTM3Lw1ylmxCsln70IjJHIZjc827k13cVKb59QsU8yrQve5_4agNnn3MvVC6ukfnOeW3NxxlP41x35ktEgDEzXyIY5lGYuh7l318WQI9rnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:b1gqYYrw2ry2ANuko5JMlu_5QNHgDWFOl-wxexqYzvwgw_23wwD4RA>
 <xmx:b1gqYRor0MQwDMHbovCLIcWSN6wIvXa6SgtXDwf8462clq2enYW46g>
 <xmx:b1gqYWRSOpzqD14aDyzmNvhafZVz3JfY6AEC_JgEAfchI2EaZkSrew>
 <xmx:b1gqYc1HFYURbhyuD2OuDisu0v3Aw2yIzM2vICICUC52nTkqBjJ_UQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:21 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 5/8] iommu/dma: Support PAGE_SIZE < iovad->granule
 allocations
Date: Sat, 28 Aug 2021 17:36:39 +0200
Message-Id: <20210828153642.19396-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Noncontiguous allocations must be made up of individual blocks
in a way that allows those blocks to be mapped contiguously in IOVA space.
For IOMMU page sizes larger than the CPU page size this can be done
by allocating all individual blocks from pools with
order >= get_order(iovad->granule). Some spillover pages might be
allocated at the end, which can however immediately be freed.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 99 +++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a091cff5829d..e57966bcfae1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -17,6 +17,7 @@
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -618,6 +619,9 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 {
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int j;
+	unsigned long min_order = __fls(order_mask);
+	unsigned int min_order_size = 1U << min_order;
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -657,15 +661,37 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 				split_page(page, order);
 			break;
 		}
-		if (!page) {
-			__iommu_dma_free_pages(pages, i);
-			return NULL;
+
+		/*
+		 * If we have no valid page here we might be trying to allocate
+		 * the last block consisting of 1<<order pages (to guarantee
+		 * alignment) but actually need less pages than that.
+		 * In that case we just try to allocate the entire block and
+		 * directly free the spillover pages again.
+		 */
+		if (!page && !order_mask && count < min_order_size) {
+			page = alloc_pages_node(nid, gfp, min_order);
+			if (!page)
+				goto free_pages;
+			split_page(page, min_order);
+
+			for (j = count; j < min_order_size; ++j)
+				__free_page(page + j);
+
+			order_size = count;
 		}
+
+		if (!page)
+			goto free_pages;
 		count -= order_size;
 		while (order_size--)
 			pages[i++] = page++;
 	}
 	return pages;
+
+free_pages:
+	__iommu_dma_free_pages(pages, i);
+	return NULL;
 }
 
 /*
@@ -682,15 +708,26 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	struct scatterlist *last_sg;
 	struct page **pages;
 	dma_addr_t iova;
+	phys_addr_t orig_s_phys;
+	size_t orig_s_len, orig_s_off, s_iova_off, iova_size;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return NULL;
 
 	min_size = alloc_sizes & -alloc_sizes;
-	if (min_size < PAGE_SIZE) {
+	if (iovad->granule > PAGE_SIZE) {
+		if (size < iovad->granule) {
+			/* ensure a single contiguous allocation */
+			min_size = ALIGN(size, PAGE_SIZE*(1U<<get_order(size)));
+			alloc_sizes = min_size;
+		}
+
+		size = PAGE_ALIGN(size);
+	} else if (min_size < PAGE_SIZE) {
 		min_size = PAGE_SIZE;
 		alloc_sizes |= PAGE_SIZE;
 	} else {
@@ -705,12 +742,14 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	if (!pages)
 		return NULL;
 
-	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova_size = iova_align(iovad, size);
+	iova = iommu_dma_alloc_iova(domain, iova_size, dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
-	if (sg_alloc_table_from_pages(sgt, pages, count, 0, size, GFP_KERNEL))
+	last_sg = __sg_alloc_table_from_pages(sgt, pages, count, 0, iova_size,
+					      UINT_MAX, NULL, 0, GFP_KERNEL);
+	if (IS_ERR(last_sg))
 		goto out_free_iova;
 
 	if (!(ioprot & IOMMU_CACHE)) {
@@ -721,18 +760,58 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 			arch_dma_prep_coherent(sg_page(sg), sg->length);
 	}
 
+	if (iovad->granule > PAGE_SIZE) {
+		if (size < iovad->granule) {
+			/*
+			 * we only have a single sg list entry here that is
+			 * likely not aligned to iovad->granule. adjust the
+			 * entry to represent the encapsulating IOMMU page
+			 * and then later restore everything to its original
+			 * values, similar to the impedance matching done in
+			 * iommu_dma_map_sg.
+			 */
+			orig_s_phys = sg_phys(sgt->sgl);
+			orig_s_len = sgt->sgl->length;
+			orig_s_off = sgt->sgl->offset;
+			s_iova_off = iova_offset(iovad, orig_s_phys);
+
+			sg_set_page(sgt->sgl,
+				phys_to_page(orig_s_phys - s_iova_off),
+				iova_align(iovad, orig_s_len + s_iova_off),
+				sgt->sgl->offset & ~s_iova_off);
+		} else {
+			/*
+			 * convince iommu_map_sg_atomic to map the last block
+			 * even though it may be too small.
+			 */
+			orig_s_len = last_sg->length;
+			last_sg->length = iova_align(iovad, last_sg->length);
+		}
+	}
+
 	if (iommu_map_sg_atomic(domain, iova, sgt->sgl, sgt->orig_nents, ioprot)
-			< size)
+			< iova_size)
 		goto out_free_sg;
 
+	if (iovad->granule > PAGE_SIZE) {
+		if (size < iovad->granule) {
+			sg_set_page(sgt->sgl, phys_to_page(orig_s_phys),
+				orig_s_len, orig_s_off);
+
+			iova += s_iova_off;
+		} else {
+			last_sg->length = orig_s_len;
+		}
+	}
+
 	sgt->sgl->dma_address = iova;
-	sgt->sgl->dma_length = size;
+	sgt->sgl->dma_length = iova_size;
 	return pages;
 
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(cookie, iova, iova_size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
