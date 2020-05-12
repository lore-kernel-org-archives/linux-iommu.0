Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D22FC54E4B
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4192E20A8B
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R9CeSKN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4192E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16CC5890C7;
	Tue, 12 May 2020 09:01:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JnstS3yRHjp; Tue, 12 May 2020 09:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 26B6B8916D;
	Tue, 12 May 2020 09:01:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03218C016F;
	Tue, 12 May 2020 09:01:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2EBC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 457D588D81
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0xl770OpIYIm for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 66AB8891AF
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090121euoutp011527f3f3c6ef889e32078e0467f8be3c~OPFs4wIBN2545625456euoutp01J
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090121euoutp011527f3f3c6ef889e32078e0467f8be3c~OPFs4wIBN2545625456euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274081;
 bh=H5Wuqd3IhdfxTrxlIPJVjW9wUYL7V9eCxWvieLv/Ae4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R9CeSKN+j/iwONFgOglNAtnffcLX3BSDXooZFe5rmzT56T+/KvRCA8lXas+5ngrJC
 H//g+LIEKMf9+rADffB+akKoK3H9TERMZkxbr3rMdYxC17josuUiEtNFD71YxtZ8xg
 4dPNeCeMcadib6AfIr5cFjBw43HAgm9KjoxzkGnE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090120eucas1p13ccfe06058a4a1cf34195a93eebcd2f4~OPFsj5kiE0080100801eucas1p1f;
 Tue, 12 May 2020 09:01:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.67.61286.0E56ABE5; Tue, 12
 May 2020 10:01:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090120eucas1p28cc382480b2e3298b59fb6bf5ffde80b~OPFsPfCnV2180321803eucas1p23;
 Tue, 12 May 2020 09:01:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200512090120eusmtrp29e638fa3d1d94c26652cbc0f1b430c27~OPFsNe7ZW0472704727eusmtrp2M;
 Tue, 12 May 2020 09:01:20 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-89-5eba65e014b4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.45.08375.0E56ABE5; Tue, 12
 May 2020 10:01:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090119eusmtip101ec658c19ed9a44edfdfb44d4ca5c32~OPFrk7kXF1148011480eusmtip1Y;
 Tue, 12 May 2020 09:01:19 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 22/38] drm: rockchip: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:42 +0200
