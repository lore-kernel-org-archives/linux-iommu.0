Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE6C433E8
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:36:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E23F2071E
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p12AyAg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E23F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ECDF2227F8;
	Wed, 26 Aug 2020 06:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4ATzq1JTYJP; Wed, 26 Aug 2020 06:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 000E722193;
	Wed, 26 Aug 2020 06:36:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF7CCC016F;
	Wed, 26 Aug 2020 06:36:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2687BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1EFCA22193
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pFrxRMQQId2X for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:36:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 242452280C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:36:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063630euoutp021c83d2d5e71cefb96bedd81e99669526~uvfgCsQYo1443214432euoutp02h
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:36:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063630euoutp021c83d2d5e71cefb96bedd81e99669526~uvfgCsQYo1443214432euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423790;
 bh=6nzs+//cqnv2gdRh2O3oHyA1orygL5sUpA1hIU76qP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p12AyAg6QfZBkshz2a4UF8U/+p+ls+IpPh+kG1agUPw3SVV4NHdFpFXDHBiDh0VvU
 jc7NRBUZa7nF4kL/WJyYaleobadRT6snWYwuX8jYbK5fe8l+UcqOT9g/sRt/rflC2P
 rg26SAGO34gGos9Z+mj8stOklgiu6eGrnEBgdPss=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200826063630eucas1p15db3537c013f0a3a42dbef31cb90c2a9~uvffvsXqY2388623886eucas1p1C;
 Wed, 26 Aug 2020 06:36:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 67.DD.05997.EE2064F5; Wed, 26
 Aug 2020 07:36:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063629eucas1p194665c749b5a37c74e6445370fd7f7c4~uvffXj8Jx2518025180eucas1p1f;
 Wed, 26 Aug 2020 06:36:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063629eusmtrp2b08e209f1a34f92878bb1ebb1bf81fc2~uvffWwVpJ0466204662eusmtrp2g;
 Wed, 26 Aug 2020 06:36:29 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-64-5f4602ee98b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.73.06017.DE2064F5; Wed, 26
 Aug 2020 07:36:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063629eusmtip224caf2afa6c7d96d3a0fb140cf493623~uvfeqzoDj0091500915eusmtip2X;
 Wed, 26 Aug 2020 06:36:29 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 32/32] videobuf2: use sgtable-based scatterlist wrappers
Date: Wed, 26 Aug 2020 08:33:16 +0200
Message-Id: <20200826063316.23486-33-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe1BMURyec19722nNtTTOeFsymEkiOmRCg7lGjf5iGCtLVx7b1uxtezBD
 ajTaXoRhqlFMkpSttZLehbYmrUol49FjMxXKo7VTMa3dbvjvO9/3/c73/c4cGpeayLn0CVU4
 p1YplDJKTJTUj790G8F2Bq65UzsDJZsaMVR8Q0ciW8llHLX//Eqhe/efYyi72hs1x34RIUt7
 L4b05k4SvSrLpFBS0SMSFT57L0K5+t8Yujo8LkK13/pJNHphktrKsAU3CwCbEdNKsJXWbILV
 5ydQ7GNrD8l2Jxox9mHOOfbtpBlnr3TdBWz5mxiKNU8MUWyKIR+wo/qFAZID4s1BnPJEBKd2
 9zksPj7wvQaE/dwT1VrVIIoBeb5a4ERDxhNesX7HtEBMS5k8ANsqDZhDkDIWAJsfRwnCKIC6
 LCPxd6I7UScShLsADqQWTh/sE+UtCcDhohgPqB3WUg48m7kAYEOys8OEMx04TGrLJx3CLGY3
 zDD/wh2YYFyhbXJ0KlvC+MCxD32kELcI3i+qmfI42XljYiol8EMiaNPKBbwdVqQbcAHPgp+M
 BpGA50Pbk6yp5SATB2CvSagKmSQAX8XeAILLG74zTdhvpe31VkJdmbtAb4M/PtYTDhoyM2DX
 8EwHjdthWsl1XKAl8GK8VHAvh+nGB/9ia1vapuuwsPN8AiU86WUAJ8xnL4FF6f+zsgHIB3M4
 DR8SzPFrVVzkal4RwmtUwauPhobogf2XNU0aLaWg7PeROsDQQOYsyaZ2BEpJRQQfHVIHII3L
 Zkt8m5sOSSVBiujTnDo0UK1RcnwdmEcTsjmSdbeH5FImWBHOneK4ME79V8Vop7kxIPOzy0bv
 Uq+9HTVPhxbs42755bh2Lqt4FNdV0bhYXq/ZErTZ1qNO6x6L8wvv92LPSFqr3lgH+TzP3GM+
 JxuAy4s01LB0sKA/4D29b0XX6z6N1X2/Mr4xa9e1Df468w7nhZ7rq01H4jd5cKmRqW7+KZat
 S2xilZw4uP35SHnxKipTRvDHFR6rcDWv+AOsEwvIYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7pvmdziDY5MMLboPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2ONv0ht3iy5WHTBabHl9jtbi8aw6bRc+GrawWa4/cZbdY
 tukPk8WUtz/ZLQ5+eMJq8bn1H5uDgMeaeWsYPWY3XGTx2PttAYvHplWdbB7bvz1g9bjffZzJ
 Y/OSeo/b/x4ze0y+sZzRY/fNBjaPx79esnn0bVnF6PF5k1wAb5SeTVF+aUmqQkZ+cYmtUrSh
 hZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvOPBxgLvvpXXNx3gr2BcYVTFyMn
 h4SAicT97vXsXYxcHEICSxkl2p+dYoFIyEicnNbACmELS/y51sUGUfSJUWJi8yJGkASbgKFE
 11uIhIhAJ6PEtO6PYKOYBe4zS/xvmM4GUiUs4C0x+/FvZhCbRUBV4v+/z0wgNq+AncSPe4+g
 VshLrN5wAKyGEyh+vLsfrFdIwFbi9NoZzBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P
 3cQIjK9tx35u2cHY9S74EKMAB6MSD+8CNtd4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW
 5ccXleakFh9iNAU6aiKzlGhyPjD280riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YW
 pBbB9DFxcEo1MAa9S+Toruabsmf67vM3OrOSyw9svrhMTCgmf/vvtysWGLzk7Vul3pD7cNm0
 gvW3lWVDVQ8b1Yub+b34qn+j0D55e7JPEMNufuVry755/7xj9kY75gLL/uBqxpaJTpsu83wt
 VLgww9PzwZy7s6v3uQk9MDnQIfR+ddWHJtPkLq/Us7aK6TrN/5VYijMSDbWYi4oTAVbGXErF
 AgAA
