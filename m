Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4002C2D110
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C30A221EE
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UtEAqJTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30A221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6277922091;
	Wed, 13 May 2020 13:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jn+raJyseK62; Wed, 13 May 2020 13:34:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6FE922048E;
	Wed, 13 May 2020 13:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C70AC0178;
	Wed, 13 May 2020 13:33:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5836C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 93F5421549
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cS4cId0EZKwU for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by silver.osuosl.org (Postfix) with ESMTPS id A2EF326291
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:11 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133310euoutp01fa5325c9c20efa42f507149915ea9a6e~OmcUWworR2269422694euoutp01L
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133310euoutp01fa5325c9c20efa42f507149915ea9a6e~OmcUWworR2269422694euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376790;
 bh=pIb0nPTrHa/iRpyO7ufWRmGfr7BSDXYV+FMd40F3xBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UtEAqJTpdD5BP834xhQwV9Mec1QiVhz3UjUgpRkSMcOOpn+FVV/FCucTVqWCWBOlh
 FICW5CQGbRL+SdqJc36PUXnEBFf9OVQwDOD9VjgQx4jTdgshmjjE2Zv5kw9sMnn/R3
 e3ohIQYNjmPLPNkK/V8mxarCF8Q53QQSvQNaULRs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133309eucas1p25b78bef1ca867a71b40fd91e10da607b~OmcUDOjQW0616406164eucas1p2Z;
 Wed, 13 May 2020 13:33:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.C5.61286.517FBBE5; Wed, 13
 May 2020 14:33:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133309eucas1p1b5b2505556566570e6fb3433397c6168~OmcTxGNQj0876608766eucas1p1_;
 Wed, 13 May 2020 13:33:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133309eusmtrp1e68a8c1c6d83efe321f433230237ed3a~OmcTwck3M1050610506eusmtrp1K;
 Wed, 13 May 2020 13:33:09 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-57-5ebbf71525ea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.1A.08375.517FBBE5; Wed, 13
 May 2020 14:33:09 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133308eusmtip18920ac7684f9687e1d8df62e18e53f73~OmcTEa_MK0131701317eusmtip1E;
 Wed, 13 May 2020 13:33:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/38] drm: omapdrm: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:25 +0200
Message-Id: <20200513133245.6408-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87qi33fHGcy7aGHRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBHcdmkpOZklqUW6dslcGVsnHiIrWCDaMW3m8/ZGxhPCnYxcnJICJhIvFq3lrWLkYtD
 SGAFo8SnJdeYIJwvjBJbb/SwQDifGSWatm1kgmlZ9OIjM0RiOaPEi2e9bHAt3+Y+BKtiEzCU
 6HrbxQZiiwi0Mkqc6OUBKWIWOMQksaX1KgtIQlggWOLj+8dgRSwCqhINLxrBbF4BW4lXW9ez
 QayTl1i94QAziM0JEr+zH+wmCYFd7BLP511hhyhykfjSs4sVwhaWeHV8C1RcRuL05B6ohmZG
 iYfn1rJDOD2MEpebZjBCVFlL3Dn3C2gdB9B9mhLrd+lDhB0lts1fyAoSlhDgk7jxFhxkzEDm
 pG3TmSHCvBIdbUIQ1WoSs46vg1t78MIlqBIPia3zbSEBdJhRYu37H6wTGOVnIexawMi4ilE8
 tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzAlnf53/NMOxq+Xkg4xCnAwKvHwWtzaHSfEmlhW
 XJl7iFGCg1lJhNdvPVCINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUw
 WSYOTqkGRlP/x7O2vMtKt2ma8H3D1qbUGPW8pSqPbxav1+7IsnSsP8ujIyhtqjY/9VeC4ZqE
 23JZF23NfidGf7jH8mKyvma7rf8uodwii/lRhyPlb1Xx+mwSvb7mMsPz6p3zNtVLf9153qnV
 Q02Pq/jcuv7uCpMv4Ymrd6xMvMYxu/aysLG/Y2jpc7MfSizFGYmGWsxFxYkAeOGoR0UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7qi33fHGZz5Im/Re+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
 6GVsnHiIrWCDaMW3m8/ZGxhPCnYxcnJICJhILHrxkbmLkYtDSGApo8T2DxfZIBIyEienNbBC
 2MISf651sUEUfWKUaLg6lx0kwSZgKNH1FiIhItDJKDGt+yM7iMMscIJJ4t7e+YwgVcICgRKr
 +1vBbBYBVYmGF41gK3gFbCVebV0PtU5eYvWGA8wgNidI/M5+FhBbSCBfYu/ifWwTGPkWMDKs
 YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyRbcd+bt7BeGlj8CFGAQ5GJR5ei1u744RYE8uK
 K3MPMUpwMCuJ8PqtBwrxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjB+80riDU0NzS0sDc2N
 zY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOpuTO4Wlcl9odToFeM1ITjs7Zy9RxqM
 vq8Olk+//HRnw4JPk/x2ibQaGqjmV69W1p8Ud9qp2Gf2WoNZx5uTL2f296Ynnv2xvXmy4JQG
 vnbmeVONnrl57xSc+GxJqcov+9V2Cxu+aAcdZYnX3OHUY8KYfm25v/Xi0zH59x7XfSp1fPyS
 OfnkRyWW4oxEQy3mouJEAOXWc2CnAgAA
X-CMS-MailID: 20200513133309eucas1p1b5b2505556566570e6fb3433397c6168
X-Msg-Generator: CA
X-RootMTR: 20200513133309eucas1p1b5b2505556566570e6fb3433397c6168
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133309eucas1p1b5b2505556566570e6fb3433397c6168
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133309eucas1p1b5b2505556566570e6fb3433397c6168@eucas1p1.samsung.com>
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

Fix the code to refer to proper nents or orig_nents entries. This driver
checks for a buffer contiguity in DMA address space, so it should test
sg_table->nents entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index c259411..cbcb361 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -48,7 +48,7 @@ struct omap_gem_object {
 	 *   OMAP_BO_MEM_DMA_API flag set)
 	 *
 	 * - buffers imported from dmabuf (with the OMAP_BO_MEM_DMABUF flag set)
-	 *   if they are physically contiguous (when sgt->orig_nents == 1)
+	 *   if they are physically contiguous (when sgt->nents == 1)
 	 *
 	 * - buffers mapped through the TILER when dma_addr_cnt is not zero, in
 	 *   which case the DMA address points to the TILER aperture
@@ -1279,7 +1279,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 	union omap_gem_size gsize;
 
 	/* Without a DMM only physically contiguous buffers can be supported. */
-	if (sgt->orig_nents != 1 && !priv->has_dmm)
+	if (sgt->nents != 1 && !priv->has_dmm)
 		return ERR_PTR(-EINVAL);
 
 	gsize.bytes = PAGE_ALIGN(size);
@@ -1293,7 +1293,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 
 	omap_obj->sgt = sgt;
 
-	if (sgt->orig_nents == 1) {
+	if (sgt->nents == 1) {
 		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
 	} else {
 		/* Create pages list from sgt */
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
