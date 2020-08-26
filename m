Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA5AC433FE
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E906920866
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IaDIIkHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E906920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E01D186AC1;
	Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ftGaT_e42mcn; Wed, 26 Aug 2020 06:35:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 17D5386B7A;
	Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04EDCC0891;
	Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB07DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AFDC286A7C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IFQt4PJ753g for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DEF1386B2D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:37 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063535euoutp02a4a42769b293931383225ede04409bff~uvetHGj9b1512715127euoutp02M
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063535euoutp02a4a42769b293931383225ede04409bff~uvetHGj9b1512715127euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423736;
 bh=p60/viRe3KtwGWtJeORUVY3qfIOgIF9iybwgzZ0CmPo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IaDIIkHRtBBQLCS1NMQulg2vqYT/tTfPJ6j+7IVC3YuyBkNtaqOl0QfCuTASD83WW
 jpGxCkM1M1jwkoVON57u6y2/pKdowaaMsb25wlPfqxkZLVFxamyGAhi9xAhkJYuGBL
 VCACv3LwrBVsWsv+W8Ocg1AZUo7NTNKY3q9nWEEs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200826063535eucas1p1ec3c07ae73a90da4655bd0b6f633e016~uves0gNAh1479914799eucas1p1c;
 Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 0E.AD.05997.7B2064F5; Wed, 26
 Aug 2020 07:35:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2~uvesPRM8S1480314803eucas1p1i;
 Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063535eusmtrp21794edd135bc8b04c20367fa6c631e7d~uvesOilpN0466204662eusmtrp2K;
 Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-cb-5f4602b7a639
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.53.06017.6B2064F5; Wed, 26
 Aug 2020 07:35:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063534eusmtip284cd426d5290cc263f07966ec9018e8a~uverllRjy0302303023eusmtip2x;
 Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/32] drm: msm: fix common struct sg_table related issues
Date: Wed, 26 Aug 2020 08:32:56 +0200
Message-Id: <20200826063316.23486-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTURjGOffu7l6Hq9smeVDLHGlZ5Dd4YSUVVpcgjKCgyHTlRS2/2pxm
 /yiJo2ZqU8IlYkssy89cw68IdWir5jR16NRMxcQSrMSPNGW27ar993ue93nPczgcAhUYMDci
 PimVkSZJEkRcHqfx/WrvkSbkdFTA5AMvKq/nI0I1qOsxaqNRhVLmpV9cqnTGBKhX1V0IpWkT
 U4vmSYTSTg1ilKrNhFMDraVcqrZzDKdmnq2gVMfvbxg1VtQJju+ka8pqAP1uWcOhW0rGcLpp
 eQKjx3MNCP2mIpMetU6hdJGlEtBvh7O4tKF1BKfzdVWAXtDuPe98hXc0hkmIT2Ok/mHRvDiV
 cRZL6RLdKdSYkSyw4KEETgQkQ+Dk4hKuBDxCQL4EcGI1B2XFIoA53SaEFQsA5s7ncLdWlEPd
 m6lKAAsGFNztlSGFyZHikoFQOad0sAuZA+CHPGd7CCVLUPhdv+YYCMkIqCs3OphDesORlgbE
 znwyDFZpyzhsnSesft2O2tnJ5htyCxxtkPyKw/zZGYQNhUNdXvEmC+GsQYez7AE3Wp4i7EI2
 gJM9tTgrHgI4cE8N2JQYfun5azuWsN3PF9a3+rP2CTg9qMLtNiR3QMvcLruN2rCwsRhlbT68
 rxCwaR9YYqjbru343I+yTMPV+XrAvpAKwHyrBX0EPEv+l2kAqAKujFyWGMvIgpKYdD+ZJFEm
 T4r1u5GcqAW272W0GhabQev6dT0gCSBy5mu4p6IEmCRNlpGoB5BARS78kybjNQE/RpJxl5Em
 R0nlCYxMD9wJjsiVH1z+I1JAxkpSmVsMk8JIt6YI4eSWBbCzkhj3tav718uMdWmDQS4+A5lY
 e3qvUXgp5sCKtzw65dw+8+jB4dBOl+A++Sh2Zkog3DNdmC20DLUdnl81B7hZOiu8L2QNXz77
 57bw5nP1hhciXnmh9h075tb3qTdch4es6HO7+38qFHz1E8vFCNVuvjU0sio4fVwsT2uufyzi
 yOIkgYdQqUzyD85dRYtaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7rbmNziDWa/tLLoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFnOdnGS1Wrj7KZLFgv7XFlysPmSw2Pb7GajFx/1l2i8u75rBZrD1yl93i
 +cIfzBYHPzxhtbg7+QijA7/HmnlrGD32flvA4rFz1l12j+3fHrB63O8+zuSxeUm9x+1/j5k9
 Jt9Yzuix+2YDm8fxXbfYPfq2rGL0+LxJLoAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
 z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j4ulXrAVHlSomLbjC1MD4WaaLkZNDQsBEouv6GeYu
 Ri4OIYGljBJrjixlgkjISJyc1sAKYQtL/LnWxQZiCwl8YpT4eVcFxGYTMJToegsS5+IQEehk
 lJjW/ZEdxGEWWMIs0Tf1EliHsICvxL9r3SwgNouAqsStnRvBNvAK2Ems2jSPBWKDvMTqDQeY
 QWxOoPjx7n6obbYSp9fOYJ7AyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCRtO/Zz
 yw7GrnfBhxgFOBiVeHgXsLnGC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQ
 oynQUROZpUST84FRnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1Oq
 gfH4v3vLZm3yFQq9s3TP/tm9Uv8vrDZ7Uem7J9dgk6zFH5e42ad+fZ+3OLVT1Uox/p7q9aT0
 ZxfYWYQ4bAwDiu7vbZ3hbsd49dRqxf8VE2/P7Eg807Kn9bTnNlaWxokpNdL589Zce1k+aUP3
 y+xpxYZ3TUsvKDz6kP/MdPvMNYum2Fb7v3kjun23EktxRqKhFnNRcSIAlxwXaboCAAA=
