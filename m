Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A6C433EA
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932BF20890
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BOWZuwWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932BF20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7DBAC888D3;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OctL8SS0-BZQ; Thu, 18 Jun 2020 15:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75FCD889F1;
	Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58193C0892;
	Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC1F6C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D85CE888F8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YWlLM2BSmG4n for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A84CD88A07
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154029euoutp025df1b236117879036c99af31b6d6545d~ZrZwZFhB21314813148euoutp02K
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154029euoutp025df1b236117879036c99af31b6d6545d~ZrZwZFhB21314813148euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494829;
 bh=XflqGGuzbUpYYYoVktMdjjrhIiuC+lHBfLj8ptx60tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BOWZuwWdbJcbKCQHFcFfKPZ4ghiknrNXzGEHxaKUqG9O1NnfvLKV2yQtiJ2uzMacD
 Fk9PRpdiFBCPdCBTVUv5xv+w/HGOzFoaXFhSvoUqVQWjDwitUS1ZonB0YFxoDUHySh
 hOk5QYrNGH/wdd0xpJ8Um8d8WktPRteJk/RLn8E4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200618154028eucas1p298772d549e3a859b6b4ba709977166fb~ZrZwH_3eT0608706087eucas1p2X;
 Thu, 18 Jun 2020 15:40:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.DE.60679.CEA8BEE5; Thu, 18
 Jun 2020 16:40:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154028eucas1p140cfc1156ef012ba74f97c5a2a7dc09e~ZrZv0jSaS0074000740eucas1p1A;
 Thu, 18 Jun 2020 15:40:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154028eusmtrp2af7f5bc6041ccaff3f0713cee8f0fbbc~ZrZvz7xmB0370403704eusmtrp2o;
 Thu, 18 Jun 2020 15:40:28 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-3f-5eeb8aec3f16
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.FE.08375.CEA8BEE5; Thu, 18
 Jun 2020 16:40:28 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154027eusmtip15ce9e44c79f4de95e367bb34237bf02d~ZrZvOvOnU0864308643eusmtip1L;
 Thu, 18 Jun 2020 15:40:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 21/36] drm: v3d: fix common struct sg_table related issues
