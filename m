Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E81C2BB84
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5C204FD
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aeYL8iR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD86D8752F;
	Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGSXdod-UxTI; Fri,  4 Sep 2020 13:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EEF7887508;
	Fri,  4 Sep 2020 13:35:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD9E2C0893;
	Fri,  4 Sep 2020 13:35:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB5CC0890
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2D62186C26
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9VBhmt5Na9_g for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F30B886C2B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:59 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133458euoutp02693cd4fff23201f82634ae28472d35c1~xmAbkoO-82781727817euoutp02X
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904133458euoutp02693cd4fff23201f82634ae28472d35c1~xmAbkoO-82781727817euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226498;
 bh=8H1bscYmofV6UafZRI60uVVnlPqwrLm9J9QpIebQpZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aeYL8iR9JYc9lkmxnzMIIHAnNI3E0L252yBi/RWf78z5pZDqnne/pZVBM42URUREE
 aAvXgPCsXHqX6bfECz0cfNd1+O3pwZ/M8k0r9KjRAvBXOcCoNtdG0D7kAUAqZjSOeo
 Com1uRGEf26F2ZIluMII0as3yXBHCrWjAZi8HNKY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200904133457eucas1p1058cf2b68d182f31cbfbeceea7957319~xmAbFDaFL1681116811eucas1p1b;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 12.66.05997.182425F5; Fri,  4
 Sep 2020 14:34:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200904133457eucas1p24d73bb3e4aa921cb76dc03b309ad5632~xmAauOTvi1446414464eucas1p2N;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200904133457eusmtrp2a28ab62b459b3dd2dccde1bca8d8a4db~xmAatbq4P0905709057eusmtrp2d;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-4e-5f52428144c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.90.06017.082425F5; Fri,  4
 Sep 2020 14:34:57 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133456eusmtip1181679675ed5d882c788a0eff35a5877~xmAZ7SJtr1932019320eusmtip1O;
 Fri,  4 Sep 2020 13:34:56 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 06/30] drm: exynos: use common helper for a scatterlist
 contiguity check
Date: Fri,  4 Sep 2020 15:16:47 +0200
Message-Id: <20200904131711.12950-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa1BMYRj2ndueXS2nrZm+YsQOzQglmvHNpOQy48zww/SPGbJ0VNRmdm1k
 xlhbUutaDVZuXRC7XbYtRZRqlkW1G7XZkNQWFQ2jNOMWu87Kv+d9nuf9nmfe+Whc0k4G0Iny
 fZxCLkuSUiKi5tE325Ija2Jil1b0zEInrU8wVKmrINHvmhwcdX79RKFbhocYyu09Q6CCBxFo
 6M0zAp12fsCRzWYUoDbNRwEa7+zDkMnZRaKOuksU0tkaMFRm7hGgps8DJNLlDVPRErb0Silg
 6ycKCNakz6bY2om3JNt73IKxVdcOs68mnTib5ygB7L1uNcWeqtYDdsw0Z9P0LaKVcVxSYiqn
 CI3aLkoYPOsU7C30OtA1ZqfUIE+kBUIaMuHwtq4b0wIRLWFuAnjDkSvgh3EAbbXtHmUMwItF
 54h/K8Xl4x6hBMDBx3Z8asXQfYxyuygmDGpHtX+xL3MUwMcnvdwmnCkh4GXDL1ILaNqH2Qaz
 exa7PQSzAD6qacfdWMxEwsIT50g+LRAajI1/eSET5So7QLrfgcyoAI5Y7QLetA4OlWfgPPaB
 I5ZqDz8b/r57FeMX0gHss5YJ+OEEgB0aHeBdEfC19TvlboQzC2FFXShPr4Yv9VWYm4bMDOgY
 9XbTuAvm1pzHeVoMszIlvDsI5lvKp2Kb2p976rDQMmT33DTHddPWp9gZEJj/P6wAAD3w41TK
 5HhOuUzO7Q9RypKVKnl8yM6UZBNw/bOWScv4HVD3c0czYGgg9RJPWxUTKyFlqcq05GYAaVzq
 K17T1rJNIo6TpR3kFCmxClUSp2wGs2hC6ideXjS8VcLEy/ZxezhuL6f4p2K0MEANwtTOi42O
 J8J5nc8qsPtdGnPCoiut6cVzBxqMGxZVhvRbM9L7J9rY2cPTxoSGp/J3qqwVVzVBZv/XiZuD
 uzaKU8OLqPcHZmbudpod3r1fLvgHal7akPzHelUTtTbTtzeHYI19Pj3S6JmFkYda/Oc3SkID
 668ndt5/ITZ3H1/2apeUUCbIwoJxhVL2B90DlvljAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7qNTkHxBrtbmCx6z51kstg4Yz2r
 xf9tE5ktrnx9z2axcvVRJotJ9yewWCzYb23x4t5FFov+x6+ZLc6f38BucbbpDbvFlysPmSw2
 Pb7GanF51xw2ixnn9zFZrD1yl93i4IcnrBYzJr9kcxDyWDNvDaPH3m8LWDw2repk89j+7QGr
 x/3u40wem5fUe9z+95jZY/KN5Yweu282sHn0bVnF6PF5k1wAd5SeTVF+aUmqQkZ+cYmtUrSh
 hZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextOpj9kLFvJUXPt8la2BcTJXFyMn
 h4SAicTidV+Yuhi5OIQEljJK3Fm0hwUiISNxcloDK4QtLPHnWhcbRNEnRom2f6/YQBJsAoYS
 XW8hEiICnYwS07o/soM4zAKbWST+rX8C5HBwCAvESCyeogHSwCKgKnFs2wVmEJtXwFZiYc80
 qA3yEqs3HACLcwrYSWyd8QQsLgRU82HOYpYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn
 525iBEbXtmM/t+xg7HoXfIhRgINRiYeXwT4oXog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWp
 RfnxRaU5qcWHGE2BjprILCWanA+M/LySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2amp
 BalFMH1MHJxSDYyGPxu7Jr5W7Wk0PXffjXufSI7liX0dc7qfibjEb9/q0hnP99Tr9Dm94i0b
 rj4NOiHrYsxXMj1PJNP+Wf/a0+p3zl3f+f6ufsV255L3j64Frl3R7qa38PH1eQaznopovV5s
 sPCMRi1jjKmn9vVbk81K7JOqvjDNXP0obZd+m0jR+vzXO3/4XF2mxFKckWioxVxUnAgAX2IH
 OMQCAAA=
X-CMS-MailID: 20200904133457eucas1p24d73bb3e4aa921cb76dc03b309ad5632
X-Msg-Generator: CA
X-RootMTR: 20200904133457eucas1p24d73bb3e4aa921cb76dc03b309ad5632
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133457eucas1p24d73bb3e4aa921cb76dc03b309ad5632
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133457eucas1p24d73bb3e4aa921cb76dc03b309ad5632@eucas1p2.samsung.com>
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
