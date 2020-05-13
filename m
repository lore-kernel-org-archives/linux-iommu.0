Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C5C2D0FA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696C320878
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oEHGq0mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696C320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 54876221C6;
	Wed, 13 May 2020 13:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4gL2Rka72lH; Wed, 13 May 2020 13:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4755621F69;
	Wed, 13 May 2020 13:33:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33486C0178;
	Wed, 13 May 2020 13:33:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F864C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6FA6C20027
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XcvGl5EJhSWw for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 8CB7E22091
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:09 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133308euoutp026bfc7b17d89f1ec9793d7146038eb797~OmcSPsPJx0033500335euoutp02K
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133308euoutp026bfc7b17d89f1ec9793d7146038eb797~OmcSPsPJx0033500335euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376788;
 bh=8EZIcd9uOIKS70E4LE4yaht4Uu6+JPLIomKkdRO0ILA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oEHGq0mft05gVvJchVPaM8BpWiQ25cl5ozj/VQfNJTtU2jACbTTUiVxzfjZB2CtC1
 kntdEbyxWLX/VhGfftgHmYUNyoloykEU2Oaejj6MW7oosdHug1Lp+JuzoRa2HFKVoK
 jn4uFTCkxSaTtjKpv05y2kadV1a5QHdy7Kma5BAY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133307eucas1p104b4da5b5f18f98423f9c0a468132794~OmcR5XWO02350723507eucas1p12;
 Wed, 13 May 2020 13:33:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.C5.61286.317FBBE5; Wed, 13
 May 2020 14:33:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133307eucas1p1da70ed30775467792f4898ccce829d02~OmcRiFtgT0876608766eucas1p12;
 Wed, 13 May 2020 13:33:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133307eusmtrp19f5dcafe20553ece9c41755c6d7ad7f9~OmcRhUAn11049110491eusmtrp1N;
 Wed, 13 May 2020 13:33:07 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4b-5ebbf71310ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.1A.08375.317FBBE5; Wed, 13
 May 2020 14:33:07 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133306eusmtip108436382068676e558ded1ef25b74614~OmcQwsTUP0698906989eusmtip1q;
 Wed, 13 May 2020 13:33:06 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/38] drm: mediatek: use common helper for extracting
 pages array
Date: Wed, 13 May 2020 15:32:22 +0200
Message-Id: <20200513133245.6408-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTut3u33ZnL2zT8YZExKkzKB1ZeMCUj6oYQ/tEQsrSlFxV1yuYj
 g8j3Y2mlUopkLh/5TlPT2sxX6czJSKf52iw1wwQtdJoJaV7vsv++853vO9/hcDBEoGbbYCGS
 KEoqEYcJOWZoc89v7QnLXyo/p97BQ0SW9gOLeJlfxyaKs7JQYrM5GyGGVn5wiMrqbhahaHcj
 jENTLKJh5hOb0CmfcAhd0gAgat8buERisgthmOxFic6fX9lnLciapzWAfLuqQMk3BQYu2VCV
 wSFbVr+wyc/31CyysfQuObExg5C5o+WAVI3Fc8gHf5zI+01VgFxuOOjNv2p2JpAKC4mhpI4e
 N8yCp4YG0cjC3beSx5eReKDiyQGGQfwkXDP6yYEZJsArAOzo3uAyhRHAkZ48wBTLAFYrVSw5
 4G07Vtqec2kswMsB7C/x2HFU9BWx6QYHd4byBTmHxlZ4CoC9Wea0CMFbEVisXEfpbEvcB6YN
 naY1KH4EtmzGbw/l4+5QMVOOMGG2sLq+Yxvztvh5fTtKz4H4JBfOligAIzoP5xNWTQZLOK9u
 4jL4ANTkZpoMSQBOaWu5TJEJoC4x3+R2g3rtOofeCMGPwTqlI0N7QuPkAMocaQ8cXdhL08gW
 zGnOQxiaD9NTBYz6KCxQv9iJ7fw4aFqHhJq0RdNJ3wE4Nm5kPwS2Bf/DFABUAWsqWhYeRMmc
 JVSsg0wcLouWBDkERIQ3gK330myol16DlcGbXQDHgNCcT4yr/ARscYwsLrwLQAwRWvEv121R
 /EBx3G1KGuEvjQ6jZF1gP4YKrfkuxd+vC/AgcRQVSlGRlPRfl4XxbOJBkcela4r0pSBK7xDw
 LHSuZrSvzEk0XNhVPy2dy/AO9G19xddMtBxGgpdih/sfiewsmy6KEtwbd5WeEz+24+lmw+x1
 x129dsUUbhRFF1Tvs3DVrGX7jvnd0U/HLGpXDZU5IeTcQuA3r0q5p6gt1T/d/YohRXtKohy5
 UMZL1vsIhagsWOxsj0hl4r+hIHpGWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7rC33fHGZzt5rToPXeSyWLjjPWs
 Fot6e1ks/m+byGxx5et7NouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfN4nLzRUaLtUfusls0
 tRhb3L13gsXi4IcnrA78HmvmrWH02PttAYvHzll32T02repk89j+7QGrx/3u40wem5fUe9z+
 95jZY/KN5Yweu282sHn0/zXw6NuyitHj8ya5AN4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
 E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyHVy6xFMzlrmi59Zm5gXE3ZxcjJ4eEgInE133L
 2LsYuTiEBJYyShzf8Z4RIiEjcXJaAyuELSzx51oXG0TRJ0aJgzMPsIMk2AQMJbreQiREBDoZ
 JaZ1fwQbxSxwjFli4+P3zCBVwgKhEo/O/wDrYBFQldj+vwHM5hWwlVjweDkzxAp5idUbDoDZ
 nEDxV3f2s4DYQgL5EnsX72ObwMi3gJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmBEbTv2
 c/MOxksbgw8xCnAwKvHwWtzaHSfEmlhWXJl7iFGCg1lJhNdvPVCINyWxsiq1KD++qDQntfgQ
 oynQUROZpUST84HRnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1Oq
 gdFqk46vx6KDCntX1y14c0vXapqt5aGeGd4d6j7OLtaPprDy71NYKSFauWXq5FW/VjO5zY5Q
 mvRu57/M/Ue4jxzY2pcSwfTVIUBGWo6l8elWZdYzE7ZezuiZzrclZRbrrYlp/y/YzPjXvrjW
 8+an4Ac8P4omtleu9N3+mY1VoTZDr26B3e/dvoeUWIozEg21mIuKEwGWZXHbvgIAAA==
X-CMS-MailID: 20200513133307eucas1p1da70ed30775467792f4898ccce829d02
X-Msg-Generator: CA
X-RootMTR: 20200513133307eucas1p1da70ed30775467792f4898ccce829d02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133307eucas1p1da70ed30775467792f4898ccce829d02
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133307eucas1p1da70ed30775467792f4898ccce829d02@eucas1p1.samsung.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
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

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 6c34c06..14fcd48 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -233,9 +233,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
 	struct sg_table *sgt;
-	struct sg_page_iter iter;
 	unsigned int npages;
-	unsigned int i = 0;
 
 	if (mtk_gem->kvaddr)
 		return mtk_gem->kvaddr;
@@ -249,11 +247,8 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->pages)
 		goto out;
 
-	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
-		if (i > npages)
-			break;
-	}
+	drm_prime_sg_to_page_addr_arrays(sgt, mtk_gem->pages, NULL, npages);
+
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