Date: Thu, 18 Jun 2020 17:39:42 +0200
Message-Id: <20200618153956.29558-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmO2fneJxbHOfADwuldYGKvGTRIUUq/HF+REkXgqjpyoOKTmWb
 lv0oM2a5NPJCipmKLrzNvN+mpa7ptJlZmprOWwZlZkbe8ILm8Sz799ze94WHl0BF5ZgTERKu
 YhThsjAJzufVti+/P/xTMy11H2o9RiV1dyJURUYZRm3UJqNU38IsTrXc6wVUUUkbQuU2e1Hz
 fRMIVTnZj1G9+iycKjWO2FCtv79iJwV03Gw7TuuydYB+tZjLo+sWxzF67JEJoau0d+nh9UmU
 Th0sAHTj51icflxdDOi5Smc/uyt870AmLCSaUbj5BPCDm9ZKschu8S1NSz4eCzLsNYAgIHkU
 zpmFGsAnRGQhgClTNShH5gHcyKyzkjkACxPGeRpguzUx8dSIcEYBgJbqVLA9srw2irApnPSA
 mhkNzmIxqQawI0nAhlCyAYF5CU2ANRzIc/B53YANi3nkPtiob0BZLCR9YMUSp0PSBZaUt2zp
 tpu62aTG2EWQfG0DRwbKrCFfaFptxjnsAH+Yqq36LrjRkINwA/cBnOguteFIIoC9cRmAS3lB
 S/cKzvaBkgdgmd6Nq+YUHFu9zMEdcHDGng2jmzClNh3lZCF8GC/iduyHmaaX21dbez5aIzRM
 s4i4fpIBVKd9wZ4Al8z/p3IBKAaOTJRSHsQoj4QzN12VMrkyKjzI9UaEvBJs/pF53TRfD/Rr
 1w2AJIBEIPx+cVoqwmTRyhi5AUAClYiFp9+ZpSJhoCzmNqOI8FdEhTFKA9hJ8CSOQs+8qWsi
 MkimYkIZJpJR/HMRwtYpFkgXLR3+XfGJe2af2dd4X611TrfNtlu65BaKNnoZP6gVQ71rQwHu
 L4ZjHmxou8RTnd8Iff2ADl/QqT1yZ1ovRLzxnXHoOtGVNdh/6A8uf6tCI48bEO1qzpnUqmH+
 nb3niz61Nat8nFZ6fjmYU0ZHd8f5eQ4YvdIbtNP5ghqD41kJTxks8ziIKpSyv+ITIt5DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7pvul7HGfzar2DRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLA42XGS1Wrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNWB
 x6Pp/TE2jzXz1jB67P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
 501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
 ehl7/qxlLTgnUtF1YDFbA+MMwS5GTg4JAROJh9OOMHUxcnEICSxllJh25ywzREJG4uS0BlYI
 W1jiz7UuNoiiT4wSR/d2MYIk2AQMJbreQiREBDqBurs/soM4zAL7mSQuHznFDlIlLOArcfrT
 JLBRLAKqErt37QRbwStgJ7Hx+3V2iBXyEqs3HACLcwLFTx9vBasXErCVeP6hjW0CI98CRoZV
 jCKppcW56bnFhnrFibnFpXnpesn5uZsYgTGy7djPzTsYL20MPsQowMGoxMP7IuR1nBBrYllx
 Ze4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Yv3kl8YamhuYWlobm
 xubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhit8qRNF+1xbZRbuCC9QrCscPcch57c
 3Nf+i9le5p7/dfVl5WPDG79Lbh7fN/Mef45rXWrs8ju/1R1vrZQpjZBfL9RsdOG76hEpM6OO
 nCuH+f0TROP/T69k1HoTk5GicTp62devG/eabfZOM/j3qExI67jyPa2IG01rn/VYyt7wCbKw
 P5Q5oVqJpTgj0VCLuag4EQD+fVZepwIAAA==
X-CMS-MailID: 20200618154028eucas1p140cfc1156ef012ba74f97c5a2a7dc09e
X-Msg-Generator: CA
X-RootMTR: 20200618154028eucas1p140cfc1156ef012ba74f97c5a2a7dc09e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154028eucas1p140cfc1156ef012ba74f97c5a2a7dc09e
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154028eucas1p140cfc1156ef012ba74f97c5a2a7dc09e@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
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
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_mmu.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index 3b81ea28c0bb..175c2578ad73 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -90,19 +90,16 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo)
 	struct v3d_dev *v3d = to_v3d_dev(shmem_obj->base.dev);
 	u32 page = bo->node.start;
 	u32 page_prot = V3D_PTE_WRITEABLE | V3D_PTE_VALID;
-	unsigned int count;
-	struct scatterlist *sgl;
+	struct sg_dma_page_iter dma_iter;
 
-	for_each_sg(shmem_obj->sgt->sgl, sgl, shmem_obj->sgt->nents, count) {
-		u32 page_address = sg_dma_address(sgl) >> V3D_MMU_PAGE_SHIFT;
+	for_each_sgtable_dma_page(shmem_obj->sgt, &dma_iter, 0) {
+		dma_addr_t dma_addr = sg_page_iter_dma_address(&dma_iter);
+		u32 page_address = dma_addr >> V3D_MMU_PAGE_SHIFT;
 		u32 pte = page_prot | page_address;
-		u32 i;
 
-		BUG_ON(page_address + (sg_dma_len(sgl) >> V3D_MMU_PAGE_SHIFT) >=
-		       BIT(24));
-
-		for (i = 0; i < sg_dma_len(sgl) >> V3D_MMU_PAGE_SHIFT; i++)
-			v3d->pt[page++] = pte + i;
+		BUILD_BUG_ON(V3D_MMU_PAGE_SHIFT != PAGE_SIZE);
+		BUG_ON(page_address + 1 >= BIT(24));
+		v3d->pt[page++] = pte;
 	}
 
 	WARN_ON_ONCE(page - bo->node.start !=
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
