Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C7CC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2A3204FD
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rU0Si/aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2A3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 451258752C;
	Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Di84YFk1aWjD; Fri,  4 Sep 2020 13:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34407874FC;
	Fri,  4 Sep 2020 13:35:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F5FBC0890;
	Fri,  4 Sep 2020 13:35:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 896E5C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7D08B86C2C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CoGsiwjO6H2I for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:34:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9689986A40
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:57 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133455euoutp028369770903952c807e550056dd866ae0~xmAZDLZi82781727817euoutp02S
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904133455euoutp028369770903952c807e550056dd866ae0~xmAZDLZi82781727817euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226495;
 bh=kpktduf+pthZLm7B07he8El0REvronC/WDDMWzL6Xyk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rU0Si/aUDC32rlgJo21CEZRX4HnsSvWrAfYWMsBzpxYMsR1fkdUVF8Cx5MdAkteJ4
 Ujqyt/BmvybMf49764UpTI3zGaVkt4e9jgikUOnE+WW/KI29wewlnyJHmAuNXcV/M9
 6YMsRmpBiT5WJS27mb/bCBLOnE8mldT49vQ9l1HY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133454eucas1p2848e5dea17908fc582aede4e5e9c64af~xmAYsavbL0143201432eucas1p2d;
 Fri,  4 Sep 2020 13:34:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.01.06456.E72425F5; Fri,  4
 Sep 2020 14:34:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200904133454eucas1p249ecc981d26cee5cde2a6bbe05324769~xmAYW9kIA1447014470eucas1p2g;
 Fri,  4 Sep 2020 13:34:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133454eusmtrp140dca417cbf260aeaf25d5b36805e7e9~xmAYWLxkB0766507665eusmtrp1x;
 Fri,  4 Sep 2020 13:34:54 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-27-5f52427e024e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.AE.06314.E72425F5; Fri,  4
 Sep 2020 14:34:54 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133453eusmtip122b58df76f076f03ad4681e352b953a6~xmAXshNqb1924719247eusmtip1Z;
 Fri,  4 Sep 2020 13:34:53 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/30] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
Date: Fri,  4 Sep 2020 15:16:43 +0200
Message-Id: <20200904131711.12950-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGuZ3OMEVKxoLhBogkNWA0YYtER9lR45hgREh4MCgUmQCRzRZQ
 IChRqKyG5YElBGpFwQKipYCgKFSkxcYGAQ0IxCIoQthkM/BAbRnQt+/c8//nPzm5OMJ7h9rg
 MfFJtDBeEMvHzNhtfZtap9v+QWGuXS3uZKG2n0W+KG9GSX1bMUIOry9h5NOG9yxS8taDXBue
 ZJHyqS8oOdRZhZFNvROm5MPfrWxSnPsEJXuWp1FSMV+M+lpQjdWNgOrakLApuSwXo9o3dChV
 3X+J+pavYlEttXeose0phCodqQPUq9FMjHqgkAGqRZNOrcoPBnIvm3lG0rExKbTQxTvcLLq3
 0yFRbXVL36TDMsEHIg9wcEi4Q1VvPSsPmOE8oh5AmXYaY4o1ABvHJgBTrAIo0dew9iy1ktds
 plEHYHn/nspg+aHTAKMKI9xg3kIeZmQrIhtAdaG5UYQQEgRurop3RJZEJNTk9CFGZhMO8Luu
 ATUyl/CCS5MtCBNnDxued+8wh/CGreXTqHEQJL6awk8aBWBEZ+Dj8TFThi3hnEqxy3ZQU1rA
 Zgz3AJzUNpkyRQGAQ3fLd90ecFy7ZdgVN+x3BDZ3uhgREn5wRnmRQQs4srDfKEYMWNJWhjDP
 XJgj5jEzHGGl6tm/1J6Bwd31KSiukiDMgYoBlA5sYUXAvvJ/lgQAGbCmk0VxUbTILZ6+6SwS
 xImS46OcryXEyYHha2m2VSsvwfpghBIQOOCbc018gsJ4qCBFlBqnBBBH+FZc/4+aqzxupCA1
 jRYmhAmTY2mREtjibL4195h09gqPiBIk0ddpOpEW7nVZOMcmE7QX9FisrLvbqpZLT9vYZc1v
 Kf18U7Ky8y+EBvz5mVYabKLziTgZfTi0xFP9qPJUX9G+xbPhHcHdHa4hQQnOzhll0gNv1DWf
 O9PFyRWzJ87PlM0dvz8a4XUjAAmMPad3dLJ1WKympSaHMhXyepvC4QyOzFJRsfIL9WyOCnHR
 L5PdfLYoWuB2FBGKBH8BAV+Bs1YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7p1TkHxBofvylr0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xcKPW1ks2jqXsVoc
 /PCE1WLLm4msDnwea+atYfTY+20Bi8emVZ1sHtu/PWD1mHcy0ON+93Emj81L6j1u/3vM7DH5
 xnJGj903G9g8+rasYvTYfLra4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj
 81grI1MlfTublNSczLLUIn27BL2MI7tUC06IVPxf+4CtgfGUQBcjJ4eEgInEkgV7WLoYuTiE
 BJYyStycdJIRIiEjcXJaAyuELSzx51oXG0TRJ0aJ429/s4Ek2AQMJbreQiREBDoZJaZ1f2QH
 cZgFVjBLvNo3lwWkSlggSeJV4zEmEJtFQFXi0YPVYGN5BWwl3j/czAyxQl5i9YYDYDangJ3E
 1hlPwGqEgGo+zFnMMoGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAKNp27OfmHYyX
 NgYfYhTgYFTi4WWwD4oXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6Cj
 JjJLiSbnAyM8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo6zd
 6SnVr05qPtsrc+G6UrfJ/N2r+P99az5w5gz3/JeHVJ6/frrVO8JcUqPoL5/2FRm7LGXuJfsu
 HLV6xsn2ZJHjjcUXOpK2bJjSIBlZ+X6qt3PMi/YT2w/9zzu/bhXHjXvFv7uO23fIfZ5h0/mt
 TFdKNPGVRbqkhnX5rz1ffFq0p7TVr1r4c4kSS3FGoqEWc1FxIgBfM8CxuAIAAA==
X-CMS-MailID: 20200904133454eucas1p249ecc981d26cee5cde2a6bbe05324769
X-Msg-Generator: CA
X-RootMTR: 20200904133454eucas1p249ecc981d26cee5cde2a6bbe05324769
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133454eucas1p249ecc981d26cee5cde2a6bbe05324769
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133454eucas1p249ecc981d26cee5cde2a6bbe05324769@eucas1p2.samsung.com>
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
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 4ed5ed1f078c..c5e796d4a489 100644
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
+			if (WARN_ON(p - pages >= max_entries))
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
+			if (WARN_ON(a - addrs >= max_entries))
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
