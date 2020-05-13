Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD935C2D10E
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9077020825
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gMxPrmbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9077020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 894D688291;
	Wed, 13 May 2020 13:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFDuuUTi3oqv; Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3029188287;
	Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B09C0892;
	Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869C3C088F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8111688211
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9CuApj2gexA for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 45B9688218
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:19 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133317euoutp01094b345876209c4a86fb281bc85d65a3~OmcbaaA-f2196121961euoutp013
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133317euoutp01094b345876209c4a86fb281bc85d65a3~OmcbaaA-f2196121961euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376797;
 bh=adSSZKLr39gCVoXMgTMjAinQz5jOSN5KlCsuomFB/vE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gMxPrmbwRamlwsM8ptaZYV+q9W5JuCFbb4TLe01pBu4dfSKpF6ZoDDOev0otx7xsF
 41o3VKoNwEHJtkpNgvip/w6OHQwkIiscE97nRZ37Ddc92REoWfiOWwaPZCzb9QnpbM
 aaZvhHiUcjjpxhLQyG6oCHNVK48bbBXW+z5OXMDA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133317eucas1p299a49b47f71bac78fea6cdfaf3c9b17e~OmcbEBCfm2972029720eucas1p2_;
 Wed, 13 May 2020 13:33:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.11.60679.D17FBBE5; Wed, 13
 May 2020 14:33:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133317eucas1p25446bcdce5220030c16477e1992385ff~Omcat18eK0616406164eucas1p2l;
 Wed, 13 May 2020 13:33:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133317eusmtrp1ae806ab66313837a29a5ee77f4e6ff9e~OmcatETTT1050610506eusmtrp1W;
 Wed, 13 May 2020 13:33:17 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-62-5ebbf71d9cb9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 76.47.07950.D17FBBE5; Wed, 13
 May 2020 14:33:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133316eusmtip16e4d1fb0d597e3e3f2e4c9d92de5b030~OmcaD90ae3222032220eusmtip1C;
 Wed, 13 May 2020 13:33:16 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 28/38] drm: host1x: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:35 +0200
