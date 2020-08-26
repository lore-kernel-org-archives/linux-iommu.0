Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D58BC43446
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0307820866
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TCjbm+KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0307820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE58B86B13;
	Wed, 26 Aug 2020 06:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgHsSc0VQIdu; Wed, 26 Aug 2020 06:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2ED1186B85;
	Wed, 26 Aug 2020 06:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A4CC088B;
	Wed, 26 Aug 2020 06:35:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01A55C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EF61386A39
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wG87XBO14MU for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2EF6D86B19
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063542euoutp025d20ac1baf332d45dc9a3bc2c2391287~uvezJrTxR1512715127euoutp02d
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063542euoutp025d20ac1baf332d45dc9a3bc2c2391287~uvezJrTxR1512715127euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423742;
 bh=J4cTiD2Ov/1hJwWc6LhEYhhzrX1Y8PyWVK9BxFfcGP0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TCjbm+KPyAiBp5ee6pFmf3eHIddfEQop4Fr0FzK0wFbZD9PkZK0ledmZIVsuZQLLv
 3luZFntyEnJktfJIRNk7MZACN2sUNIufzO7+edFRc6LIvo2Tj8a4a31Vlxk7jEQ1Da
 uDm0GMhikP0NOOY8GayX/T6+lmhwddZij27UdfLc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063542eucas1p2d744ea2a32c922ccc03568ced3f944fe~uveyxrZIP0398703987eucas1p2l;
 Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.33.06456.DB2064F5; Wed, 26
 Aug 2020 07:35:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063541eucas1p2ec5d8a396f52ce690641659b74819e60~uveyWgr6g0403504035eucas1p23;
 Wed, 26 Aug 2020 06:35:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063541eusmtrp18bc45783e65357b9f4118828fd8aae34~uveyV20w51167511675eusmtrp1H;
 Wed, 26 Aug 2020 06:35:41 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-da-5f4602bd1c49
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.D0.06314.DB2064F5; Wed, 26
 Aug 2020 07:35:41 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063540eusmtip2e9e577d407a57c4136d8c0e328d8b7e7~uvextSb830092600926eusmtip2D;
 Wed, 26 Aug 2020 06:35:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 23/32] xen: gntdev: fix common struct sg_table related
 issues
Date: Wed, 26 Aug 2020 08:33:07 +0200
Message-Id: <20200826063316.23486-24-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87p7mdziDe7esLHoPXeSyWLjjPWs
 Fhent7JY/N82kdniytf3bBYrVx9lsliw39pizk0jiy9XHjJZbHp8jdXi8q45bBZrj9xltzj4
 4Qmrxfctk5kc+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuhx+MMVFo/d
 NxvYPD4+vcXi0bdlFaPH+i1XWTw+b5IL4I3isklJzcksSy3St0vgynjzbjNbwUmxiqbHjewN
 jFuEuhg5OSQETCT6274zdzFycQgJrGCUaJk7C8r5wijx8UIHK4TzmVFi8btmJpiW5VduQyWW
 M0ps/raRDa5lVd9ORpAqNgFDia63XWwgtohAK6PEiV4ekCJmgW5mialrV7GCJIQFgiSWbH/O
 DGKzCKhKfDz5HczmFbCTWHLiKTPEOnmJ1RsOgNmcQPHj3f1g2yQEbrFLzGu6ywZR5CJx8f4a
 dghbWOLV8S1QtozE6ck9LBANzYwSD8+tZYdwehglLjfNYISospa4c+4X0CQOoPs0Jdbv0gcx
 JQQcJXY804Iw+SRuvBUEKWYGMidtm84MEeaV6GiDBqSaxKzj6+C2HrxwCep8D4k1E46A2UIC
 Exkluh4wTWCUn4WwagEj4ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHX63/FPOxi/
 Xko6xCjAwajEw7uAzTVeiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlY
 lMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwhp3UaLrmcXJ7mXXd0ua2DNtTTAExuRVhhb7X
 NxyMVn/fHNN52r7JbVJM4exNu42O5H3z0lhiYaP+4EPzSmv+86orc9X550it7AqROBHpLMt1
 baNqlcqPvZ8uvEw+5bzqCW/n+YURh1Yn59St/f9y8YYDqZzbPn6TfM9yr7bjx9yHO99p6MZ0
 K7EUZyQaajEXFScCAHZPlrZXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7p7mdziDZ5Ml7PoPXeSyWLjjPWs
 Fhent7JY/N82kdniytf3bBYrVx9lsliw39pizk0jiy9XHjJZbHp8jdXi8q45bBZrj9xltzj4
 4Qmrxfctk5kc+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuhx+MMVFo/d
 NxvYPD4+vcXi0bdlFaPH+i1XWTw+b5IL4I3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
 NDaPtTIyVdK3s0lJzcksSy3St0vQy3jzbjNbwUmxiqbHjewNjFuEuhg5OSQETCSWX7nN2sXI
 xSEksJRRYsfRS+wQCRmJk9MaWCFsYYk/17rYIIo+MUrcOd3EBJJgEzCU6HoLkRAR6GSUmNb9
 kR3EYRaYzCzxbPV1sCphgQCJV32PwMayCKhKfDz5nRnE5hWwk1hy4ikzxAp5idUbDoDZnEDx
 4939bCC2kICtxOm1M5gnMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhJ24793LyD
 8dLG4EOMAhyMSjy8C9hc44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU
 6KiJzFKiyfnAKM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBY
 VHTT5mZN82rn5+Fd7LMu315sP+9UV3NujXpO1eG5ag4zzu585TTrbeGBN9Fi+qJuT5Y3bPp8
 69SNjR6S4ekin34a39nrYDdRs8h8bYes2zIF0cDzYac9Wh6tZLKvVfPMnjc/b/ZDl9sb+abe
 mpDi2PM6PTh0+bHtscJeMY0yV9VnFc00l2JSYinOSDTUYi4qTgQAzZ8ga7oCAAA=
X-CMS-MailID: 20200826063541eucas1p2ec5d8a396f52ce690641659b74819e60
X-Msg-Generator: CA
X-RootMTR: 20200826063541eucas1p2ec5d8a396f52ce690641659b74819e60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063541eucas1p2ec5d8a396f52ce690641659b74819e60
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063541eucas1p2ec5d8a396f52ce690641659b74819e60@eucas1p2.samsung.com>
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
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/gntdev-dmabuf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index b1b6eebafd5d..4c13cbc99896 100644
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
 
@@ -288,8 +287,8 @@ dmabuf_exp_ops_map_dma_buf(struct dma_buf_attachment *attach,
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
@@ -633,7 +632,7 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	/* Now convert sgt to array of pages and check for page validity. */
 	i = 0;
-	for_each_sg_page(sgt->sgl, &sg_iter, sgt->nents, 0) {
+	for_each_sgtable_page(sgt, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		/*
 		 * Check if page is valid: this can happen if we are given
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
