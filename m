Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BFC433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE8E208B8
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KKhvj8+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE8E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D287A89957;
	Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLnHl8mMaRPz; Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F415C896AF;
	Fri, 19 Jun 2020 10:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB810C089E;
	Fri, 19 Jun 2020 10:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D339C0865
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E344988E80
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJryIfynnj2m for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:36:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 123F088E7F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:36:57 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103655euoutp017606b2775fc69e1810d0361a7f6f3ade~Z65-0Tqr41836418364euoutp01O
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200619103655euoutp017606b2775fc69e1810d0361a7f6f3ade~Z65-0Tqr41836418364euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563015;
 bh=SiDbyfz+DT2A87073zIKJOnOPoiLke52kDecHXuerdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KKhvj8+Uw2FO7t+Aqfqf7wHlTcC7m81tgQTYGa7LTSLWDxn95j4uFpUdvJSRgZA0m
 2cIVsGWzauYHhU7RUjDoLWDJS/wmbP9A43CnliDFk2EJDitgld2JJT9lZ7CrhomQnr
 HjWBjnwPUmVWdjSfEqkxm3K961MLzDG5dKgjO7AU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200619103655eucas1p203c16efdd1ae8d5c522e56b6528b4c06~Z65-X3x462889328893eucas1p2j;
 Fri, 19 Jun 2020 10:36:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.8D.05997.6459CEE5; Fri, 19
 Jun 2020 11:36:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210~Z65_vv1sk2893928939eucas1p2R;
 Fri, 19 Jun 2020 10:36:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103654eusmtrp1fa456b45408242fead0128e61b85a43d~Z65_vC34y0959609596eusmtrp1r;
 Fri, 19 Jun 2020 10:36:54 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-ce-5eec9546e73e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.DA.06314.6459CEE5; Fri, 19
 Jun 2020 11:36:54 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103653eusmtip2fb6ea7e1b71335bb29b3d3fa436b9e9a~Z65_Fdj8S2581725817eusmtip2i;
 Fri, 19 Jun 2020 10:36:53 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/36] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
Date: Fri, 19 Jun 2020 12:36:02 +0200
Message-Id: <20200619103636.11974-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzf7557nnvcPHo6ym+0bNeyanNImydKpRfP/KWprVXo8DjyuntQ
 0ualEudlXtaYiat5yXvdSaJWbnRhKMzuipNoCFNzNGbKedB/n+/n+/n8Pt999sMRUQdqg4dF
 xTLyKGmEGBPymz+s9DtceDTn71Sc60pl93XxqBdFjSj1tzkPoYaWFjCquraTRynfuVPGoXEe
 pZoYRqnB1hKMqu8YFVBPfr/kU2kZlSjV/msSpZrm8tDTFnRdaR2g3y4r+bSqJgOjXy1/Q+nS
 rov0WKaWR6vLk+iv6xMIXaCrAnSbPhmjc5pqAK3uSaQXVft9iKvCE8FMRFg8I3f0uCEMNWSk
 CmIGLG93ry+hycCwSwHMcEgeg5PGdEwBhLiIfAbgQq9CwA1GAPWVs4AbFgH8ka9Gti3FU7MI
 t6gCMG1wnLdjaRnS80wqjHSGinkFZsJW5AMAP2abm0QIqUTgymIaMC0sySCYkTqxEYjjfPIg
 LNP4mmiCPAl1+jaUS7ODtc/fbyabkR5w9n47anoHksMC2NC9JuBE52D5WOkWtoQ/tU1beB/s
 Kcjic4Z7AI731Qu4IQvAwdQiwKnc4UjfKma6AiEPw8ZWR44+A7NeT2zSkLSAuvndJhrZgPnN
 hQhHEzA9TcSp7WGxtmEntv3TwFZbNDR0ft8qOG+jrYpcNBfYFf8PUwJQA6yZODZSxrBHo5hb
 ElYaycZFySRB0ZEqsPG3eta1xhbQuhaoASQOxObE9KVZfxEqjWcTIjUA4ojYivDs7fEXEcHS
 hDuMPDpAHhfBsBpgi/PF1oTL0xk/ESmTxjLhDBPDyLe3PNzMJhl4IbIZ15GHRmLUqzagtcn2
 j5t1J/4FHvJzmV5OL9wji9HelcxjJauhkjBLnTQnxSZ6MKXXLNrzTb8sZIx1KicTdVMhhLdD
 RdXx6kndgfRA9WX7tVN7Yx/rVdfirxSWLITLpqF9lu/nCp+bbvLrZ9uL+r3yz/NcDN7qzOCy
 wCQxnw2VOh9B5Kz0H0PGf9BXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7puU9/EGbxsF7ToPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4Uft7JYtHUuY7U4
 +OEJq8WWNxNZHfg81sxbw+ix99sCFo9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hvc/veY2WPy
 jeWMHrtvNrB59G1Zxeix+XS1x+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
 5rFWRqZK+nY2Kak5mWWpRfp2CXoZ9zqb2AsuCVec+veVtYHxHn8XIyeHhICJxKznr5m7GLk4
 hASWMkpMO9HJCpGQkTg5rQHKFpb4c62LDaLoE6PEof5eNpAEm4ChRNdbiISIQCdQd/dHdhCH
 WWAFs8SrfXNZQKqEBRIlGnetB0pwcLAIqErMPxQMEuYVsJW4cXM31AZ5idUbDjCD2JwCdhKv
 Ww6CxYWAapYveM88gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAo2nbs5+YdjJc2
 Bh9iFOBgVOLhfRHyOk6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgW6a
 yCwlmpwPjPC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mc5lX
 /b5i2C++cNmEpsWJIeEBZjUXQkyviPzIbf379fiZ2JzLugXL3jPXfoi/06glJLKK5btPgUSy
 6X/zTlZ283y1AwJrDh9UszktVDyrhnND7qqfZgLbT5/qtdvl6MTw7l+Ux3mp8L0BWuYy788v
 XBO4+V+eitiFuszl1/JmvFGNf7xp4qMjSizFGYmGWsxFxYkAqyN577gCAAA=
