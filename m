Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504BEC81848
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267832082E
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IvcD8/Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267832082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0699286FC9;
	Tue, 12 May 2020 09:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZBys_qCWp3B; Tue, 12 May 2020 09:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1F7F87065;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBC9DC088E;
	Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F54C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68E0188E1E
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7uEa0Yl90S1 for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8308E88DB4
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:29 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090128euoutp01facd4bf8a86f3541af5182642c34b429~OPFzjD14A2629726297euoutp01l
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090128euoutp01facd4bf8a86f3541af5182642c34b429~OPFzjD14A2629726297euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274088;
 bh=5NGMaE4Pq4Gr2vd+9hsaDXuy+T7oe1nlC85nQzi6s74=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IvcD8/ZcabHxbl72bWaWdsYAopPN1EQoGJ60nBaZkzpOyRmcznVfeopawWGtV34e0
 VyOfaIfaWxhobpdbLpsWj3Nug3kIoLsYEnJIwjZ4LW/vPpYm3HcW9VSSAZvYfrtXuT
 rpY8AiCkbP3dJSNPelkrRdBth6Cft82hfJ2p+JZA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090127eucas1p29cf72b429b59cdb7355ad7d1473bda4b~OPFzRZ7iF2661826618eucas1p2j;
 Tue, 12 May 2020 09:01:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.67.61286.7E56ABE5; Tue, 12
 May 2020 10:01:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090127eucas1p19889d83b1c750dcdc869323e8d1946a3~OPFy9MUqQ2838128381eucas1p1P;
 Tue, 12 May 2020 09:01:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090127eusmtrp1a3807a059ca1740ced7a4d55072ad119~OPFy8bt4b0183401834eusmtrp11;
 Tue, 12 May 2020 09:01:27 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ae-5eba65e70eaf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.03.07950.7E56ABE5; Tue, 12
 May 2020 10:01:27 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090126eusmtip178d4ef6401588445a17a097376736bca~OPFyE8_nj1257212572eusmtip1x;
 Tue, 12 May 2020 09:01:26 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 33/38] staging: tegra-vde: fix common struct sg_table
 related issues
