Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2CFC433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34E1208C3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t6ESMzLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34E1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 964E987C3F;
	Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4EFRJD0mMKF; Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 013F887C19;
	Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE538C08A7;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EFD1C08A2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7506896A4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFWWYtRRkjQJ for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76757891C8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154031euoutp022c46efce695ac907b906f1ab0f6b76e8~ZrZy750um1476714767euoutp02C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154031euoutp022c46efce695ac907b906f1ab0f6b76e8~ZrZy750um1476714767euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494831;
 bh=OFqbUENGcwHkaTj73rLNsgPPEJEVjihPUEx1KDeP3MU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t6ESMzLJjAfQr8z/AOOMm2jfaJWpis+kK8tjBKwhEO9Zesdly+GPL8s9vsRfojW+K
 hS0Y4Q56O+e+uzjtvCh6/Fv5+Gwu89LofWWh/Myov/VDs2rBo8q7TsSiwAroxjVFPs
 zFrxinvjFDYb0u1EhBO2Vs57a9/Uar2jSA2K1IcE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154031eucas1p1ce6e57d0a2d0556f04a7fcd3183f9cbc~ZrZypCTKs0074000740eucas1p1H;
 Thu, 18 Jun 2020 15:40:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 17.DE.60679.FEA8BEE5; Thu, 18
 Jun 2020 16:40:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154031eucas1p15e6527663f0f925c4b8b86f051c82c0a~ZrZyVgc1-0074000740eucas1p1G;
 Thu, 18 Jun 2020 15:40:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154031eusmtrp2a2a62a31e0dcabc27719c44266237bf0~ZrZyU6H_i0399203992eusmtrp2i;
 Thu, 18 Jun 2020 15:40:31 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-46-5eeb8aefa76e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.FE.08375.FEA8BEE5; Thu, 18
 Jun 2020 16:40:31 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154030eusmtip10b580271ad26480dc952d65a4cb35f35~ZrZxrdwLH0833608336eusmtip1T;
 Thu, 18 Jun 2020 15:40:30 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 25/36] drm: host1x: fix common struct sg_table related
 issues
Date: Thu, 18 Jun 2020 17:39:46 +0200
Message-Id: <20200618153956.29558-26-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c5lO14Wp2n6oZUxqKzIS0Uc0cRE6NAfKRH9IWStPEzRTd3U
 0oLM0tq8J16YVqsU817TZi4yHeYsc3m/oGbqoNYUDS9glLZ51P573t/zvDwvHx+B8ptwFyJS
 Es9IJcJoAccW03SsGo7OK8xhXvIRAZVl+IhQr4rrcWpdk4dSA8vzHKqy+gNCqd77UksDUwil
 nhnCqX5tKYeSLyk5VG37BJdqWzDi1Kr2MRbAo2se1wD63YoKo5uVE1y6aeUbTk9m6BG6oew2
 PbY2g9L5IxWAfjuawqGzG6sAvajeG2IXausXzkRHJjJST/8rthEmYwcWO+R647uyH08BRU4K
 YENA8gRsbvmFKIAtwSdfAJj/pZfDDksAFqdmouywCGCF+Q7YWsm+v4yzRgWA5ZXPwfZKSkYZ
 Yk1xSG+omFNwrNqRTAOwM8veGkLJaQTKh3tRq+FAnoe5a1rcqjFyPzRNZm9wHukPc/rbN+vc
 YPXL1g1uY+Fd+rSNakjquFDXUoixoSDYo1XjrHaAP/WNXFbvhuvNTxB24S6AU4ZaLjtkAtif
 WrxZ4QvHDb8ttxKW+w7Beq0ni09DfXYO14ohuQOOzO20YtQiH2qKUBbz4IN0Pps+AJX6uu3a
 tp6+zQgN+7q92AfKA7ClxsjNBW7K/10qAKqAM5MgE4sY2TEJc91DJhTLEiQij2sxYjWwfKeu
 Nf3SG6D9c1UHSAII7Hk/LpjD+LgwUZYk1gFIoAJHXmB3VxifFy5MSmakMZelCdGMTAdcCUzg
 zDv+zHSJT4qE8UwUw8Qy0i0XIWxcUkCB6/C9PV8HP/lV7VOGlKcFH6lrcFMbJCfb7epwebqj
 fdfszHRQWa/P4t/QTHShNCS842bSxfSBzwMZpVEHRXFnieDxMvdOh/DVsVO+sa/PqSJ63FuN
 PaU2YyWDTSFyM1Y/GZisaQgQhM46jmtGTdW3Cndl+px5tFAS5/S0KK2gQ4DJIoTeh1GpTPgP
 aCAi/0oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7rvu17HGUz/zmPRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzaLzyyw2i7VH7rJbHPzwhNXi
 5655LA68HmvmrWH02PttAYvHzll32T22f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6bDWwe
 fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl/HyyTGWgmvSFc9nXWZtYJwu1sXIySEhYCLR1/6VFcQWEljKKPFsDzNEXEbi5LQG
 VghbWOLPtS62LkYuoJpPjBITu2eBFbEJGEp0vYVIiAh0MkpM6/7IDuIwC7xikvjwp5URpEpY
 IECi4/d1FhCbRUBV4uX9PrBuXgE7if7LRxghVshLrN5wACzOCRQ/fbwV6iRbiecf2tgmMPIt
 YGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgr24793LyD8dLG4EOMAhyMSjy8L0Jexwmx
 JpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OBcZxXEm9oamhu
 YWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFRP29tR/K+7IpHfDGrry4Rur6Z
 +9OtHKfs/Q5LZwv6+pp4LZw+8cre5vmPOR/2rF6Zw5PBz2t6oi5zQ24U79Eb936s2P1iZSh/
 /tdtp7PkxM533dlv+ubWDqOZ6xn88vkvLX5rV/cytuG/U9nbDU9z1jcv3TWpmzvm0LuXbdyr
 pDZONCn/zZzlosRSnJFoqMVcVJwIAL4j8NGrAgAA
X-CMS-MailID: 20200618154031eucas1p15e6527663f0f925c4b8b86f051c82c0a
X-Msg-Generator: CA
X-RootMTR: 20200618154031eucas1p15e6527663f0f925c4b8b86f051c82c0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154031eucas1p15e6527663f0f925c4b8b86f051c82c0a
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154031eucas1p15e6527663f0f925c4b8b86f051c82c0a@eucas1p1.samsung.com>
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
 drivers/gpu/host1x/job.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index a10643aa89aa..4832b57f10c4 100644
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
