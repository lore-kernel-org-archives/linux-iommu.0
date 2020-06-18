Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC921C433E8
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E26F2075E
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hD7WacUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E26F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 68D212634F;
	Thu, 18 Jun 2020 15:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZC+6lFusINI1; Thu, 18 Jun 2020 15:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E599F2625C;
	Thu, 18 Jun 2020 15:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D27EBC088C;
	Thu, 18 Jun 2020 15:40:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D2DC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EFF6D26285
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8eJoYUM4UhNh for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 99E0820502
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154037euoutp0290641642a0ef244b3dbf2571e374c394~ZrZ3yYpdm1354913549euoutp02O
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154037euoutp0290641642a0ef244b3dbf2571e374c394~ZrZ3yYpdm1354913549euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494837;
 bh=uHaHrVj9uEjHIe4StK4tJYVPskphxegmYKiq5klM8TA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hD7WacUMzhbtAo/IxhsXRxve2LOqp/6uM+0oZP8iFNhlydYW8/Y5oY8M9Ad4o6DUl
 iQhTDeKQ/8jv7ZwJxTSH7QmzQHH44d2bndi1rALEj/auBQke45jIZ3YvkbXNOedOya
 6qmr5ORz2UOBEBOz/ETRUbOqcChnSD7bB+NFcFoo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154036eucas1p12b1b5bb16a87b93f8c608072f0299566~ZrZ3iWPVL1755717557eucas1p1X;
 Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.1F.61286.4FA8BEE5; Thu, 18
 Jun 2020 16:40:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f~ZrZ25Z76N2945829458eucas1p20;
 Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154036eusmtrp1db46a96eb0cf1f0c63cf7e0222937e54~ZrZ24q8NZ2230622306eusmtrp1M;
 Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ef-5eeb8af45f00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 61.F9.07950.4FA8BEE5; Thu, 18
 Jun 2020 16:40:36 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154035eusmtip14307191b27018d21a029dcd22091c1ee~ZrZ2NS2vX0742307423eusmtip1X;
 Thu, 18 Jun 2020 15:40:35 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 31/36] misc: fastrpc: fix common struct sg_table related
 issues
Date: Thu, 18 Jun 2020 17:39:52 +0200
Message-Id: <20200618153956.29558-32-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTut7u7zeHqNgV/qGQMKkp8ocIlY5kU3T8CjcIoSJt5UUmnbL7/
 yNlUbL4nodk0S0vT+Wj5fmvqEnHkozJKTFymTtFyPnJpbbtq/33nO993vsPhsBBuO2rLChNG
 kyKhIJzHYNObBn9rnPQyXYCratMZz9IM0fAd+SATf11Yh+J/m/IQfGJ9hYFLy+oY+KvqARpe
 2u2F6ydmaLhq9iOKj7cpGHhN/xQT713Vot4cQlmiBIRhWw6Izo1SOtG88Q0luouVTGI6Q00j
 3pQnEV92ZxEif7ICEO2fJQwiu6EKEGuqY36Wt9jngsnwsFhS5MK/ww5NG5lGoyaw+E+bU3QJ
 WOXIgAULYh5Q+V1KM2EuVgmgznBZBthGrAfw3VI7ShVrADbXPkX2HWvKMiblqACwI+3IgSMj
 XUk3NRiYG5QtyxgmbI2lGkdlWZpECLZIgyWKh6ipYYVdhymNWWYRHTsBtf1S81QOxoejrRso
 leYAq+t7zMkWRn5YnWpeCWIaJtzp+LMnugiTX8r3sBVcVDcwKWwPh/Mz6ZRBCuCMpoZJFZkA
 jj8oBJTKC37VbBvXYBn3Ow3r2lwo+gJ89lYJTDTEDsPJ5aMmGjFCeVMBQtEcmJ7GpdQnYZG6
 9iC29/3Y3rUI2Dk/D6gL5QEoaV9CcoFD0f+wUgCqgA0ZI44IIcVuQjLOWSyIEMcIQ5zvRkao
 gPGlhnfVv1rA+lhQH8BYgGfJ8b6hC+CiglhxQkQfgCyEZ83xGRkO4HKCBQmJpCgyUBQTTor7
 gB2LzrPhuD9fuM3FQgTR5D2SjCJF+10ay8JWAvCzPvbhfj8eY8T9ueRcbbnkkgIcnwxy9awT
 yt0HPHJ19T8N+pSem1cVC/5aML7FH2I7kfN8/ayj59buSu/OWteLU9dWmnPinxRoD533dpy8
 0uhn51sTNPMoaXw0x8r3Q3O20MuQF2DHKEycq5Sw/Z0CV5LjCoptDF1prS3OuTy6OFTgdgYR
 iQX/APrcvXROAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pful7HGSy6x2zRe+4kk8XfScfY
 LTbOWM9q8X/bRGaLK1/fs1k0L17PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZrD1yl93i
 4IcnrA68HmvmrWH0+P1rEqPH3m8LWDy2f3vA6rF/7hp2j/vdx5k8Ni+p97j97zGzx+Qbyxk9
 dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
 m5TUnMyy1CJ9uwS9jLaz91kLrghUXP9+l6WB8QNvFyMnh4SAicTnNYvZuxi5OIQEljJKzN16
 iAUiISNxcloDK4QtLPHnWhcbRNEnRonzCycxgSTYBAwlut5CJEQEOhklpnV/BBvFLPCJSeLI
 tdNsIFXCAkESa3vXMYLYLAKqEk+ONLOD2LwCdhIXd36DWiEvsXrDAWYQmxMofvp4K1hcSMBW
 4vmHNrYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbNtmM/t+xg7HoXfIhRgINR
 iYf3RcjrOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFOmois5Rocj4w
 pvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDufPqN/YNwekJH
 v/a9D02M4ZNydLbNmXxMW1v02vUI8dJpXxwFbXllmTtct34/v3/vmfPXb8uVaa/zuuZueWnK
 yfmfvlbzsM65yrf0Kq/EHFnTH/f3HlTl+LWx+0rcf81bf601VTM3V03p2HZ5RdUDoYe2FTL3
 siftNfj/+Kj+y3URXy/e4+ksVGIpzkg01GIuKk4EAEZmncmxAgAA
X-CMS-MailID: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
X-Msg-Generator: CA
X-RootMTR: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f@eucas1p2.samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7939c55daceb..9d6867749316 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -518,7 +518,7 @@ fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = &a->sgt;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+	if (!dma_map_sgtable(attachment->dev, table, dir, 0))
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -528,7 +528,7 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 				  struct sg_table *table,
 				  enum dma_data_direction dir)
 {
-	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+	dma_unmap_sgtable(attach->dev, table, dir, 0);
 }
 
 static void fastrpc_release(struct dma_buf *dmabuf)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