X-CMS-MailID: 20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2
X-Msg-Generator: CA
X-RootMTR: 20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2@eucas1p1.samsung.com>
Cc: freedreno@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
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
Acked-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.c    | 13 +++++--------
 drivers/gpu/drm/msm/msm_gpummu.c | 14 ++++++--------
 drivers/gpu/drm/msm/msm_iommu.c  |  2 +-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b2f49152b4d4..8c7ae812b813 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -53,11 +53,10 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
-		dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_sync_sgtable_for_device(dev, msm_obj->sgt,
+					    DMA_BIDIRECTIONAL);
 	} else {
-		dma_map_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 	}
 }
 
@@ -66,11 +65,9 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
-		dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_sync_sgtable_for_cpu(dev, msm_obj->sgt, DMA_BIDIRECTIONAL);
 	} else {
-		dma_unmap_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 310a31b05faa..319f06c28235 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -30,21 +30,19 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
 	unsigned idx = (iova - GPUMMU_VA_START) / GPUMMU_PAGE_SIZE;
-	struct scatterlist *sg;
+	struct sg_dma_page_iter dma_iter;
 	unsigned prot_bits = 0;
-	unsigned i, j;
 
 	if (prot & IOMMU_WRITE)
 		prot_bits |= 1;
 	if (prot & IOMMU_READ)
 		prot_bits |= 2;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		dma_addr_t addr = sg->dma_address;
-		for (j = 0; j < sg->length / GPUMMU_PAGE_SIZE; j++, idx++) {
-			gpummu->table[idx] = addr | prot_bits;
-			addr += GPUMMU_PAGE_SIZE;
-		}
+	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&dma_iter);
+
+		BUILD_BUG_ON(GPUMMU_PAGE_SIZE != PAGE_SIZE);
+		gpummu->table[idx++] = addr | prot_bits;
 	}
 
 	/* we can improve by deferring flush for multiple map() */
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 3a381a9674c9..6c31e65834c6 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -36,7 +36,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
+	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
 	WARN_ON(!ret);
 
 	return (ret == len) ? 0 : -EINVAL;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
