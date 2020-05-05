Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E0C4725B
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA68B206B9
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hL5JSfDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA68B206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9B28B88616;
	Tue,  5 May 2020 08:46:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLhfOp8whwu0; Tue,  5 May 2020 08:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF7ED885DB;
	Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B740AC0893;
	Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88A37C088C
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 74EC787DE2
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rjkc1bh2qcRj for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 241F287DE4
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:36 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084633euoutp026f1487e8e046c56c367740368e066f14~MFXyzhjIB2638126381euoutp02Q
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200505084633euoutp026f1487e8e046c56c367740368e066f14~MFXyzhjIB2638126381euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668393;
 bh=XbOrFi14wZnLLR+D8IQye6yZyzXRz7ibxgFZt2Xt8y8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hL5JSfDcU+DCHzbwlON4/36WnmwtQhza0RHC2bCgARLmMp2RhZKAc+e0zyqjiP/1E
 glBuz9elbxgLBS8EGLKEhcrp4Y+FSuHU0sajYwt75ne7L1JIXLr4BuzKlG3L/6GC8D
 ab7TDZY/PRhoDjK8/5gupLnJe/5NTLLCa0/oEedE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084633eucas1p1bef72d98018191e2ab095d6b5cde6d45~MFXyiloBc0600906009eucas1p1M;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.CF.61286.9E721BE5; Tue,  5
 May 2020 09:46:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200505084633eucas1p26a6a3f44c64955aadec834bed027e522~MFXyIHf071949019490eucas1p2L;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084633eusmtrp153afdf239488ef4df2fa03d0ecbc82de~MFXyHcV0-0942309423eusmtrp1f;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ad-5eb127e955d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.21.07950.9E721BE5; Tue,  5
 May 2020 09:46:33 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084632eusmtip1c357efec5cd7eb62ab62b23c5f3547be~MFXxkQbKo0309503095eusmtip1v;
 Tue,  5 May 2020 08:46:32 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/25] xen: gntdev: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:46:05 +0200