Message-Id: <20200512090058.14910-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTcRjG+e9cdlxOTlvkq4XFYqWS1rIPJ5R1QeRAX4qEIMxaeVLJqWzT
 UghXmtlSMYsuo9LMKDXTZmy66GbpEmOWylKs1DSWpmXqFK22XKfLt9/zvO/L8/DnT2GSR0Qg
 lZyq4zSpqhQZKcLNrXMdYQOcNX79zWE5U2RvEzD3LtURjMd8FmO6XV9JpqqmRcB4PnwmmKul
 x5jyx5HMdPeggDENOQimy3qFZCYHPBhT+/ydkHk6MUxs8WPvXLuD2Icz5ThrmRkg2P4zNgHb
 UJnD9rmHMPZczy3EPujVk+xP42OcLb5fjViL4xrGTpmCdvjuEUUlcCnJmZxmnXK/KGnWbiPS
 R4OOWkoLhHrkCDAgHwrojXD6WQNmQCJKQt9GYM3v/COmERS/byJ5MYXAWdRD/D0ZrvmA84Nb
 CIbcn8h/JzdLcpF3i6QVYBg3kF5eQp9E8KLI18sYfQGDaleMl6V0LJh7OnAv47QcrEPXBQZE
 UWJaCc6XO/mwFVBT/wTzss+C3V/2A+f9TiF8KUznORrm+uoQz1IYtd0X8rwcPE1lAm83oHMR
 DNprhbwoRNB14tKfi0h4a58nvcEYHQJ11nW8vRW+O4y/+wDtBz3ji/n6flBqvojxthgK8iX8
 9mow2u7+i336qhPjmYVRqwPxz9OCoH3YRpSgFcb/YeUIVSN/LkOrTuS0ilTuSLhWpdZmpCaG
 H0xTm9DCr2p32yYbkavzQDOiKSTzFRdsaIqXEKpMbZa6GQGFyZaI85IXLHGCKiub06Tt02Sk
 cNpmtIzCZf7iiIqRvRI6UaXjDnNcOqf5OxVQPoF61MidcVp6XwtGVs5lrUreUhISjI2dv6EY
 cxXU5s3N+G0edMdmNpyKnc03KXdX6+KYOI9826PKjbqlP6IKA5ir09JQfWv7rFKaG/EqeM18
 /LeyRXuPF+qdHvmbjqTxqRTRBGQr6u/lh0345GwKW3v546Fdk66Y2sw2eYUDosuqtstwbZJK
 EYpptKpfn9yiw1EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7oPUnfFGSz4x2XRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMln8f/Sa1WLupFqLBfutLb5cechksenxNVaLy7vmsFl8evCf2WLt
 kbvsFgc/PGF14PNYM28No8febwtYPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH7psNbB5/
 Z+1n8ejbsorRY/u1ecwenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
 mSrp29mkpOZklqUW6dsl6GV8P3ecteCVXMX2SR3sDYzXJLsYOTkkBEwknqx+xNLFyMUhJLCU
 UeLzxinMEAkZiZPTGlghbGGJP9e62CCKPjFKnGv6C5ZgEzCU6HoLkRAR6GSUmNb9kR3EYRaY
 xyyxfNVhpi5GDg5hgSCJ+fcSQRpYBFQldj1eCBbmFbCTeH4mEGKBvMTqDQfAFnMChe/P/8MC
 YgsJFEo8uvqWZQIj3wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbPt2M/NOxgvbQw+
 xCjAwajEw9thtDNOiDWxrLgy9xCjBAezkghvSyZQiDclsbIqtSg/vqg0J7X4EKMp0E0TmaVE
 k/OBcZ1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFR3mK7hH6y
 yDou3nvVO7dMjXxgMccgubFYIZGDUVfj1T+LI2K9U9n+5bg/FFeX+stz9HGxlutr4YK8G3Oj
 ruyxqWZuKTUvW6qgwabn/df8dv2vFz3/BI5/ED33tjolW1r0fsF+VnHZOzI3Hk/5c/p8UJ/F
 D+OEuXlXNwVFGvO/Vk1+fkRyUocSS3FGoqEWc1FxIgCVrMwwswIAAA==
X-CMS-MailID: 20200512090120eucas1p28cc382480b2e3298b59fb6bf5ffde80b
X-Msg-Generator: CA
X-RootMTR: 20200512090120eucas1p28cc382480b2e3298b59fb6bf5ffde80b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090120eucas1p28cc382480b2e3298b59fb6bf5ffde80b
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090120eucas1p28cc382480b2e3298b59fb6bf5ffde80b@eucas1p2.samsung.com>
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 linux-rockchip@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 21f8cb2..566557b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -36,8 +36,8 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	rk_obj->dma_addr = rk_obj->mm.start;
 
-	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
-			   rk_obj->sgt->nents, prot);
+	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
+				prot);
 	if (ret < rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -98,11 +98,10 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
 	 * without relying on symbols that are not exported.
 	 */
-	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
+	for_each_sgtable_sg(rk_obj->sgt, s, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
-			       DMA_TO_DEVICE);
+	dma_sync_sgtable_for_device(drm->dev, rk_obj->sgt, DMA_TO_DEVICE);
 
 	return 0;
 
@@ -350,8 +349,8 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 		if (private->domain) {
 			rockchip_gem_iommu_unmap(rk_obj);
 		} else {
-			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
-				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			dma_unmap_sgtable(drm->dev, rk_obj->sgt,
+					  DMA_BIDIRECTIONAL, 0);
 		}
 		drm_prime_gem_destroy(obj, rk_obj->sgt);
 	} else {
@@ -476,15 +475,13 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 			struct sg_table *sg,
 			struct rockchip_gem_object *rk_obj)
 {
-	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
-			       DMA_BIDIRECTIONAL);
-	if (!count)
-		return -EINVAL;
+	int err = dma_map_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
+	if (err)
+		return err;
 
 	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
-		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
 		return -EINVAL;
 	}
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
