Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D332C4725A
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A3F2078E
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DwPzGLBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A3F2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ECC6F23504;
	Tue,  5 May 2020 08:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZ9JFWa+YFWO; Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7A0F023524;
	Tue,  5 May 2020 08:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6852DC088E;
	Tue,  5 May 2020 08:46:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9503C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 97D208954C
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puamSHUUmsWJ for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7782C89537
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:28 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084627euoutp0285cc315baaf05df36f2c8cb62ef7e3b6~MFXsgpJUG2636626366euoutp02J
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200505084627euoutp0285cc315baaf05df36f2c8cb62ef7e3b6~MFXsgpJUG2636626366euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668387;
 bh=kVItjuzkDZEWgWWKI3FgsiswD6i+/SL80m0l+V0hN28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DwPzGLBxZhh4g1jktHAp0peUHDhIlb3NPoiSsIdhOGYVCiBIF2qTINWJjfYJBp1KE
 w8M5TLed7PNXLMOrmtFVahVe64l/nCAoBxJmVi0T0wkNHAEfXH77L+EFd34Ao9LQ+T
 jgXexE5+sEbXy0S/Jw9Hammvz5CnNdzCrI+1zhDE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200505084626eucas1p2bd08c1934dd8d39db7ddf52dfe576b9d~MFXsULUhN1058410584eucas1p2r;
 Tue,  5 May 2020 08:46:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E0.CF.61286.2E721BE5; Tue,  5
 May 2020 09:46:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a~MFXsB2CIY1942419424eucas1p2I;
 Tue,  5 May 2020 08:46:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084626eusmtrp18fa2f153b5af7296c4a2a944ba75303f~MFXsBOMfc0942509425eusmtrp15;
 Tue,  5 May 2020 08:46:26 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-97-5eb127e2d689
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.21.07950.2E721BE5; Tue,  5
 May 2020 09:46:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084626eusmtip198ef62d087e4d50afa1a00ff5371d8a9~MFXreJocU0686606866eusmtip1H;
 Tue,  5 May 2020 08:46:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/25] drm: etnaviv: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:45:54 +0200
Message-Id: <20200505084614.30424-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7qP1DfGGRy9aWrRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLXTPusFusXH2UyWLBfmuLB3NvMll8ufKQyWLT42usFpd3zWGzWHvkLrvF
 wQ9PWB14PdbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR/9fA4++
 LasYPT5vkgvgjuKySUnNySxLLdK3S+DKaGsxKngjVrH540+2BsZ1wl2MHBwSAiYSBzrsuhi5
 OIQEVjBKHLiwgRnC+cIo0fvnBwuE85lR4uTkHUAZTrCOI2fXQCWWM0rMb5mM0HJ29joWkCo2
 AUOJrrddbCC2iEAro8SJXh4Qm1ngPpPE75dZILawQLDEmtVvwKayCKhKfJzVA9bLK2Ar8e7a
 aiaIbfISqzccAKvhFLCTeHzpDhvIMgmBY+wSB/5+ZoQocpFYPa2NBcIWlnh1fAs7hC0jcXpy
 DwtEQzOjxMNza9khnB5GictNM6C6rSXunPvFBgoOZgFNifW79CHCjhLzGh+yQUKJT+LGW0GI
 B/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuQUPLQ6Lry2NGSAAdZZRY++A20wRG+VkIyxYw
 Mq5iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITEun/x3/tIPx66WkQ4wCHIxKPLwRn9fH
 CbEmlhVX5h5ilOBgVhLhXfZjQ5wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1Kz
 U1MLUotgskwcnFINjHo2PJ33RHV8L0nbMh1dV2V2/9WfqqXyiz9GXld7+U9nw7NNL+5L39+e
 8Cy0giFh5soMjcA7eeaefmz/tjGEv61eofMk/lmcz2rNGxL/suf2Sk+NfSWavv7E4XUNztvq
 /99/PuXQjKkMNU8O/Tr/ZE9JhP3qxuVPOvP96rWYvh4LPNDQcU37iZgSS3FGoqEWc1FxIgDg
 MXN2RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7qP1DfGGVzbomjRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLXTPusFusXH2UyWLBfmuLB3NvMll8ufKQyWLT42usFpd3zWGzWHvkLrvF
 wQ9PWB14PdbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR/9fA4++
 LasYPT5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
 LdK3S9DLaGsxKngjVrH540+2BsZ1wl2MnBwSAiYSR86uYeli5OIQEljKKPFxyT82iISMxMlp
 DawQtrDEn2tdbBBFnxglnk6/zQ6SYBMwlOh6C5EQEehklJjW/REswSzwnEniZYt+FyMHh7BA
 oMTfdgGQMIuAqsTHWT0sIDavgK3Eu2urmSAWyEus3nCAGcTmFLCTeHzpDtgRQgKFEh/Of2ed
 wMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCUbDv2c8sOxq53wYcYBTgYlXh4N3xd
 HyfEmlhWXJl7iFGCg1lJhHfZjw1xQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOC8knhD
 U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MAR/zt7hp3xEWyrk0N5Sp
 unbJzPtTxZP7LzwR0on/Khzzdd+C5UqcGU8St2ueOeiebbG/+0zd6XKbGHaFZ5fKpJVCeh6f
 LlhR0/wufdNn092PWFmcAq613276Y5rQ3fxFXaw+q1HdbJlvdo673YyLR+9UNJqmJzbrVVje
 4tXSZzN41KzkvUuJpTgj0VCLuag4EQC8t0YKqAIAAA==
X-CMS-MailID: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
X-Msg-Generator: CA
X-RootMTR: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084626eucas1p20abe79e406f60ae92fec252072befc5a@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index dc9ef30..340026b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -27,7 +27,7 @@ static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
 	 * because display controller, GPU, etc. are not coherent.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_map_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL);
 }
 
 static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj)
@@ -51,7 +51,7 @@ static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj
 	 * discard those writes.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_unmap_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL);
 }
 
 /* called with etnaviv_obj->lock held */
@@ -404,9 +404,8 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
 	}
 
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
-		dma_sync_sg_for_cpu(dev->dev, etnaviv_obj->sgt->sgl,
-				    etnaviv_obj->sgt->nents,
-				    etnaviv_op_to_dma_dir(op));
+		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
+					 etnaviv_op_to_dma_dir(op));
 		etnaviv_obj->last_cpu_prep_op = op;
 	}
 
@@ -421,8 +420,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
 		/* fini without a prep is almost certainly a userspace error */
 		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
-		dma_sync_sg_for_device(dev->dev, etnaviv_obj->sgt->sgl,
-			etnaviv_obj->sgt->nents,
+		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
 			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
 		etnaviv_obj->last_cpu_prep_op = 0;
 	}
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
