Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC6C2D100
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB3120829
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eYEKmPYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB3120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D26048935E;
	Wed, 13 May 2020 13:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1RCh31jMnwDO; Wed, 13 May 2020 13:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D452E89393;
	Wed, 13 May 2020 13:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5BF7C0891;
	Wed, 13 May 2020 13:33:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 230C8C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 18C1588D58
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0YSAJPoTdKHk for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C65D8923B
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133323euoutp01078e1b3b48376cf249c7fe59d33f5ae2~Omcg9u7H72234622346euoutp01m
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133323euoutp01078e1b3b48376cf249c7fe59d33f5ae2~Omcg9u7H72234622346euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376803;
 bh=CZbbwG/c/y8+wYH8ObEE3tIAUZE/HWxN0ulpE2QNiE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eYEKmPYmJIwJzHHc7tM+Ya6oHzwuAHyWDJNgCtvLhP1EZ1S4iJ93PwZ/VipmNANlt
 ouNyos6OzWlnGGgEpMoZBWQrA+3RwhVI3fK5ZTiCq/qZ2VOZBLTSVZqS2lspJibx+A
 FUMXvzny6ewSMHyJbZIZddUwVwQ/vx3AUG9IrnuY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133323eucas1p167560f10137968d51959b06f96d18508~OmcgqQDwP0384603846eucas1p1k;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.11.60679.327FBBE5; Wed, 13
 May 2020 14:33:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515~OmcgULNyA0785007850eucas1p1G;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133323eusmtrp12afaeda27ef00a9d1e53f0fb03dfb511~OmcgTZQiB1050710507eusmtrp1a;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-77-5ebbf723f197
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.2A.08375.327FBBE5; Wed, 13
 May 2020 14:33:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133322eusmtip15b0156e78861f281e5548f723b5c1813~OmcfiHzeD0693406934eusmtip1d;
 Wed, 13 May 2020 13:33:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 35/38] rapidio: fix common struct sg_table related issues
Date: Wed, 13 May 2020 15:32:42 +0200
Message-Id: <20200513133245.6408-35-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSzUcRzH+/4e7n5uzn6dq/sOYzvVli2i/vhtqmVa/WqtefirRF35DeOO
 7hBt6nIeLypkhGSyeY4QcuMikbRLSITkqSGSeU6jOz/03+vz/nze38/DvgQq0OBmhJ8smJHL
 JAFiDg+rblnVHbJe1ngdfjRhRiXq2hBqpKgXpV6kl+HURnUSSnUvznKowuK3CJWjdaQWuocR
 qmK0B6e66rI4VGnzIJdK/biMUo2/x/CTfLokuwTQ9Us5GP0qY5BLJ0xH4XTN0necHrrXitCV
 eXfo/vVRlE7pzQe0pk/Joe9XFQF6vsLSxfgS75g3E+AXysjtTlzl+fbHWwSphGHK3DlcCb6R
 amBEQPIobCuoBGrAIwRkAYDlymiMDRYA7FTPIWwwD+CziSSwbRlOTeWyiXwAJz5koTuWns/F
 iKGKQ9pD9YyaY2AhGQ3gu0RjA6PkLwQ2z9sY2JQ8D7ti6jEDY+R+2KHJ3PTyyeOwu3YRY7tZ
 weLy16iBjfT61IB2cz5IvufCkfYGDlt0CmYsx6Esm8Kp1iouyxawPSVhy6ACcFhXymWDBAC7
 ItO3FnKEA7o/+pcI/XgHYVmdHSs7wRVNAWKQIWkCe2d2swuYwOTqNJSV+TAuRsBWH4AZrc93
 2jZ2dG6NQ8PBvuytA70BMDIrB38IrDL+N8sBoAiImBCF1IdROMiYm7YKiVQRIvOxvR4orQD6
 L9W+3rpQC+r+XmsCJAHExnzqq8ZLgEtCFeHSJgAJVCzkXyjTS3xvSfgtRh54RR4SwCiagDmB
 iUX8I7mTngLSRxLM+DNMECPfziKEkZkS7Bl1D2ux/ZEWafNTtld0zs/STXs2BZud1ob2Cevp
 M5gzL+y2W7yLr/dkedPQg8I1lcPq4yd55nLPiA0Rddp1fEM1cHdf0pez/mvODWGxLQ7uL5ko
 c1Xn5bFOr6he0tHiotDLNdOaZ1LjsZJmIooQPHW6ERj8ibIfLtPG7hpP9hBjCl+JvQ0qV0j+
 AZ22r+JOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rK33fHGbxtZrboPXeSyeLRqhvM
 FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
 4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
 3Tcb2Dz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
 JiU1J7MstUjfLkEv43anTEGzSEXDoo+sDYz3BLoYOTkkBEwkHk6dyt7FyMUhJLCUUeL2wyvM
 EAkZiZPTGlghbGGJP9e62CCKPjFKtLafYwdJsAkYSnS9hUiICHQySkzr/gg2ilngG5PEpKW3
 2ECqhAV8JC637WUBsVkEVCUu7J7NBGLzCthKXNnxlQVihbzE6g0HwFZzAsVf3dkPFhcSyJfY
 u3gf2wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2bbsZ+bdzBe2hh8iFGAg1GJ
 h9fi1u44IdbEsuLK3EOMEhzMSiK8fuuBQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOi8
 knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M89T2LWmXyqwpTXhQ
 qdMzLX/tv2UFv7dERKhOt/iaw8FgdWRJituRJzkqE7ymC/5dzOB/4HHcGv7q+oZiN9/HZk+n
 Pk/L+c0e2nNNUu/Y/wKFwLhZ9/Lk3pzl4e35KWdeMynnHofXK8+dq+M5ePZoSpw/ca6y3SJR
 8leopMznuvzpx2axXCtUYinOSDTUYi4qTgQAssdja7ACAAA=
X-CMS-MailID: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
X-Msg-Generator: CA
X-RootMTR: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Alexandre Bounine <alex.bou9@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matt Porter <mporter@kernel.crashing.org>,
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
 drivers/rapidio/devices/rio_mport_cdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 4029637..92d8742 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -574,8 +574,7 @@ static void dma_req_free(struct kref *ref)
 	struct mport_cdev_priv *priv = req->priv;
 	unsigned int i;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		for (i = 0; i < req->nr_pages; i++)
@@ -927,9 +926,8 @@ static int do_dma_request(struct mport_dma_req *req,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
