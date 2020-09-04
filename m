Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1AC2D0E0
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D30521707
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cPNAtmB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D30521707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAA8286D94;
	Fri,  4 Sep 2020 13:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KzXL0tAmac4g; Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6B2F86D46;
	Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6DEC0890;
	Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF36AC0052
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D3AA486DCB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cI5QEnPTlWB1 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0268486D3A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133506euoutp01e44358599efd14bc06389d342a4b7338~xmAjZV3h10722107221euoutp01r
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133506euoutp01e44358599efd14bc06389d342a4b7338~xmAjZV3h10722107221euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226506;
 bh=Db9nvbneKnU3dPPVQUd6yNfcbBXdpUJGDyQOdzxZWm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cPNAtmB43/uiwfG0fH8dy6drJ9CWnnd2FYc5adT9O39SzeaM3EZMyUaoZU8iCu9IP
 DiaMXkDYUiisYDi21jPuusoaTj+4APlAkEvDiCG2xZcgJ2nxVLsZ10TXwg9itn+ElG
 CjZspcFRgmh9P/aMCWYCQahOeS4XSXGc1l7n33yE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133506eucas1p24a30d84b5e029fac5fcbb8f780fa112b~xmAjIoLIu0781807818eucas1p27;
 Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.11.06456.A82425F5; Fri,  4
 Sep 2020 14:35:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200904133505eucas1p2de5392a85883aca8e7774735811eb4c8~xmAi2931i1447814478eucas1p2v;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200904133505eusmtrp2adf1426bc98b35548c05ea243dbea175~xmAi2KorI0977109771eusmtrp2H;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-56-5f52428a56ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.A0.06017.982425F5; Fri,  4
 Sep 2020 14:35:05 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133505eusmtip1a7993933030331dbd7a6496ff66e9951~xmAiQPV7d1939819398eusmtip15;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 20/30] drm: vmwgfx: fix common struct sg_table related
 issues
Date: Fri,  4 Sep 2020 15:17:01 +0200
Message-Id: <20200904131711.12950-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSxVYRz2nq97yK3TZfOOlu1uWpnI+OOYplhrZ7XKFIsW3XLCcNm9iFZL
 WY0rn0lYYsrX9S0uaVZuIvlI9xKNREw0inyUEt3TufTf83ue3/M+z357SVTUgJuTQdIIViaV
 hIgJI0zVtvJmr8LNw29folZAJ/V0IHRNVhVOr6vSULpv6RtBl5a9ROj8Z870Yt8YQteOv8Pp
 mdY2QGub7hN0ResHAd0yN4HTZQmuB4VM+YNywDQv52NMw/IoznxMbEeYx4+uMUNr4yhzZ7AY
 ME/fxxJMcp0SMAu1O5mvebOE+xYfo/3+bEhQFCuzczlnFDg9v4KFp5pFrxYWIbGgwEQBDElI
 OcK33YsCBTAiRVQJgJ9WVAQ/LAL4eaAe44cFALWaXLBhGRmN1wvFACp/p4NNi/Z1KcZtEZQ9
 VMwqCA6bUjcBfJVkzC2h1B8EasbTcU4woU7C7LhuhMMYZQUXh4r/GYSUC+yY7MD4OEtYVv0c
 5bChjq/PmsC5hyClFsDMlEl9p0NQVdmP8tgEfmmvE/B4B1x/kofwhjgAx3oqBPxwW9f1Rpbe
 7QyHe37pokldvz2wqsmOp12hcrwI52hIbYWDs9s5GtXBdNU9lKeFMP6WiN/eBXPaKzdjW3o1
 +joM1A4X6I+aBmCKZgpJBZY5/8PyAVACMzZSHhrAyu2l7CVbuSRUHikNsL0QFloLdN+pc639
 eyNY0pxXA4oEYmOhwQEPPxEuiZLHhKoBJFGxqdCtu9NXJPSXxFxmZWF+ssgQVq4GFiQmNhM6
 FEyfFVEBkgg2mGXDWdmGipCG5rHA6W6uV3b3aqpFz1HjY2ara0muJcL5tvJccYZDAHoq7jjS
 fKXQTvowc/dk5bafiE9fcoZNl/2Zoh9NRwgvT2rOuqorMc3SUaN0t4k+4UmZtqUh1YxrIzF9
 cch7ZLqZwE9bya47edfk9yb4vjCY0eJlXqzhVPzVw44DVhHBnf2NYkweKLG3RmVyyV+FKjyT
 SgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7qdTkHxBtuWGlr0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBZvjhxjtLi8aw6bxdojd9ktDn54wmqx
 utPRgddjzbw1jB57vy1g8dj+7QGrx/3u40wem5fUe9z+95jZY/KN5Yweu282sHn0bVnF6PF5
 k5zHu/lv2QK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyXn78yVIwQbziz9JlTA2Mi4S7GDk5JARMJO496GDpYuTiEBJYyihxafJORoiEjMTJ
 aQ2sELawxJ9rXWwQRZ8YJdbfuMkOkmATMJToeguREBHoZJSY1v0RLMEs0Mwscf5lLYgtLBAo
 sW/eExYQm0VAVeLL7eVsIDavgJ3EyWcnWSA2yEus3nCAGcTmBIpvnfEEbLOQgK3EhzmLWSYw
 8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGCnbjv3csoOx613wIUYBDkYlHl4G+6B4
 IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjCK80riDU0N
 zS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MFruLvZg3Ccs3i5S2GqcorHO
 yXdiEXfnmqnz/m79Pt/lzpFjzj92cexXMF3pJfBhwtPm95vOBK+XjTBI1rRxr2bS0n1se7+j
 8/NxtkWH9/AkGDLL2HQ1MB2ef3zdnFqvXul1fizZb6ebudhNvmfsGth969/lf26nlypkWbHo
 pk4PU2q+u+LASyWW4oxEQy3mouJEALruKeyqAgAA
X-CMS-MailID: 20200904133505eucas1p2de5392a85883aca8e7774735811eb4c8
X-Msg-Generator: CA
X-RootMTR: 20200904133505eucas1p2de5392a85883aca8e7774735811eb4c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133505eucas1p2de5392a85883aca8e7774735811eb4c8
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133505eucas1p2de5392a85883aca8e7774735811eb4c8@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Roland Scheidegger <sroland@vmware.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
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
Acked-by: Roland Scheidegger <sroland@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index c7f10b2c93d2..13c31e2d7254 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -362,8 +362,7 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
 
-	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
-		DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(dev, &vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 }
 
@@ -383,16 +382,8 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 static int vmw_ttm_map_for_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
-	int ret;
-
-	ret = dma_map_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.orig_nents,
-			 DMA_BIDIRECTIONAL);
-	if (unlikely(ret == 0))
-		return -ENOMEM;
 
-	vmw_tt->sgt.nents = ret;
-
-	return 0;
+	return dma_map_sgtable(dev, &vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 }
 
 /**
@@ -449,10 +440,10 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 		if (unlikely(ret != 0))
 			goto out_sg_alloc_fail;
 
-		if (vsgt->num_pages > vmw_tt->sgt.nents) {
+		if (vsgt->num_pages > vmw_tt->sgt.orig_nents) {
 			uint64_t over_alloc =
 				sgl_size * (vsgt->num_pages -
-					    vmw_tt->sgt.nents);
+					    vmw_tt->sgt.orig_nents);
 
 			ttm_mem_global_free(glob, over_alloc);
 			vmw_tt->sg_alloc_size -= over_alloc;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
