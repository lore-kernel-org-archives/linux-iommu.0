Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D3C433E3
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B83E20707
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H072O/jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B83E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 306F686B1D;
	Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrupsfxwRaxr; Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8753086AD8;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 768C5C088B;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A3CC016F
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1310B2281C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dB8KC9emB4yR for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id C4A87227F8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063531euoutp026ee01cab1e54347b8528b175885e2952~uvepKlcvj1510015100euoutp02J
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063531euoutp026ee01cab1e54347b8528b175885e2952~uvepKlcvj1510015100euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423731;
 bh=8H1bscYmofV6UafZRI60uVVnlPqwrLm9J9QpIebQpZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H072O/jDGDDFjuFTH5o3idIRZA7eo8/ZDFnBI5bCrEtr+dI1R17Y7bPDxKjoHJtQ8
 SE1QNwAc9lI5BtTbbUPWmCWclFCh8KTKq6VvRkfk16vQxQJY7J3PjHkOGmhhz5i81W
 OuLw9rY6bbnaobEhiRcYuFMICfRe0GDOLEDWf3JM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063531eucas1p248ebe392029fc6a0fd4a1b8c8288bab3~uveo5b_lz0402804028eucas1p2e;
 Wed, 26 Aug 2020 06:35:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.23.06456.3B2064F5; Wed, 26
 Aug 2020 07:35:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063531eucas1p21c9277fe2a91e632e40822fb04a2c095~uveog6mDa0403504035eucas1p2o;
 Wed, 26 Aug 2020 06:35:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063531eusmtrp133d833530b3a2b770231736ad24afb9e~uveogH7nN1091110911eusmtrp1L;
 Wed, 26 Aug 2020 06:35:31 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-b7-5f4602b344c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.C0.06314.2B2064F5; Wed, 26
 Aug 2020 07:35:30 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063530eusmtip247af081d1930d5e275f6f52617cdf1d2~uvenw-tS40092200922eusmtip2x;
 Wed, 26 Aug 2020 06:35:30 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/32] drm: exynos: use common helper for a scatterlist
 contiguity check
