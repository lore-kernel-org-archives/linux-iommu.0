Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC5C2D114
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D0D20794
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AvBafkx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0D20794
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9B14C22219;
	Wed, 13 May 2020 13:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x907ZGZsssPL; Wed, 13 May 2020 13:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9EE0D25E15;
	Wed, 13 May 2020 13:33:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E798C088F;
	Wed, 13 May 2020 13:33:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB53C0178
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B5F686FA3
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ikF2ne40HMFq for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A5DC87051
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:02 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133300euoutp013dbb2948ade892790b0306961eb31211~OmcLNqLfT2196321963euoutp01Y
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133300euoutp013dbb2948ade892790b0306961eb31211~OmcLNqLfT2196321963euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376780;
 bh=oNpMhB6u80Fid+GHvivkODco9j1HUEJu/W2ta0uaMDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AvBafkx8brbSRRV748D45ZRkxVq+2emMkwsgn0Js6V0CzzlwxhG0bU2A9xwuDWc59
 KXWlchNKRBAIHoyntQSuWPaQW0aihc78E9J/U67ldQh5hskeo+9H/Tm82nr950x6MP
 e05wFItxakZryos0E4inWRbb7Kk8Ojjm4Mh5a/fk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133300eucas1p20002e9cdc628d3268278598f4364bece~OmcK5YtwM1009610096eucas1p2w;
 Wed, 13 May 2020 13:33:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.F0.60679.C07FBBE5; Wed, 13
 May 2020 14:33:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133259eucas1p273f0e05005b7b1158d884295d35745fd~OmcKaiQ0k2378623786eucas1p2s;
 Wed, 13 May 2020 13:32:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133259eusmtrp1b523be1c96f1abf4612d97b3081404a1~OmcKZ24kJ1011910119eusmtrp1m;
 Wed, 13 May 2020 13:32:59 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-21-5ebbf70c6c31
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.0A.08375.B07FBBE5; Wed, 13
 May 2020 14:32:59 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133258eusmtip1a63e165bb22888a2895f3f37f60fd350~OmcJuktVf3222032220eusmtip1z;
 Wed, 13 May 2020 13:32:58 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/38] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
Date: Wed, 13 May 2020 15:32:12 +0200
Message-Id: <20200513133245.6408-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzf73m5e5izp6P5pZZ2G01bh972FBXNeNaWpba2WtTFk5ccdg8K
 a5G5IVpekjCj4sI5hTAm7hJJO4aZOG9jIwvJ27x35yH/fb7fz+fz/Xx/3/0IVNiMWxIBwWGM
 LFgSJOIZY9UtK9rjJsv13vbN3zEqRduGUB+zynFqqzoVpXoWZ3lUcelXhMpvdKQWekYRqmKs
 F6e663J5VFnzIJ8qmPuEUfLEIpxS/xnHqarfqbizKa3MUwK6YSkfoytKEnl0zdIITue1edLD
 z1oRuvLdE3pgcwyl0/sUgK7/GcOjn1eVALqyPZqerzh8VXDL2MmXCQqIYGR2F+4a+7dl1oLQ
 yv2PMmu7sRhQtC8JGBGQPAU1q9O8JGBMCMn3ANYUFGNcsQBg97CSzxXzAI5MpiG7lpaOSpQj
 FACu5uj2LGszctSg4pEOMGk6iWfA5mQ8gN9STAwilMxH4cq8HBgIM9IHjnyO3RZhpDVsTO7E
 DVhAOkHVy2E+F2cFSz80bQ81Is/DKV3jdhoku/hwpGUC40Su8PXbjB1sBqdaq3bMh2B7evKO
 IQ7AUW0ZnyuS9c97mgU4lSPUaVf1axD6/WxheZ2dAULSBTan23DQFPZNb18M1cO06lco1xbA
 BLmQm2EDs1tV/1PVnV0oh2n4I6EU4Q70BcBZhQZ5Aayy97LyASgBFkw4K/Vj2BPBzEMxK5Gy
 4cF+Yp8QaQXQ/632zdaFWlC3fk8DSAKITARUf723EJdEsJFSDYAEKjIXeJTrWwJfSWQUIwu5
 IwsPYlgNOEhgIgvByTe/vISknySMecAwoYxsl0UII8sYcMX+wPUNF5P7tblHGop1blkeizlb
 C2eQwNOu51zi3HXeSmWTxvmmdG3Oeuas+FK29oa8/FqGu3Xc46sD84nrpGeseqhLGD+lSCZB
 1Ea8oreGXTQb94o2PTp3W93797LKdrJArOpfjlVeTHQDKtAy0TjUETg43eRQKI4vTHAvEGGs
 v8ThGCpjJf8AktPkG1cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rc33fHGdxrVLLoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4Uft7JYtHUuY7U4
 +OEJq8WWNxNZHfg81sxbw+ix99sCFo9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hvc/veY2WPy
 jeWMHrtvNrB59G1Zxeix+XS1x+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
 5rFWRqZK+nY2Kak5mWWpRfp2CXoZJ6ftYCzYLFoxbcdllgbGZYJdjJwcEgImEsfOb2YGsYUE
 ljJKfG4uhYjLSJyc1sAKYQtL/LnWxdbFyAVU84lRYv+VfWAJNgFDia63EAkRgU5GiWndH9lB
 HGaBFcwSr/bNZQGpEhZIlGjZOAVsBYuAqsT+ngtg3bwCNhLrpt5nh1ghL7F6wwGwGk4BW4lX
 d/azQJyUL7F38T62CYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG0bZjPzfvYLy0
 MfgQowAHoxIPr8Wt3XFCrIllxZW5hxglOJiVRHj91gOFeFMSK6tSi/Lji0pzUosPMZoCHTWR
 WUo0OR8Y4Xkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgFOto3
 nBbydDOV/c2pbKEteHBj4rR4uSk+Ut88FKZV3F735WPhvlhrtabJv3aVHNB8brxM8KqSUt76
 ygXrDR3f1YjbdksLr//I8GtLeG+5g1zlooxk39Pa+zheuk364rHRpX1O2utPHp2coqKCB3Xa
 29zCdGySmfv7DtcJTKv66bBh05Xr15RYijMSDbWYi4oTAZ3DacK4AgAA
X-CMS-MailID: 20200513133259eucas1p273f0e05005b7b1158d884295d35745fd
X-Msg-Generator: CA
X-RootMTR: 20200513133259eucas1p273f0e05005b7b1158d884295d35745fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133259eucas1p273f0e05005b7b1158d884295d35745fd
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133259eucas1p273f0e05005b7b1158d884295d35745fd@eucas1p2.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/drm_prime.c | 47 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 1d2e5fe..dfdf4d4 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -985,45 +985,26 @@ struct drm_gem_object *drm_gem_prime_import(struct drm_device *dev,
 int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
 				     dma_addr_t *addrs, int max_entries)
 {
-	unsigned count;
-	struct scatterlist *sg;
-	struct page *page;
-	u32 page_len, page_index;
-	dma_addr_t addr;
-	u32 dma_len, dma_index;
+	struct sg_dma_page_iter dma_iter;
+	struct sg_page_iter page_iter;
+	struct page **p = pages;
+	dma_addr_t *a = addrs;
 
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
