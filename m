Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDEC2D106
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA78C207BA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AkEeF+x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA78C207BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E19D86FC9;
	Wed, 13 May 2020 13:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1s5n985hpVMc; Wed, 13 May 2020 13:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0189986FA3;
	Wed, 13 May 2020 13:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF97FC0178;
	Wed, 13 May 2020 13:33:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9EF3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ACAAB2221C
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPx9ZcCmv2mT for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by silver.osuosl.org (Postfix) with ESMTPS id 6B5B226258
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:05 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133303euoutp01e88113bb87b2255bf3f954b0b0670198~OmcOIT_hE2196121961euoutp01i
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133303euoutp01e88113bb87b2255bf3f954b0b0670198~OmcOIT_hE2196121961euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376783;
 bh=xlFAx0rB6qSWIPJXnzgQs84AILqr7ct37TqDQh+3XKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AkEeF+x6hKYfOfyL78fh81S6X2bGe8FwF/gD/FSqYfbrb4ft+6JWB/VusNVZHSMkf
 ZquoDWNzNhWvKdzV5rX1lM8vS1tIb1Ak0G4P7Y7Vb3/AVkDIJj3r6huBS0QPcX/7Ro
 b1cIj7iPLNj5ImPKsMbWQ61togiIGUROLMtYdF2g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133303eucas1p292f76762e69c5893318be4b7d284e048~OmcNxtrk30616406164eucas1p2L;
 Wed, 13 May 2020 13:33:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 01.D8.60698.F07FBBE5; Wed, 13
 May 2020 14:33:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133302eucas1p1edbd033e0137d0c973f82c409d3a4e5d~OmcNUM0m-2635426354eucas1p1O;
 Wed, 13 May 2020 13:33:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133302eusmtrp18870554b5b43d5fe76f6fa388bbc3f7f~OmcNTgE9-1011910119eusmtrp12;
 Wed, 13 May 2020 13:33:02 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-bb-5ebbf70f5fdc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.37.07950.E07FBBE5; Wed, 13
 May 2020 14:33:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133301eusmtip10c90e7ef6136a0a651be93162b005956~OmcMnEFLw3222032220eusmtip11;
 Wed, 13 May 2020 13:33:01 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/38] drm: etnaviv: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:16 +0200
Message-Id: <20200513133245.6408-9-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmO2dnO15mp2n4paIyNErJC0odULtA0PkVgWGitVp58n5hRy37
 UaJk5d0UFCkZJWxt3nLe2FDTMjPzkooXnKhphTNNnE7U1DbPtH/P87zPw/O+Hx+OChoxBzw6
 IZmWJIjjhFxLTtOnzYHTRzY0Ip+sTS6Z19+DkO/KajFyr6kIJUfW/3BJdZmWR75VdiGktD2A
 nHk1gZBrI7MIWT83ipHD6pdcsvrjFI/sWJnHLvCpqooqQLUapByq2TCDUdM53QilqnxMTe7O
 oVTxuAxQmol0LlWw40PlNygApa93vmoVZhkYQcdFp9IS73O3LaMWC/ySFO4P8hU9WDpQumQD
 CxwS/nAyQ4lkA0tcQMgBHNZmcVmyBqBeZcBYogdw+fsv7kHk28gehx3IANRNlYDDSPtiDjC5
 uIQvzF7K3k/YEU8A/JxnbcIoMY3A7YUYE7YlgqFOJ9v3cAh3qJ3e5JkwnwiEBvUyj21zgcq6
 96gJWxBBUKdt32+GRBsPrq/Om02X4GTXIGCxLdR1N5h1J9hbnGsOZAI421/NY0mu8dSMMnMi
 AGr7t4xr4Mb1TsFatTcrX4T9hmbEJEPCBo4vHWUPsIEvmkpRVubDZ1kC1n0ClnfXHNZ2DA6h
 LKagVP7V/EAfAHwu13AKgUv5/zIpAApgT6cw8ZE045dA3/dixPFMSkKk193E+Hpg/Ey9u93r
 LaDt751OQOBAaM2fGdOIBJg4lUmL7wQQR4V2/Cu1RokfIU57SEsSb0lS4mimEzjiHKE93+/1
 wk0BESlOpmNpOomWHEwR3MIhHTz1DtvGyp2aW/nBMXaNHaUeISHBbhvnfxcUluDFPx3Xjmde
 i3iUVTGvcrMpCAcplcxUUInzvaU6Qd+Qp37HynVv9mRL6NZqh7Rt0/NsLLbyxVU0Wi0VyUWw
 L/zGaGiFXCFTeQxfvk6rxnJ/+C9NvdEfWxnoK3MuqpE1WniJzgg5TJTY1wOVMOJ/gm7CwUgD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7p833fHGazZp2rRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLXTPusFusXH2UyWLBfmuLB3NvMll8ufKQyWLT42usFpd3zWGzWHvkLrvF
 wQ9PWB14PdbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR/9fA4++
 LasYPT5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
 LdK3S9DLeN1vXLBKtaJv1UnWBsbV8l2MnBwSAiYSF6/8ZwGxhQSWMkpsaK+HiMtInJzWwAph
 C0v8udbF1sXIBVTziVFi09SDzCAJNgFDia63EAkRgU5GiWndH9lBEswCz5kkXrbog9jCAoES
 f389A2tgEVCVuHP/J1gNr4CNxLdd79ghNshLrN5wAKyGU8BW4tWd/VAX5UvsXbyPbQIj3wJG
 hlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBUbLt2M8tOxi73gUfYhTgYFTi4bW4tTtOiDWx
 rLgy9xCjBAezkgiv33qgEG9KYmVValF+fFFpTmrxIUZToKMmMkuJJucDIzivJN7Q1NDcwtLQ
 3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjqn/IsdNX/jK8Nv15SGDSctcXt5a7
 mmu1M6fcXxhgrHxpam20xPS5VXIhKru0es77mk+avNbQbFpq//85mz/vUb3+5bbpU21jmaI/
 b+4GvduyYNKsJB7/iPT8kp74rq+n6qOCe2pYRMx73O/UZk+1rdXgbZp7tCmnuGPdfb3relpP
 5yYlCCorsRRnJBpqMRcVJwIAsC7ysagCAAA=
