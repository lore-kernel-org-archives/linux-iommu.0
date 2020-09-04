Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2BC31E40
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8992083B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bf2fKFSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8992083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B786086DF1;
	Fri,  4 Sep 2020 13:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql9G92guHqZH; Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9FD486DD3;
	Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA51FC0890;
	Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540A5C0894
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A7BB86C3A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mjis-9ABjor7 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9615086C39
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:10 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133509euoutp027591b8b9b69872c6bfe909b342d87908~xmAl-qtFv2890128901euoutp02v
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904133509euoutp027591b8b9b69872c6bfe909b342d87908~xmAl-qtFv2890128901euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226509;
 bh=65zQC7AbXs+h4Aa/SkiEZNz20G0ZAx6H0WtGo6ycvZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bf2fKFShGlm+pfJSXUQUVICSDo6soEQGaqsqijd6BS3x595gzQh6G3n1AxUNaSZdE
 gPBTN2wR0xDgGTEqemJTwhpp4nVEXQs26Muj9ip/D0jT/hfO3sEdgeaBFOv9YNn3TI
 tOjE+yhY8fuIKZpjL613A+pZI/Vr96D5TyllYAOY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133508eucas1p21f933737a416c70575a6bc8994670007~xmAljtcol0781307813eucas1p2-;
 Fri,  4 Sep 2020 13:35:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.11.06456.C82425F5; Fri,  4
 Sep 2020 14:35:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133508eucas1p144e8c20b098912e8bf275642f2c709e6~xmAlI3sXS2307023070eucas1p1W;
 Fri,  4 Sep 2020 13:35:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133508eusmtrp18a48b753c6c81394e3d104bf3cf3a8ea~xmAlIKVZ40766507665eusmtrp1K;
 Fri,  4 Sep 2020 13:35:08 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-5d-5f52428c4fa2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.BE.06314.C82425F5; Fri,  4
 Sep 2020 14:35:08 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133507eusmtip16507aff28a627187d88af93e208665b5~xmAke9p3K1624216242eusmtip1t;
 Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 24/30] drm: rcar-du: fix common struct sg_table related
 issues
Date: Fri,  4 Sep 2020 15:17:05 +0200
Message-Id: <20200904131711.12950-25-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURiFuZ3OdCiUDIXIDRhIGjUgYVNjroGA4pJRHzTEF00UiwyLQiEt
 IPCgaFGhgGGJoRRiAAlo2cuiQghLhKIoIlQEBWUTAoLImrDLOKhv3//fc3Lyn1wSE7fj1mSw
 LIKRy6QhEkLIr21b6XRK9vbxdZ1bsEcpna95qFJdjqOt2jQMGZZmCfSsuJWHchvd0XxvEkCJ
 aQUCtGgY5iHdaC+OeupyCJRcUYOjmsmfPFT6alCACnXrPNT8aww/StElj0sA3bCcy6ezE7Jw
 WqdNJOjny0M4/S1Jz6OrCm7TXzZHMTqjrwjQ9f1xBP2wWgvoBZ3tedNLQg9/JiQ4ipG7eF4V
 BlV//ESEb8FozeI6iAOrlipAkpA6BOPnCRUQkmLqKYDTldl8blgEsD5+UKACxtvDAoCT7ddZ
 Zg2afC3GiYoANKwpd0Tbjo6JWJYJyg2qZlQEy5bUPQDbU0xZxqh1DGbmeLFsQV2AmSs5f7x8
 ai8caRv/wyLKE75Xl/K5MDtYXNGEsWy8va9Rj+FsMKS+CqC2cBNwohOweEa/wxZwSl8t4Hg3
 7MhI5nMGJYDDnaUCbkgGsOeuesfhDgc6Vwm2DIxygOV1Ltz6GPxcXs7jOjKDfTPm3AFmML02
 E+PWIphwX8yp90GNvuxfbHNXN8YxDRtaR3caTQOwq0wpSAV2mv9huQBogRUTqQgNZBRuMuam
 s0IaqoiUBTpfCwvVge3/1bGpn38Blrr9WgBFAompyMjLx1eMS6MUMaEtAJKYxFLk/a7jiljk
 L42JZeRhvvLIEEbRAmxIvsRKdDB/8rKYCpRGMDcYJpyR/33lkcbWcSDQ6bufW8CbW5qRYZMs
 bb6ywuRt3sjcmothV8Ap/cUHR5KmbGY38ozKhoq9jOfP3uk/be+1x3zgQyPwdrWLafKQbVDT
 h50nDLZj69Lu/HGmoSth2PCyRHhgdSo65VyqWum7WbrkaIOU6Rs/+oeqhA4h0SczHm0VPXGU
 NRK1RmeOS/iKIKnbfkyukP4Gp6V1LFsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7o9TkHxBhMeCVr0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLrWzWjROXEJu8WXKw+ZLDY9vsZqcXnXHDaLng1bWS22
 vnzHZLH2yF12i2Wb/jBZHPzwhNVBwGPNvDWMHnu/LWDxmN0xk9Vj06pONo/t3x6wetzvPs7k
 sXlJvcftf4+ZPSbfWM7osftmA5tH35ZVjB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa
 6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZWy5ep2t4L9ExawvfxgbGH+JdDFyckgImEjM
 WrSKuYuRi0NIYCmjxP3981ggEjISJ6c1sELYwhJ/rnWxQRR9YpQ4MP8yO0iCTcBQoustREJE
 oJNRYlr3R3YQh1mghUXiw6eHYKOEBYIk5uxaA9bBIqAq8ejYMzCbV8BO4vyMtVDr5CVWbzjA
 DGJzAsW3zngCtlpIwFbiw5zFLBMY+RYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjKpt
 x35u3sF4aWPwIUYBDkYlHl4G+6B4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleak
 Fh9iNAU6aiKzlGhyPjDi80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFx
 cEo1MNZ2fNoken3nzGv7OBJblzuXN728X7mVo1n3qbRX2noma/v2UyfPH4ifz3nNW1zax+BT
 KxNP2vzURPMjdpyXJ3YpfIgJO133+0Zg6xKmE4n+ivL5T5hsQuoKe92zb26OPVq3LXNh65nc
 b6FJ279YLDJmCb0Zrb5PJGu5Sva9tzqXMn7ptT3iVWIpzkg01GIuKk4EAHzI3KjAAgAA
