Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D169BC4345B
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BA5208A9
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bcg62Ama"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BA5208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 995B986B7A;
	Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ei82At4bnVWO; Wed, 26 Aug 2020 06:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A47186BE2;
	Wed, 26 Aug 2020 06:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2271BC0893;
	Wed, 26 Aug 2020 06:35:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E03E6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A5173227F8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNcmFCiEZudM for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 2DF902283C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:39 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063537euoutp02c3d74278b9b50a46597fda60a4d1f170~uveuoh7f51514215142euoutp02N
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063537euoutp02c3d74278b9b50a46597fda60a4d1f170~uveuoh7f51514215142euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423737;
 bh=8L76JluA1DA+XDINuFmhMyh7/pZztphzaFRThYOm+6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bcg62Amagk23m9A+Ve0Sz3WXSzkhDX0Trsl4Y+oiQSuHxvAapBWLifCM7k8+6/s7X
 BLuqo7StKgLMsMgIpntox4JY19fQWm3IQxDHTq9a7n7yQV60Oij3+zw4sR1hMcH1gT
 48BCLPZWGxCa4buY+8mtP43Pl/rq2wSHIZYIwxHM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063537eucas1p2cbe586658c973f74d00447834e1d7a38~uveuNiHsq0402804028eucas1p2l;
 Wed, 26 Aug 2020 06:35:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.33.06456.9B2064F5; Wed, 26
 Aug 2020 07:35:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063536eucas1p2d9ea013228bcfbd5778959274aa01b78~uvetyJ-PZ0398703987eucas1p2e;
 Wed, 26 Aug 2020 06:35:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063536eusmtrp1bd2d212415335d772a8e2f7b51ea8b14~uvetxgu8c1091110911eusmtrp1b;
 Wed, 26 Aug 2020 06:35:36 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-cc-5f4602b97bbe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.D0.06314.8B2064F5; Wed, 26
 Aug 2020 07:35:36 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063536eusmtip26a7a8cb12a4cfae92c0a3899a191cf98~uvetOJhH90302303023eusmtip2y;
 Wed, 26 Aug 2020 06:35:36 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 15/32] drm: panfrost: fix common struct sg_table related
 issues
Date: Wed, 26 Aug 2020 08:32:59 +0200
Message-Id: <20200826063316.23486-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmO3eHk9M0/FiiMDJSSh1JHFBErdnpXz/6VdRceVJpm7Z5yQwy
 RbOpUzPUVESGYF7WbJm3Ei+Us8xL3pjWUFEpNTW8oRHa5rH697zv8zzv834vH4WK2nExFatO
 4DRqhVJCCLDm3t2h021IhDygIodk8gY/IMzLUhPO7DcXoszY1hrB1Na/R5iqziBmc2wWYcxz
 Ezgz2l5BMMZ3NpLZf9tKMt0/53FGbxwhQoVsQ2UDYFtt1YDt2K7CWHPdY4Jt2Z7B2ekcC8K+
 qn7AftmbQ9kiaw1g30ymEay+qQ6wG2bPS85XBMFRnDI2idP4h0QKYoYNQ3j8J3i3uniQTAN9
 bjpAUZAOhEWvr+mAgBLRzwEs1k+hOuBkLzYBbKsJ5IkNANcnOoCDcBh+GKYAT9QAmLHcd1jY
 HQXfnx3YCVoKdSs6woHd6EwA+/KcHSKUnkegdceIOwhX+jI01fN5GO0N1/VLB30hHQIXbAaU
 j/OC9Y1dB9jJ3rfk5BOOQZD+SMLM2iGMF52HaYU6hMeucMnSRPLYA/YX5WK8IQPA2UEjyRe5
 AI6mlx6+KAh+HfxFOM6B0j7Q1O7PXyYM/i64wEMXaF054hCjdvikuQTl20KYnSXiZ5yAZZYX
 /1K7h0cO12fh2LiV5A9UCGBnrQ0pAF5l/7OqAKgD7lyiVhXNaaVqLtlPq1BpE9XRfjfjVGZg
 /1H9e5b1VrA1cqMH0BSQOAurCJlchCuStCmqHgApVOImDB/ovy4SRilS7nGaOLkmUclpe8Ax
 CpO4C88YFq+J6GhFAneb4+I5zV8WoZzEaSDYW1wemZ+1+i0nJTpAv3lRLrSVLtxvPFqyKtsR
 yyYFeto6Nj43sf80edEkYbI8P5dv96dWFvVmLE+HRK5hJ3cxJboQJj6+cTb8kVJ9tUVdQvbO
 yEMNvtAF3+tV+61nPxxKl3YFnPPZldaGnZJVDHhE3Lm1wi1uppZ3+ywNSDBtjELqi2q0ij8D
 8a32TQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7o7mNziDQ52qlv0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xf89O9gtDn54wmrR
 t/YSmwOvx5p5axg9dtxdwuix99sCFo9NqzrZPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH
 7psNbB59W1YxenzeJBfAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
 k5Kak1mWWqRvl6CXcWHRedaCMxIVS6adY29gPCHSxcjJISFgIvFm0S3GLkYuDiGBpYwSa3ou
 skMkZCROTmtghbCFJf5c62KDKPrEKNHx8SETSIJNwFCi6y1EQkSgk1FiWvdHsG5mgTdMEpeu
 RoDYwgJBEh3zNzKD2CwCqhKf+l6BTeUVsJN4encRM8QGeYnVGw6A2ZxA8ePd/WwgtpCArcTp
 tTOYJzDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYNduO/dy8g/HSxuBDjAIcjEo8
 vAvYXOOFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIjRFOioicxSosn5wIjO
 K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAmDvdJP6S0vKYjzHa
 az3uHZ77p50jmSmj+Nvh5S+krszRTGJZteiGmEx1QNDWchv9M1FhJssLzz5TDj+pLTvlbFYL
 Y3uzxOFcsdUv10qbVewWmG+88qGe9wWzfYrafzMO5J1szLYNb/5pefzkk2hejZs/vH/35h0K
 5H6/cqfj/G0Z75foxAk5KbEUZyQaajEXFScCAPQm8FOwAgAA
X-CMS-MailID: 20200826063536eucas1p2d9ea013228bcfbd5778959274aa01b78
X-Msg-Generator: CA
X-RootMTR: 20200826063536eucas1p2d9ea013228bcfbd5778959274aa01b78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063536eucas1p2d9ea013228bcfbd5778959274aa01b78
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063536eucas1p2d9ea013228bcfbd5778959274aa01b78@eucas1p2.samsung.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 33355dd302f1..1a6cea0e0bd7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL, 0);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e8f7b11352d2..776448c527ea 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -253,7 +253,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
 
-	for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
 
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
