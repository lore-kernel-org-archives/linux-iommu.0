Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0317C83006
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6308206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qPZ5njqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6308206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9F3C863FF;
	Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkAQRqIP5pGU; Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 375E68623E;
	Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FADCC0863;
	Tue, 28 Apr 2020 13:22:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5789DC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B63F2284A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUBN-uTZJjfE for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:21:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 29E5622851
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:34 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132032euoutp0279b72e2ec65ab5f551cf4546e93aaa27~J-mAyaU8w2883528835euoutp02h
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200428132032euoutp0279b72e2ec65ab5f551cf4546e93aaa27~J-mAyaU8w2883528835euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080032;
 bh=5KUNgNWBVnt9CNq1cC1kYdO2bgPtm1BszHBSm62Fo5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qPZ5njqMplXPCCwq1k6CPt7iIVdCSBYnYnuRNh9TrN3jNm8mRTFN0BqPACQc6cP/O
 tamMDLzydhCVmaOIP/HftdiYBGs7pQvPmHAfSw9xPXf7HW2eXDaB7fFEObYC1I+jOw
 uu+XfXtRfQXKcTcgWCp8oZeCO01ZB/AcT0zauJcM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200428132032eucas1p1781cc080b8d75eed20c2e8377492af14~J-mAbZYKd1362813628eucas1p1L;
 Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.26.60698.0AD28AE5; Tue, 28
 Apr 2020 14:20:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132031eucas1p25bf6d0d1f24a69cc3692b2001ac0ebd1~J-mAFGnfz1082710827eucas1p2W;
 Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200428132031eusmtrp214019cd67d683af32c16a42eb4afff05~J-mAEdncH2140321403eusmtrp2X;
 Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-99-5ea82da062b2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.E3.07950.F9D28AE5; Tue, 28
 Apr 2020 14:20:31 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132031eusmtip2ede9f87ed322aa7eb656f70d33798961~J-l-ebRoC1180911809eusmtip2E;
 Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 16/17] drm: host1x: fix sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:20:04 +0200
Message-Id: <20200428132005.21424-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1zdYpUh0LCQ9wSxOImrAJH2MgKBFl3PkxGg3VIhOKUCAtoCDR
 UgWxbrgrKgKCIGCLhRRlUSBoBUllk0VZC36oQY1sIgrSTtW/c8+S83LySFRYizuREdFxrDxa
 EiUibDD9y2mjW7ZbodjzWrGQPm9sROh8bQqPfnxTi9Oq+iaCntNfQumOia8E/bD4BULfzihD
 6OznvvR4xxBC64Y7cbq98g5BP2ro49F130ZwuqlvjLdhMVOSVQKYmslsjOntrCaYislBnBk4
 a0CYsrwTzPvZYZS50l0AmKoeJcFcKC8CzJhuefDCfTZ+YWxURAIr9/A/aCNt0U9isdfsj9aa
 EpQgjVIDkoSUD+xp9lADG1JIFQKo7GpHuGMcwKuz/Rh3jAGY2WRC1YBvSXwZHiA4oQDAG99/
 4/8iFRk1uNlFUF5QPaomzNieSgXw1Xlbswml9CgcKWjgmQU7aiucbTxtCWCUCxzQ5Vl4AeUP
 y3IM1roVsLi01oL583y+6YOlGlJGHtQM3bWaAuGpz1M8DtvBT4ZyK14K557eQ7jASQCHjI94
 3HEOwHbVTcC5fGGv8Sdh3gOlVkNtpQdHB8CZViXCzbQIdo8uMdPoPLysv4FytACmpwk5tyvM
 NGj+1da1tFmfxsA3zdPWHS8BWHq/H8sAKzL/l2UDUAQc2HiFLJxVeEezR9wVEpkiPjrc/VCM
 TAfm/9XrWcPEE/DsV2g9oEggshWU2haKhbgkQZEoqweQREX2ApP0gVgoCJMkJrHymAPy+ChW
 UQ+cSUzkIPDO/RgipMIlcWwky8ay8r8qQvKdlMD57Z6p6c7H27e9ywndL2k9k7S73FPqkmvy
 t+uPlAZtwVI04o2N65Nx4Y6LI8UHjxnHFnocT21TuQff6vEP4Vcnd8hWNngv8hMc3lB13fWH
 OGRZus86++Q1m6sn2mY6yYys79Ordq3VYM7tg6oqx65YbXWQY2DApnRmL7pzwVeNji/CFFKJ
 1xpUrpD8Aev8+gVTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rzdVfEGbz7Y27Re+4kk8XS9Y3s
 FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
 9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
 k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQyLmz7xlIwVaTiwKOyBsY2gS5GTg4JAROJd4/vs3UxcnEICSxl
 lLh6aQ4TREJG4uS0BlYIW1jiz7UuqKJPjBKd7zrZQRJsAoYSXW8hEiICnYwS07o/soM4zAIH
 mCW6z58EGyUs4CXx72Q72CgWAVWJ+5uWgHXzCthJbF54nBlihbzE6g0HwGxOoPjSR0+BpnIA
 rbOVuNySO4GRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA6Nl27OeWHYxd74IPMQpw
 MCrx8G7gWREnxJpYVlyZe4hRgoNZSYT3UcayOCHelMTKqtSi/Pii0pzU4kOMpkA3TWSWEk3O
 B0Z2Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxssNE6ZJ6Mfq
 NvmVLmdk+KG95pfLSb4ddepBXY57tLNqD96UXhNUOnn+daOAjkUl7g91T2hPj5ZrnhfrZHbr
 KcP6o9cOxc02ntGw/uxay/Ke/B3FTfMNnghJxbpu+L7raqmN3qr32lsD2dK3X7Co+xxyd8Z5
 E8+oRWwmiTmd3yZlt6jozNawVmIpzkg01GIuKk4EAGUr1+e0AgAA
X-CMS-MailID: 20200428132031eucas1p25bf6d0d1f24a69cc3692b2001ac0ebd1
X-Msg-Generator: CA
X-RootMTR: 20200428132031eucas1p25bf6d0d1f24a69cc3692b2001ac0ebd1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132031eucas1p25bf6d0d1f24a69cc3692b2001ac0ebd1
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132031eucas1p25bf6d0d1f24a69cc3692b2001ac0ebd1@eucas1p2.samsung.com>
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
