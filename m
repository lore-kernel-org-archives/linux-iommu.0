Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A00BC81841
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C0D20714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iyJA435d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C0D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03E07204C4;
	Tue, 12 May 2020 09:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q+NbSMXnvSu0; Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C5DE261DB;
	Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ADFFC0893;
	Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49223C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D13A688DFE
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQZzf0GwEVlS for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 30405891D2
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:19 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090117euoutp0134b90093c624e6346d82f7b0615a172e~OPFpfuiAb2545625456euoutp01B
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090117euoutp0134b90093c624e6346d82f7b0615a172e~OPFpfuiAb2545625456euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274077;
 bh=QK3oV3GThH1mLbyMRASC+hEmi3B48cmvnyZEHAGh6eM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iyJA435dHOB7nsDD4LkeW7krsJuND2Tvw6Qk8DzAVW4po2OrCqVpormFdM4ZnSJ1V
 mjqqX+tOecMzDMFvK20nq2x5cXwNlzoBD57lA+xjrJUKcfFfpNOcJe9VqAlWbvr68b
 ATSNzt0y7F6z2JiWAK9tHBbqT3x9S27oqlxobHq4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090117eucas1p17d792157b650a40117110aadd5469cfe~OPFpNIKo11613916139eucas1p1e;
 Tue, 12 May 2020 09:01:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.67.61286.CD56ABE5; Tue, 12
 May 2020 10:01:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090116eucas1p24662e01574c0700cfe6d474280bb8df5~OPFo3pf0f0955009550eucas1p2s;
 Tue, 12 May 2020 09:01:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090116eusmtrp14004cd9fd0a34e696f88b67d4572d6b9~OPFo27p7f0188101881eusmtrp1J;
 Tue, 12 May 2020 09:01:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-74-5eba65dc25ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.F2.07950.CD56ABE5; Tue, 12
 May 2020 10:01:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090116eusmtip1dc725179573278247b96449deb5612c7~OPFoQBfKf1148011480eusmtip1V;
 Tue, 12 May 2020 09:01:15 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/38] drm: msm: fix common struct sg_table related issues
Date: Tue, 12 May 2020 11:00:36 +0200
Message-Id: <20200512090058.14910-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzm7Ow+XK5u0/D0MGlhj5GZFXTBsoIeF4LsBVFRuvI6V27ZppYR
 KFpiy0drkTZkrXc+eplYTiydjxnqLBVZK1tlZIpiNC3N0Ha7s/77ft/j9x1+HBJKGrA5pFKd
 yGrU8ngpLhJWNI7ZQ96xlkMrMk1r6Rz7SwH9uOAhRk9W6CHdOTKE04W9rYAuKmkQ0OYX4fRw
 50cBXdbThdH6F60E3WEpxOn79d0E3Xt9FNK13z5jdLehHmyYwZSaSgFT/cMsZCqN3QTz9McH
 jHFdsAmYJ7dSmbcTPZAxOO4CpupNGs7YLE6CyS0vBoy7bP4O3/2itTFsvDKZ1YRGRIviLpcM
 4QnWhae+OVtgGnAF6oAPiajVSF8yCjgsoe4B1GfbpQMiDx4GaMBdJOAHN0D6az1wKtFy2Uzw
 wl2APmUY4L/I8wGDgHPhVBjSDepwDvtT5wBqyvHlTJAyQvTVOv5X8KMiUV7ThCdNkkIqGF29
 uY+jxVQEqnY1A74tCJU8qvnb7OPhXdd+C7k9iHISyFE/ivGmTZ49fTiP/VC/rZzg8TzUbMj2
 BjIA+mi/T/BDNkAd6QXeinD0zv4L514BqaXooSWUpzeimrMtGEcjajpyDM7kaOiBlyryIU+L
 UVamhHcvQkbbg3+1ta/avddiUFWj23utBoDqHpvgRRBk/F9mBqAYBLBJWpWC1Yap2ZPLtXKV
 NkmtWH7kuKoMeD5X84Tt+zMw0n7YCigSSH3FWSsrD0kwebI2RWUFiIRSf/FZpYcSx8hTTrOa
 41GapHhWawVzSaE0QLzqRt9BCaWQJ7LHWDaB1UypAtJnThoIIdMty87kfmjrSJ+MVS849X7a
 7jGIxWYEti15nWUyhtz2C1q8LZOYt/1ApCyxblbv3q13RHn5rlalfU/f5jdRRcFblO3rg3/u
 dFS8lF0JTSGfn2eOhvdfKuv64pwcdvqnzthRnh+b35F0evzEePSYebZpsKp3dc26NU1hcG9C
 s0ImFWrj5GEyqNHK/wCS0IPcWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7p3UnfFGSyfqmbRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLOc/PMlqsXH2UyWLBfmuLL1ceMllsenyN1WLi/rPsFpd3zWGzWHvkLrvF
 84U/mC0OfnjCanF38hFGB36PNfPWMHrs/baAxWPnrLvsHtu/PWD1uN99nMlj85J6j9v/HjN7
 TL6xnNFj980GNo/ju26xe/RtWcXo8XmTXABPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
 nqGxeayVkamSvp1NSmpOZllqkb5dgl7GlNXv2QoOKVd8uHWGuYHxvmwXIyeHhICJxJkpC9i7
 GLk4hASWMkr8+tXGBJGQkTg5rYEVwhaW+HOtiw2i6BOjRO/OZSwgCTYBQ4mutxAJEYFORolp
 3R/BRjELLGGW6Jt6iQ2kSljAV2Jf1xegURwcLAKqEjMXR4KEeQXsJPbeP80IsUFeYvWGA8wg
 NidQ/P78P2ALhAQKJR5dfcsygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBI2nbs
 55YdjF3vgg8xCnAwKvHwdhjtjBNiTSwrrsw9xCjBwawkwtuSCRTiTUmsrEotyo8vKs1JLT7E
 aAp000RmKdHkfGCU55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRq
 YNy8f4OprtfytY+M/PPPnm7adSffXvT5je7LCaZua7bPqTFl0P78evJKHk8lf4Ga2MJWv/B4
 RZHMV9XysbUepqvmxk1ire28toDnyrLZR+w35T3hmc5sfSXt4anTpS/vCG5lvF37oHsFc/rc
 eRGBexVYY9PWmnTwnHjLdutgzAcpyX6JqbXx3kosxRmJhlrMRcWJAKePAWK6AgAA