X-CMS-MailID: 20200904133508eucas1p144e8c20b098912e8bf275642f2c709e6
X-Msg-Generator: CA
X-RootMTR: 20200904133508eucas1p144e8c20b098912e8bf275642f2c709e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133508eucas1p144e8c20b098912e8bf275642f2c709e6
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133508eucas1p144e8c20b098912e8bf275642f2c709e6@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-media@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mauro Carvalho Chehab <mchehab@kernel.org>,
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

dma_map_sgtable() function returns zero or an error code, so adjust the
return value check for the vsp1_du_map_sg() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c  | 3 +--
 drivers/media/platform/vsp1/vsp1_drm.c | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index f1a81c9b184d..a27bff999649 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -197,9 +197,8 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
 			goto fail;
 
 		ret = vsp1_du_map_sg(vsp->vsp, sgt);
-		if (!ret) {
+		if (ret) {
 			sg_free_table(sgt);
-			ret = -ENOMEM;
 			goto fail;
 		}
 	}
diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index a4a45d68a6ef..86d5e3f4b1ff 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -912,8 +912,8 @@ int vsp1_du_map_sg(struct device *dev, struct sg_table *sgt)
 	 * skip cache sync. This will need to be revisited when support for
 	 * non-coherent buffers will be added to the DU driver.
 	 */
-	return dma_map_sg_attrs(vsp1->bus_master, sgt->sgl, sgt->nents,
-				DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	return dma_map_sgtable(vsp1->bus_master, sgt, DMA_TO_DEVICE,
+			       DMA_ATTR_SKIP_CPU_SYNC);
 }
 EXPORT_SYMBOL_GPL(vsp1_du_map_sg);
 
@@ -921,8 +921,8 @@ void vsp1_du_unmap_sg(struct device *dev, struct sg_table *sgt)
 {
 	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
 
-	dma_unmap_sg_attrs(vsp1->bus_master, sgt->sgl, sgt->nents,
-			   DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(vsp1->bus_master, sgt, DMA_TO_DEVICE,
+			  DMA_ATTR_SKIP_CPU_SYNC);
 }
 EXPORT_SYMBOL_GPL(vsp1_du_unmap_sg);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
