Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1105DC2D0E4
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBED2166E
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Awm+ccSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBED2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E9FC87508;
	Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59ClmTpQLZ09; Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6268D87518;
	Fri,  4 Sep 2020 13:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4964AC0894;
	Fri,  4 Sep 2020 13:35:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7509EC0893
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E90786D44
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0VqcENI0P9t for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 34A6786D3A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:00 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133458euoutp029bb5e9db4310cf3d7b7d6bfd3ca5136a~xmAcHI3S22890028900euoutp02a
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904133458euoutp029bb5e9db4310cf3d7b7d6bfd3ca5136a~xmAcHI3S22890028900euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226498;
 bh=QOEXRl2z3ozWMJXcJ/ZYCIy/nZzMSXSHvZvf61p4Upk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Awm+ccSHUQQgK4CJH/OKkbCamNK5eGjoasL9cIbxa2ARunI9QPmOjm0AU7HqUnRIg
 fjgvn7SuQidONLatCz/CeMwLetZRT9rQQKGW1Bins4FMSob+8a/kQMyfTIVWvjOthG
 y90u2fxN3jN+YxbZ1QDJtaRPwxdCq54vEbKZpsN4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133458eucas1p29f0d35d0499f0cbed96b2843ca336b30~xmAbu1mxb0694006940eucas1p2d;
 Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.66.05997.282425F5; Fri,  4
 Sep 2020 14:34:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133457eucas1p137d219c4f1af06078d7da5fe92c9aed9~xmAbY4xkM1679116791eucas1p1i;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133457eusmtrp1ccba99a63a17a8a192a0cfb5f3ce35a3~xmAbXuhNR0766507665eusmtrp18;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-51-5f524282f8f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.AE.06314.182425F5; Fri,  4
 Sep 2020 14:34:57 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133457eusmtip15a4c02f7a9ad3a34526338d40b675258~xmAao6iHX1888418884eusmtip1R;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/30] drm: exynos: fix common struct sg_table related
 issues
