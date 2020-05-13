Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C9C2D0FC
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D67F20885
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BnwkevTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D67F20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 47CDC86657;
	Wed, 13 May 2020 13:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xv4+gUAFXBe; Wed, 13 May 2020 13:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5EB61864B8;
	Wed, 13 May 2020 13:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF96C0178;
	Wed, 13 May 2020 13:34:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F50FC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F059F221C6
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrZl4vtrHkfT for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:34:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 9216D20488
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:27 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133326euoutp02862c662727dbcdb49a26af8baf0cc618~OmcjLrRWB3219432194euoutp02V
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133326euoutp02862c662727dbcdb49a26af8baf0cc618~OmcjLrRWB3219432194euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376806;
 bh=Utl3zZDmykdZNyu6dAm8fTuaeGY3h535BeMF/H0qJaQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BnwkevTTq6gNd8KZ67iTQwImTtX4ZKeHcn9m1Ps+TW+tE9hdsSw9JWsErSdLWvXfp
 PHbwSDMCISHBPTm8r4HnwHsrFPDIp+wOxf+QlZjUaEIyqKG4nsAuKvpKpKE7zWe3Kh
 GX+mTz/MTQc8prse8TGyjmCIaSinUePhsPhv8/IM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133325eucas1p16a0d8a2b6db49bfbbcb8114295e3fc17~OmcizHp0R0608106081eucas1p1Q;
 Wed, 13 May 2020 13:33:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 2B.11.60679.527FBBE5; Wed, 13
 May 2020 14:33:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133325eucas1p1c8faf557b23b5d171b7c328eca5f6482~Omciakj5y0784607846eucas1p1I;
 Wed, 13 May 2020 13:33:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133325eusmtrp1e4f940dd4a4d1413d24c15726e0540f7~OmciZnsBq1050710507eusmtrp1e;
 Wed, 13 May 2020 13:33:25 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-7e-5ebbf72576ce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.57.07950.527FBBE5; Wed, 13
 May 2020 14:33:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133324eusmtip1b7de34a68017f5899adbdae6b9962816~OmchmXAM00741507415eusmtip1s;
 Wed, 13 May 2020 13:33:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 38/38] videobuf2: use sgtable-based scatterlist wrappers
Date: Wed, 13 May 2020 15:32:45 +0200
Message-Id: <20200513133245.6408-38-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0gUURTHuzOzM6O4Na5CN42iBYOCNFPimha9GSpCgvoQaW05rZK7yo5a
 1ocWRXPXLewBiYWZRJqv1fWRaWrqppWP8pFmru8s1toerFppWDvOVt9+53/+/3MOl0vjshaJ
 Fx2ljuM0akW0nHQlqlp+dm7w+V4bvrGrbj263PkcQ2WZRgn6XXUVR70zX0j0oPAphnIaglFH
 0icKTfeOYcg00SdBPTW3SWQorZSgYvMQhe6bfmHohu0nhRq/vpNsX8YWZRcBtm42h2BNBTqS
 fTg7KmFH0lsxtvzeRXZwYQJnr7/JA2ztgJZkJ+asJHulogCwdtOqULejriERXHRUAqfx23bC
 NfLu8DwVO3jo3KVbVokWWHbrgQsNmUDY/XiY0gNXWsbkA5j90UyKxTSAXdkdzo4dQHvVZ/xv
 ZHxiyOnKA3AktxIIjcXIiyxMYJLxh3qbnhTYk0kB8NllNyGAM2U4bBkxLk7yYPbD7PmvhMAE
 4wO7S4oogaXMVtjzJdm5bTUsLH2yyC4OfcrSQAiDINNHwUFbKiGadsO2hVxKZA841Vrh5JWw
 7brBGUgGcKyzmBILA4A9SZlAdAVDS+ec41bacd86aKzxE+UdsL/dTAgyZJbCNzZ3QcYdeK3q
 Ji7KUpiWKhPda2FWa8m/tY2vup33s/BH3jwmvlYzgMU940QGWJ31f1kOAAVgORfPq5Qcv0nN
 nfXlFSo+Xq30PRWjMgHH72pbaJ2uBjW/TjYBhgZyNyl6WxsukygS+ERVE4A0LveUHjQ6JGmE
 IvE8p4k5romP5vgm4E0T8uXSgFxrmIxRKuK4MxwXy2n+djHaxUsL9BdMRn+0q31Nsy6fSZ+D
 327ltYeVB/s0z/jvsYY1TnJdcan90vrkl/t0o7rJY9TrvvA7Ge8fKUNnT38IsiyBZcNH+C1B
 KScOXKk1bBvbl5gxEJm2eQWWZnGvzwzJz79UYg6oTn9YEOh9OHQ8San16N9ZTlu8bS72I4Fn
 gpi9qXKCj1T4r8c1vOIPe7I8r1kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7qq33fHGdw9x2/Re+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9tcbbpDbvFlysPmSw2Pb7GanF51xw2i54NW1kt1h65y26x
 bNMfJospb3+yWxz88ITVgd9jzbw1jB57vy1g8di0qpPNY/u3B6we97uPM3lsXlLvcfvfY2aP
 yTeWM3rsvtnA5vH410s2j74tqxg9Pm+SC+CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
 MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYeO83e8HtoIr22S9ZGxjvuHQxcnJICJhIPHp8l62L
 kYtDSGApo8Tkw8+ZIRIyEienNbBC2MISf651QRV9YpR43/qcCSTBJmAo0fUWIiEi0MkoMa37
 IzuIwyywm1li3eE9YO3CAt4S835/YAGxWQRUJS6tW8MOYvMK2Epcft8MtU5eYvWGA2A2J1D8
 1Z39YPVCAvkSexfvY5vAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCxtO/Zzyw7G
 rnfBhxgFOBiVeHgtbu2OE2JNLCuuzD3EKMHBrCTC67ceKMSbklhZlVqUH19UmpNafIjRFOio
 icxSosn5wDjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWCS0
 /46FmXfv4VmNrY7FKzI2a+yU4OCJue4yr2PzRa1L2k5Svvb75D59LH1lMu/a89iXF75vezrj
 Uvzq2t4J+RusFezDOaK52G6YliR8Lr7f8cjN1qZTb/OsKtswu4oJcVtzbqRwXr69rpx1jXS8
 XTZfSEOhhudM1VTZg32r+Z7NmCg56XauEktxRqKhFnNRcSIA5BMrEbsCAAA=
