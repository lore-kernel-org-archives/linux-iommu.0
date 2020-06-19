Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2014AC433E3
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E998220EDD
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j8ZKrKst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E998220EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC1AA85C08;
	Fri, 19 Jun 2020 10:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLNC16PI5fKa; Fri, 19 Jun 2020 10:37:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31324871FA;
	Fri, 19 Jun 2020 10:37:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB4CC0892;
	Fri, 19 Jun 2020 10:37:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E933C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A5F388E89
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j722cLWEF2X6 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B6D7488E90
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103712euoutp02071aef3135a8d684cea53b07ce057a39~Z66Pb5AdP2414424144euoutp02E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200619103712euoutp02071aef3135a8d684cea53b07ce057a39~Z66Pb5AdP2414424144euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563032;
 bh=65zQC7AbXs+h4Aa/SkiEZNz20G0ZAx6H0WtGo6ycvZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j8ZKrKstsAM9Mjsq7aSijpNXcIRtSosWsfanYagPBo66HFRiHou/gKbXGCeT5cvUT
 O6lDpp9GYbMbRN9MM3VEKOasHotvPzFOM0Rm3YmceJRMFVqHfs10vhQ5aAqs1H6Zrb
 /vPlutLvAzoJ9KSDfltLKxWtCL994imrB3KG5ahc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200619103711eucas1p254b1919badc84e3856bf5440c266bbb9~Z66PDD_1Y3081430814eucas1p21;
 Fri, 19 Jun 2020 10:37:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 29.AC.06456.7559CEE5; Fri, 19
 Jun 2020 11:37:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200619103711eucas1p188e07cb9aaad13d39238aac4fe84b10c~Z66Or38xK0708007080eucas1p18;
 Fri, 19 Jun 2020 10:37:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103711eusmtrp157844e173b18813c1bc7c8589033aa4d~Z66OrJz7E0949709497eusmtrp1k;
 Fri, 19 Jun 2020 10:37:11 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-68-5eec9557a639
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.EA.06314.7559CEE5; Fri, 19
 Jun 2020 11:37:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103710eusmtip2498efcd4c81c177059743c29f12322db~Z66N7xtP53164531645eusmtip2a;
 Fri, 19 Jun 2020 10:37:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 27/36] drm: rcar-du: fix common struct sg_table related
 issues
Date: Fri, 19 Jun 2020 12:36:27 +0200
Message-Id: <20200619103636.11974-28-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeyyVYRzu/W7nO+bY12Hzrpt1tmxskbT2ltxaW99fra0/NKGOfLkfnINS
 S4Yah8y1pBaJ5NY5HXdGGB3NnMotRhdOtSQljkIuOX3ov+d5fs+z5/d799K4uJvcRgfKIjm5
 TBoioUyI2ucLur0eOd989vW32KObuhcYepqrItFqbQaO+ud+UKi0vBNDBc+c0MxgCkDJGUUC
 ZOgfw5BGP0iivsZ7FEpV15CoZuI7hio73grQI80ShtqmP5JuDFtxvwKwzb8KCPZu0h2S1ZQl
 U2zdrw8k+z5Fi7FVRdfYkRU9zmYNlQC2aTiOYtOqywA7q9l10tTT5IgfFxIYzcntXc6ZBFQP
 vKHCV+GlPMMSiAOLFkogpCFzAH7W1xNKYEKLmccAln8uxXliAFCvLl4nswCufhwnNiIz6nzA
 D0oAfK2sozYj2SPNAqOLYhygckpJGbEFcx3ArpumRowzSzi8fc/ViM2ZU7BVu4wZMcHsgQk9
 8//8IsYFXn+ZKeDbrGC5uhU3YuGaPpnYRhrLIDMugDUTzSRvOgY7O3+vr2cOv2qr18M7YHdW
 KsEHEgAc01UKeJIKYF98LuBdTnBUt7hWTa+tZwNVjfa87A4H9O+AUYaMGRya2sofYAYza2/j
 vCyCSTfEvNsa5mmfbNa2verFeczCMVUFyT9QBoDTI4VUOrDK+19WAEAZsOSiFKH+nMJBxl20
 U0hDFVEyf7vzYaEasPbFule0M/Vgrte3HTA0kJiK3DwmfcSkNFoRE9oOII1LLERHe7p9xCI/
 acxlTh52Vh4VwinawXaakFiKHAsnvMWMvzSSC+a4cE6+McVo4bY4YG9O5i88aPBUndxNeCcE
 RBxCaRHpx3VVA8XH5s98Mbh23HK54hycE9twuDcsm1NZD/0saMUMfz6dcLoctX88Vu9YtzP+
 apr7sPuoJZ5nuycs54Jz1x/Hca+m5RargzG2iR1Cm8qgxcYiYabVaa/G1oedsiCp2rdsS4TY
 1I9LwMwkhCJA6mCLyxXSv6ZjevteAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7rhU9/EGez4KmbRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8elaN6NF58Ql7BZfrjxkstj0+BqrxeVdc9gsejZsZbXY
 +vIdk8XaI3fZLZZt+sNkcfDDE1YHAY8189Yweuz9toDFY3bHTFaPTas62Ty2f3vA6nG/+ziT
 x+Yl9R63/z1m9ph8Yzmjx+6bDWwefVtWMXp83iQXwBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hp
 oWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hl6nW2gv8SFbO+/GFsYPwl0sXIySEhYCLx
 acN8xi5GLg4hgaWMEsffPGeFSMhInJzWAGULS/y51sUGUfSJUeLz0kawBJuAoUTXW4iEiEAn
 o8S07o/sIA6zQAuLxIdPD1m6GDk4hAUCJb602oE0sAioSjSf/cEGYvMK2Em0np/EDrFBXmL1
 hgPMIDYnUPx1y0GwBUICthLLF7xnnsDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg
 TG079nPzDsZLG4MPMQpwMCrx8L4IeR0nxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii
 0pzU4kOMpkBHTWSWEk3OB8Z7Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKY
 PiYOTqkGRvMJJZmnxU5bTXrwotIo7UVGH9vmjJbFDF2F7yq2JM6O7iy/8mezUNG9oBlJ8852
 nOTc6Jp5s8+rtOxb37qJ4iZnWSdx/bH6k7TbfXXa/wKlpEJ25Rcb167atnNzxsKJi12fvgnh
 MDgSsI/hbgXrm+Ceb05KBW+mC8Y53lyfcm+x0QQfLpGTzEosxRmJhlrMRcWJAHd/wE+/AgAA
X-CMS-MailID: 20200619103711eucas1p188e07cb9aaad13d39238aac4fe84b10c
X-Msg-Generator: CA
X-RootMTR: 20200619103711eucas1p188e07cb9aaad13d39238aac4fe84b10c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103711eucas1p188e07cb9aaad13d39238aac4fe84b10c
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103711eucas1p188e07cb9aaad13d39238aac4fe84b10c@eucas1p1.samsung.com>
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
