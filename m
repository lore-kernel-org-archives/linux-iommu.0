Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293BC81846
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E0020714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BP901js1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E0020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AC2687128;
	Tue, 12 May 2020 09:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQg8FNl1afNm; Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6231E87051;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4809DC016F;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA64C0178
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1596D891AF
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6QSZJPc6t5t for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1C19D8916D
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:26 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090124euoutp02c86d7d7af186ad3287212ab7805854e7~OPFvtJmO50304403044euoutp02f
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090124euoutp02c86d7d7af186ad3287212ab7805854e7~OPFvtJmO50304403044euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274084;
 bh=FXPMiPZ7c5SpQvubIUWbXGofE01C1Z/1aYgGs4t5Rxs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BP901js1GRZjmNF1SwtMzosbRHEa1o6G1icsOMfwQ9l93Oo6cjLR8VbhmXr29uccy
 EzUKr/OsIwN4BiL5PtbIzmQlpt7pg3irpJ5bC67B1Z9FUC2y4flIg8qoLG7+nHikyy
 0dmXxNldyN/xM4k5urp6yaKbjBtAc9MHt8oSP+VI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090123eucas1p27aea9b6c10466074bd204422df08d17e~OPFvPqjYq3098030980eucas1p2J;
 Tue, 12 May 2020 09:01:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 75.7B.60698.3E56ABE5; Tue, 12
 May 2020 10:01:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090123eucas1p268736ef6e202c23e8be77c56873f415f~OPFu8MRmS2180321803eucas1p27;
 Tue, 12 May 2020 09:01:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090123eusmtrp120653e9289ee4b94bb938846d5e1609a~OPFu7bCGL0188101881eusmtrp1V;
 Tue, 12 May 2020 09:01:23 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-44-5eba65e3ce95
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.03.07950.3E56ABE5; Tue, 12
 May 2020 10:01:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090122eusmtip1628d2b6fc16039b5ec284bb2840665fe~OPFuTMsTB1181011810eusmtip1r;
 Tue, 12 May 2020 09:01:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 27/38] xen: gntdev: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:47 +0200