X-CMS-MailID: 20200826063629eucas1p194665c749b5a37c74e6445370fd7f7c4
X-Msg-Generator: CA
X-RootMTR: 20200826063629eucas1p194665c749b5a37c74e6445370fd7f7c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063629eucas1p194665c749b5a37c74e6445370fd7f7c4
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063629eucas1p194665c749b5a37c74e6445370fd7f7c4@eucas1p1.samsung.com>
Cc: Pawel Osciak <pawel@osciak.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-media@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Daniel Vetter <daniel@ffwll.ch>,
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

Use recently introduced common wrappers operating directly on the struct
sg_table objects and scatterlist page iterators to make the code a bit
more compact, robust, easier to follow and copy/paste safe.

No functional change, because the code already properly did all the
scaterlist related calls.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 34 ++++++++-----------
 .../media/common/videobuf2/videobuf2-dma-sg.c | 32 +++++++----------
 .../common/videobuf2/videobuf2-vmalloc.c      | 12 +++----
 3 files changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index ec3446cc45b8..1b242d844dde 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -58,10 +58,10 @@ static unsigned long vb2_dc_get_contiguous_size(struct sg_table *sgt)
 	unsigned int i;
 	unsigned long size = 0;
 
-	for_each_sg(sgt->sgl, s, sgt->nents, i) {
+	for_each_sgtable_dma_sg(sgt, s, i) {
 		if (sg_dma_address(s) != expected)
 			break;
-		expected = sg_dma_address(s) + sg_dma_len(s);
+		expected += sg_dma_len(s);
 		size += sg_dma_len(s);
 	}
 	return size;
@@ -103,8 +103,7 @@ static void vb2_dc_prepare(void *buf_priv)
 	if (!sgt)
 		return;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
-			       buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 }
 
 static void vb2_dc_finish(void *buf_priv)
@@ -115,7 +114,7 @@ static void vb2_dc_finish(void *buf_priv)
 	if (!sgt)
 		return;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 }
 
 /*********************************************/
@@ -275,8 +274,8 @@ static void vb2_dc_dmabuf_ops_detach(struct dma_buf *dbuf,
 		 * memory locations do not require any explicit cache
 		 * maintenance prior or after being used by the device.
 		 */
-		dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				   attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sgt);
 	kfree(attach);
 	db_attach->priv = NULL;
