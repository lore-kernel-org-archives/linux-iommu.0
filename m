Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D26C83006
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A142206E2
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rBoN/0Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A142206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B24187117;
	Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUqxOnusz9kr; Tue, 28 Apr 2020 13:21:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E93998706B;
	Tue, 28 Apr 2020 13:21:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D084DC0888;
	Tue, 28 Apr 2020 13:21:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D842C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7962386C82
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmt-cRJI7fQ4 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:21:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD06D88177
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:30 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132029euoutp021014d18570dd9b84bd5928516db59a47~J-l9YQBSF2992529925euoutp02M
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200428132029euoutp021014d18570dd9b84bd5928516db59a47~J-l9YQBSF2992529925euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080029;
 bh=cfYCOvsx3QdDuA2fjr6jTbYynzEHe3yJ3h29IXE9HwA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rBoN/0GtunKOaIAFa+eDe913QiN8qnicknivHA/Lnd17T6gBluOuD684XKfVxjzvJ
 y/tMCCvMD9vrEWSmHdQgyImWPfMEvvJJBL379w8yuYAyxLE1LmTzANX7wSTgQCe/Q6
 qeNhaZiBD7EmIJ3i4S5pTQBsdu2zuIig3JdcJC+U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200428132028eucas1p2186ba166ce39fbe9de18c170b40f2194~J-l9EfGAn2652726527eucas1p2P;
 Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.B4.61286.C9D28AE5; Tue, 28
 Apr 2020 14:20:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905~J-l8oHmZU3058230582eucas1p1V;
 Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200428132028eusmtrp2596d757d384520465f7f2e4abf86e5bf~J-l8naNCZ2140321403eusmtrp2L;
 Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-7b-5ea82d9c54af
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.E3.07950.C9D28AE5; Tue, 28
 Apr 2020 14:20:28 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132027eusmtip2b741095e65b1ade0da2d1555b2832bf6~J-l79aO_m1116911169eusmtip2X;
 Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 10/17] drm: radeon: fix sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:19:58 +0200
Message-Id: <20200428132005.21424-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURiFc2famaFSHQqEG8QljWIwgBI1uQrBJUQnvGhIfDGIVpkASoF0
 AMEHRVwgKMhiENEoLkBZi4CALEEqWilSsCBCAKUsBk0QAxQoiWDHqfr2/ec/556bm0vhMq3Y
 lYqIimVVUYpIOSER1b21dHs98FKH7NRWb0Pphg4MFWqukOh5nkaMkrV6Aq3WZeGozzxDoJKy
 Nxi6n1mDoYJWXzTfZ8JQ9Xi/GPU2PiBQRfsIidp+ToiRfmSOPLCOKX9YDpiWhQIRM9zfTDD1
 C6Ni5stNHcbUPLvMDK2M40zOQDFgmgaTCCajthQwc9Ubj605IfELZSMj4lnVDv/TkvA7TbNk
 zD064evzb0QSGJSmATsK0rvhr6JskAYklIxWA6ix1GPCMA9gjimFFIY5ADOeGsDfyOt3BbZI
 MYCFA2bwL6KdmcJ4F0H7wLTpNIJnJ/o6gO/S7XkTTtfhcKK4neQXjnQgzG7tFfMsorfCqs9L
 OM9S2h9a1FO2uk2wrOrVH93OqheOTRL8QZA2krBnqJMQTAHwR02OjR3hd10tKbAbXH35CBMC
 VwE0GSpIYbgFYG9ynq3CFw4blq1pyno/D6hp3CHIB+HS42GSlyG9Fg5MO/AybsXsuru4IEth
 6g2Z4HaH+brKf7VtPUZcYAaazHrbo2YBmLRsJDPBpvz/ZQUAlAIXNo5ThrGcTxR7wZtTKLm4
 qDDvs9HKamD9WZ0rutkGYDae0QKaAnJ7aZW9OkQmVsRziUotgBQud5KOhReFyKShisSLrCr6
 lCoukuW0YD0lkrtIdz35dlJGhyli2fMsG8Oq/m4xys41CQRLk8cemeJyRysPyLqaU6rC540x
 WYfyPfYEcZH6zXLnAIejJTnubYHnEj6tpl/qEKv7j3f3ex7WdUUUOjOL+zqvH2VqNliCy71P
 76eQm9907orj4aCGF1v2tuUnf0y9XNsySROG96rulawbs0TsB3us8ghCntG5i5rbfYPXLP5y
 EReu8NmOqzjFb/bXJ8pVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pzdFfEGZxewmfRe+4kk8XS9Y3s
 FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
 9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
 k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQypuz+xF4wU6Di2caXbA2MN3m7GDk5JARMJA6fWMDYxcjFISSw
 lFFixoMdTBAJGYmT0xpYIWxhiT/Xutggij4xSqxYMxmsiE3AUKLrLURCRKCTUWJa90d2EIdZ
 4ACzRPf5k2BVwgJeEpP2XwYbxSKgKrHh3g9mEJtXwE7i54oXjBAr5CVWbzgAFucEii999BRo
 KgfQOluJyy25Exj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMn23Hfm7Zwdj1LvgQ
 owAHoxIP7waeFXFCrIllxZW5hxglOJiVRHgfZSyLE+JNSaysSi3Kjy8qzUktPsRoCnTTRGYp
 0eR8YGznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg7KgNmeW3
 I3e37OTv6+YzN584e1GvJWZdufZqj76QrKBTPs+vCZvxzLBRT176SKfOuvh/Q4An48/VW5r7
 XG713tpYe2WKeWnk29fT939f96vedMIsr8cnm366Zk1RNve863fplXfwNGv+hs1qDqtbPPue
 RjBGzjs1b5aAMevHpAvn9/7vDH/wQYmlOCPRUIu5qDgRAGBApzi1AgAA
X-CMS-MailID: 20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905
X-Msg-Generator: CA
X-RootMTR: 20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905@eucas1p1.samsung.com>
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
 drivers/gpu/drm/radeon/radeon_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9e..4770880 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -481,7 +481,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
 	struct radeon_ttm_tt *gtt = (void *)ttm;
-	unsigned pinned = 0, nents;
+	unsigned pinned = 0;
 	int r;
 
 	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
@@ -522,8 +522,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 		goto release_sg;
 
 	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	ttm->sg->nents = dma_map_sg(rdev->dev, ttm->sg->sgl,
+	if (ttm->sg->nents == 0)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -554,9 +554,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
 
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
+	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->orig_nents, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
 			set_page_dirty(page);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
