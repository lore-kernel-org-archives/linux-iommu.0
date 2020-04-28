Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318BC83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052BF206E2
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B1o9Ldgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052BF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA32F86237;
	Tue, 28 Apr 2020 13:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp-qibB5XF2o; Tue, 28 Apr 2020 13:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B55486433;
	Tue, 28 Apr 2020 13:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC000C0889;
	Tue, 28 Apr 2020 13:21:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 663F9C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 42C2E22844
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uVg2jjN6XY+v for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:21:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id AF5E622854
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:34 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132033euoutp02991b9e42c313806f8e778bd65de64cf1~J-mBP0Fmt2995329953euoutp02O
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200428132033euoutp02991b9e42c313806f8e778bd65de64cf1~J-mBP0Fmt2995329953euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080033;
 bh=W1cooQvBlT6u8ezdjLvm+dB0V90PbzJlXZ1A87QbWGY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B1o9LdgvkDl+bDAQ1Zo3mJbGWjVT0tYh4GM+CZD2JHRmJBxDNNEszg2LFTkraaWQ9
 7va8eiqBhfaUfZu8KiXs12f7fuMJkDg8HFRleGQoLyPQZC06WgEM7ne0NWZqYwaTjg
 L/DZpwq+ENhDM7AszBmFtVyHapNiuUo/r7OdfGRE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200428132032eucas1p2488259606ff3e4dad28e7de81cfe4baa~J-mA2SEnw2653326533eucas1p2S;
 Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id AE.26.60698.0AD28AE5; Tue, 28
 Apr 2020 14:20:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200428132032eucas1p17c2b93daf91c95c41650e75b251d525c~J-mAm0ZZa1368113681eucas1p1R;
 Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200428132032eusmtrp2a527f876c3f2d680c57d874708de8d31~J-mAmDBus2140221402eusmtrp2b;
 Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-9d-5ea82da01ffa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.E3.07950.0AD28AE5; Tue, 28
 Apr 2020 14:20:32 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132031eusmtip2b5690c9c67116c2ec0e00c4bc3216f63~J-mACdxOH1116911169eusmtip2b;
 Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 17/17] dmabuf: fix sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:20:05 +0200
Message-Id: <20200428132005.21424-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7oLdFfEGVzr0rPoPXeSyWLp+kZ2
 i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
 e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
 yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUVw2Kak5mWWpRfp2CVwZJ88sYirYL1yxaGYjYwPjSoEu
 Rk4OCQETiTMn3jB2MXJxCAmsYJR40ToVyvnCKDH35wVmCOczo8Sdr2uZYFquPLzHApFYziix
 Zdt3JriWhm9LwKrYBAwlut52sYHYIgKtjBInenlAipgFtjFLPFl+hB0kISzgKrFjywJWEJtF
 QFVi8+atzCA2r4CdxNKGh2wQ6+QlVm84ABbnBIk/egoVv8Qu8aMlDMJ2kbhzcA/UecISr45v
 YYewZST+75wPdp2EQDOjxMNza9khnB5GictNMxghqqwl7pz7BTSVA+g8TYn1u/RBTAkBR4kr
 h1ghTD6JG28FQYqZgcxJ26YzQ4R5JTrahCBmqEnMOr4ObuvBC5eYIWwPiTe3prBDwmcio8TR
 LW9YJzDKz0LYtYCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgujr97/jXHYz7/iQd
 YhTgYFTi4d3AsyJOiDWxrLgy9xCjBAezkgjvo4xlcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
 jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUw8tTcmldqUOKySi/5gHlzgK3j39s87tPS4/uCNEyE
 Vt249jf58qqXa/yee/kYcbz1rX5jcKqLaZPW9pUX/aYxBvks7k7RfvIuYUP1Bv3nxn2Xy3UW
 z/my1i8wOfvR2YAPMw9tqbMzX1g5R8hDZJHGqbkyN533TW1++smWu3xiTLmB23vW6L7zSizF
 GYmGWsxFxYkAKWHGIVMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7oLdFfEGUzZJ2/Re+4kk8XS9Y3s
 FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
 9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
 k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQyTp5ZxFSwX7hi0cxGxgbGlQJdjJwcEgImElce3mPpYuTiEBJY
 yihx79VJZoiEjMTJaQ2sELawxJ9rXWwQRZ8YJZ5sfsMIkmATMJToeguREBHoZJSY1v2RHcRh
 FjjALNF9/iQTSJWwgKvEji0LwEaxCKhKbN68FWwFr4CdxNKGh2wQK+QlVm84ABbnBIk/egoU
 5wBaZytxuSV3AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxs+3Yzy07GLveBR9i
 FOBgVOLh3cCzIk6INbGsuDL3EKMEB7OSCO+jjGVxQrwpiZVVqUX58UWlOanFhxhNgW6ayCwl
 mpwPjO28knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MfTW39hzO
 mxy01EE76EWz3dGUqnuftJNOBSv8ebYjt4dt2cwXa/9s+f2j8pVC7MWVX4RU76qtNNMp/r+1
 t8thX422iuiukxu6pBMLDq2J/vJtxYcbTwvv9TPk3N3+5QyDzb8tjhN3eWy4Xf+n8qRsV6mF
 qf3XUvX82csYS+3/FtWUXZp/ZtriO0osxRmJhlrMRcWJAGKr1d21AgAA
X-CMS-MailID: 20200428132032eucas1p17c2b93daf91c95c41650e75b251d525c
X-Msg-Generator: CA
X-RootMTR: 20200428132032eucas1p17c2b93daf91c95c41650e75b251d525c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132032eucas1p17c2b93daf91c95c41650e75b251d525c
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132032eucas1p17c2b93daf91c95c41650e75b251d525c@eucas1p1.samsung.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma-buf/heaps/heap-helpers.c | 7 ++++---
 drivers/dma-buf/udmabuf.c            | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 9f964ca..b923863 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -144,8 +144,9 @@ struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = &a->table;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
+	table->nents = dma_map_sg(attachment->dev, table->sgl,
+				  table->orig_nents, direction);
+	if (!table->nents)
 		table = ERR_PTR(-ENOMEM);
 	return table;
 }
@@ -154,7 +155,7 @@ static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
 				   struct sg_table *table,
 				   enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sg(attachment->dev, table->sgl, table->orig_nents, direction);
 }
 
 static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index acb26c6..ea0cf71 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -63,7 +63,8 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					GFP_KERNEL);
 	if (ret < 0)
 		goto err;
-	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
+	sg->nents = dma_map_sg(dev, sg->sgl, sg->orig_nents, direction);
+	if (!sg->nents) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -78,7 +79,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
+	dma_unmap_sg(dev, sg->sgl, sg->orig_nents, direction);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