Date: Fri,  4 Sep 2020 15:16:48 +0200
Message-Id: <20200904131711.12950-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe1BMYRjGfee+qzXHyeWbFDMbZphBYcxHro0xxx8uIzNuQx0cramtZrci
 l7GtcVui7GBL2FGjy5ZYLJPrVqxstrI0m8glpGgUi2HcOp3Ff7/3eZ93nm+e+Ric85AhzMak
 VFGXJCSqKSXhuPPNM84YvSQ2orlGgbI8tRg6b6kg0W9HDo4efv5AoRLbbQwdfpZNIOvNKPS2
 tZFAh9re4ai+/hyN7hvf08j/8AWG7G1NJPJW5lPIUn8DQ+U1T2nk7H5FIou5g5rN8WUnywB/
 /YuV4O2l+yj+8pfnJP9svwvjLxTu4Ft+teG82VcE+KvNBoo/eLEU8J/swxf3X6mcvl5M3Jgu
 6ibMjFNqjnZOS+kI3uys8lEG4GVNgGEgOxmeasdMQMFwbDGAx69pTUDZy34Aze0fKXn4BGC+
 JwtILumg7koTJi+KAOxs8JL/TvILX5KSi2IjoanLREk8iN0F4N2sIMmEs0UEPGH72WcKZmNg
 u/EyLTHBjoIVxa/7dBU7A9pavgXiRkDbuVu4xAp2JrxkedWXBtkeGh7pKcNl01zYuecDJnMw
 7HRdpGUOhW7zAUI+2AngC085LQ8HAPQaLYGIKPjE852S6sDZMbCicoIsz4GXqq/jcksDoK9r
 oCTjvXjYcSwgq+De3ZzsHg3zXGf/xTobHgSexsPj/kO03FAOgMV5ZiobjMj7H2YFoBQMFdP0
 2nhRPzFJ3DReL2j1aUnx49cla+2g95e5f7n8V0Dlj7VVgGWAOkjVb9aSWI4U0vUZ2ioAGVw9
 SBV9372GU60XMraIuuRYXVqiqK8CwxhCPVQ16XTHao6NF1LFBFFMEXV/txijCDGAWbB1Rc5c
 S9GM0XH8gKncyDPlsRHzzYsXOTNzW62ZhcvuuAYLOzdwQ/B7xwq8mZ75mtCf3TY6vDbS1xP2
 eeGwXdkrqqMSQhs1uY/INyW+VRFxquyw6LCsggWae49PmOvMyb9LRENKv5gp235sTc8Nn+c+
 H7T8a+0kx1Jhz8TtaLJSTeg1QuRYXKcX/gDFNAP7YQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7qNTkHxBt+uGlj0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBaT7k9gsViw39rixb2LLBb9j18zW5w/v4Hd4mzTG3aLL1ceMlls
 enyN1eLyrjlsFjPO72OyWHvkLrvFwQ9PWC1mTH7J5iDksWbeGkaPvd8WsHhsWtXJ5rH92wNW
 j/vdx5k8Ni+p97j97zGzx+Qbyxk9dt9sYPPo27KK0ePzJrkA7ig9m6L80pJUhYz84hJbpWhD
 CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jGmvrApeClccPHSDrYHxskAXIyeH
 hICJxJkd15i6GLk4hASWMkp8b13OBJGQkTg5rYEVwhaW+HOtiw3EFhL4xChx+K4WiM0mYCjR
 9RYkzsUhItDJKDGt+yM7iMMssJlF4t/6J+wgVcICgRIPt3aAdbMIqEqsX/EUbCqvgK3E6ts/
 GSE2yEus3nCAGcTmFLCT2DrjCSvENluJD3MWs0xg5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9d
 Lzk/dxMjMLa2Hfu5eQfjpY3BhxgFOBiVeHgZ7IPihVgTy4orcw8xSnAwK4nwOp09HSfEm5JY
 WZValB9fVJqTWnyI0RToqInMUqLJ+cC4zyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
 nZpakFoE08fEwSnVwKh1zfr/rR+3I73PPnLarndsdWxGgNQC3lxmtf4eNt7GwEJzlT17p1X+
 MP6+e1lX4PWD4bU5ZoLSXIduTjlZHvDh8scC0b62RvbJfwvEeyrmG8/w15kucWTFvVvTI5QV
 rv1b53tw7y/5Hc1Bwlcdg/clFm7WMJ30JW8T1/q3984fd/Bm2zhFYroSS3FGoqEWc1FxIgDU
 ikxUwwIAAA==
X-CMS-MailID: 20200904133457eucas1p137d219c4f1af06078d7da5fe92c9aed9
X-Msg-Generator: CA
X-RootMTR: 20200904133457eucas1p137d219c4f1af06078d7da5fe92c9aed9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133457eucas1p137d219c4f1af06078d7da5fe92c9aed9
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133457eucas1p137d219c4f1af06078d7da5fe92c9aed9@eucas1p1.samsung.com>
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
Acked-by : Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 03be31427181..967a5cdc120e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -395,8 +395,8 @@ static void g2d_userptr_put_dma_addr(struct g2d_data *g2d,
 		return;
 
 out:
-	dma_unmap_sg(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt->sgl,
-			g2d_userptr->sgt->nents, DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt,
+			  DMA_BIDIRECTIONAL, 0);
 
 	pages = frame_vector_pages(g2d_userptr->vec);
 	if (!IS_ERR(pages)) {
@@ -511,10 +511,10 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 
 	g2d_userptr->sgt = sgt;
 
-	if (!dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl, sgt->nents,
-				DMA_BIDIRECTIONAL)) {
+	ret = dma_map_sgtable(to_dma_dev(g2d->drm_dev), sgt,
+			      DMA_BIDIRECTIONAL, 0);
+	if (ret) {
 		DRM_DEV_ERROR(g2d->dev, "failed to map sgt with dma region.\n");
-		ret = -ENOMEM;
 		goto err_sg_free_table;
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
