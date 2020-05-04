Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75FC5321F
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A459420757
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M+d1o5ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A459420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6AB7B87775;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qBSPV_AbbZGw; Mon,  4 May 2020 12:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DBE88775C;
	Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B67FC088C;
	Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE421C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABB8122D33
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZhppTg-hQuN for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 5FD4A20384
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125420euoutp02d3dcb9788a27651e17663eda45d0d9c4~L1G2l1qPW1833318333euoutp029
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125420euoutp02d3dcb9788a27651e17663eda45d0d9c4~L1G2l1qPW1833318333euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596861;
 bh=Ttmk3z/wgaMlZxwZtUmC4+W+gIbK2TZtfskAp6FVn7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M+d1o5ZVhUVN1ZfQPrZfcMnshXvBbdGH9uQSDnzkA1rkF5Fa0TTbDqJeIa2JLYN5a
 ri+j49X6WhbENiIDYSQRM4Zu38uH++zQsA9puDZohEvHoy3o0dQGSx5gGmkOqaAl5V
 jX6UUXADZApBPRcOQoC87q7cSHMnDNZekKucTcDA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200504125420eucas1p2a81c07be105dda54ab34624f355a272f~L1G2WAnsK2246922469eucas1p2m;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.E2.60679.C7010BE5; Mon,  4
 May 2020 13:54:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125420eucas1p2387a795af11e62779e8aa7f7673a8562~L1G194XiM2235822358eucas1p2q;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504125420eusmtrp2717a6a2fb13d54ea48e921ea03000013~L1G19MkLc2826928269eusmtrp2X;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-af-5eb0107c4555
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.69.08375.C7010BE5; Mon,  4
 May 2020 13:54:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125419eusmtip21a00d04f6d566f3a535fb519094872c2~L1G1UE7360241302413eusmtip2Z;
 Mon,  4 May 2020 12:54:19 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/21] drm: xen: fix sg_table nents vs. orig_nents misuse
Date: Mon,  4 May 2020 14:53:53 +0200
Message-Id: <20200504125359.5678-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87o1AhviDBruaVj0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xYfV71ktDn54wmrx
 fctkJgdejzXz1jB63Fm6k9Fj77cFLB7bvz1g9bjffZzJY/OSeo/b/x4ze0y+sZzR4/CHKywe
 u282sHn0bVnF6PF5k1wATxSXTUpqTmZZapG+XQJXxvlZL9kK1nNWPN7Uw97A+IW9i5GDQ0LA
 ROLfQeYuRi4OIYEVjBJvW98AxTmBnC+MErcemkEkPjNK7G14ANdw/qg3RHw5o8S69l8sEA5Q
 Q+/3k2DdbAKGEl1vu9hAbBGBVkaJE708IEXMAj+YJM4tOwFWJCzgIzHz8TYmEJtFQFVi6/8e
 sAZeAVuJQ60nweISAvISqzccYAbZzAkUn9mrDjJHQuAcu8S+jlXsEDUuEuvP9DJD2MISr45v
 gYrLSPzfOZ8JoqGZUeLhubXsEE4Po8TlphmMEFXWEnfO/WID2cAsoCmxfpc+RNhRYs3uFcwQ
 L/NJ3HgrCBJmBjInbZsOFeaV6GgTgqhWk5h1fB3c2oMXLkGd4yHROW87KySADjNKfN9yiHkC
 o/wshGULGBlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCao0/+Of9nBuOtP0iFGAQ5G
 JR7eiM/r44RYE8uKK3MPMUpwMCuJ8O5oAQrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZI
 ID2xJDU7NbUgtQgmy8TBKdXAqPxMeH9caFgt04/DWtmWj/x0q89+28o8YYqCp8lV+9ADG/ey
 HGZQv38jqWBe9yyDINbMG0zbeidKq9dzNs6rVbFQ1FgyPe+VmIHgMv+qZ6dyQmvz703783jt
 lZY7AdMcJiuc5mtNTj7+bNkWETFzr3ut1ztiHLdOW/n/4UGBaqV1woHdN/bPUGIpzkg01GIu
 Kk4EAL6Bl7lMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7o1AhviDLat5rfoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12iw+r37NaHPzwhNXi
 +5bJTA68HmvmrWH0uLN0J6PH3m8LWDy2f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+EPV1g8
 dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
 m5TUnMyy1CJ9uwS9jPOzXrIVrOeseLyph72B8Qt7FyMHh4SAicT5o95djFwcQgJLGSW+dfWw
 dTFyAsVlJE5Oa2CFsIUl/lzrYoMo+sQocez/OrAiNgFDia63EAkRgU5GiWndH9lBHGaBf0wS
 J/ZuZwKpEhbwkZj5eBuYzSKgKrH1P8QKXgFbiUOtJ5kgVshLrN5wgBnkJE6g+MxedZCwkEC+
 xN2n/1gmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgz24793LyD8dLG4EOMAhyM
 Sjy8EZ/XxwmxJpYVV+YeYpTgYFYS4d3RAhTiTUmsrEotyo8vKs1JLT7EaAp000RmKdHkfGA8
 55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYDRl2smZdaTtsAHT
 T4sU8eo3p25X3D342e7br9fmfP+e7LjlGn36SPmHNtmeQ8VLFCaKr9U9sK8i+Cr72feKndd+
 N+zxMNy5z83t4wFLKTvH45pJd79N+fNWkVNEa1eZgI+P3MYGC4s0j4fnfq7WmJG/xLwkLq7m
 cL9IXfVq/U9ujQ4T11X2eyixFGckGmoxFxUnAgAhUwpyrwIAAA==
X-CMS-MailID: 20200504125420eucas1p2387a795af11e62779e8aa7f7673a8562
X-Msg-Generator: CA
X-RootMTR: 20200504125420eucas1p2387a795af11e62779e8aa7f7673a8562
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125420eucas1p2387a795af11e62779e8aa7f7673a8562
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125420eucas1p2387a795af11e62779e8aa7f7673a8562@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index f0b85e0..ba4bdc5 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -215,7 +215,7 @@ struct drm_gem_object *
 		return ERR_PTR(ret);
 
 	DRM_DEBUG("Imported buffer of size %zu with nents %u\n",
-		  size, sgt->nents);
+		  size, sgt->orig_nents);
 
 	return &xen_obj->base;
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