Message-Id: <20200513133245.6408-28-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGe89tx9XiOC1fXCWMClLyUn44YGVR0CEzIj9VpC07qaUrdtS0
 IKdDyUtSrcxmrBF287KpmZeJ2aa1YrUsV1p5W8YiQ0qcphna5ln17fn/nud/4eUlUXETHkim
 yNNZhVyWKiWEWNPTGdv6lT/b4sMr1BL6gu05QteXG3B6vukSStsnvxP0/eonCK3riKJddgdC
 N4y8w+ke4w2CLnRpCLq2a0BAm358xukZoxbbKmJqtDWAaZ/SYUyrZkDANE8N48xQsQVhHlTm
 MB/nRlBG3XcXMG3vlQRT2lgFmImGVXsXHxBuOsqmpmSyirAth4XJ+u+dxCn1yiy7VkUowaOA
 IuBDQioSmoq7iCIgJMXUPQArK8YFHkNMuQDUXV3CGxMA3uh7hf3t6HdoUN64C+CdWSvCF+6O
 7krtQoqgImDRWBHh0f5UPoDPLiyMQqlPCCzsfY16DD9qHxw0fME9GqPWwKdDjgUuojbD69Z6
 lF8XBKvrHi9oHzcf7e/APIMgZRbAm1PzAj60A+ZalN4GPzhqafTyFdCqLvE2qAB02GoFfFEC
 YE9eOeBTUbDf9st9K+m+bx00GMN4vA3aG4sRD4bUUtg35uvBqFtebrqG8lgEzxeI+fRaqLHo
 /601db/xRhjY2hvDP1AngCp9J3ERBGn+79IBUAUC2AwuLYnlNsjZ06GcLI3LkCeFJp5MawDu
 32Sds7hagPH3ETOgSCBdIqI/tMWLcVkml51mBpBEpf6iPQY3Eh2VZZ9hFScTFBmpLGcGEhKT
 Bog23vp6SEwlydLZEyx7ilX8dRHSJ1AJDoSzccbgl85B36GK6OlxZH+Mc3D7lpTc2kLLDnIW
 LcGrd942Tap2NZvmzvkVSEo3J+Y8OdsrqTvxor39/Zv8Zd9e2Mp2RlzBuodjp8PiQlbrd6uj
 yxIe5D3K2jA7Y+LCtW/xg+8ehsQujVx+TEX6ZzqfdQ2Wv43StRwvLXSOLWqVYlyyLCIYVXCy
 Pz+4h6tJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7qy33fHGfz4wGzRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzaLzyyw2i7VH7rJbHPzwhNXi
 5655LA68HmvmrWH02PttAYvHzll32T22f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6bDWwe
 fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl7Hu/WG2gsmyFVfmNbM1MO4T72Lk5JAQMJG483AWM4gtJLCUUeLbaleIuIzEyWkN
 rBC2sMSfa11sXYxcQDWfGCXmnzzPBpJgEzCU6HoLkRAR6GSUmNb9kR3EYRZ4xSTx4U8rI0iV
 sECAxKmni9hBbBYBVYlj9x+CreMVsJWYeXojM8QKeYnVGw6A2ZxA8Vd39rNAnJQvsXfxPrYJ
 jHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbKtmM/t+xg7HoXfIhRgINRiYfX4tbu
 OCHWxLLiytxDjBIczEoivH7rgUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4zjvJJ4Q1ND
 cwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjH0BfWWLqy9ld8vI7JfIepIU
 8utUXkTrNs30i5uT5y9Ie/Nk1o6Iaft5BHwjM6TcgjYdF7r40dRwW/fGRjc2lVz+rrZ3R39p
 JW2tvG9WF1jX96X9kVBaRrrYLC1G1TDXEq946xUCjPH83qVxX7w7n1om3A5V2sy0+aame7S6
 iPu1Z0WLV1gpsRRnJBpqMRcVJwIAGOX5WasCAAA=
X-CMS-MailID: 20200513133317eucas1p25446bcdce5220030c16477e1992385ff
X-Msg-Generator: CA
X-RootMTR: 20200513133317eucas1p25446bcdce5220030c16477e1992385ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133317eucas1p25446bcdce5220030c16477e1992385ff
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133317eucas1p25446bcdce5220030c16477e1992385ff@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org,
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/host1x/job.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index a10643a..4832b57 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -166,11 +166,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dev, sgt, dir, 0);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dev = dev;
 			job->unpins[job->num_unpins].dir = dir;
@@ -217,7 +215,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) && host->domain) {
-			for_each_sg(sgt->sgl, sg, sgt->nents, j)
+			for_each_sgtable_sg(sgt, sg, j)
 				gather_size += sg->length;
 			gather_size = iova_align(&host->iova, gather_size);
 
@@ -229,9 +227,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = iommu_map_sg(host->domain,
+			err = iommu_map_sgtable(host->domain,
 					iova_dma_addr(&host->iova, alloc),
-					sgt->sgl, sgt->nents, IOMMU_READ);
+					sgt, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
 				err = -EINVAL;
@@ -241,12 +239,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			job->unpins[job->num_unpins].size = gather_size;
 			phys_addr = iova_dma_addr(&host->iova, alloc);
 		} else if (sgt) {
-			err = dma_map_sg(host->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(host->dev, sgt, DMA_TO_DEVICE, 0);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dir = DMA_TO_DEVICE;
 			job->unpins[job->num_unpins].dev = host->dev;
@@ -647,8 +642,7 @@ void host1x_job_unpin(struct host1x_job *job)
 		}
 
 		if (unpin->dev && sgt)
-			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->nents,
-				     unpin->dir);
+			dma_unmap_sgtable(unpin->dev, sgt, unpin->dir, 0);
 
 		host1x_bo_unpin(dev, unpin->bo, sgt);
 		host1x_bo_put(unpin->bo);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
