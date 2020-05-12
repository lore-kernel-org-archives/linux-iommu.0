Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE6C81849
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AE72137B
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HJB2lan1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AE72137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 416718705C;
	Tue, 12 May 2020 09:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmNFDDV_7kbJ; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 615D18708D;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CC8DC0894;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06F2EC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E894A88291
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fTXCg4pX8Bw8 for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EEF0F88148
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:26 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090125euoutp0278c759290ab83869a8169c723e4eab49~OPFw5UBBm0453404534euoutp02b
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090125euoutp0278c759290ab83869a8169c723e4eab49~OPFw5UBBm0453404534euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274085;
 bh=iw9vIrPCZD2qW3sRT80MQUSQFIX+DQ+bqZb79NSn1lQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HJB2lan1J3tTXC3kOzwEcFA+Ln7Eb5j2ljvLXrxI8q+jG0ZWTwfrQ+jEsCTPh8r+q
 oSi4hMNnnqV9mYXi8orsGpIS79OLQnQYwG6foClg+z+b2hDV1Ma+GWOEKLVn5ybtd2
 PbqUmmnfkIb3sd97AJ2CLrFGZ75ZhqL/5Y8qGxc4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090124eucas1p2ec1525b3ac2455ce984ccb1ea0183d4c~OPFwXTnB22180321803eucas1p28;
 Tue, 12 May 2020 09:01:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id E6.7B.60698.4E56ABE5; Tue, 12
 May 2020 10:01:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090124eucas1p1f96fac067834c139fe1095a63b4dc2f0~OPFwCxWCp1182411824eucas1p1B;
 Tue, 12 May 2020 09:01:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200512090124eusmtrp2e644540b357af188330c72d982f38497~OPFwCBK-C0472704727eusmtrp2T;
 Tue, 12 May 2020 09:01:24 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-4b-5eba65e49ccf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.45.08375.4E56ABE5; Tue, 12
 May 2020 10:01:24 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090123eusmtip137b08d0e8a85e04ec9bb6f00accea5d0~OPFvZjtnE1352513525eusmtip1N;
 Tue, 12 May 2020 09:01:23 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 29/38] drm: rcar-du: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:49 +0200
Message-Id: <20200512090058.14910-29-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c5tR9nqNI2+LLImBhppmtlHlhWEHCShqL+6mKc8meS22pxW
 Bi21WCvLS2IXy5WWecnL8pJbN0c2UzCxEMVKTYs0NEsdXdbM7Zj997y/93l5Hj4+Gpe+JL3o
 eEUir1JwCTLKnah78bNt5SBvil6Vb/ZDGW0vMVR9pZJEU3VZOHoz+ZVCJWVNGDI8DUPfO88D
 dC6rSIQm3vRjyDjQSaLXpnwKXaiqJVHt0CiG7j9/J0J3jXYMNY4NkpsYtvxmOWAf2wwEe113
 lWSNpecott7WR7K9560Y+6DoFNvjGMDZnK5iwJq7tRR7saYUsOPGJdvEu9zXx/IJ8Um8KjA8
 xv3QWNon/MjowmOtNUWEFnTN1wM3GjIhMNV2GtMDd1rK3APwT5aDEIYJAA3vW3BhGAfw4+di
 0b+TfkfjzKIYwN+FDWD2RKtvcbkoJgjqR/SUU3syZwBszhA7Nc7YcZiXv1EPaNqD2QEdo6FO
 TDC+MLXzqciJJUw4/JaPC1nesKzqmUu7TePeArurHWQ+iGCJ2UQIpi0w7UcLKWgPOGytmSm6
 GE41FGDCQRqA/W33RcJwAcDXqVeA4AqDb9t+Uc5knPGDlaZAAW+GD6aaXRgyc2DXyDyh/hyY
 XZeHC1gCdWelgns5vGatmI1tbO+Y6c/Cn+MOUnieJgALum+IMoH3tf9hBgBKwQJeo5bH8erV
 Cj45QM3J1RpFXMABpdwIpj9Yq8M6+RA8se+3AIYGMrFEF9wQLSW5JPVxuQVAGpd5StLjp5Ek
 ljt+glcp96k0CbzaAhbRhGyBZPXtob1SJo5L5A/z/BFe9W+L0W5eWqC8vMwvfX96R0R2zMF1
 kSmBOdxWj0vVGT5RS2seUZ7f1p/dXWbciVVk7wsNT97QYiopbx/ObQ85Ghk2d3v3Hv8OaRQV
 jYK3V5hzmgzKgT7ZF91k5iOLJn5zimLNWk1hfewrr8q1oDWKq/cV65Z88nnVM3Kr1ztiYsWZ
 k3cCg225hIxQH+KC/HGVmvsLz89v4FwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7pPUnfFGXy5L2LRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8elaN6NF58Ql7BZfrjxkstj0+BqrxeVdc9gsejZsZbXY
 +vIdk8XaI3fZLZZt+sNkcfDDE1YHAY8189Yweuz9toDFY3bHTFaPTas62Ty2f3vA6nG/+ziT
 x+Yl9R63/z1m9ph8Yzmjx+6bDWwefVtWMXp83iQXwBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hp
 oWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Gh+RlzwTvJitNblrA0MN4Q7WLk5JAQMJF4
 +O8gcxcjF4eQwFJGiUcLFzNCJGQkTk5rYIWwhSX+XOtigyj6xCjR/+UFG0iCTcBQoustREJE
 oJNRYlr3R3YQh1mghUXiw6eHLCBVwgKBEp/XNIB1sAioSjRd2w9UxMHBK2An8XEOM8QGeYnV
 Gw6A2ZxA4fvz/4C1CgkUSjy6+pZlAiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIEx
 te3Yz807GC9tDD7EKMDBqMTD22G0M06INbGsuDL3EKMEB7OSCG9LJlCINyWxsiq1KD++qDQn
 tfgQoynQTROZpUST84HxnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+J
 g1OqgVH9z4mj+z2jhM3yVRm3vXD7qvfq09OnXp9TJk63WmPt765+99PE4sDLkeF903dcE5rp
 emzWzR1rL9fvYtS9913/6srKBWs7Z8bZ/tVp2m6rl3zkibmdxBXfwiu1Pyo39Ic4T/I6uqb/
 S4m8fpSbdo9mj0Hhms2fGJeI702+2P/sA8PWqCS2e9xKLMUZiYZazEXFiQDLa3DlvwIAAA==
X-CMS-MailID: 20200512090124eucas1p1f96fac067834c139fe1095a63b4dc2f0
X-Msg-Generator: CA
X-RootMTR: 20200512090124eucas1p1f96fac067834c139fe1095a63b4dc2f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090124eucas1p1f96fac067834c139fe1095a63b4dc2f0
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090124eucas1p1f96fac067834c139fe1095a63b4dc2f0@eucas1p1.samsung.com>
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
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c  | 3 +--
 drivers/media/platform/vsp1/vsp1_drm.c | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 5e4faf2..2fc1816 100644
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
index a4a45d6..86d5e3f 100644
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
