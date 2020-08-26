Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE3C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED8D20738
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B6ZJL+ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC5748697D;
	Wed, 26 Aug 2020 06:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRZQ3T-PpH1L; Wed, 26 Aug 2020 06:35:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E897864F2;
	Wed, 26 Aug 2020 06:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13DD7C088B;
	Wed, 26 Aug 2020 06:35:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB0BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D2F887A04
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cEgePs-iBPy2 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 522F987A30
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063530euoutp01bfc096c6f8361a0477a106a5eaf55882~uvenoeBXD1717417174euoutp01R
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200826063530euoutp01bfc096c6f8361a0477a106a5eaf55882~uvenoeBXD1717417174euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423730;
 bh=ZezuyQz2nJ1PApAqwXHe/K2AgzEw+WSa16yHFOl7Qq0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B6ZJL+ewp9e23wEFbR24xW0t+VNy81v04tamW2mQLQH1pwBjg7kAroPwj4McH5ugK
 vd+h4F5rsahvHeZ8VyIC+Zlg2TE2I8yiKEHwd487BF0ijJ3CRqyWSJN2xaXTsy2kkG
 9XNwtfDl8DxaTASkQcRrirdE+OhsZrOFwkO39Xes=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063529eucas1p2d7da65f0c9a807f7f7715f3dba412ef4~uvenTtDCh0401804018eucas1p2V;
 Wed, 26 Aug 2020 06:35:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.AD.05997.1B2064F5; Wed, 26
 Aug 2020 07:35:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf~uvemyFhJx2388623886eucas1p1E;
 Wed, 26 Aug 2020 06:35:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063529eusmtrp113af80c687209d6bcf2dc31b077d357a~uvemxbcGa1091110911eusmtrp1F;
 Wed, 26 Aug 2020 06:35:29 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-b8-5f4602b15dd7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.C0.06314.1B2064F5; Wed, 26
 Aug 2020 07:35:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063528eusmtip2db1ff1ad4cdc17ffea7b36ca1d8c807f~uvemItSCO0091500915eusmtip2D;
 Wed, 26 Aug 2020 06:35:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/32] drm: core: fix common struct sg_table related issues
Date: Wed, 26 Aug 2020 08:32:47 +0200
Message-Id: <20200826063316.23486-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c5tR3FymqZfFxoNNIrSNItTmpatOgSR9Ud/FGUrD2o6Lztq
 ZZHDaLip1TRMRGSmpM1LNS8zw8p5WToclRJTixIva6GkaJEVlseT9t/vfd7n4Xn5+EhU0oGv
 JeOT0lhVkiJRRrhjzd3z9m1PkEPR258X+NP59h6EflL8CKf/NOtReuDbV4J+WNOF0IYXofTc
 wAhCm0bf4XR/aylB13V+ENHlM00YrdE+wOn26TGcbpzU4/s8mdqyWsC0fTdgjMmoJRjz9084
 U9ZznPmYa0WYhsosZnhhFGUKHVWAeTaoJphbjUbANNiuMrOmDVHiU+5hMWxifAarCgw/5x5n
 H+slUr76XX6TV42rgUWqA24kpEJgeWEtzrOEqgbQ5VytA+6LPAdgt6MfF4ZZAEs6ipDlREn+
 FCYsqgBscj0kViKVbfolF0EFQd2UjuDZm7oJ4Kt8D96EUgYUzs9qgA6QpBcVBe0TR3gPRvnB
 pyaDiGcxtRcaqypEQpsU1jx+ifLsRoVDa+7tpTJIDYmgeSYfE0xy+GDiMyqwF/xibfwXXg9t
 hXmYELgB4Ii9TiQMeQD2ZxcDwRUK39t/EvxFKLUZPmoNFOT9cLI1G+dlSHlCx9QqXkYXsaD5
 HirIYpijkQhuf1hirV+pbX/99t85DOzs0aLCA+kBvDv9g7gDpCX/ywwAGIEvm84pY1kuOIm9
 FMAplFx6UmzAhWSlCSx+LduCda4FtP4+bwEUCWQeYgNxMFqCKzK4K0oLgCQq8xZH9tnOSsQx
 iiuZrCo5WpWeyHIWsI7EZL7iHfddZyRUrCKNTWDZFFa1vEVIt7VqsK3bSvnsjFIe6+syjdeo
 h1uCneJdoqDJma05WS75TIV+3LZbe+L6tYLiMK/D0uiNDb/I+siAzh9IXOal8SLz6WoNi5br
 nHKbwcipV/l2GSP2XFwzJI9xyLJDepMPMglOn00H9NVh/eaTLRUFR0URhXc1qSpJYOKgPLUU
 KT0tw7g4RdAWVMUp/gKmtVodVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7obmdziDfb/ZLfoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4Uft7JYtHUuY7U4
 +OEJq8WWNxNZHfg81sxbw+ix99sCFo9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hvc/veY2WPy
 jeWMHrtvNrB59G1Zxeix+XS1x+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
 5rFWRqZK+nY2Kak5mWWpRfp2CXoZ556cYit4r1pxsWcFawPjIfkuRk4OCQETiVm9b1m6GLk4
 hASWMkq8m3qLFSIhI3FyWgOULSzx51oXG0TRJ0aJxRufMIEk2AQMJbreQiREBDoZJaZ1f2QH
 cZgFVjBLvNo3lwWkSljAT+LnxxuMIDaLgKrEzk0L2EFsXgFbiVXLF7NDrJCXWL3hADOIzSlg
 J3G8u58NxBYCqjm9dgbzBEa+BYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjaNuxn5t3
 MF7aGHyIUYCDUYmHdwGba7wQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGa
 Ah01kVlKNDkfGON5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY
 W+Ks7D8U5Z1vmmrTLuhx7s1GedmmVVX/IpTXTFzsmFLwgd8r5uaqS07pe29Jm3hwF4e82tU+
 Uabc9sikBtee+Q+FN3Aulj11W2pJyhvWNVmtVUk2quedrX8xvrh9rVOqLdVz2UaB6C8MUtX5
 m3s8l6w1mhK47pyK3Z6Oqke1iwwjmmunKJ9SYinOSDTUYi4qTgQAC/sGebkCAAA=