Message-Id: <20200505084614.30424-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURTldZYODcWxgrwgkaRECSqb+jEJ2GD0YyLRoPHDmIiMMkEjBdIC
 ikvEBaIFZNOACEioAVlqWWohKCrVUhFlKQVBKC5IEAxr2dxQygD+nXuWe5KbSyAiPeZMnI6I
 ZmURTLgYF6Daxh+tnsPulcE+qbWuVEpLE4+qzFZjVHtWAkr91aYjlGlmHKdKyvQ8quC5H5Xb
 s52aNn3mUVUDXRjVUZeLU6pXZj7VMPEVo+Y0mbwAe7o8vxzQ9bMFKF0z+wmjPyYZeHT1g8t0
 78IAQmd2FwP65YQJpZ/0xOP05OAHlL6lKQW0WtOJ0paqjUHCowL/UDb8dCwr85aECE615+l5
 UWrROa26C48HqWsUwJaA5E5YfuUNogACQkQ+BNCiKALcMA1gWpuBxw0WAJvfTyErkeqnv5eF
 YgA7u77xVyOD34eWXDjpCxWjCtyKHcgEAF+n2FlNCJmEwDuqUswqrCMPwbrmjKUASm6Cpg71
 4lqCEJISqGty59pcYVnFiyWL7SI9YOzDrXsg+YEPvwzOAc60F9akf8E4vA6OGDR8DrvA5sxk
 lAtcA/Bzi4rPDckAdlzNXk77wb6Wn7i1GSE9oLrOm6N3w6HEEtRKQ9Iedo+utdLIIszQZiEc
 LYQ3EkWcezPMMTxarW1oMy5fi4Zz983LB9YDaB7rw9OAa87/sgIASoETGyOXhrFy3wj2rJec
 kcpjIsK8TkZKq8DiczUvGKZqwYzxhA6QBBDbCY9Y1MEijImVx0l1ABKI2EFYNF8RLBKGMnHn
 WVnkcVlMOCvXgQ0EKnYS7igcPiYiw5ho9gzLRrGyFZVH2DrHA9U0dbtB6WPcpWMMtN/44W+X
 kEmNW1D69fz9IaFO2/r3MWZHlxcFgSmF0sB+F0wY4GbpmdQGNSkl4+7nplz9I3uJxnLil/n7
 26E5paDeJBiR5j0btgF3AySJ7xoSlZ7zDhcvCu7taT24fupPhY3DyGOPm3GOW7N9L1SMHbiA
 8MWo/BTjuwWRyZl/hn1cLlgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7ov1TfGGTxYz27Re+4kk8XGGetZ
 LS5Ob2Wx+L9tIrPFla/v2SxWrj7KZLFgv7XFnJtGFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWi+9bJjM58HmsmbeG0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNHj8IcrLB67
 bzaweXx8eovFo2/LKkaP9Vuusnh83iQXwBulZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqln
 aGwea2VkqqRvZ5OSmpNZllqkb5egl3Fx7lGmgvVCFdvWX2NrYOzn72Lk5JAQMJHYvOcPE4gt
 JLCUUeJJkxFEXEbi5LQGVghbWOLPtS62LkYuoJpPjBLPLu8ES7AJGEp0vYVIiAh0MkpM6/7I
 DuIwC0xmlni2+jrYWGGBAIlFR64zgtgsAqoSVy6vB4pzcPAK2EkcOqkOsUFeYvWGA8wgNidQ
 +PGlO2wQFxVKfDj/nXUCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgVG07djPLTsY
 u94FH2IU4GBU4uHd8HV9nBBrYllxZe4hRgkOZiUR3mU/NsQJ8aYkVlalFuXHF5XmpBYfYjQF
 umkis5Rocj4wwvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDu
 UKrVPM4bzCF1Rs89/+CqWlVf/+m3Nz0Uq9jHW7mCn9V2sj0Dq9CK5+f/xGmdtCs6dGH2izPP
 TOpb7qtK7ZjNFStx7MMcgbuFi2JdO1N81jyVul7o5Km09tfWf99qnjaJfW/rbVdf9W+C8Uc7
 n3l/7lz0F2UIXV9mu3ebqaqBdMv2pOSXD4qUWIozEg21mIuKEwEKUxAkuAIAAA==
X-CMS-MailID: 20200505084633eucas1p26a6a3f44c64955aadec834bed027e522
X-Msg-Generator: CA
X-RootMTR: 20200505084633eucas1p26a6a3f44c64955aadec834bed027e522
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084633eucas1p26a6a3f44c64955aadec834bed027e522
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084633eucas1p26a6a3f44c64955aadec834bed027e522@eucas1p2.samsung.com>
Cc: Juergen Gross <jgross@suse.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/xen/gntdev-dmabuf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 75d3bb9..4b22785 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -247,8 +247,7 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 
 		if (sgt) {
 			if (gntdev_dmabuf_attach->dir != DMA_NONE)
-				dma_unmap_sg_attrs(attach->dev, sgt->sgl,
-						   sgt->nents,
+				dma_unmap_sgtable_attrs(attach->dev, sgt,
 						   gntdev_dmabuf_attach->dir,
 						   DMA_ATTR_SKIP_CPU_SYNC);
 			sg_free_table(sgt);
@@ -288,7 +287,7 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 	sgt = dmabuf_pages_to_sgt(gntdev_dmabuf->pages,
 				  gntdev_dmabuf->nr_pages);
 	if (!IS_ERR(sgt)) {
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
+		if (dma_map_sgtable_attrs(attach->dev, sgt, dir,
 				      DMA_ATTR_SKIP_CPU_SYNC)) {
 			sg_free_table(sgt);
 			kfree(sgt);
@@ -625,7 +624,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 
 	/* Now convert sgt to array of pages and check for page validity. */
 	i = 0;
-	for_each_sg_page(sgt->sgl, &sg_iter, sgt->nents, 0) {
+	for_each_sg_page(sgt->sgl, &sg_iter, sgt->orig_nents, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		/*
 		 * Check if page is valid: this can happen if we are given
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
