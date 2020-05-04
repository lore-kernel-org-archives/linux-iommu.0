Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F7AC47257
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B287C20757
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sEAnJL2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54BBC87769;
	Mon,  4 May 2020 12:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kt2VYZFcMfcl; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 615EF87771;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B866C088F;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94222C088F
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8387688993
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bI8ReS9cQ9df for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5791E88A9E
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:23 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125421euoutp02d8b97b6d9011f943bf9071f97804728e~L1G3aR3L-1839718397euoutp02z
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125421euoutp02d8b97b6d9011f943bf9071f97804728e~L1G3aR3L-1839718397euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596861;
 bh=hIVKbtmx1XAHMIJRyoiRKcMk/l0lgvfGQGy5Zto+wzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sEAnJL2fC+ZnoahfzdPWADihe+rPRIsanyusjPwOMloIVK9nBfLSCgVcLv6pFg+TE
 v7PYfjpEHbZlgtV+Q7pD3mrc1cIdl+MclSSfWwCNcLn1BtWgzNb9Lv1hxcsGbmcjSB
 Gy8KZtSe6lgZ3N/e+URuhCx/uTR9hVe+/PW54668=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200504125421eucas1p1df1e13bc891512672bc23e3e21550bda~L1G3FrEs91117211172eucas1p1i;
 Mon,  4 May 2020 12:54:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.E2.60679.D7010BE5; Mon,  4
 May 2020 13:54:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200504125421eucas1p19cb27a8f2a795675a48c8665e20ede12~L1G2np2cd1174811748eucas1p1d;
 Mon,  4 May 2020 12:54:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504125420eusmtrp2e34104d77afa7aadc76a009fbfd037db~L1G2nAHOG2826928269eusmtrp2Z;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-b1-5eb0107daca2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.69.08375.C7010BE5; Mon,  4
 May 2020 13:54:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125420eusmtip2c98c2cbfba68d1691c21ef1ebaf5d249~L1G189nOL3246632466eusmtip2c;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/21] drm: host1x: fix sg_table nents vs. orig_nents misuse
Date: Mon,  4 May 2020 14:53:54 +0200
Message-Id: <20200504125359.5678-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHec9lO14mp2n6sixhZjfwVlEnrEioOBBYfTAiSp15UslN2bxk
 Gc1M06WpaXmhdHYz5/2azrupSyKtFNNSzLQPDUfB1LDUtdOZ+e33PM////x5H14CFTbiIiJc
 Fs3IZZIIMc8aa+pfGnK/TtYEeLUNQSpjcAChavOrccrUlI1SIws/eFRZeR9CqTt9qPmRaYSq
 mxnFqWHtQx6VNl/Ioyp7J/lU989ZnFrSFmFHBHRFUQWg2xfVGN1SOMmnXy5+wempOzqErn96
 g/68OoPSOWOlgG4dV/Louw0aQBvrtpyyOWd9MISJCI9l5J6Hg6zDCoqpqLKNV/q047gSJG9Q
 ASsCknvhg5UxVAWsCSH5AsClzhLAFfMAZo6uYFxhBPC2vhesWRKXpy2DUgAz0lXrlq5HZXxW
 xSO9ocqg4rHsQCYD+DrDlhWh5FcEpn18j7IDe/I0/FXQirCMkW4w2fQEY1lAHoIdJbl8Ls4F
 ltd0mfUEYWXuF2RsZ/dAsp8PK7RqjNMchcN/niMc20O9rsHidYamlmKEMyQBOD1YyeeKdACH
 b+ZbHuQDJwZ/89gElNwJq7WeLELSF1Z8iuPQDo4Z/h0MNeO9pjyUawtgaoqQ27ENFuqq/qd2
 v/uAckzDib5Jy31fAagpq0KzgEvhepYaAA1wYmIU0lBGsVvGxHkoJFJFjCzU42KktA6YP9Ob
 Vd18M9AuB/cAkgBiW8FZY3WAEJfEKuKlPQASqNhB0HzL3BKESOKvMvLIQHlMBKPoAZsITOwk
 2PP4+wUhGSqJZi4zTBQjX5sihJVICVKdjR5bu3xLvdyKWgYMrUmjknZH1yp/dUrXgZO5wQZV
 j4aI8jM1u79VOpY02iVkXvuWIGgbGbfJ0RzT2eOJJ30TY1Kn6lvTGzaHpblO5oVjC/65i3Nz
 6Wcy7fXZgTvOP1vVNLrV7VeL9EHH/e5n6QtwP3FE7aWSbNFsvLzjxD4xpgiTeO9C5QrJX4Wr
 HbZIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7o1AhviDB6et7ToPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZtH5ZRabxdojd9ktDn54wmrx
 c9c8FgdejzXz1jB67P22gMVj56y77B7bvz1g9bjffZzJY/OSeo/b/x4ze0y+sZzRY/fNBjaP
 vi2rGD0+b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcks
 Sy3St0vQy5g536JgpWjF0V03WRsYWwW7GDk5JARMJBr/PGTpYuTiEBJYyiix/dgWRoiEjMTJ
 aQ2sELawxJ9rXWwQRZ8YJS6vvsAEkmATMJToeguREBHoZJSY1v2RHcRhFnjFJPHhTyvYKGEB
 f4mZ50+CdbAIqEq0/l/MAmLzCthK7Fs4hR1ihbzE6g0HmLsYOTg4geIze9VBwkIC+RJ3n/5j
 mcDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgpGw79nPzDsZLG4MPMQpwMCrx8EZ8
 Xh8nxJpYVlyZe4hRgoNZSYR3RwtQiDclsbIqtSg/vqg0J7X4EKMp0E0TmaVEk/OBUZxXEm9o
 amhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFR89Cl78Js6XOWyR9ccVXw
 seH3rcd/cdb1G2xfl3Wd49yvLVumr/M5tOjMUbdfvDv3+K+M2/jN60Svh8bLe0LRMarNxepJ
 MfOvnYuWeizhbRipGRMR0z5JzK/yuieXkcqL9RN/GBy7U+32894W0yOWOuXSRrzN/8IvpWyu
 XuAo5JAbpizrxzFRiaU4I9FQi7moOBEAQsJL2aoCAAA=
