Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC0C433E5
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F9320707
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="siRwixq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCA6787D3D;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mM6xTHPl1Jz6; Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42C2187BD4;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2074FC088B;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99619C0894
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 724E587A30
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2q-hVYivEpDW for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C5A0287BCA
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:36 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063535euoutp025b6fa0f6a9a3791ed41b5859a01565c2~uvesOmpGf1510015100euoutp02P
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063535euoutp025b6fa0f6a9a3791ed41b5859a01565c2~uvesOmpGf1510015100euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423735;
 bh=dgA8N0ViLqnC/QZEgzrc3l/K0+XnEV3AJx7m2vhhZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=siRwixq0qBG0Qn2SJuB5/YMjcftDmJsRVhKz0TJ2IYzfgC1tUaggXPaNcR6gkzCB+
 QiOyOM51FONo+vebrSvxZB9Bax6QQ9NGE8NWi+iZ2BTSQ8bcLzVAIno21Z5Lb34cIH
 SveSt/yqiHMePpywTOj6jHlwtF91X1hgRUm1jFZA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063534eucas1p270a1c2e25b72630202fda78d4f366ae5~uver8bPkT0402704027eucas1p2j;
 Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.4D.06318.6B2064F5; Wed, 26
 Aug 2020 07:35:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b~uvermfILm0402704027eucas1p2i;
 Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063534eusmtrp2e49ad1248f6754d2c01d073c550e1795~uverl2G8a0466204662eusmtrp2I;
 Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-da-5f4602b6da51
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.53.06017.6B2064F5; Wed, 26
 Aug 2020 07:35:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063533eusmtip22cc306bbc45cef23b492bdcd73791658~uveq_oHja0302003020eusmtip2o;
 Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/32] drm: mediatek: use common helper for extracting
 pages array
Date: Wed, 26 Aug 2020 08:32:55 +0200
Message-Id: <20200826063316.23486-12-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ3pdECqYyFwgyjauGFkC5KMYXFBzBh9INFEY8JSYCxIC6QF
 ZHlgU6JlRxJJ3UoVUAqCSMqmIEQohFVABbXIHqqihi2KLLYM6Nt3/vOf+5+cXBzhadiWeHBo
 BC0JFYj4mDGqbvndbatmnfJ16GzeT6Z3tbHIZ3llbFKZno6Sq+pshOyf/4GRT1TNLFLR4ELO
 9Y+wyIqxd2yyr/YuRvYlvwFk6Wsth0y65kRqh1pRsvHnOPvYVqrkfgmgXi4oUKpGruVQFcU3
 MapqYZhNfU7VsKjnj+KpjytjCHVroAhQdYMJGJW57EBlVBYDarZipxf3krFrIC0KjqIl9u5+
 xkGy5WokfNgoeiDrK5IAcnEZMMIhcRiqdd85BuYRjwHsnHJgeA7AmZWzDM8COKiM2/BPyrVs
 GTDW60UA3qlPWy/0A/eyOtgGF0Y4Qtm0DDOwGXEdwNZ0E4MJIV4gUFm7iBoapsQF2PmrbS0a
 JfbCgvKaNeYS7rCtJBVh4qyhqvzVGhvpdU1qJmZ4CBKjHNhRVYgyppOwriB/nU3hF00lh2Er
 uFrzgMUMJAM40lXKYYo0APuS8gDjcoGfuhb1z+L6/WxgWa09Ix+HUxMtazIktsCB6W0GGdFj
 jvo2wshceCOFx7j3Qbnm6b/Yxp7e9f0pmNjajDEXytafsbeBkwWs5f/DFAAUAws6UioW0lKn
 UPqqnVQglkaGCu0CwsQVQP+92lc089Wgfsm/CRA44JtwFZinL48tiJLGiJsAxBG+GfdEZ7sP
 jxsoiImlJWG+kkgRLW0C23GUb8F1Uuq8eYRQEEGH0HQ4LdnosnAjywTgIfhWJop2XTkfqyx0
 O+L8tm4m0Tbc7mFNOd/abYdSnDeBV1u17iogBhd0OTYp3SHe5tpJL7/caZ/2yKU9R7syVZuH
 DjmoAi4q4vxLR3dzoHCTCVF+5sBkvCjfU5eqbvxzWqgTXX4vVC1nNJZNFp+zbgluSDMfVyY4
 D1yRe/R84KPSIIHjQUQiFfwF5PuO7FoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rbmNziDVasE7LoPXeSyWLjjPWs
 Fot6e1ks/m+byGxx5et7NouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfN4nLzRUaLtUfusls0
 tRhb3L13gsXi4IcnrA78HmvmrWH02PttAYvHzll32T02repk89j+7QGrx/3u40wem5fUe9z+
 95jZY/KN5Yweu282sHn0/zXw6NuyitHj8ya5AN4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
 E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyuvzuYCx5wVtyY8Jq5gXEKRxcjJ4eEgInEs1l3
 WbsYuTiEBJYySjz7sJ0FIiEjcXJaAyuELSzx51oXG4gtJPCJUaL5DD+IzSZgKNH1FiTOxSEi
 0MkoMa37IzuIwyxwjFli4+P3zCBVwgKhEmt+PwCbxCKgKrF0w052EJtXwE7i5JpuZogN8hKr
 NxwAszmB4se7+6G22UqcXjuDeQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8bTt
 2M8tOxi73gUfYhTgYFTi4V3A5hovxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU
 4kOMpkBHTWSWEk3OB8Z6Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYO
 TqkGxpVtrhV6Fw4ZSLnlKV2ZvXmX+YtM16gOp56HVjvf/+57zy3KJrZiyTSPnexrv18W8tn5
 ZeOTvNUGkyxOXci8Vs1xXW++weQsBsmz0lPCKtZUvd3AuZF9oUHBxXvLDFl61+x9aRS/onH3
 k6sMu6WMq/58fHsk+uAtbp8VQR/cZu+/2Ce2Qo+v7aYSS3FGoqEWc1FxIgCa5HSqvQIAAA==
X-CMS-MailID: 20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b
X-Msg-Generator: CA
X-RootMTR: 20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b@eucas1p2.samsung.com>
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
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 3654ec732029..0583e557ad37 100644
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