X-CMS-MailID: 20200513133302eucas1p1edbd033e0137d0c973f82c409d3a4e5d
X-Msg-Generator: CA
X-RootMTR: 20200513133302eucas1p1edbd033e0137d0c973f82c409d3a4e5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133302eucas1p1edbd033e0137d0c973f82c409d3a4e5d
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133302eucas1p1edbd033e0137d0c973f82c409d3a4e5d@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>,
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
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 +++++-------
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 13 +++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index dc9ef30..cc50c7b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -27,7 +27,7 @@ static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
 	 * because display controller, GPU, etc. are not coherent.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_map_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 }
 
 static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj)
@@ -51,7 +51,7 @@ static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj
 	 * discard those writes.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_unmap_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 }
 
 /* called with etnaviv_obj->lock held */
@@ -404,9 +404,8 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
 	}
 
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
-		dma_sync_sg_for_cpu(dev->dev, etnaviv_obj->sgt->sgl,
-				    etnaviv_obj->sgt->nents,
-				    etnaviv_op_to_dma_dir(op));
+		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
+					 etnaviv_op_to_dma_dir(op));
 		etnaviv_obj->last_cpu_prep_op = op;
 	}
 
@@ -421,8 +420,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
 		/* fini without a prep is almost certainly a userspace error */
 		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
-		dma_sync_sg_for_device(dev->dev, etnaviv_obj->sgt->sgl,
-			etnaviv_obj->sgt->nents,
+		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
 			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
 		etnaviv_obj->last_cpu_prep_op = 0;
 	}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 3607d34..13b1005 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -79,7 +79,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 	if (!context || !sgt)
 		return -EINVAL;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+	for_each_sgtable_dma_sg(sgt, sg, i) {
 		u32 pa = sg_dma_address(sg) - sg->offset;
 		size_t bytes = sg_dma_len(sg) + sg->offset;
 
@@ -95,14 +95,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 	return 0;
 
 fail:
-	da = iova;
-
-	for_each_sg(sgt->sgl, sg, i, j) {
-		size_t bytes = sg_dma_len(sg) + sg->offset;
-
-		etnaviv_context_unmap(context, da, bytes);
-		da += bytes;
-	}
+	etnaviv_context_unmap(context, iova, da - iova);
 	return ret;
 }
 
@@ -113,7 +106,7 @@ static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
 	unsigned int da = iova;
 	int i;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+	for_each_sgtable_dma_sg(sgt, sg, i) {
 		size_t bytes = sg_dma_len(sg) + sg->offset;
 
 		etnaviv_context_unmap(context, da, bytes);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