Date: Wed, 26 Aug 2020 08:32:50 +0200
Message-Id: <20200826063316.23486-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+XbOzs6Wy9M0/LKLMMhQUpOivkhNw+xEElGEGZTOPKipU87U
 sn8ahpmb5mpdRNTUSs17W6wwvOaaYrryhpJ5YRlajswbFGS5Hcv/fu/7Ps/3vLx8JCbp4buS
 cfIUhpXLEqSECDe8/Wn20vNCIva8VG9Bub1dPPQ8v56P/hjuYGhg6TuBnlUbeejuuAZHJS2H
 0PTYBxzlWb5hyGxuEKCejFkBWhyY5CGdZYiP+hsLCZRvbuah2o5PAtQ295mP8rUzRKCErimu
 AXTTcglO66qyCfrl8gSfHlebeLT+yXX644oFo7XDFYB+PaIk6NsvqgC9oNtxasN5kV80kxCX
 xrA+AZGi2Kn7FkFyqcPVoYVBQgm0IhUgSUjtg4NGRxUQkRKqEsCsAT3gikUAjT+Ma8UCgHlZ
 mYQKCO0OVUUWwQ0qAFSOGdctk7oHfJuKoHyhyqqyO5ypTAA7cx1sIoyqwGFR9W+7yIm6AO+Z
 y4GNcWonnC3twmwspvyhUTm1FucGqxta7X0hFQBN6ry1/owAFs35cxwMO2ZzAcdO8KvphYDj
 bbBbm4PbgiF1Y3W73loBV+QA2J+Rv+Y4BEd7fxG2c2CUB6xv9OEuEwTv6f043AiHrZtsYmwV
 7xoeYlxbDG/dlHBvuMMCU93/1Lb3fRjHNCysUdtzJNQdAB81e2iAW8F6VAkAVcCFSVUkxjAK
 XzlzxVshS1SkymO8LyUl6sDqJ+teMc2/Akt9Ue2AIoHUQVxCHI2Q8GVpivTEdgBJTOosPtLT
 fVEijpalX2PYpAg2NYFRtIOtJC51Ee8tm7kgoWJkKUw8wyQz7L8pjxS6KkF93JHTAVc6QtwB
 W7BbExXy5pi/u3f0jGbu7HIh3YCFnmnVlD2eXhi5Vb5ffcxPaCjyDmQK3b+4Xj4ujXZsi2TC
 paxz04HMyODt4WFVoUNs2eHRIqt1s8uZ7BO410TY0zqtl774dmVUkKG9M/5pXUvX1vKWcy7z
 u6Y8Tx5893yiWYorYmW+nhirkP0FEPcxe2ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7qbmNziDRZ8trHoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwm3Z/AYrFgv7XFi3sXWSz6H79mtjh/fgO7xdmmN+wWX648ZLLY
 9Pgaq8XlXXPYLGac38dksfbIXXaLgx+esFrMmPySzUHIY828NYwee78tYPHYtKqTzWP7twes
 Hve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fnTXIB3FF6NkX5pSWpChn5xSW2StGG
 FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GU+nPmYvWMhTce3zVbYGxslcXYyc
 HBICJhJdy9vZuhi5OIQEljJK7DzSww6RkJE4Oa2BFcIWlvhzrQuq6BOjxIyr69lAEmwChhJd
 byESIgKdjBLTuj+ygzjMAptZJP6tfwI2SlggWmL10qPMIDaLgKrEm4UnwWxeAVuJow1P2SBW
 yEus3nAALM4pYCdxvLsfLC4EVHN67QzmCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+du
 YgTG17ZjPzfvYLy0MfgQowAHoxIP7wI213gh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRbl
 xxeV5qQWH2I0BTpqIrOUaHI+MPbzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphak
 FsH0MXFwSjUwGq5vejPD8X7PrqZbxsqLvrg55WnMP3jAqq3FvbsgKuX974at358++DCD6WTO
 pEbWKde00ktsl5eUf/g0/52FrPOt+jcxd/yklm/vfL15m/jKqPeHfy9epHr23hOeRk8OfZ/t
 cX8OHeQued28K/qzjrn8lNNNijM1LjRcq/7EIZQ850NtqNfXGCWW4oxEQy3mouJEABxpr6LF
 AgAA
X-CMS-MailID: 20200826063531eucas1p21c9277fe2a91e632e40822fb04a2c095
X-Msg-Generator: CA
X-RootMTR: 20200826063531eucas1p21c9277fe2a91e632e40822fb04a2c095
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063531eucas1p21c9277fe2a91e632e40822fb04a2c095
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063531eucas1p21c9277fe2a91e632e40822fb04a2c095@eucas1p2.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
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

Use common helper for checking the contiguity of the imported dma-buf.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by : Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index efa476858db5..1716a023bca0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -431,27 +431,10 @@ exynos_drm_gem_prime_import_sg_table(struct drm_device *dev,
 {
 	struct exynos_drm_gem *exynos_gem;
 
-	if (sgt->nents < 1)
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size) {
+		DRM_ERROR("buffer chunks must be mapped contiguously");
 		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Check if the provided buffer has been mapped as contiguous
-	 * into DMA address space.
-	 */
-	if (sgt->nents > 1) {
-		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
-		struct scatterlist *s;
-		unsigned int i;
-
-		for_each_sg(sgt->sgl, s, sgt->nents, i) {
-			if (!sg_dma_len(s))
-				break;
-			if (sg_dma_address(s) != next_addr) {
-				DRM_ERROR("buffer chunks must be mapped contiguously");
-				return ERR_PTR(-EINVAL);
-			}
-			next_addr = sg_dma_address(s) + sg_dma_len(s);
-		}
 	}
 
 	exynos_gem = exynos_drm_gem_init(dev, attach->dmabuf->size);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
