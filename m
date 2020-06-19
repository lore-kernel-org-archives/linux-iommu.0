Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98BCC433EA
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE69208D5
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TovOxvHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE69208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7BCD989943;
	Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeuw5OlkNjsC; Fri, 19 Jun 2020 10:37:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95A7489966;
	Fri, 19 Jun 2020 10:37:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBE1C0892;
	Fri, 19 Jun 2020 10:37:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF8C6C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BBEC88E97
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgvjHLQHjC5c for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F2C0088E80
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103703euoutp0240e6ffd8e3f27e91fcae185917cc737b~Z66HJSWl-2242222422euoutp02X
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200619103703euoutp0240e6ffd8e3f27e91fcae185917cc737b~Z66HJSWl-2242222422euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563023;
 bh=zV96V2vYwfqZCBn3pFDPDrE8ppfbK/CRdkHj1ScotiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TovOxvHK21n70TAwdg4ASuR1uq5RqEkSJPTIVU3nF1MUU34uzRFTTLPaGn93/faBY
 ePDnYWuAZEmh/ewc4fbGnUNlUHxIGRO+rmDYxoPpJXm6MHVUp3iieS/Gph8j1ThLWF
 /DBmXt2Sxm+7av0wx2RA6ZKx01cScYpTlxAgDW58=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200619103702eucas1p2a4ea2cb07ee15416ef222bfbaf908415~Z66Gzqkzj1691016910eucas1p26;
 Fri, 19 Jun 2020 10:37:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.9C.06318.E459CEE5; Fri, 19
 Jun 2020 11:37:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103702eucas1p207b9cacc7460a334a0eda58c2b60a965~Z66Gc0eoE2893928939eucas1p2Z;
 Fri, 19 Jun 2020 10:37:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103702eusmtrp16ab3ac15f7f96ffb9888f4c260be442f~Z66GcK19X0949709497eusmtrp1O;
 Fri, 19 Jun 2020 10:37:02 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-64-5eec954efd1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.0B.06017.E459CEE5; Fri, 19
 Jun 2020 11:37:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103701eusmtip21cb30ea2d98fdfe12fd39a725f93e2fc~Z66F3gjN70302603026eusmtip2O;
 Fri, 19 Jun 2020 10:37:01 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/36] drm: omapdrm: use common helper for extracting
 pages array
Date: Fri, 19 Jun 2020 12:36:14 +0200
Message-Id: <20200619103636.11974-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7p+U9/EGdzptbToPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrBarJ9/i82B
 x2PNvDWMHnu/LWDx2P7tAavH/e7jTB6bl9R73P73mNlj8o3ljB67bzawefRtWcXocfzGdiaP
 z5vkArijuGxSUnMyy1KL9O0SuDKuzp3KVjCDu+Ldy5XMDYytnF2MnBwSAiYSrb3r2LoYuTiE
 BFYwSqxZ0c4I4XxhlJj79RkLhPOZUeLVnhWMMC1P1p1khkgsZ5RY23QboeXu5TVMIFVsAoYS
 XW+72EBsEYFWRokTvTwgRcwCh5gktrReZQFJCAuESUy/08wKYrMIqEo09WxgB7F5Bewkvv5f
 xAKxTl5i9YYDzCA2J1D8dctBVpBBEgL72CWetvwG2sYB5LhIbFxuDlEvLPHq+BZ2CFtG4vTk
 HhaI+mZGiYfn1rJDOD2MEpebZkA9ZC1x59wvNpBBzAKaEut36UOEHSV+L/zPCDGfT+LGW0GQ
 MDOQOWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiRnC9pBY9KYDGowTgQG05RL7BEb5WQjLFjAy
 rmIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMSaf/Hf+6g3Hfn6RDjAIcjEo8vC9CXscJ
 sSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6Yklqdmp
 qQWpRTBZJg5OqQbGtNZfORMm8S+PeaDmLzKLOWRTsW1iV73hxm8yrxcnPWSTbBcy7PH/H37A
 K3JmzofMPxyTCq5xNm3Nvjftvl8l79FFMhHnv3F7BT78cNvxo1/7kunSetd6ghZdfpyx8BaH
 ztedLbVnO+J2pm3aEj2l4uXSzprWDyUPfq76fipmrVHSRb+JNgFiSizFGYmGWsxFxYkAb7kS
 2EUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7p+U9/EGXxfoGTRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
 6GVcnTuVrWAGd8W7lyuZGxhbObsYOTkkBEwknqw7ydzFyMUhJLCUUeJHx1xmiISMxMlpDawQ
 trDEn2tdbBBFnxgl+uYuZQJJsAkYSnS9hUiICHQySkzr/sgO4jALnGCSuLd3PiNIlbBAiMSW
 x4vBRrEIqEo09WxgB7F5Bewkvv5fxAKxQl5i9YYDYKs5geKvWw6C1QsJ2EosX/CeeQIj3wJG
 hlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBMbLt2M8tOxi73gUfYhTgYFTi4X0R8jpOiDWx
 rLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4zfvJJ4Q1NDcwtL
 Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjPMFr3nf633xf+79NT9kAvh1Dl2c
 73r5z5+vbl231liuvlxcMXvBdCunD7FLetPU+FdLTJ9RqLnHtuoYjwDL5G67PPFL/sdWqCb/
 XZY4NdhR6jJfhDN7bnmLsHkmj+O2ssdR7GIPRUXWarJcV9gpqFrpmTCRYdeivqLnwVKvpU61
 dP1eqn/tthJLcUaioRZzUXEiAJKyk3enAgAA
X-CMS-MailID: 20200619103702eucas1p207b9cacc7460a334a0eda58c2b60a965
X-Msg-Generator: CA
X-RootMTR: 20200619103702eucas1p207b9cacc7460a334a0eda58c2b60a965
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103702eucas1p207b9cacc7460a334a0eda58c2b60a965
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103702eucas1p207b9cacc7460a334a0eda58c2b60a965@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d0d12d5dd76c..ff0c4b0c3fd0 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1297,10 +1297,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
 	} else {
 		/* Create pages list from sgt */
-		struct sg_page_iter iter;
 		struct page **pages;
 		unsigned int npages;
-		unsigned int i = 0;
+		unsigned int ret;
 
 		npages = DIV_ROUND_UP(size, PAGE_SIZE);
 		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
@@ -1311,14 +1310,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		}
 
 		omap_obj->pages = pages;
-
-		for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-			pages[i++] = sg_page_iter_page(&iter);
-			if (i > npages)
-				break;
-		}
-
-		if (WARN_ON(i != npages)) {
+		ret = drm_prime_sg_to_page_addr_arrays(sgt, pages, NULL,
+						       npages);
+		if (WARN_ON(ret)) {
 			omap_gem_free_object(obj);
 			obj = ERR_PTR(-ENOMEM);
 			goto done;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