X-CMS-MailID: 20200513133325eucas1p1c8faf557b23b5d171b7c328eca5f6482
X-Msg-Generator: CA
X-RootMTR: 20200513133325eucas1p1c8faf557b23b5d171b7c328eca5f6482
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133325eucas1p1c8faf557b23b5d171b7c328eca5f6482
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133325eucas1p1c8faf557b23b5d171b7c328eca5f6482@eucas1p1.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 .../media/common/videobuf2/videobuf2-dma-contig.c  | 41 ++++++++++------------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 32 +++++++----------
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 12 +++----
 3 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index d3a3ee5..bf31a9d 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -48,16 +48,15 @@ struct vb2_dc_buf {
 
 static unsigned long vb2_dc_get_contiguous_size(struct sg_table *sgt)
 {
-	struct scatterlist *s;
 	dma_addr_t expected = sg_dma_address(sgt->sgl);
-	unsigned int i;
+	struct sg_dma_page_iter dma_iter;
 	unsigned long size = 0;
 
-	for_each_sg(sgt->sgl, s, sgt->nents, i) {
-		if (sg_dma_address(s) != expected)
+	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+		if (sg_page_iter_dma_address(&dma_iter) != expected)
 			break;
-		expected = sg_dma_address(s) + sg_dma_len(s);
-		size += sg_dma_len(s);
+		expected += PAGE_SIZE;
+		size += PAGE_SIZE;
 	}
 	return size;
 }
@@ -99,8 +98,7 @@ static void vb2_dc_prepare(void *buf_priv)
 	if (!sgt || buf->db_attach)
 		return;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
-			       buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 }
 
 static void vb2_dc_finish(void *buf_priv)
@@ -112,7 +110,7 @@ static void vb2_dc_finish(void *buf_priv)
 	if (!sgt || buf->db_attach)
 		return;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 }
 
 /*********************************************/
@@ -273,8 +271,8 @@ static void vb2_dc_dmabuf_ops_detach(struct dma_buf *dbuf,
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
@@ -299,8 +297,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
-		dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
-				   attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 		attach->dma_dir = DMA_NONE;
 	}
 
@@ -308,9 +306,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
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
@@ -423,8 +420,8 @@ static void vb2_dc_put_userptr(void *buf_priv)
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
@@ -521,9 +518,8 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
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
@@ -545,8 +541,7 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	return buf;
 
 fail_map_sg:
-	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 
 fail_sgt_init:
 	sg_free_table(sgt);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 92072a0..6ddf953 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -142,9 +142,8 @@ static void *vb2_dma_sg_alloc(struct device *dev, unsigned long dma_attrs,
 	 * No need to sync to the device, this will happen later when the
 	 * prepare() memop is called.
 	 */
-	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (!sgt->nents)
+	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC)) {
 		goto fail_map;
 
 	buf->handler.refcount = &buf->refcount;
@@ -180,8 +179,8 @@ static void vb2_dma_sg_put(void *buf_priv)
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
@@ -202,8 +201,7 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	if (buf->db_attach)
 		return;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
-			       buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 }
 
 static void vb2_dma_sg_finish(void *buf_priv)
@@ -215,7 +213,7 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	if (buf->db_attach)
 		return;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 }
 
 static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
@@ -258,9 +256,8 @@ static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
 	 * No need to sync to the device, this will happen later when the
 	 * prepare() memop is called.
 	 */
-	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (!sgt->nents)
+	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
+			    DMA_ATTR_SKIP_CPU_SYNC)) {
 		goto userptr_fail_map;
 
 	return buf;
@@ -286,8 +283,7 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
 
 	dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
 	       __func__, buf->num_pages);
-	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir,
-			   DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (buf->vaddr)
 		vm_unmap_ram(buf->vaddr, buf->num_pages);
 	sg_free_table(buf->dma_sgt);
@@ -410,8 +406,7 @@ static void vb2_dma_sg_dmabuf_ops_detach(struct dma_buf *dbuf,
 
 	/* release the scatterlist cache */
 	if (attach->dma_dir != DMA_NONE)
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir);
 	sg_free_table(sgt);
 	kfree(attach);
 	db_attach->priv = NULL;
@@ -436,15 +431,12 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
 
 	/* release any previous cache */
 	if (attach->dma_dir != DMA_NONE) {
-		dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
-			attach->dma_dir);
+		dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir);
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
index c66fda4..bf5ac63 100644
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
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
