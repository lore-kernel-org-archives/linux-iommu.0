Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F276DC81829
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9497207FF
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f48x/tnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9497207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B253186FBA;
	Tue, 12 May 2020 09:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blhLsu4Kg_4P; Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B57CE86FC9;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAFD2C0893;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2A8C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 00103882AB
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clklasmY1hjj for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9653883D6
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:23 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090121euoutp015d96340e695d1b7f5469011bf7778992~OPFt0UmWN2637026370euoutp01M
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090121euoutp015d96340e695d1b7f5469011bf7778992~OPFt0UmWN2637026370euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274082;
 bh=VL4LQ1ISezq2D47CSd0K/DfpoScEMrGkXUPKP1u1YRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f48x/tnwjCUXeKnli3cEUf0zWoBRcuGgHvKI/KGdtTpPOhhIwNsJhCIgNdBQVf18V
 Mq/50QES4dVTHrl+WGScYNK5pnrUsBO6KKtBeFn3lmsn95kV/p1MDhtncd7sUHVjPk
 r/eV5yddNams+x93RdQggeFUZ0x5fMwUAGxzYHSM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090121eucas1p2e0453552b936596e63c57e2ffe651687~OPFtkCzEu2662326623eucas1p2Z;
 Tue, 12 May 2020 09:01:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.67.61286.1E56ABE5; Tue, 12
 May 2020 10:01:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090121eucas1p2f20e300f70ff54da15fe49cc6690f608~OPFtOVjFD3099030990eucas1p2J;
 Tue, 12 May 2020 09:01:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090121eusmtrp114eb01c10205f43f3b8ec4069a88301c~OPFtNqoRl0188101881eusmtrp1S;
 Tue, 12 May 2020 09:01:21 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-91-5eba65e14e27
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.F2.07950.1E56ABE5; Tue, 12
 May 2020 10:01:21 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090120eusmtip125f29dafed6f117e46b6797a94f9c83a~OPFss8QdI1148011480eusmtip1Z;
 Tue, 12 May 2020 09:01:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/38] drm: v3d: fix common struct sg_table related issues
Date: Tue, 12 May 2020 11:00:44 +0200
Message-Id: <20200512090058.14910-24-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2znbzqar07T80EpYGWSpzRsHDCkQOv+M6FeRNvOgw2s7as1+
 ZJql85LOQpHIqeXUadOpSy3TabpiMUMtFLM1VoKCeZkapVmbZ+W/5/byPHx8GCLsYHtj0tQM
 SpYqSRZx+Kh+5OdogJXqjTmpGPYnSsxvWUR7lZZN/NGXI8TE2iKHGLg9DogmzTCLUPVHEKsT
 Vhahs31kE+O9jzhE6+sZLmFY+so+7U7mLo5wyJbHLYDsW1eh5PP1L2zSUmRkkR1PbpHTWzaE
 rJhUA/LFVA6HLO1sBqRdd+ic20X+qXgqWZpFyYIir/ATJ+93cdI/77vxYy4PyQGVQgXgYRAP
 hfWqDZYC8DEh3gjgTHUnypBVALW1s1yG2AHU6BXov5NaQxNgDDWAo23zOyem6RmWM8XBxVCx
 oOA4sSeeD+CbEndnCMF7WLCu8CVwGh54NKwytHOdGMX94Eb35rYuwCOhqqGBzdT5Qk3bAOLE
 PIduqdncboP4Ky60dPUgTCgKPm2d5zLYA84bO134ADRVFLsO8gC0mlu5DCkGcDy3CjCpCPjJ
 /MuxFXPsOwa1vUGMfAY+yL0HnDLEd8PJhb1OGXFApb4SYWQBLLjresmjsNr47H+t4f2YaxoJ
 J1wThPgwcJAltAz4Vu+UqQBoBl5UJp2SQNHiVOp6IC1JoTNTEwKvpqXogOMrmbaMK91gbSxu
 EOAYELkLCoJ7YoRsSRYtTxkEEENEnoI7UockiJfIsylZWqwsM5miB4EPhoq8BCF1c5eFeIIk
 g0qiqHRK9s9lYTzvHBBtPTsevTiHzm4WKYfafytt58uu+UvDSXGV33cfzYVSt357duxDnenI
 0OG44xoMF+//wLeZ0/KnDipDS4NVXuVNJxp5QTe1eWr7RIvMEyzzkpfVe4wh8XM2+0pSYmGN
 Xhl2aVeAhlZFfZPml2mDwuX1YaPvwGQL3Scvt1pEKJ0oEfsjMlryF/RPXCNGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7oPU3fFGcx7KWzRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLA42XGS1Wrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNWB
 x6Pp/TE2jzXz1jB67P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
 501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
 ehk3+reyFdwTrfj+spm5gXG6UBcjJ4eEgInEwoMrGbsYuTiEBJYySmx538wGkZCRODmtgRXC
 Fpb4c62LDaLoE6PErQnHGUESbAKGEl1vIRIiAp2MEtO6P7KDOMwC+5kkLh85xQ5SJSzgKzHt
 UQ9YB4uAqsTvHX/AbF4BO4kFy5ZBrZCXWL3hADOIzQkUvz//DwuILSRQKPHo6luWCYx8CxgZ
 VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGyLZjP7fsYOx6F3yIUYCDUYmHt8NoZ5wQa2JZ
 cWXuIUYJDmYlEd6WTKAQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wPjN68k3tDU0NzC0tDc
 2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6OZjejcJaFac5a9mLLMOeuJxv8/WxVU
 2zn5DGbKLJdMfPXLulT4F+PEHKYQZvV3f++v2n3bccLtW2H3jEv+P9f8b/fK5fC7C4L7PWzO
 nnq4z7Rfq+LqyY3iZ79q6RzrfhJVtCP4RNCu7zbuOmEp5Rb665ILpD2yFrgcO71hrkrHq4df
 q/5dqIlSYinOSDTUYi4qTgQACgdpdqcCAAA=
X-CMS-MailID: 20200512090121eucas1p2f20e300f70ff54da15fe49cc6690f608
X-Msg-Generator: CA
X-RootMTR: 20200512090121eucas1p2f20e300f70ff54da15fe49cc6690f608
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090121eucas1p2f20e300f70ff54da15fe49cc6690f608
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090121eucas1p2f20e300f70ff54da15fe49cc6690f608@eucas1p2.samsung.com>
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
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/v3d/v3d_mmu.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index 3b81ea2..175c257 100644
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