Date: Tue, 12 May 2020 11:00:53 +0200
Message-Id: <20200512090058.14910-33-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0iTURjGO/uuk2afU/BgYTAyS8hbQaeMKCo6CUH1R2EXbeWXl9yUfWkp
 UZoWNjUyqdbKKRpa3rbmWjUt71pq66KEkTrLQrSraTexy9bX5b/f+5z3OQ/P4bCEfITyYePU
 B3iNWpmgoN1Ia/s3+6IR3hYZ/O51CMqz35OgazojhX5a8wlU3z3FoMrxYYB6P72nUWapkUZX
 K9skqLghDGXpS0g02ftcgszDTyjUY7tEo1zTdQqdnNTTqLp1gEFl5mkJavrwkkLfbAZylSeu
 MlQBPHinhcS3PxeT+JZ+gMHmipM0vvF5iMINhVUMduR0SHDt5aP42Y9hAhf0lQNc9zSdxnmZ
 72h8ylIB8ITZd9Os7W4rovmEuBReE7Ryt1us5dQrMmmcO1Sb42DSgc5dC1gWckvg/aYoLXBj
 5dwVAL/XZwNxmASwp+gCJQ4TAE4Yssm/joKzy0S9HEBb8xvmn6PTMeZ0SFmaC4Hat1raxV7c
 cQDv5s10McF1k7D762IXe3IRMDdvnHQxyfnBp52Nv/dl3EpoOjP4+x7IzYWVpkbCxVKn7iia
 Jl1hkMtnYd/XSSAurYUv2jJIkT3hWIeFEXkO7CrI/WPIBPC5vZoRh1xnuWO6P+4w2G+fol3d
 CG4hNNqCRHk1nDYW0WJld9j31kMs4A7PWM8ToiyD2Sfk4vZ8qO+o+Rfb9PAxITKGFx6YaPGB
 2gC0GtqZ02Cu/n9YMQAVwJtPFlQxvBCi5g8GCkqVkKyOCdybqDID5/fr+tHx8Sb49HhPM+BY
 oJgpyw69FSmnlClCqqoZQJZQeMmy4pySLFqZmsZrEqM0yQm80Axms6TCW7a4ZHSXnItRHuD3
 83wSr/l7KmGlPunA58sMYV6l31LVfZ0uOGOn9/J+8tJ06Pes9ROvh8Jlm63YgOfFn4u46HGo
 q+5lzZGhmK37Wi3sGr+oHFn+F6lxja1c3TIatO3RyIbQ1rMO++EFYE5ZeOEW35KNfgFVvqrw
 tPh1Pe7+z5hef2pEWrfjZqPinDajZMZU6VikKbPaAhSkEKsMCSA0gvIX/dPjWHoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7rPU3fFGew/JW3Re+4kk8XGGetZ
 Lf5vm8hssefML3aL1R8fM1pc+fqezaJ58Xo2i5WrjzJZLNhvbdEyaxGLxZcrD5ksNj2+xmpx
 edccNoueDVtZLTq/zGKzWHvkLrvFsk1/mCwOfnjCavFz1zwWB2GPNfPWMHrc23eYxWPvtwUs
 Hjtn3WX32LSqk81j+7cHrB77565h97jffZzJY/OSeo/b/x4ze0y+sZzRY/fNBjaP3uZ3bB59
 W1YxenzeJBfAH6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
 WqRvl6CXsaXvKUvBR4GKzd332RsYZ/B1MXJwSAiYSEyeatnFyMUhJLCUUeLB43bGLkZOoLiM
 xMlpDawQtrDEn2tdbBBFnxglZnf/ZAJJsAkYSnS9hUiICHQySkzr/sgO4jAL3GCRmLvlAztI
 lbBAuMTZF5+YQWwWAVWJm6cOsIHYvAJ2Ehsm3YNaIS+xesMBsBpOoPj9+X9YQGwhgUKJR1ff
 skxg5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMB63Hfu5ZQdj17vgQ4wCHIxKPLwd
 RjvjhFgTy4orcw8xSnAwK4nwtmQChXhTEiurUovy44tKc1KLDzGaAh01kVlKNDkfmCrySuIN
 TQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwiq5apvhvq99i+812f2y9
 i9+/fLOft7Pv2DomAQH+f+wTryZvXtdWEbXVSXHSRsZFYW4su2cyBZw9NfvwSqOkhp0xy2Yy
 CwldF7iw5HmzhMiFuRczAvr2mj1z+NV5OPX6g1zBjP5EFpWpGkf21KxVOLxdIfpv0oJFHVd2
 Gc5cXRj99cu56XlfI5VYijMSDbWYi4oTAfqsapLdAgAA
X-CMS-MailID: 20200512090127eucas1p19889d83b1c750dcdc869323e8d1946a3
X-Msg-Generator: CA
X-RootMTR: 20200512090127eucas1p19889d83b1c750dcdc869323e8d1946a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090127eucas1p19889d83b1c750dcdc869323e8d1946a3
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090127eucas1p19889d83b1c750dcdc869323e8d1946a3@eucas1p1.samsung.com>
Cc: devel@driverdev.osuosl.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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
 drivers/staging/media/tegra-vde/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/staging/media/tegra-vde/iommu.c
index 6af863d..adf8dc7 100644
--- a/drivers/staging/media/tegra-vde/iommu.c
+++ b/drivers/staging/media/tegra-vde/iommu.c
@@ -36,8 +36,8 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
 
 	addr = iova_dma_addr(&vde->iova, iova);
 
-	size = iommu_map_sg(vde->domain, addr, sgt->sgl, sgt->nents,
-			    IOMMU_READ | IOMMU_WRITE);
+	size = iommu_map_sgtable(vde->domain, addr, sgt,
+				 IOMMU_READ | IOMMU_WRITE);
 	if (!size) {
 		__free_iova(&vde->iova, iova);
 		return -ENXIO;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
