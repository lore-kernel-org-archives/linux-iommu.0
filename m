Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D447C2D0E3
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568C21582
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="irpJt6rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3568C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 19B5586D7B;
	Fri,  4 Sep 2020 13:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4f-M75PNmOT1; Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EEEF786DF0;
	Fri,  4 Sep 2020 13:35:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91CD2C0893;
	Fri,  4 Sep 2020 13:35:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C41FC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5BFF386D72
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZRMzUhMvsEp for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5735786D46
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133504euoutp0195b09775457004262afe7a801eeba245~xmAh6tt1V0721507215euoutp01j
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133504euoutp0195b09775457004262afe7a801eeba245~xmAh6tt1V0721507215euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226504;
 bh=6mXoG5G9PW5+boUAHHItjwrf4VrXlD4+aWxl8BX4EFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=irpJt6rvcnjqUgQZaO88fr8b+ScYrYeuFZi/s5KBROzokTkuXXnXYS5ECdmj6xwwH
 HU1LLO4GDGVuR9ZVZ8w/xICirBtEuoXF2Rfl6iEJvhcWOb86MbmDdX/LrmuhkVdDiG
 zTRQu2xD6lnL1wpnOXgUvK97iII78FJLFxdVO1T8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200904133504eucas1p1147c9da883b8213540141300a31313ad~xmAhjzxmV0114501145eucas1p1u;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.66.05997.882425F5; Fri,  4
 Sep 2020 14:35:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133504eucas1p12ddfe8e0904a750bfe21f964821cb832~xmAhQs7X01134411344eucas1p1R;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133504eusmtrp1ce7f9eda04fb52c97d36192787872ba4~xmAhQAnMy0766507665eusmtrp1A;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-69-5f5242887000
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.BE.06314.782425F5; Fri,  4
 Sep 2020 14:35:04 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133503eusmtip157f60648e81dc5a72c6e8a9c62ca8c80~xmAglfis_1624216242eusmtip1q;
 Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 17/30] drm: tegra: fix common struct sg_table related
 issues
Date: Fri,  4 Sep 2020 15:16:58 +0200
Message-Id: <20200904131711.12950-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTYRTGe3d3tztxcp2GL7OSVhoKbppBlwwrE7pBhIxMCFKXXlTyi121
 9B9FU3RqZILNZaKWzfxMM7Op5KycNhtzWmkm5UdJH1a0pfmRtnnV/vud5zyH85yXF0MEWlSI
 xSYkU/IEWZyIY8du71s0eOcFSsN9evtdiSLDAItoUTajxFp7MUKM/P7BIe7VP2cRlU/8iSuq
 ajZhGZlkEa3Tr1FiWFPOIfItKg7R+GyCS2h/zqDEoqaCfdSBbKhoAGT3fCWbfKya4JKP5j+g
 5PsCHYt8cCeDHF+dRsiSUTUgO8cyOWRR9ncOebWtDpDm1l3B9ufsDkdRcbGplFwSEGEXU9pa
 jiZpfC6vNXdzM4FynwLwMIgfgFp1DlsB7DABXgtg/q1XXKawAPh1UAeYwgxgtbmKuzlSYZlC
 mIYawPG6j8jWiNF0m2VzcXBfqJhTcGzsjOcA2F9kbzMheCECe0oXgK3hhEthoVmP2JiNu8M8
 gxG1MR8PgHdNgwizzg3W3+9ZZ55Vf6icQRndxIX9ZQcZDoKKpTwWw07wi65tI+oOqC8pXL8O
 4tkAThoauUxRCOBwlhIwLn/4zrBkjYpZ43nCZo2EkY/Bto5FYJMh7gBH5xxtMmLF6+03EEbm
 w7xcAeP2gCpd09ZardG0EZ+EfbVqlHmgYgBLa6e414Cb6v+ySgDqgAuVQsdHU/T+BOqSmJbF
 0ykJ0eLIxPhWYP1Y+lWdpQNoVi70AhwDInv+tiPScAEqS6XT4nsBxBCRMz/wpT5MwI+SpaVT
 8sRweUocRfcCV4wtcuH7VX8+L8CjZcnURYpKouSbXRbGE2aCxvrjXgtvco2z7sahZUVTyy8p
 +W0sK7jyULlnjbRMslu850RUOxnqyDu57HfKqzM9VRypd9cJ3XaeqXkRG7Q2aBpY+6vUBj0N
 das3sEJmTvNoY+m4t+VT5k3BWY+KoeLxMKWE3i4Mini7MtvV9cc9QjUSUFZQFTI65G2/V5uV
 IWLTMTJfL0ROy/4BssApWlQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7odTkHxBqcuMVn0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbtMxaxGLx5cpDJotNj6+xWlzeNYfNovPLLDaLtUfuslsc
 /PCE1eLnrnksDnwea+atYfTY+20Bi8fOWXfZPbZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH
 7psNbB69ze/YPPq2rGL0+LxJLoAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
 yFRJ384mJTUnsyy1SN8uQS9j2qY5rAW7DCr+r9/L3sA4Q72LkZNDQsBEYt6XR8xdjFwcQgJL
 GSXmrWpmhUjISJyc1gBlC0v8udbFBmILCXxilHhwpBLEZhMwlOh6CxLn4hAR6GSUmNb9kR3E
 YRaYwiwx9X4DI0iVsECAxLQzM8AmsQioSnScuwBm8wrYSSy7dIYZYoO8xOoNB8BsTqD41hlP
 WCG22Up8mLOYZQIj3wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiB8bPt2M/NOxgvbQw+
 xCjAwajEw8tgHxQvxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkBHTWSW
 Ek3OB8Z2Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxpKXX14p
 7b2Xd1f5Wu2TFexT9xr//SV6sjvn2ZR4vqjkC891fT1m8N76/jim/PDJvfm3ZNsLLWpmmxW+
 0YyxvLlvVQ5zVbPD8mUdD7lS2ALufd21rDk2g78uWa3D+KGvXEjAhmcSjtaOxu8D4m6a3uXk
 iZcQuTIt9N5y/h7F7pQZMYuSdUs9lViKMxINtZiLihMBo67HBLUCAAA=
