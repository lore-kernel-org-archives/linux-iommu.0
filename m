Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6857FC433FE
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146A761057
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 146A761057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECB90600CC;
	Tue, 19 Oct 2021 16:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBWhot2eqO1h; Tue, 19 Oct 2021 16:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B844E60723;
	Tue, 19 Oct 2021 16:38:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A397BC000F;
	Tue, 19 Oct 2021 16:38:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2FA1C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96208606EC
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-iVLosTbomz for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3FCC606B6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:56 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id DEAC8580FAB;
 Tue, 19 Oct 2021 12:38:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 19 Oct 2021 12:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=Lm167NMYXwDZM
 5T2X52d4c+cqmvc3ib0uOll8ogRyr0=; b=kaFG4MWkopcsn6C2h32z1M2E86eHt
 LnPKVoJ9uAfRyWkPDgmLzfl2GGIDe6V5vb7IQ3Xfb7hninoKFCiTnFJQrF/xZy4k
 wpST3OuxZHvZRbZoaJQnEZwaxCBaJUzmF+XKQD/P4UTwMX66Xk11UbEhMti3lTHp
 ygRjw7I+B5Glrm59a6jrlecgDwWqKlT5+EU18S/t5fNHxUJ6MjpeoSayW/bVWQ3b
 vi0gaB5/6FTHcleRRrVlrLs7I4dldLyx54VGTxNp1Ss4RYaYll5o/HK81GmAYmUy
 L9UCDGBZ1KyULAxu6uts9KvVT239ftIgrEVAlLnZNEI5eB/uoFtmhxQWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Lm167NMYXwDZM5T2X52d4c+cqmvc3ib0uOll8ogRyr0=; b=YvQyiO+z
 TrGQoiI9DO5Xd+flepqOgobBH2hQ20alakaelO0QnNPFYJsJws2z0U67BvdN2R2x
 73ezK08KmTj3DKrQRbKhmuGOwxfZjUFZGro0c4oknlwsfPSvCjr5+mnKg7BeE84w
 zPqWctDJvspTfMdgcmhSJ9pGC5ZxT1sV1ikGlqGwsl6us/jqaycMp7m5bEQVc7mM
 rf33zXbmleKyI4RKuKBDYh00GyrvloqGqcnJ1Y7d+F5bxw7kj2bG9l96qcHjq+GD
 JZu9r13hXeA+x0SCsEIrCc/Z1dOkX42f17O5ji7VnbOq4/XZ8nUsMvZ5xqCEtc71
 F4RL8YkfE5lXfQ==
X-ME-Sender: <xms:n_RuYZwxo5_cJqP9Ru1HE-k7isbhyRcmOvky9_LGC_EDVBkG7NDKeQ>
 <xme:n_RuYZRj1OJGNiBpiwE11P0e-d9s2mx73D9CeZ769N2WLYAl8Dj-0A716korSHzgD
 yy7HttuqSftKwQ48_A>
X-ME-Received: <xmr:n_RuYTW2tYH31tyFj-CnTUwzf09jGA1i3IR1GvCuM-gvZO4kOUIEeP3uo4ReBsst8pDo8REntc5d0dV-EbhDO-HZgk47lqFCq02a5pkP-MFQtJTdr4V3Quc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:n_RuYbie0a8SOzf1LUhz0oGMRZKKfjS9PFriz044fVQLx4QWMg2kdg>
 <xmx:n_RuYbCovU7J3FtAMwjJ_TtbOD19-ZCa3z7BotRC_y6tIG8hi1w0mQ>
 <xmx:n_RuYUKPdY8hoDx0zPuBYDXfDlEQClFwpsgSSLkDv8GvPOabreNb_w>
 <xmx:n_RuYf7Gn3nKaUmPoAmqX_WLY7KUeID-N9VQMh2pY8AHj3ZYHk4iNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:54 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 3/6] iommu/dma: Support granule > PAGE_SIZE allocations
Date: Tue, 19 Oct 2021 18:37:34 +0200
Message-Id: <20211019163737.46269-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
 drivers/iommu/dma-iommu.c | 103 ++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea799e70fc98..579a5a89d1ec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -17,6 +17,7 @@
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pfn.h>
@@ -547,6 +548,9 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 {
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int j;
+	unsigned long min_order = __fls(order_mask);
+	unsigned int min_order_size = 1U << min_order;
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -586,15 +590,37 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
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
@@ -611,15 +637,27 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	struct sg_append_table sgt_append = {};
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
@@ -634,13 +672,17 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	if (!pages)
 		return NULL;
 
-	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova_size = iova_align(iovad, size);
+	iova = iommu_dma_alloc_iova(domain, iova_size, dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
-	if (sg_alloc_table_from_pages(sgt, pages, count, 0, size, GFP_KERNEL))
+	/* append_table is only used to get a pointer to the last entry */
+	if (sg_alloc_append_table_from_pages(&sgt_append, pages, count, 0,
+					iova_size, UINT_MAX, 0, GFP_KERNEL))
 		goto out_free_iova;
+	memcpy(sgt, &sgt_append.sgt, sizeof(*sgt));
+	last_sg = sgt_append.prv;
 
 	if (!(ioprot & IOMMU_CACHE)) {
 		struct scatterlist *sg;
@@ -650,18 +692,59 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
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
+				pfn_to_page(PHYS_PFN(orig_s_phys - s_iova_off)),
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
+			sg_set_page(sgt->sgl,
+				pfn_to_page(PHYS_PFN(orig_s_phys)),
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