X-CMS-MailID: 20200512090116eucas1p24662e01574c0700cfe6d474280bb8df5
X-Msg-Generator: CA
X-RootMTR: 20200512090116eucas1p24662e01574c0700cfe6d474280bb8df5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090116eucas1p24662e01574c0700cfe6d474280bb8df5
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090116eucas1p24662e01574c0700cfe6d474280bb8df5@eucas1p2.samsung.com>
Cc: freedreno@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
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
 drivers/gpu/drm/msm/msm_gem.c    | 13 +++++--------
 drivers/gpu/drm/msm/msm_gpummu.c | 14 ++++++--------
 drivers/gpu/drm/msm/msm_iommu.c  |  2 +-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 5a6a79f..6318c20 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -53,11 +53,10 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
-		dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_sync_sgtable_for_device(dev, msm_obj->sgt,
+					    DMA_BIDIRECTIONAL);
 	} else {
-		dma_map_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 	}
 }
 
@@ -66,11 +65,9 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
-		dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_sync_sgtable_for_cpu(dev, msm_obj->sgt, DMA_BIDIRECTIONAL);
 	} else {
-		dma_unmap_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 34980d8..5d8da4d 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -35,21 +35,19 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
 	unsigned idx = (iova - GPUMMU_VA_START) / GPUMMU_PAGE_SIZE;
-	struct scatterlist *sg;
+	struct sg_dma_page_iter dma_iter;
 	unsigned prot_bits = 0;
-	unsigned i, j;
 
 	if (prot & IOMMU_WRITE)
 		prot_bits |= 1;
 	if (prot & IOMMU_READ)
 		prot_bits |= 2;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		dma_addr_t addr = sg->dma_address;
-		for (j = 0; j < sg->length / GPUMMU_PAGE_SIZE; j++, idx++) {
-			gpummu->table[idx] = addr | prot_bits;
-			addr += GPUMMU_PAGE_SIZE;
-		}
+	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&dma_iter);
+
+		BUILD_BUG_ON(GPUMMU_PAGE_SIZE != PAGE_SIZE);
+		gpummu->table[idx++] = addr | prot_bits;
 	}
 
 	/* we can improve by deferring flush for multiple map() */
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index ad58cfe..d322b39 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -43,7 +43,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
+	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
 	WARN_ON(!ret);
 
 	return (ret == len) ? 0 : -EINVAL;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
