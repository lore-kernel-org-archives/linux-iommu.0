Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF1C8300A
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720EC20787
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AqPnu5re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720EC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6525A870B3;
	Tue, 28 Apr 2020 13:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6HhahszOKEC; Tue, 28 Apr 2020 13:21:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4413887120;
	Tue, 28 Apr 2020 13:21:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 212D8C0172;
	Tue, 28 Apr 2020 13:21:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84DA4C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 118A6880F5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFb-mvKc80rJ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:21:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7758288196
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132030euoutp01913fdb9d21d151b1723c54f4f5e04ff3~J-l_oHy5S2027120271euoutp01R
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200428132030euoutp01913fdb9d21d151b1723c54f4f5e04ff3~J-l_oHy5S2027120271euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080030;
 bh=0NzO7ssURWc2wlUQIUDfAcRGvfVCN08n+4uz3K6mlUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AqPnu5re/mHzBomo6/eHb0iwmOJ0rv3CZng9aw93PCHxLz4Bb9RWAGyn+U723Z+Bd
 g03MM/qAGXCbWZomCu8+ub4H2+MuXkgHIDx/4ZreTLDpnsplWYLtctcM2quZ6/ScKj
 W/5LCMNLofKsSjLL1al5zhhimI9/4JKhlXHO1gq8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200428132030eucas1p145b6690ab076cb1d8bcd6ffae95c5ca9~J-l_PKbA03051530515eucas1p1S;
 Tue, 28 Apr 2020 13:20:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.26.60698.D9D28AE5; Tue, 28
 Apr 2020 14:20:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132029eucas1p2433959853ef384ef783cbe9a1e45fde3~J-l918pCb2651026510eucas1p2S;
 Tue, 28 Apr 2020 13:20:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200428132029eusmtrp2adf8545534f5892ecf53e400e6022bee~J-l91PXzR2140321403eusmtrp2P;
 Tue, 28 Apr 2020 13:20:29 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-8f-5ea82d9dfd5c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.E3.07950.D9D28AE5; Tue, 28
 Apr 2020 14:20:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132028eusmtip2b44644ae4720ed3e765aad715106ddc1~J-l9LaKkD0625706257eusmtip2M;
 Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 12/17] drm: tegra: fix sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:20:00 +0200
Message-Id: <20200428132005.21424-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGc2famSlSHAsJN6AQK5JgAkgwYSJINDFkfFDkxQcTwQpjWQtp
 KYgJAXEB2QIuAVkElaWWIktJQXCBsmNsZAmbFGTTICAgW1ADth3Et+/8/3/uOTm5BCrQcm2I
 EEk0I5WIwoWYGUfTsaVzLnRW+B9XF3lQGbpuhCqtuoVTNblVXCpJ24NRO5pslBpYX8KolxXt
 CJWfpUao4vee1NrAJELVTg9yqf7GAoyqbNPjVMvyDJfq0a/ip/fTqqcqQL/dKObQY4NvMLp+
 4wuXnkjrRGh1SQL9eXsapR8OlwO6aSQRozPrlIBerbW7uO+ymVcQEx4Sw0hdva+aBT/pHUOi
 hpxu7PQqsUTQcTgV8AhInoCZ1c1YKjAjBKQCwK2uZyhbrAFY/vXRrrMKYFnGD86/FpV2nsMa
 5QCmT+Xiey01S3rMmMJIN5i6mGpiK/IugF0Z5sYQSmpQOFPehhsNS/IcvJ+2YmIOeRT+VnSb
 mE96Q3XJLMqOs4cV1c0m5hn00qlZ006Q7MPh1LIKYUNnYX5pIZdlS/i9sw5n+SDceV2EsA23
 AZzUVeJskQ5gf1IuYFOecEz3y/AsYdjPCVY1urLyGVjYVoMaZUhawOHFA0YZNeADTc6uzIcp
 9wRs2hHmdb7aG9vyqW93fxqWaFcQ9kLZACqnu0AWsM/7P6wYACWwZuSyCDEjc5cwsS4yUYRM
 LhG7BEZG1ALDz/qw3bneAN79uaYFJAGE5vxqc4W/gCuKkcVFaAEkUKEVfyq4zF/ADxLF3WSk
 kQFSeTgj0wJbgiO05rs/n7siIMWiaCaMYaIY6T8XIXg2iWDYId7mQmaYuV5+MjlWHHeJ9r7z
 sSttVJjnZd+U5rBQ4atkfOUW3144/XTk1wfP58j91kOaQ1vx8fFDAY+Hwib8PUZ4UUd0tpML
 oZYpqoJ4nqfFZuCQT6tYMbrZ7DMn0secGr3eYJdAtdfwwofXK0olPcnnB/x6pWvTsS4bqyoh
 RxYscjuGSmWiv3iau05VAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pzdVfEGfzcI23Re+4kk8XS9Y3s
 FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
 9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
 k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQyZl68w1RwXbPi/8VVbA2MxxS7GDk5JARMJNYces3SxcjFISSw
 lFHi0KfvbBAJGYmT0xpYIWxhiT/Xutggij4xSuyffpsZJMEmYCjR9RYiISLQySgxrfsjO4jD
 LHCAWaL7/EkmkCphAU+JTrAEJweLgKrE7xUnwWxeATuJzUueMkOskJdYveEAmM0JFF/66CnQ
 VA6gdbYSl1tyJzDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYP9uO/dyyg7HrXfAh
 RgEORiUe3g08K+KEWBPLiitzDzFKcDArifA+ylgWJ8SbklhZlVqUH19UmpNafIjRFOimicxS
 osn5wNjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKPOw2OhW
 o3xA6/rJnS8DjM8nWxhq7baRaFhlENb35/7FjRyFYmGdMy9xyc910p+f/ezz7sC4q8G3Lk5j
 +nM290Zsv+XvwyvrlqlGuqS9bU+JN5Wq9LLiP8wmK31x0xOv5y9Dnfb+9HwVGGfAYTf7sBqb
 9gm59N3X9tuvkvnNxem7u8Ho3bN0JZbijERDLeai4kQAfeCBeLUCAAA=
