Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE57BC2D101
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68840207D3
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d9W5/oE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68840207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5197187212;
	Wed, 13 May 2020 13:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YaE8XUA8oHk4; Wed, 13 May 2020 13:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 862798721E;
	Wed, 13 May 2020 13:33:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 670FCC0890;
	Wed, 13 May 2020 13:33:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03812C088F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D3618881D2
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXDpRbBNjlj3 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 845AC88228
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:12 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133311euoutp01528352acb3897ac2044a4f714ef68a0c~OmcVMm4Tv2269422694euoutp01N
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133311euoutp01528352acb3897ac2044a4f714ef68a0c~OmcVMm4Tv2269422694euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376791;
 bh=LffS5bYPgRETT3M74qJNeZGYgl9TTyynFbb9Sq2/aPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d9W5/oE4v35es0vbX9PyJqF62ctJz1u//VCwOVQYUklEOjiB8kehjbtXlIsi05xbo
 k28M3XdO40oJ3B5MANvDepDN79ClQvUt6UhCIl5vZ2pJE9xmeb2Gmi30p85ZPg9wPf
 lnApq5UvXm4GFbqGYTW4KnvyzZni6ZqTZjgGYd2o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133310eucas1p2dfa423c1dd02d4f7422afd99a66a28ce~OmcUz6wXt0616406164eucas1p2b;
 Wed, 13 May 2020 13:33:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B8.D8.60698.617FBBE5; Wed, 13
 May 2020 14:33:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133310eucas1p176c920345e7f05f670e26e330b358d7f~OmcUk6gAF2350623506eucas1p1H;
 Wed, 13 May 2020 13:33:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133310eusmtrp14a5310d8ec8a7383f0dfee53efa99761~OmcUkSOjS1011910119eusmtrp1R;
 Wed, 13 May 2020 13:33:10 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-d8-5ebbf716ae7e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.1A.08375.617FBBE5; Wed, 13
 May 2020 14:33:10 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133309eusmtip176b7b06def49b2e95bc3716c90d655f2~OmcTsxDLb0131701317eusmtip1F;
 Wed, 13 May 2020 13:33:09 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/38] drm: panfrost: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:26 +0200
Message-Id: <20200513133245.6408-19-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSazBUYRjHe89tD9k6FnlTw7QzmTQh6cOZcRlNjc5MpjR8UqmVkzVY2nXt
 SzspacOoLUSjrczIdVlGcrcqyViFwqAYjEtJxl0N7TpL3/7P7/k/7/9533lJVFCP25ChkmhW
 KhGFCwlTrOr9aqfjnuXawKMjG0foVF0bQpdnqXF6o+oBSvcszhJ0QdE7hFY1utELPSMIrRn9
 itPdNU8JuuTtEI/eqKvm0c2/x3A6raSL8OIzxbnFgKkeygNM/ZIKYzSF9wjm9dIwzny/34ow
 FXk3mYH1UZRR9uUDprZfTjBplYWAmdfY+poFmLoHs+GhsazU2fOKqXh9vomI6t4bfzvzLioH
 DVYKYEJC6jgcHFcTCmBKCqhXAHYrE43FAoDpq10oV8wD+HPpG7o1slLfw+Ma+QDK+3Vge2Qq
 IwUzuAjKBSpmFIRBW1J3APyQamYwodQYAvtWSnBDw4Lyh0vP+4BBY9RBWNf5cpPzKQ84uS43
 xtnBorKmTW2i59ODjZjhIEh95MGO1UqMM52Cy3MjOKct4HRrJY/T+2G7MsU4kAjgiK6ExxUp
 +rveygKcyw0O6tb0u5L6/RygusaZwyfgo2fJiAFDahfsmzE3YFQvH1Zlohzmw+QkAee2h9mt
 pduxzZ+6jPszUJvbYXyhFgAX635h6cAu+3+YCoBCYM3GyCJCWJmrhI1zkokiZDGSEKerkREa
 oP9U7euti9Wg4W+QFlAkEJrxh3trAwW4KFaWEKEFkESFlvyzaj3iB4sSbrDSyMvSmHBWpgX7
 SExozXd9MXVJQIWIotkwlo1ipVtdhDSxkQPxac9D5y9o5a4DpMNktTgOFXjviF+r8XvskeRz
 0XsCz0pEclQFvZbic+a0omw244ztzhzfxFmXCueTLe6Vygl7m91F155EH6hIN5eER1oVUKUL
 /uYDDmGONT90PnOfg0L8vN6UX7dTj3f88WoLLuhdaWrW9CodghHlF/eAgdhjQkwmFrkcRqUy
 0T+nmzdrUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7pi33fHGSzaIGvRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFv/37GC3OPjhCatF
 39pLbA68HmvmrWH02HF3CaPH3m8LWDw2repk89j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
 u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
 TUpqTmZZapG+XYJexr/PB9gKLktWtExvZ25g3CfaxcjJISFgIvFj7xX2LkYuDiGBpYwSV37v
 Z4FIyEicnNbACmELS/y51sUGUfSJUeLDvR1gCTYBQ4mutxAJEYFORolp3R/ZQRLMAm+YJC5d
 jQCxhQWCJNbM/MQGYrMIqErsOb8YrJlXwFbixb8GZogN8hKrNxwAszmB4q/uQFwhJJAvsXfx
 PrYJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbNtmM/N+9gvLQx+BCjAAejEg+v
 xa3dcUKsiWXFlbmHGCU4mJVEeP3WA4V4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxjReSXx
 hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGE0Tpn20Uw9jXND/61We
 9zb5gNOLIyyLbO+/vrKBr3DSoavsV4vFwva5Xt9fuKZ/Xfj8H1PSXh+xWDcjdcdvkclWrT+i
 WfYZ3vM1kXM6IP5kNjvXj3DWWcZC3y88WOiw8qhoQtXOFGWxq4kNk0LTfj/4dj63RnzNmmSp
 YKX+s0+82O+8/5/w4a8SS3FGoqEWc1FxIgDc3DkUsAIAAA==
X-CMS-MailID: 20200513133310eucas1p176c920345e7f05f670e26e330b358d7f
X-Msg-Generator: CA
X-RootMTR: 20200513133310eucas1p176c920345e7f05f670e26e330b358d7f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133310eucas1p176c920345e7f05f670e26e330b358d7f
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133310eucas1p176c920345e7f05f670e26e330b358d7f@eucas1p1.samsung.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
Reviewed-by: Steven Price <steven.price@arm.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 17b654e..6696304 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL, 0);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ed28aeb..eb2550e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -253,7 +253,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
 
-	for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
 
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