X-CMS-MailID: 20200504125421eucas1p19cb27a8f2a795675a48c8665e20ede12
X-Msg-Generator: CA
X-RootMTR: 20200504125421eucas1p19cb27a8f2a795675a48c8665e20ede12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125421eucas1p19cb27a8f2a795675a48c8665e20ede12
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125421eucas1p19cb27a8f2a795675a48c8665e20ede12@eucas1p1.samsung.com>
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/gpu/host1x/job.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index a10643a..3ea185e 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -166,8 +166,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-			if (!err) {
+			sgt->nents = dma_map_sg(dev, sgt->sgl, sgt->orig_nents,
+						dir);
+			if (!sgt->nents) {
 				err = -ENOMEM;
 				goto unpin;
 			}
@@ -217,7 +218,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) && host->domain) {
-			for_each_sg(sgt->sgl, sg, sgt->nents, j)
+			for_each_sg(sgt->sgl, sg, sgt->orig_nents, j)
 				gather_size += sg->length;
 			gather_size = iova_align(&host->iova, gather_size);
 
@@ -231,7 +232,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 
 			err = iommu_map_sg(host->domain,
 					iova_dma_addr(&host->iova, alloc),
-					sgt->sgl, sgt->nents, IOMMU_READ);
+					sgt->sgl, sgt->orig_nents, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
 				err = -EINVAL;
@@ -241,9 +242,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			job->unpins[job->num_unpins].size = gather_size;
 			phys_addr = iova_dma_addr(&host->iova, alloc);
 		} else if (sgt) {
-			err = dma_map_sg(host->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (!err) {
+			sgt->nents = dma_map_sg(host->dev, sgt->sgl,
+						sgt->orig_nents, DMA_TO_DEVICE);
+			if (!sgt->nents) {
 				err = -ENOMEM;
 				goto unpin;
 			}
@@ -647,7 +648,7 @@ void host1x_job_unpin(struct host1x_job *job)
 		}
 
 		if (unpin->dev && sgt)
-			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->nents,
+			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->orig_nents,
 				     unpin->dir);
 
 		host1x_bo_unpin(dev, unpin->bo, sgt);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
