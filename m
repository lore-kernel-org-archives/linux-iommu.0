Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE33C4345D
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDC720866
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MDWa/v2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDC720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8D0387D63;
	Wed, 26 Aug 2020 06:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9nd-zThmgxr; Wed, 26 Aug 2020 06:35:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5978387C17;
	Wed, 26 Aug 2020 06:35:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42A32C0894;
	Wed, 26 Aug 2020 06:35:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6696EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 404A322855
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpDotrtAqzxM for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 5739622193
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063546euoutp02fc37a9815d192e7427a0ffd7ec3ac93e~uve3Mc6oH1514215142euoutp02j
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063546euoutp02fc37a9815d192e7427a0ffd7ec3ac93e~uve3Mc6oH1514215142euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423746;
 bh=i9tfBl9XK1ZIcmVNmOj760Z4Av4MmZkmEeWSykU107Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MDWa/v2UN64kd/Pdh2+Eqeqoqxov2kLfJNAWiAuYfPUDZdGsjK6rzp0jDh/Ieviln
 FTtvqfiaz8SXSMsHICUOsl47/oAzIj4oVOeTnycj3hrxaX9nk4J4vuowAU11CNovOv
 MRLIevFWqldfH/vPZ87AN+jaPiLfdmm0deNKsdu8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063546eucas1p248e3327a2574966e6260f8ea4243a18c~uve27uU5X0403504035eucas1p2_;
 Wed, 26 Aug 2020 06:35:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 59.BD.05997.2C2064F5; Wed, 26
 Aug 2020 07:35:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063546eucas1p268558dcd08ac9b43843f9f5e23da227d~uve2fzbFv0398703987eucas1p2r;
 Wed, 26 Aug 2020 06:35:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063546eusmtrp1324e39600c0b1709cb7b91c674f0a758~uve2fFvRB1167511675eusmtrp1M;
 Wed, 26 Aug 2020 06:35:46 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-ed-5f4602c23e0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.E0.06314.1C2064F5; Wed, 26
 Aug 2020 07:35:45 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063545eusmtip2148831d8e511c634dd22bec68983ea60~uve14XvZb0092300923eusmtip2U;
 Wed, 26 Aug 2020 06:35:45 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 30/32] samples: vfio-mdev/mbochs: fix common struct
 sg_table related issues
Date: Wed, 26 Aug 2020 08:33:14 +0200
Message-Id: <20200826063316.23486-31-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87qHmNziDT68kLXoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2mDO10GLL6bmMFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObR2/yOzaNv
 yypGj8+b5AK4o7hsUlJzMstSi/TtErgyfm/bxF6wRLDi1o78BsaNfF2MnBwSAiYSbe2XGbsY
 uTiEBFYwSnx/tZYFwvnCKHHnxE4WkCohgc+MEp++x8N0rO9bDdWxnFGid9d0JriOM1fmMoNU
 sQkYSnS97WIDsUUEWhklTvTygBQxC1xjknj79x1rFyMHh7BAgsSnV6kgNSwCqhLPph8C6+UV
 sJOY1/qIDWKbvMTqDQfA4pxA8ePd/VDxfewSO4/EQNguEnfetjFC2MISr45vYYewZSROT+4B
 e0dCoJlR4uG5tewQTg+jxOWmGVAd1hJ3zv1iAzmIWUBTYv0ufYiwo0T3uknMIGEJAT6JG28F
 QcLMQOakbdOhwrwSHW1CENVqErOOr4Nbe/DCJWYI20Oie+N5Nkj4TGSUeDP9IfMERvlZCMsW
 MDKuYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExKp/8d/7KDcdefpEOMAhyMSjy8C9hc
 44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU
 7NTUgtQimCwTB6dUA+OU74IBMS0vucr3ZHVH7+uVTr/jXntVNFgm02oxx793fImpnqG6U+9d
 nXLmWK0Cd1/XLLNPN7RVfHZLvj188cKthwerP+04vObfls4Xz0yyUwraz23gsP6T2K9V7Vjt
 vNJp3+8+s5yO9+F+rHIymgFcyzy1tIv/Fb07a1S6v2N+wExW7m2BHEosxRmJhlrMRcWJAKtM
 O5tGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7oHmdziDb6vtbToPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2mDO10GLL6bmMFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObR2/yOzaNv
 yypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyfm/bxF6wRLDi1o78BsaNfF2MnBwSAiYS6/tWM3YxcnEICSxllPj5aSIrREJG4uS0
 BihbWOLPtS42iKJPjBKHf19jB0mwCRhKdL2FSIgIdDJKTOv+CJZgFrjHJLF3nR+ILSwQJ/Gi
 /ysbiM0ioCrxbPohZhCbV8BOYl7rIzaIDfISqzccAItzAsWPd/eDxYUEbCVOr53BPIGRbwEj
 wypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAONl27OfmHYyXNgYfYhTgYFTi4V3A5hovxJpY
 VlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkBHTWSWEk3OB8ZwXkm8oamhuYWl
 obmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRsu2U4X6kaYfvvde3DRTdfW1pKJj
 l2V3bww7cEX3+YmKl0rMtrNUezkDopax21noP7DjmaHGtro+5aG64EVHpZfTQtITnsZH2mzy
 DCqQmsTD6HZt0cTgpAtaNzdGlxSt3+reNuf2Y8MfLVczbF8tnp4c8cMk0EhskYlH7ZJPbQdC
 XHfadyrdVWIpzkg01GIuKk4EAOSPyuupAgAA
X-CMS-MailID: 20200826063546eucas1p268558dcd08ac9b43843f9f5e23da227d
X-Msg-Generator: CA
X-RootMTR: 20200826063546eucas1p268558dcd08ac9b43843f9f5e23da227d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063546eucas1p268558dcd08ac9b43843f9f5e23da227d
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063546eucas1p268558dcd08ac9b43843f9f5e23da227d@eucas1p2.samsung.com>
Cc: kvm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Kirti Wankhede <kwankhede@nvidia.com>,
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

While touching this code, also add missing call to dma_unmap_sgtable.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 samples/vfio-mdev/mbochs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 3cc5e5921682..e03068917273 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -846,7 +846,7 @@ static struct sg_table *mbochs_map_dmabuf(struct dma_buf_attachment *at,
 	if (sg_alloc_table_from_pages(sg, dmabuf->pages, dmabuf->pagecount,
 				      0, dmabuf->mode.size, GFP_KERNEL) < 0)
 		goto err2;
-	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
+	if (dma_map_sgtable(at->dev, sg, direction, 0))
 		goto err3;
 
 	return sg;
@@ -868,6 +868,7 @@ static void mbochs_unmap_dmabuf(struct dma_buf_attachment *at,
 
 	dev_dbg(dev, "%s: %d\n", __func__, dmabuf->id);
 
+	dma_unmap_sgtable(at->dev, sg, direction, 0);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
