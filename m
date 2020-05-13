Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE56C2D119
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C841522211
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mr4wLD6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C841522211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6F7587150;
	Wed, 13 May 2020 13:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hl_t9CSKE1FQ; Wed, 13 May 2020 13:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 364678701F;
	Wed, 13 May 2020 13:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD66C0178;
	Wed, 13 May 2020 13:34:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F9BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E6A33265AD
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PodaNq2op0He for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:34:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id E84A726600
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:23 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133322euoutp02747670fe84611fab6347573f5f4f314e~OmcfvF0Y03216632166euoutp02S
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133322euoutp02747670fe84611fab6347573f5f4f314e~OmcfvF0Y03216632166euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376802;
 bh=sMCpKm/mYI1T1jeLS6Xad9LPvFW5tKSA1dr4LtDjiIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mr4wLD6FGoGr0Ke7iFGnF8UceZn/iX27FLELv3m99A2EXIUP7WHWjWHKsDj4nPpIP
 ZyvI8OqrabY9ExFvd9zi8AcPljJcENt1I/GMb0d4cs0cRhpPl2Nyj7vbIMqsF/gZn5
 QTMGevhHPCAtUVPVg9o8qorsy/m4lhBrDlTZnW/8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133322eucas1p2d95ee605cb9c29fd95c682d21005ada9~OmcfYZhv21009610096eucas1p2W;
 Wed, 13 May 2020 13:33:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id F8.D5.61286.227FBBE5; Wed, 13
 May 2020 14:33:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133321eucas1p13acea3aa6219ce5f7076c7677ef9eae3~Omce9qmhP0785007850eucas1p1E;
 Wed, 13 May 2020 13:33:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133321eusmtrp1ce353d78d9c1837784c5060b07716ef4~Omce86CR61050710507eusmtrp1X;
 Wed, 13 May 2020 13:33:21 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-81-5ebbf722ae93
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.47.07950.127FBBE5; Wed, 13
 May 2020 14:33:21 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133320eusmtip1c65f8b0654a7f1d159d86a9a57b5fe30~OmceAbuLj0693406934eusmtip1c;
 Wed, 13 May 2020 13:33:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 33/38] staging: tegra-vde: fix common struct sg_table
 related issues
