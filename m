Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E0C8300B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7676C206E2
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="irvfzwf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7676C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BC1B862C1;
	Tue, 28 Apr 2020 13:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0s3blAAtJZ3; Tue, 28 Apr 2020 13:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B9B0854FC;
	Tue, 28 Apr 2020 13:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7E7DC0863;
	Tue, 28 Apr 2020 13:20:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD514C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B41A48708C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZwjteoZLQfpU for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:20:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 723568706B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:26 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132024euoutp024d13cae15ae103655736f2b1ada988ac~J-l4s9TFs2985029850euoutp02N
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200428132024euoutp024d13cae15ae103655736f2b1ada988ac~J-l4s9TFs2985029850euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080024;
 bh=RdD4vdA/dvZy//4SN9fUUFJeQGUgv987I0tmWIX3CFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=irvfzwf9hA76tsOHtjijkJk++tSF6mR9/7sy6f0/mLZrdvADMZXs5oYbMpCFkZxBF
 1LEql2GBq5NLI/hjN08RV/xJX4ikt3NLsSiTFY65tzEwX2dynCAhWTQ/KwZ8dYsFzo
 z6BQzHPzvhPZVjPxAAiw8RomTZNVTh5pRROqx3dA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200428132023eucas1p22608a33dbb73c19b9e6e4c9e1cfc7ef3~J-l4WkzdE2651826518eucas1p2K;
 Tue, 28 Apr 2020 13:20:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.B1.60679.79D28AE5; Tue, 28
 Apr 2020 14:20:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43~J-l4FznJX1084510845eucas1p2Q;
 Tue, 28 Apr 2020 13:20:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200428132023eusmtrp2bcac38ecf53e28df3183908ba73ff661~J-l4FF7Zw2140221402eusmtrp2B;
 Tue, 28 Apr 2020 13:20:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-88-5ea82d974d9d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.96.08375.79D28AE5; Tue, 28
 Apr 2020 14:20:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132022eusmtip2eb2ef3f32b45fad3d3e3bf7df616d25f~J-l3VS6cB0876008760eusmtip2h;
 Tue, 28 Apr 2020 13:20:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 02/17] drm: amdgpu: fix sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:19:50 +0200
Message-Id: <20200428132005.21424-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzf7557XlxOT8fmNynbbbXKkGr1KzI2rWfNH72stbVFTzzDOOwe
 lFpLyjE6owzRSnZyDp2QckJudGHDkMlLea3lZVqkkcjTg/77vP4+23c/ClM04g5UaEQ0p45g
 w5WETFr9brHdJdtF779/qngP0ra3SFCh8TaJXuQYcZRgbiXQanUGhnp+zhKouKRZgvLSKyUo
 v8EDzfeMSFDFWC+Ouk2PCFTWNESixu/jOGodmiO9tzKlj0sBU7eQL2UGe98QzKuFYZz5nGqR
 MJW6W8zAyhjGPOgrAkztx3iCSasyAGauYufpLRdlnkFceGgsp3bzuiwLWTZr8SiN/bWZ5SQ8
 HhhsU4AVBelDMK+3mEwBMkpB6wFMTNMBkcwDWJNajolkDsCpcY1ko/Kl2ygVjSIAG4bnsM1K
 YlamVEgRtDtMmUkhBGxHJwL4XmsthDC6GoPjRU2kYNjSp+BikuFfSErvggVa09o4Rcnp41BX
 GieuOcGS8reYgK1oL1g4OkEI70C6l4SVdZNADPnCp9NpuIht4aSlihSxI1yteSIRC3cAHGkv
 I0VyD8DuhJz1tgccbF8ihGWM3guNJjdR9oEJqW2kIEPaBvbNbBNkbA3er87GRFkOkzUKMb0b
 5lqeb842dnZhImbgxELH+oEzANTqnoB04JT7fywfAAOw52J4VTDHH4jgrrryrIqPiQh2DYxU
 VYC1j9W2Ypl/DUzLV8yApoDSWl5urfdX4GwsH6cyA0hhSjv5aMgzf4U8iI27zqkjA9Qx4Rxv
 BtspqdJefrDg2yUFHcxGc2EcF8WpN1wJZeUQD6IzfWyY2eaCMOOvSrZDetdsCQpIGMiIdr7Z
 0+e5nMz49debxlVWBr+8VqcLRzUPi8/6tpyJ7OpkPY/lZiGZ82/NuRNk95Ldj9QQpzabTs+c
 qfPTw3+O7Ki98aH+8CJrtNb0RzH+gU2f9Ir0qZP8V7OjEXiTtjiXW0+gl7pRpZQPYd33YWqe
 /QuTM2vnVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rTdVfEGZw4KGDRe+4kk8XS9Y3s
 FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
 9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
 k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQy/hzqZS1oE694+6edtYFxlXAXIyeHhICJxLPL61m6GLk4hASW
 Mko8m3GQHSIhI3FyWgMrhC0s8edaFxtE0SdGie8LX7OAJNgEDCW63kIkRAQ6GSWmdX9kB3GY
 BQ4wS3SfP8kEUiUs4CXxs30VG4jNIqAqsah3F2MXIwcHr4CtxJI1lRAb5CVWbzjADGJzCthJ
 LH30lA2kRAio5HJL7gRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2fbsZ+bdzBe
 2hh8iFGAg1GJh3cDz4o4IdbEsuLK3EOMEhzMSiK8jzKWxQnxpiRWVqUW5ccXleakFh9iNAU6
 aSKzlGhyPjCy80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MBaU
 /PjeeVsqlPNZQ6Po07lvZPJdHYqKvhyWfb3BSctZZ1p4ln7aX9WOkJQdDyR/rpwmVq6fwM5i
 c1hwlcwG52ltX7ouTHknf/LYtP9FU3xUa5/mahwXvXx486mFjV5pM5/vUdnkJXTj0iQ/B9OE
 47N8Gfkm8y7jDNjFwH/Pm6/8XXyUztQlbEosxRmJhlrMRcWJAITrShy0AgAA
X-CMS-MailID: 20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43
X-Msg-Generator: CA
X-RootMTR: 20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43@eucas1p2.samsung.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 43d8ed7..4df813e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -307,8 +307,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (IS_ERR(sgt))
 			return sgt;
 
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC))
+		sgt->nents = dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->orig_nents,
+					      dir, DMA_ATTR_SKIP_CPU_SYNC);
+		if (!sgt->nents)
 			goto error_free;
 		break;
 
@@ -349,7 +350,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 	if (sgt->sgl->page_link) {
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d5543c2..5f31585 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1043,7 +1043,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	unsigned nents;
 	int r;
 
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
@@ -1059,8 +1058,9 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 
 	/* Map SG to device */
 	r = -ENOMEM;
-	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	ttm->sg->nents = dma_map_sg(adev->dev, ttm->sg->sgl,
+				    ttm->sg->orig_nents, direction);
+	if (ttm->sg->nents == 0)
 		goto release_sg;
 
 	/* convert SG to linear array of pages and dma addresses */
@@ -1091,7 +1091,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* unmap the pages mapped to the device */
-	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
 
 	sg_free_table(ttm->sg);
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