X-CMS-MailID: 20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf
X-Msg-Generator: CA
X-RootMTR: 20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf@eucas1p1.samsung.com>
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
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/drm_cache.c            |  2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c | 14 +++++++++-----
 drivers/gpu/drm/drm_prime.c            | 11 ++++++-----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 03e01b000f7a..0fe3c496002a 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -127,7 +127,7 @@ drm_clflush_sg(struct sg_table *st)
 		struct sg_page_iter sg_iter;
 
 		mb(); /*CLFLUSH is ordered only by using memory barriers*/
-		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
+		for_each_sgtable_page(st, &sg_iter, 0)
 			drm_clflush_page(sg_page_iter_page(&sg_iter));
 		mb(); /*Make sure that all cache line entry is flushed*/
 
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4b7cfbac4daa..47d8211221f2 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -126,8 +126,8 @@ void drm_gem_shmem_free_object(struct drm_gem_object *obj)
 		drm_prime_gem_destroy(obj, shmem->sgt);
 	} else {
 		if (shmem->sgt) {
-			dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
-				     shmem->sgt->nents, DMA_BIDIRECTIONAL);
+			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
+					  DMA_BIDIRECTIONAL, 0);
 			sg_free_table(shmem->sgt);
 			kfree(shmem->sgt);
 		}
@@ -424,8 +424,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_object *obj)
 
 	WARN_ON(!drm_gem_shmem_is_purgeable(shmem));
 
-	dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
-		     shmem->sgt->nents, DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(obj->dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
 	sg_free_table(shmem->sgt);
 	kfree(shmem->sgt);
 	shmem->sgt = NULL;
@@ -697,12 +696,17 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_object *obj)
 		goto err_put_pages;
 	}
 	/* Map the pages for use by the h/w. */
-	dma_map_sg(obj->dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
+		goto err_free_sgt;
 
 	shmem->sgt = sgt;
 
 	return sgt;
 
+err_free_sgt:
+	sg_free_table(sgt);
+	kfree(sgt);
 err_put_pages:
 	drm_gem_shmem_put_pages(shmem);
 	return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 5d181bf60a44..c45b0cc6e31d 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -617,6 +617,7 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
 {
 	struct drm_gem_object *obj = attach->dmabuf->priv;
 	struct sg_table *sgt;
+	int ret;
 
 	if (WARN_ON(dir == DMA_NONE))
 		return ERR_PTR(-EINVAL);
@@ -626,11 +627,12 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
 	else
 		sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
 
-	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC)) {
+	ret = dma_map_sgtable(attach->dev, sgt, dir,
+			      DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret) {
 		sg_free_table(sgt);
 		kfree(sgt);
-		sgt = ERR_PTR(-ENOMEM);
+		sgt = ERR_PTR(ret);
 	}
 
 	return sgt;
@@ -652,8 +654,7 @@ void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
 	if (!sgt)
 		return;
 
-	dma_unmap_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-			   DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sgt);
 	kfree(sgt);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