X-CMS-MailID: 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210
X-Msg-Generator: CA
X-RootMTR: 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210@eucas1p2.samsung.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Replace the current hand-crafted code for extracting pages and DMA
addresses from the given scatterlist by the much more robust
code based on the generic scatterlist iterators and recently
introduced sg_table-based wrappers. The resulting code is simple and
easy to understand, so the comment describing the old code is no
longer needed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 226cd6ad3985..b717e52e909e 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -990,45 +990,26 @@ EXPORT_SYMBOL(drm_gem_prime_import);
 int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
 				     dma_addr_t *addrs, int max_entries)
 {
-	unsigned count;
-	struct scatterlist *sg;
-	struct page *page;
-	u32 page_len, page_index;
-	dma_addr_t addr;
-	u32 dma_len, dma_index;
-
-	/*
-	 * Scatterlist elements contains both pages and DMA addresses, but
-	 * one shoud not assume 1:1 relation between them. The sg->length is
-	 * the size of the physical memory chunk described by the sg->page,
-	 * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
-	 * described by the sg_dma_address(sg).
-	 */
-	page_index = 0;
-	dma_index = 0;
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
-		page_len = sg->length;
-		page = sg_page(sg);
-		dma_len = sg_dma_len(sg);
-		addr = sg_dma_address(sg);
-
-		while (pages && page_len > 0) {
-			if (WARN_ON(page_index >= max_entries))
+	struct sg_dma_page_iter dma_iter;
+	struct sg_page_iter page_iter;
+	struct page **p = pages;
+	dma_addr_t *a = addrs;
+
+	if (pages) {
+		for_each_sgtable_page(sgt, &page_iter, 0) {
+			if (p - pages >= max_entries)
 				return -1;
-			pages[page_index] = page;
-			page++;
-			page_len -= PAGE_SIZE;
-			page_index++;
+			*p++ = sg_page_iter_page(&page_iter);
 		}
-		while (addrs && dma_len > 0) {
-			if (WARN_ON(dma_index >= max_entries))
+	}
+	if (addrs) {
+		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+			if (a - addrs >= max_entries)
 				return -1;
-			addrs[dma_index] = addr;
-			addr += PAGE_SIZE;
-			dma_len -= PAGE_SIZE;
-			dma_index++;
+			*a++ = sg_page_iter_dma_address(&dma_iter);
 		}
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