Date: Wed, 13 May 2020 15:32:40 +0200
Message-Id: <20200513133245.6408-33-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ3pdKgUh2LkBhdME3GJghU1N6BEAw/jizHRF0lAikwAZTEd
 FjEakSqytLgQtwYM4sJWKBREpCyyiQjWKiDIIpAaIygguywBWwb17Tv/OX/+c08uiYkH+Q5k
 cFgEIw+ThUgIIV76etawSzKj992dY8KQytDEQ0X3tXy0VHoLQxUtcwKUN2YCqG1qlECKx1oC
 5eQ18FBGtTu6qs7E0WTbAA/pTJ/4qLU8jUDKwud8lDipJlB+fa8APdMt8FDNr698NFv+ED9k
 R2seagD9paoOpyunM3D6pbpXQOtyEwn6xXQ/n65O1wjovuRGHl385DLdvWjC6NTOLEDrP8cS
 tEoxQtApJbmAntBtOrbGW3gggAkJjmLkLh5+wqDSu9/xc+PU+Z9GJT8WPLBJAlYkpPbCpr5K
 kASEpJjKBvBuXTfOFZMA9tx5ulJMANgVb8T+Wgzt7QTXyAKwXNHP+2d5l36bZ5kiKClMGk4i
 LLyWugbgG5W1hTGqBYctv10tbEedhEULZbiFcWoLjE1IBxYWUQdhe9V1gktzhHmFr5aTrcz6
 UE/18kqQUpFQP24A3JAX7Ehpxjm2g0ONJQKON8DmVOWKQQHggCFfwBVKAFvj7q+43WGPYc4c
 R5rX2w615S6cfBiOjhiXZUjZwM5hW+4BNvB26T2Mk0UwIV7MTTtBdWPBv9ga48eVa9EwW9En
 4A5UB+C8upi4CRzV/8MyAMgF9kwkGxrIsNIwJtqZlYWykWGBzqfDQ3XA/AGbFxvHy8DUR/9a
 QJFAYi1CXXpfMV8WxcaE1gJIYpK1oqNasyQKkMVcYOThp+SRIQxbC9aTuMRe5Jo56COmAmUR
 zFmGOcfI/3Z5pJVDLNg/E7UwjT12Pn5Deuzt0qPkA0fBibE4231N85RKX5Bj27RHG+d2ZfV8
 5lOqI1OakGv7Ibv2henWBFgyngmOXuX9vLvDkOej9NytEXn1rfP/dmSr94+ai35BwZ6zNwc2
 Z51gE4ViWNXrZrXzUUN/lcYrZuPgtks1bfXvK66nOek9iiQ4GyST7sDkrOwPWfDyNHwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qK33fHGdzbrWjRe+4kk8XGGetZ
 Lf5vm8hssefML3aL1R8fM1pc+fqezaJ58Xo2i5WrjzJZLNhvbdEyaxGLxZcrD5ksNj2+xmpx
 edccNoueDVtZLTq/zGKzWHvkLrvFsk1/mCwOfnjCavFz1zwWB2GPNfPWMHrc23eYxWPvtwUs
 Hjtn3WX32LSqk81j+7cHrB77565h97jffZzJY/OSeo/b/x4ze0y+sZzRY/fNBjaP3uZ3bB59
 W1YxenzeJBfAH6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
 WqRvl6CXsW3aC5aCTwIVby70sDYwzuTrYuTkkBAwkTh39SpbFyMXh5DAUkaJidtfMkMkZCRO
 TmtghbCFJf5c64Iq+sQoseXXfrAiNgFDia63EAkRgU5GiWndH9lBHGaBGywSc7d8YAepEhYI
 l3g7ZQ4LiM0ioCrR0DGXEcTmFbCVuLqvnQ1ihbzE6g0HwKZyAsVf3dkPVi8kkC+xd/E+tgmM
 fAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERuS2Yz+37GDsehd8iFGAg1GJh9fi1u44
 IdbEsuLK3EOMEhzMSiK8fuuBQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPTBZ5JfGGpobm
 FpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY1xz1mTXv2TeNJ493mhRmmfoI
 Tn/FLlosVPk8LWnepql6azkc+090O9woL+F/dt3Nj/f+a5W/WU3pkw/vYfDVvPjy/fG4i2I+
 RWZ9Xunsu3lW/tq6yK5gvfD5fxLObe5VZzNOPHjz8pDMTIneGO7SyStvfPetz4nx/Xbvps81
 Y+EtWuo2gTMnKrEUZyQaajEXFScCALAaeATeAgAA
X-CMS-MailID: 20200513133321eucas1p13acea3aa6219ce5f7076c7677ef9eae3
X-Msg-Generator: CA
X-RootMTR: 20200513133321eucas1p13acea3aa6219ce5f7076c7677ef9eae3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133321eucas1p13acea3aa6219ce5f7076c7677ef9eae3
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133321eucas1p13acea3aa6219ce5f7076c7677ef9eae3@eucas1p1.samsung.com>
Cc: devel@driverdev.osuosl.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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
 drivers/staging/media/tegra-vde/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/staging/media/tegra-vde/iommu.c
index 6af863d..adf8dc7 100644
--- a/drivers/staging/media/tegra-vde/iommu.c
+++ b/drivers/staging/media/tegra-vde/iommu.c
@@ -36,8 +36,8 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
 
 	addr = iova_dma_addr(&vde->iova, iova);
 
-	size = iommu_map_sg(vde->domain, addr, sgt->sgl, sgt->nents,
-			    IOMMU_READ | IOMMU_WRITE);
+	size = iommu_map_sgtable(vde->domain, addr, sgt,
+				 IOMMU_READ | IOMMU_WRITE);
 	if (!size) {
 		__free_iova(&vde->iova, iova);
 		return -ENXIO;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