X-CMS-MailID: 20200428132029eucas1p2433959853ef384ef783cbe9a1e45fde3
X-Msg-Generator: CA
X-RootMTR: 20200428132029eucas1p2433959853ef384ef783cbe9a1e45fde3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132029eucas1p2433959853ef384ef783cbe9a1e45fde3
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132029eucas1p2433959853ef384ef783cbe9a1e45fde3@eucas1p2.samsung.com>
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
 drivers/gpu/drm/tegra/gem.c   | 25 +++++++++++++------------
 drivers/gpu/drm/tegra/plane.c | 13 +++++++------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 6237681..5710ab4 100644
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
@@ -197,7 +197,7 @@ static int tegra_bo_iommu_map(struct tegra_drm *tegra, struct tegra_bo *bo)
 	bo->iova = bo->mm->start;
 
 	bo->size = iommu_map_sg(tegra->domain, bo->iova, bo->sgt->sgl,
-				bo->sgt->nents, prot);
+				bo->sgt->orig_nents, prot);
 	if (!bo->size) {
 		dev_err(tegra->drm->dev, "failed to map buffer\n");
 		err = -ENOMEM;
@@ -264,7 +264,7 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
 static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 {
 	if (bo->pages) {
-		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
+		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->orig_nents,
 			     DMA_FROM_DEVICE);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
@@ -290,9 +290,9 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 		goto put_pages;
 	}
 
-	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			 DMA_FROM_DEVICE);
-	if (err == 0) {
+	bo->sgt->nents = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->orig_nents,
+				DMA_FROM_DEVICE);
+	if (bo->sgt->nents == 0) {
 		err = -EFAULT;
 		goto free_sgt;
 	}
@@ -571,7 +571,8 @@ int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma)
 			goto free;
 	}
 
-	if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+	sgt->nents = dma_map_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
+	if (sgt->nents == 0)
 		goto free;
 
 	return sgt;
@@ -590,7 +591,7 @@ static void tegra_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	struct tegra_bo *bo = to_tegra_bo(gem);
 
 	if (bo->pages)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
 
 	sg_free_table(sgt);
 	kfree(sgt);
@@ -609,7 +610,7 @@ static int tegra_gem_prime_begin_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_cpu(drm->dev, bo->sgt->sgl, bo->sgt->nents,
+		dma_sync_sg_for_cpu(drm->dev, bo->sgt->sgl, bo->sgt->orig_nents,
 				    DMA_FROM_DEVICE);
 
 	return 0;
@@ -623,8 +624,8 @@ static int tegra_gem_prime_end_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sg_for_device(drm->dev, bo->sgt->sgl,
+				       bo->sgt->orig_nents, DMA_TO_DEVICE);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 9ccfb56..3982bf8 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -130,9 +130,10 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		}
 
 		if (sgt) {
-			err = dma_map_sg(dc->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (err == 0) {
+			sgt->nents = dma_map_sg(dc->dev, sgt->sgl,
+						sgt->orig_nents,
+						DMA_TO_DEVICE);
+			if (sgt->nents == 0) {
 				err = -ENOMEM;
 				goto unpin;
 			}
@@ -143,7 +144,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 			 * map its SG table to a single contiguous chunk of
 			 * I/O virtual memory.
 			 */
-			if (err > 1) {
+			if (sgt->nents > 1) {
 				err = -EINVAL;
 				goto unpin;
 			}
@@ -165,7 +166,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
+			dma_unmap_sg(dc->dev, sgt->sgl, sgt->orig_nents,
 				     DMA_TO_DEVICE);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
@@ -185,7 +186,7 @@ static void tegra_dc_unpin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
+			dma_unmap_sg(dc->dev, sgt->sgl, sgt->orig_nents,
 				     DMA_TO_DEVICE);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
