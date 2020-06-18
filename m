Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C258C433E3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A70208D5
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LHn85sMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A70208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4EC7387C30;
	Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqKNy1CGdxDg; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 853A787C14;
	Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5783FC016E;
	Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53688C088C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4DD2489400
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GK5pi-q0qYSW for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D712B89438
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:24 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154022euoutp029a5f650d3e1f1a902a4f2e2bbc6427a2~ZrZqeUsxz1470214702euoutp02B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154022euoutp029a5f650d3e1f1a902a4f2e2bbc6427a2~ZrZqeUsxz1470214702euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494822;
 bh=dgA8N0ViLqnC/QZEgzrc3l/K0+XnEV3AJx7m2vhhZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LHn85sMeOO4rmyR3Hovjkzb7mH+Rj8Cgl1aUWkKSKUkFmRhqzylAo1GfJWXu5Sj3P
 J5IsGY75/GDOxtAN6qedWvEV2RZyROny6xiO8OGxfjMdc3sxU5DknBiFga3LrzoZPa
 WzcsL9Y6ASWmVO9xXxfh/zIV7BPHBw/QoeWOyl7k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154022eucas1p1cc2c3555a8b3a71e30ddd163b7e2b4df~ZrZqLudAu1755717557eucas1p1G;
 Thu, 18 Jun 2020 15:40:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.1F.61286.6EA8BEE5; Thu, 18
 Jun 2020 16:40:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154022eucas1p1a8136b9677ac6a98ac47a3154ab0c763~ZrZp8yY471545815458eucas1p1S;
 Thu, 18 Jun 2020 15:40:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154022eusmtrp29f126925ca53016633b0dde40b5af358~ZrZp8GBKM0370403704eusmtrp2h;
 Thu, 18 Jun 2020 15:40:22 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-cb-5eeb8ae62003
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.EE.08375.6EA8BEE5; Thu, 18
 Jun 2020 16:40:22 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154021eusmtip160203d7d536539124d9640b161f7055a~ZrZpQHKd80744107441eusmtip1z;
 Thu, 18 Jun 2020 15:40:21 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/36] drm: mediatek: use common helper for extracting
 pages array
Date: Thu, 18 Jun 2020 17:39:33 +0200
Message-Id: <20200618153956.29558-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87rPul7HGXR+lrXoPXeSyWLjjPWs
 Fot6e1ks/m+byGxx5et7NouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfN4nLzRUaLtUfusls0
 tRhb3L13gsXi4IcnrA78HmvmrWH02PttAYvHzll32T02repk89j+7QGrx/3u40wem5fUe9z+
 95jZY/KN5Yweu282sHn0/zXw6NuyitHj8ya5AN4oLpuU1JzMstQifbsEroyuvzuYCx5wVtyY
 8Jq5gXEKRxcjJ4eEgInEqrZ/7F2MXBxCAisYJY60L2WGcL4wSlyZOw/K+cwoMfPaXcYuRg6w
 lj+7xEG6hQSWA8X/qsI1zDqykx0kwSZgKNH1tosNxBYRaGWUONHLA1LELLCHWWLRrl8sIAlh
 gXCJbwf2MYPYLAKqEjfvzgGzeQXsJN41bmGFuE9eYvWGA2BxTqD46eOtrCCDJATusUu8WdnP
 BFHkIrGxeysLhC0s8er4FnYIW0bi/875TBANzYwSD8+tZYdwehglLjfNYISospa4c+4XG8hv
 zAKaEut36UOEHSXmru1gh3iZT+LGW0GQMDOQOWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiRnC
 9pDo27OKBRJCExkl+n/OY53AKD8LYdkCRsZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsY
 genr9L/jn3Ywfr2UdIhRgINRiYfXIfx1nBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lj
 i0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYFR8cF6nkPvzhOVht76vNyvP
 7nZbX6W+pya7Vdjoe+Qvr+aJ982Mcy2UuC7+3cRW8ex3T8upF9sYzPTWWOy0zjf/F2ywIF9X
 TfHKpCUP6mLCpm0+Gpu+dI9Pg/k3lyeGNb/0d54wafpht2TPW6WVZ+S0BDcc8S/Vv3dtwoOy
 NtMl0lcZf+ckvFFiKc5INNRiLipOBAB33GSmWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7rPul7HGfS957XoPXeSyWLjjPWs
 Fot6e1ks/m+byGxx5et7NouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfN4nLzRUaLtUfusls0
 tRhb3L13gsXi4IcnrA78HmvmrWH02PttAYvHzll32T02repk89j+7QGrx/3u40wem5fUe9z+
 95jZY/KN5Yweu282sHn0/zXw6NuyitHj8ya5AN4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
 E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyuvzuYCx5wVtyY8Jq5gXEKRxcjB4eEgInEn13i
 XYycHEICSxklDrwvBbElBGQkTk5rYIWwhSX+XOti62LkAqr5xCgxcTWIw8nBJmAo0fUWIiEi
 0MkoMa37IzuIwyxwjFli4+P3zCBVwgKhEk/mHgPrYBFQlbh5dw5YnFfATuJd4xaoFfISqzcc
 AItzAsVPH29lhTjJVuL5hza2CYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG07Zj
 PzfvYLy0MfgQowAHoxIP74uQ13FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUkt
 PsRoCnTURGYp0eR8YKTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+Lg
 lGpgtLr0dOdTd/EVLFnJyjVRC/5uXLvcdPKfH9+Wuy2cZnp/m4VsBpuLwFox7rn/e9/Ye/8z
 y5f/+SP3iut55ssvnd+xOezSmPm+JIv3srOC8PlzSjfueS1zXt2yYkHB78cGXvs1k1++fNnz
 6Yb6RkELZ501u85LlTeZNW7zSwu4oX1K5lNk7s3LykosxRmJhlrMRcWJAI8Nqhm8AgAA
X-CMS-MailID: 20200618154022eucas1p1a8136b9677ac6a98ac47a3154ab0c763
X-Msg-Generator: CA
X-RootMTR: 20200618154022eucas1p1a8136b9677ac6a98ac47a3154ab0c763
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154022eucas1p1a8136b9677ac6a98ac47a3154ab0c763
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154022eucas1p1a8136b9677ac6a98ac47a3154ab0c763@eucas1p1.samsung.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
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

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 3654ec732029..0583e557ad37 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -233,9 +233,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
 	struct sg_table *sgt;
-	struct sg_page_iter iter;
 	unsigned int npages;
-	unsigned int i = 0;
 
 	if (mtk_gem->kvaddr)
 		return mtk_gem->kvaddr;
@@ -249,11 +247,8 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->pages)
 		goto out;
 
-	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
-		if (i > npages)
-			break;
-	}
+	drm_prime_sg_to_page_addr_arrays(sgt, mtk_gem->pages, NULL, npages);
+
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
