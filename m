Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F375C2D100
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F263207F5
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zku6+QRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F263207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E1F6D870ED;
	Wed, 13 May 2020 13:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzrEfsPj3HgW; Wed, 13 May 2020 13:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 675CB87122;
	Wed, 13 May 2020 13:33:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D24AC0178;
	Wed, 13 May 2020 13:33:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7D5DC0178
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AA223881E1
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yuG6ea9Flbd7 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0E62887657
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:11 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133309euoutp02e60e5fe97ce3697478056ce836ec33a9~OmcTuogyr3219432194euoutp02z
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133309euoutp02e60e5fe97ce3697478056ce836ec33a9~OmcTuogyr3219432194euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376789;
 bh=BqNldBb33cMwmWvoqM/jBTxhzBWgAGhI9NhIOAfKnDQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zku6+QRe4AQZR/j48qv8voBGQVB9MHW97EYZdaUR0XWjJnX6kbyZUkaCseLvEXb1d
 Ohl/rPEZfw1cJtopp6H9CdHzXbmby0hIDQH10KmGRgY8Vwo3gjcm/mfNlVXz0SoS/+
 lxkEhU9pebFk+yCIPlssPRTnqukJWcuy2ybqUz4o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133309eucas1p27c87b06c0c27ce4b8596ba1ae5b38578~OmcTYruNb2972029720eucas1p2y;
 Wed, 13 May 2020 13:33:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.C5.61286.517FBBE5; Wed, 13
 May 2020 14:33:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133308eucas1p248892466634483dfa3b23f11e4da0e68~OmcTGQsgp0359403594eucas1p2b;
 Wed, 13 May 2020 13:33:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133308eusmtrp1be8d0aac5e2020d489ea5187deff7e5a~OmcTFkiAE1049110491eusmtrp1R;
 Wed, 13 May 2020 13:33:08 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-53-5ebbf71590b3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 1D.37.07950.417FBBE5; Wed, 13
 May 2020 14:33:08 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133308eusmtip17de24666b15bff0680978334a3b7af82~OmcSb531w0131701317eusmtip1D;
 Wed, 13 May 2020 13:33:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/38] drm: omapdrm: use common helper for extracting
 pages array
Date: Wed, 13 May 2020 15:32:24 +0200
Message-Id: <20200513133245.6408-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87qi33fHGfxZy2nRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBHcdmkpOZklqUW6dslcGV8PJVdcJWn4sxK1wbGNVxdjJwcEgImElc2b2XpYuTiEBJY
 wSix99kCJgjnC6PEjvU/mSGcz4wSB08fZeti5ABraWpkBekWEljOKPGhRwiu4ez2HywgCTYB
 Q4mut11sILaIQCujxIleHpAiZoFDTBJbWq+CFQkLhEkcnL0RrIhFQFXi0J+7TCA2r4CtxK17
 b9gh7pOXWL3hADOIzQkUf3VnPwtEfB+7xK5DChC2i8Tx3XtZIWxhiVfHt0D1ykicntwD9puE
 QDOjxMNza9khnB5GictNMxghqqwl7pz7BfYas4CmxPpd+hBhR4n5f6ayQHzMJ3HjrSBImBnI
 nLRtOjNEmFeio00IolpNYtbxdXBrD164xAxhe0j0nOmBBu9hYCD+2sI+gVF+FsKyBYyMqxjF
 U0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQJT0el/xz/tYPx6KekQowAHoxIPr8Wt3XFCrIll
 xZW5hxglOJiVRHj91gOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoE
 k2Xi4JRqYGSyjto0/+O66oDJpxg0mL8nzaw/0OyruvjvRm/LEyt+tBwUM+2IvLSocmfwh6tN
 IkekZhyUNN71pP2jmAGDjKD15qhF0pILHp4rNWLKMdfIu1uU7rKjN1lhB2fWrKLJx9LTfc7e
 YDgrqLq/X7H3xvUpH98wLLJfbSGjeeDlve1OuS437/w2ClJiKc5INNRiLipOBACZ16MhQQMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xu7oi33fHGXz+YmzRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
 6GV8PJVdcJWn4sxK1wbGNVxdjBwcEgImEk2NrF2MXBxCAksZJVZ/7wByOIHiMhInpzVA2cIS
 f651sUEUfWKUmNy5kgkkwSZgKNH1FiIhItDJKDGt+yM7iMMscIJJ4t7e+YwgVcICIRLL185j
 B7FZBFQlDv25C9bNK2ArceveG3aIFfISqzccYAaxOYHir+7sZwGxhQTyJfYu3sc2gZFvASPD
 KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDo2Hbs55YdjF3vgg8xCnAwKvHwWtzaHSfEmlhW
 XJl7iFGCg1lJhNdvPVCINyWxsiq1KD++qDQntfgQoynQUROZpUST84GRm1cSb2hqaG5haWhu
 bG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTFEfVVGiUJNudmZT/Z/hQujxe10Pz5K
 CFly9YPDpFX/+zYXRZj+c1j82eXgkZevcr0YlFw/Jl532q1p6/tj+Yfa5VLPK3MfLFimmiDI
 m9qu19K4renHuzRH4duz2OJWf72T7pV/f8KH4++4Pz/gWyJ+q39vVNmek89jXRIUX8z4eOvk
 hM9zXtcosRRnJBpqMRcVJwIA+OxVUqQCAAA=
X-CMS-MailID: 20200513133308eucas1p248892466634483dfa3b23f11e4da0e68
X-Msg-Generator: CA
X-RootMTR: 20200513133308eucas1p248892466634483dfa3b23f11e4da0e68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133308eucas1p248892466634483dfa3b23f11e4da0e68
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133308eucas1p248892466634483dfa3b23f11e4da0e68@eucas1p2.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d08ae95..c259411 100644
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
