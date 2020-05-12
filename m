Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC324C81839
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10D020714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kjN0kVdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10D020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F87E86F90;
	Tue, 12 May 2020 09:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zuhfrh2JIMpt; Tue, 12 May 2020 09:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11BCA86F89;
	Tue, 12 May 2020 09:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F86C0178;
	Tue, 12 May 2020 09:01:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A813C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F9B188E3D
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aCHTvmjRFGjX for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1BF7788E60
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:15 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090113euoutp01d69ab603af6f92b2c49552570d601a07~OPFl7nruJ2545625456euoutp015
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090113euoutp01d69ab603af6f92b2c49552570d601a07~OPFl7nruJ2545625456euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274073;
 bh=NhVbnJ+jqa6Cm7UcCSShQXuCIUUkP8fYD45Nu0/gv44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kjN0kVdlQY1j5bVaOTTBeKY7yRJWLWeRK8vtjLFmeXN+9Bx8kD2SQc1/cDOAfwwdY
 qELap4716r3WtBMV2ij01C/WCf7iIkgfm3Pj0GyfSWK8hfb/LRTqTGkAIYTk4Z2b/c
 xZq6lDNQhYFYlrHDTJdY48DysW2xpJXWhXurckb8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090113eucas1p1ef8c5da040086e7cd941a733488a5719~OPFloZoPF3053130531eucas1p1c;
 Tue, 12 May 2020 09:01:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.6B.60698.9D56ABE5; Tue, 12
 May 2020 10:01:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090112eucas1p280707473d14730b8d3054fe9b0781a05~OPFlYNMQO2661426614eucas1p2U;
 Tue, 12 May 2020 09:01:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090112eusmtrp15f7e3d008cd5e61e09ab2b1e8f14459b~OPFlXhG0_0188101881eusmtrp1B;
 Tue, 12 May 2020 09:01:12 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-0b-5eba65d9f4ae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.F2.07950.8D56ABE5; Tue, 12
 May 2020 10:01:12 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090112eusmtip1e6afa75d409d6f8bde05c4af7510a21e~OPFk0YbqY1148011480eusmtip1T;
 Tue, 12 May 2020 09:01:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/38] drm: exynos: use common helper for a scatterlist
 contiguity check
Date: Tue, 12 May 2020 11:00:30 +0200
Message-Id: <20200512090058.14910-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87o3U3fFGWx9yGXRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
 wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
 +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK+PB9i2sBbd4Kl43TWJtYDzI1cXIySEhYCLx8N5c
 ZhBbSGAFo8T/1ypdjFxA9hdGienT2hghnM+MEudvLmOC6Xj56w07RGI5o0TXs7XMcC1/eueD
 zWITMJToetvFBmKLCLQySpzo5QEpYhboYJa4NnE+0FwODmGBWImlffUgJouAqsS04yIg5bwC
 dhJb1rczQiyTl1i94QDYSE6g+P35f1hAxkgIHGOXeLHpLxtEkYvE+lOboWxhiVfHt7BD2DIS
 pyf3QDU0M0o8PLeWHcLpYZS43DQDaoW1xJ1zv9hArmAW0JRYv0sfIuwosW/bUnaQsIQAn8SN
 t4IgYWYgc9K26cwQYV6JjjYhiGo1iVnH18GtPXjhElSJh8SmOSmQ4DnKKLF84wOmCYzysxB2
 LWBkXMUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYlk7/O/51B+O+P0mHGAU4GJV4eDuM
 dsYJsSaWFVfmHmKU4GBWEuFtyQQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
 OzW1ILUIJsvEwSnVwMjSycz0RC/dt0w9rmzSlvfxDFYexQ4Vb+tDNKfPvT2HMaXh3q5P8/xq
 /1nbRs6dk+lyO7CuaCv/ZqE97x4fnbYj5sf1x/0eIYobfPJuNczkDDtTs1Jrq52N8r37n99f
 c5GMM99Z9eD7dXOJ/w7b1cKPz/h912S36Mp/6R/EA18d58pdwy/zc6MSS3FGoqEWc1FxIgCa
 4y+URwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7o3UnfFGTyebW7Re+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
 wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
 +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
 LLVI3y5BL+PB9i2sBbd4Kl43TWJtYDzI1cXIySEhYCLx8tcbdhBbSGApo8SH18IQcRmJk9Ma
 WCFsYYk/17rYuhi5gGo+MUrs7l3OBJJgEzCU6HoLkRAR6GSUmNb9kR3EYRaYwCxxv2U1Yxcj
 B4ewQLTE4521ICaLgKrEtOMiIL28AnYSW9a3M0IskJdYveEAM4jNCRS/P/8PC8RBhRKPrr5l
 mcDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgnGw79nPLDsaud8GHGAU4GJV4eDuM
 dsYJsSaWFVfmHmKU4GBWEuFtyQQK8aYkVlalFuXHF5XmpBYfYjQFumkis5Rocj4whvNK4g1N
 Dc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCumcBn9k/UZ9c6Duk1Zedm
 ha14rH/czPF1gMqN4xfaP+saP574S7v/1ZMNLyvXXxStP7pIfynvltmxk8S9mP/mXtu3yHqr
 +YkT8yd+mbNwvV9ijRHjlAlCr8/Us/9c+b7+7Pd7B7ZPak1o9vlc8frRBuduAbbdzM+ME/Y6
 fcwTPbnIctNXadl1rEosxRmJhlrMRcWJABokKdCpAgAA
X-CMS-MailID: 20200512090112eucas1p280707473d14730b8d3054fe9b0781a05
X-Msg-Generator: CA
X-RootMTR: 20200512090112eucas1p280707473d14730b8d3054fe9b0781a05
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090112eucas1p280707473d14730b8d3054fe9b0781a05
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090112eucas1p280707473d14730b8d3054fe9b0781a05@eucas1p2.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Inki Dae <inki.dae@samsung.com>, Daniel Vetter <daniel@ffwll.ch>,
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

Use common helper for checking the contiguity of the imported dma-buf.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 0df57ee..a49a8ea 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -431,27 +431,10 @@ struct drm_gem_object *
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