X-CMS-MailID: 20200904133504eucas1p12ddfe8e0904a750bfe21f964821cb832
X-Msg-Generator: CA
X-RootMTR: 20200904133504eucas1p12ddfe8e0904a750bfe21f964821cb832
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133504eucas1p12ddfe8e0904a750bfe21f964821cb832
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133504eucas1p12ddfe8e0904a750bfe21f964821cb832@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/tegra/gem.c   | 27 ++++++++++-----------------
 drivers/gpu/drm/tegra/plane.c | 15 +++++----------
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 723df142a981..01d94befab11 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -98,8 +98,8 @@ static struct sg_table *tegra_bo_pin(struct device *dev, struct host1x_bo *bo,
 		 * the SG table needs to be copied to avoid overwriting any
 		 * other potential users of the original SG table.
 		 */
-		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl, obj->sgt->nents,
-					     GFP_KERNEL);
+		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl,
+					     obj->sgt->orig_nents, GFP_KERNEL);
 		if (err < 0)
 			goto free;
 	} else {
@@ -196,8 +196,7 @@ static int tegra_bo_iommu_map(struct tegra_drm *tegra, struct tegra_bo *bo)
 
 	bo->iova = bo->mm->start;
 
-	bo->size = iommu_map_sg(tegra->domain, bo->iova, bo->sgt->sgl,
-				bo->sgt->nents, prot);
+	bo->size = iommu_map_sgtable(tegra->domain, bo->iova, bo->sgt, prot);
 	if (!bo->size) {
 		dev_err(tegra->drm->dev, "failed to map buffer\n");
 		err = -ENOMEM;
@@ -264,8 +263,7 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
 static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 {
 	if (bo->pages) {
-		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			     DMA_FROM_DEVICE);
+		dma_unmap_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
@@ -290,12 +288,9 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 		goto put_pages;
 	}
 
-	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			 DMA_FROM_DEVICE);
-	if (err == 0) {
-		err = -EFAULT;
+	err = dma_map_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
+	if (err)
 		goto free_sgt;
-	}
 
 	return 0;
 
@@ -571,7 +566,7 @@ tegra_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 			goto free;
 	}
 
-	if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+	if (dma_map_sgtable(attach->dev, sgt, dir, 0))
 		goto free;
 
 	return sgt;
@@ -590,7 +585,7 @@ static void tegra_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	struct tegra_bo *bo = to_tegra_bo(gem);
 
 	if (bo->pages)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 
 	sg_free_table(sgt);
 	kfree(sgt);
@@ -609,8 +604,7 @@ static int tegra_gem_prime_begin_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_cpu(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-				    DMA_FROM_DEVICE);
+		dma_sync_sgtable_for_cpu(drm->dev, bo->sgt, DMA_FROM_DEVICE);
 
 	return 0;
 }
@@ -623,8 +617,7 @@ static int tegra_gem_prime_end_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(drm->dev, bo->sgt, DMA_TO_DEVICE);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 4cd0461cc508..539d14935728 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -131,12 +131,9 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		}
 
 		if (sgt) {
-			err = dma_map_sg(dc->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (err == 0) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
+			if (err)
 				goto unpin;
-			}
 
 			/*
 			 * The display controller needs contiguous memory, so
@@ -144,7 +141,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 			 * map its SG table to a single contiguous chunk of
 			 * I/O virtual memory.
 			 */
-			if (err > 1) {
+			if (sgt->nents > 1) {
 				err = -EINVAL;
 				goto unpin;
 			}
@@ -166,8 +163,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
-				     DMA_TO_DEVICE);
+			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
 		state->iova[i] = DMA_MAPPING_ERROR;
@@ -186,8 +182,7 @@ static void tegra_dc_unpin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
-				     DMA_TO_DEVICE);
+			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
 		state->iova[i] = DMA_MAPPING_ERROR;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