@@ -301,8 +300,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
-		dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				   attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 		attach->dma_dir = DMA_NONE;
 	}
 
@@ -310,9 +309,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
 	 * mapping to the client with new direction, no cache sync
 	 * required see comment in vb2_dc_dmabuf_ops_detach()
 	 */
-	sgt->nents = dma_map_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				      dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (!sgt->nents) {
+	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC)) {
 		pr_err("failed to map scatterlist\n");
 		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
@@ -455,8 +453,8 @@ static void vb2_dc_put_userptr(void *buf_priv)
 		 * No need to sync to CPU, it's already synced to the CPU
 		 * since the finish() memop will have been called before this.
 		 */
-		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 		pages = frame_vector_pages(buf->vec);
 		/* sgt should exist only if vector contains pages... */
 		BUG_ON(IS_ERR(pages));
@@ -553,9 +551,8 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	 * No need to sync to the device, this will happen later when the
 	 * prepare() memop is called.
 	 */
-	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (sgt->nents <= 0) {
+	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC)) {
 		pr_err("failed to map scatterlist\n");
 		ret = -EIO;
 		goto fail_sgt_init;
@@ -577,8 +574,7 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	return buf;
 
 fail_map_sg:
-	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 
 fail_sgt_init:
 	sg_free_table(sgt);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 0a40e00f0d7e..0dd3b19025e0 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -148,9 +148,8 @@ static void *vb2_dma_sg_alloc(struct device *dev, unsigned long dma_attrs,
 	 * No need to sync to the device, this will happen later when the
 	 * prepare() memop is called.
 	 */
-	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (!sgt->nents)
+	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC))
 		goto fail_map;
 
 	buf->handler.refcount = &buf->refcount;
@@ -186,8 +185,8 @@ static void vb2_dma_sg_put(void *buf_priv)
 	if (refcount_dec_and_test(&buf->refcount)) {
 		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
 			buf->num_pages);
-		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 		if (buf->vaddr)
 			vm_unmap_ram(buf->vaddr, buf->num_pages);
 		sg_free_table(buf->dma_sgt);
@@ -204,8 +203,7 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
-			       buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 }
 
 static void vb2_dma_sg_finish(void *buf_priv)
@@ -213,7 +211,7 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 }
 
 static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
@@ -256,9 +254,8 @@ static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
 	 * No need to sync to the device, this will happen later when the
 	 * prepare() memop is called.
 	 */
-	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (!sgt->nents)
+	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC))
 		goto userptr_fail_map;
 
 	return buf;
@@ -284,8 +281,7 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
 
 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
 	       __func__, buf->num_pages);
-	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir,
-			   DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (buf->vaddr)
 		vm_unmap_ram(buf->vaddr, buf->num_pages);
 	sg_free_table(buf->dma_sgt);
@@ -408,8 +404,7 @@ static void vb2_dma_sg_dmabuf_ops_detach(struct dma_buf *dbuf,
 
 	/* release the scatterlist cache */
 	if (attach->dma_dir != DMA_NONE)
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
 	sg_free_table(sgt);
 	kfree(attach);
 	db_attach->priv = NULL;
@@ -434,15 +429,12 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
 		attach->dma_dir = DMA_NONE;
 	}
 
 	/* mapping to the client with new direction */
-	sgt->nents = dma_map_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				dma_dir);
-	if (!sgt->nents) {
+	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
 		pr_err("failed to map scatterlist\n");
 		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index c66fda4a65e4..bf5ac63a5742 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -229,7 +229,7 @@ static int vb2_vmalloc_dmabuf_ops_attach(struct dma_buf *dbuf,
 		kfree(attach);
 		return ret;
 	}
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+	for_each_sgtable_sg(sgt, sg, i) {
 		struct page *page = vmalloc_to_page(vaddr);
 
 		if (!page) {
@@ -259,8 +259,7 @@ static void vb2_vmalloc_dmabuf_ops_detach(struct dma_buf *dbuf,
 
 	/* release the scatterlist cache */
 	if (attach->dma_dir != DMA_NONE)
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
 	sg_free_table(sgt);
 	kfree(attach);
 	db_attach->priv = NULL;
@@ -285,15 +284,12 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
 		attach->dma_dir = DMA_NONE;
 	}
 
 	/* mapping to the client with new direction */
-	sgt->nents = dma_map_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				dma_dir);
-	if (!sgt->nents) {
+	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
 		pr_err("failed to map scatterlist\n");
 		mutex_unlock(lock);
 		return ERR_PTR(-EIO);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