Message-Id: <20200512090058.14910-27-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHOffe7V7FyW0qHlQUFoUFaT6iG4oUJt1/DCukh2gtvejQTdt8
 ZEWJZsic5pKlmJaF4PuRrWmKmo+5mWW+H7NQU6MM0fJRmlmbV+2/7+/z+37P93A4BMrv5NgR
 IkksI5UIowRcc0zTufb+0DTTEHL4z6w9ldHThVDPc6s5VF9OKkb91ShRanBlgUuVlmsRqrDF
 i8ofc6eWB6cQqnZ6mEMNNORzqcqOjzjVujjDoX6qs5HjlnTF4wpAN60WYnTd6iSHnkjXIfSL
 ojv0+OY0SmePFgO6fXEQoxvHkrj091kDRmeqywBdrR7C6KVaxwDeJXPvMCZKFM9IXX2umEcU
 pGXiMb221wum2tEkUGolB2YEJD3hbK8alwNzgk+WADiykc9lh2UA83/83t4sAdi6qeXsRJSG
 coRdFAM4qsjCdiODdXrE5OKSblA+L+eatDWZCqA+w8JkQsl0FKoqy7aOsiLPwrwNA27SGLkP
 6r89Rk2aR/pAg3YcYeucYHnN6y1uZuQTTza22iBpwGFR8wiXNZ2Ey/cHtrUVnNOpcVY7wO5s
 xXYgBcCpnkqcHRQADiTnAtblBT/0rBvThPF+B2B1gyuLT8C+ftUWhqQlHJ3fY8KoUT7Q5KAs
 5sG0e3zWvR/m6ap2a1t7+1FW07CmxLD9jloAteUKkAWc8v6XFQJQBmyZOJk4nJF5SJgEF5lQ
 LIuThLuERotrgfF3dW/qVupB88bVNkASQGDBS3N/FcLnCONlieI2AAlUYM27KzIiXpgw8QYj
 jb4sjYtiZG3AnsAEtjyPZ1+D+WS4MJaJZJgYRrqzRQgzuyTgj6/bOJA9KhuNdsKuacw3chLB
 pwu7Yo76LZx/6dWo7BAOOQc2DdUnWLgGOaw8xfUd8kSVyDtQsVcZ/CvimP8R0ZxjYoBkOPmT
 9Vho7WlnlWfn27V3vjpR3rVHb4Jawvwu5AyMnPG/7btOz4hTnM/Jb1alx3x+eCtWeTFQnHLq
 iwCTRQjdDqJSmfAfUBbuYVkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qPU3fFGTz/xmbRe+4kk8XGGetZ
 LS5Ob2Wx+L9tIrPFla/v2SxWrj7KZLFgv7XFnJtGFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWi+9bJjM58HmsmbeG0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNHj8IcrLB67
 bzaweXx8eovFo2/LKkaP9Vuusnh83iQXwBulZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqln
 aGwea2VkqqRvZ5OSmpNZllqkb5eglzG3o4+94IJ4xdyHh5kbGFcKdzFyckgImEhMvLWaqYuR
 i0NIYCmjxL3rM9kgEjISJ6c1sELYwhJ/rnWxQRR9YpQ42/yABSTBJmAo0fUWIiEi0MkoMa37
 IzuIwywwmVni2errQHM5OIQFAiSmvuYDaWARUJU48XoeM4jNK2AncevobSaIDfISqzccAItz
 AsXvz/8DtkBIoFDi0dW3LBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjKNtx35u
 2cHY9S74EKMAB6MSD2+H0c44IdbEsuLK3EOMEhzMSiK8LZlAId6UxMqq1KL8+KLSnNTiQ4ym
 QEdNZJYSTc4HxnheSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
 Ba+Ub1VHxD9sT/5RO83mwGInkclS+/W8P06vU82Qf/K1czKPkJ/95kkfdYOm8pj7fvRhke3b
 51ih+Ct1XVX+limzVJ5+E+hLtquTeP37shD7jeNvDHSLP2lzzxb4fSbUUNksdvM2Q86pUr1f
 y6OetU8sKHasnPnadw87xwq7hAjhv1N1PAKUWIozEg21mIuKEwEHRpQquQIAAA==
X-CMS-MailID: 20200512090123eucas1p268736ef6e202c23e8be77c56873f415f
X-Msg-Generator: CA
X-RootMTR: 20200512090123eucas1p268736ef6e202c23e8be77c56873f415f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090123eucas1p268736ef6e202c23e8be77c56873f415f
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090123eucas1p268736ef6e202c23e8be77c56873f415f@eucas1p2.samsung.com>
Cc: Juergen Gross <jgross@suse.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/xen/gntdev-dmabuf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 75d3bb9..ba6cad8 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -247,10 +247,9 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 
 		if (sgt) {
 			if (gntdev_dmabuf_attach->dir != DMA_NONE)
-				dma_unmap_sg_attrs(attach->dev, sgt->sgl,
-						   sgt->nents,
-						   gntdev_dmabuf_attach->dir,
-						   DMA_ATTR_SKIP_CPU_SYNC);
+				dma_unmap_sgtable(attach->dev, sgt,
+						  gntdev_dmabuf_attach->dir,
+						  DMA_ATTR_SKIP_CPU_SYNC);
 			sg_free_table(sgt);
 		}
 
@@ -288,8 +287,8 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 	sgt = dmabuf_pages_to_sgt(gntdev_dmabuf->pages,
 				  gntdev_dmabuf->nr_pages);
 	if (!IS_ERR(sgt)) {
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC)) {
+		if (dma_map_sgtable(attach->dev, sgt, dir,
+				    DMA_ATTR_SKIP_CPU_SYNC)) {
 			sg_free_table(sgt);
 			kfree(sgt);
 			sgt = ERR_PTR(-ENOMEM);
@@ -625,7 +624,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 
 	/* Now convert sgt to array of pages and check for page validity. */
 	i = 0;
-	for_each_sg_page(sgt->sgl, &sg_iter, sgt->nents, 0) {
+	for_each_sgtable_page(sgt, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		/*
 		 * Check if page is valid: this can happen if we are given
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
