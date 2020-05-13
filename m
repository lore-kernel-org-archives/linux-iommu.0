Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9FDC2D0FA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EDE207BA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gh5UyUJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EDE207BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D981888228;
	Wed, 13 May 2020 13:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTm+Wrv9GMoo; Wed, 13 May 2020 13:33:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4188487657;
	Wed, 13 May 2020 13:33:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33FF9C088F;
	Wed, 13 May 2020 13:33:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD8FEC0178
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CCB0986FC4
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qiordN8fxA5i for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 248D18701F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:01 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133259euoutp01f11e33dfb17c98ec68494b8988839d69~OmcKdWlEM2196121961euoutp01c
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:32:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133259euoutp01f11e33dfb17c98ec68494b8988839d69~OmcKdWlEM2196121961euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376779;
 bh=jaNdX2aJTFsRpUX29VfIto14HjpaD6l+ox1EVZ7cX2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gh5UyUJZdbT4fmfJAizmyXQ5nWBC0xbfm8weh+K1+lZ3T+LfPOCgtIyTnFO8OrYxU
 IUsaurRXnxf+m7xGi7iFZxsogkRhJVOYhFFCeFyMoHVBND73L2TkP5mhioADk3OcY/
 4po8ry5w7cADjw6lsnn9oiIvVNMhyTQPEAs5S8ZE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513133259eucas1p2818fb6d2768faf81ec6dbb912e61afaf~OmcKGU44v1009510095eucas1p27;
 Wed, 13 May 2020 13:32:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.C5.61286.B07FBBE5; Wed, 13
 May 2020 14:32:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133258eucas1p1eba6e0ced0c749655f028206d5f84b7a~OmcJxzEQx0874908749eucas1p1W;
 Wed, 13 May 2020 13:32:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133258eusmtrp1fd7bd53644225fb7e2283a8cb47db7b5~OmcJweEPK0994509945eusmtrp1c;
 Wed, 13 May 2020 13:32:58 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-2f-5ebbf70b24b7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.27.07950.A07FBBE5; Wed, 13
 May 2020 14:32:58 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133258eusmtip172311bd51bf138cd3fe3bd47bfeadb30~OmcJC-20L2932629326eusmtip1b;
 Wed, 13 May 2020 13:32:58 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/38] drm: prime: add common helper to check scatterlist
 contiguity
Date: Wed, 13 May 2020 15:32:11 +0200
Message-Id: <20200513133245.6408-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeyyVcRjud77L+Y4c+zosv0mx02ppi0Tr2+iitfZZ1uS/2siHb1jOYecg
 8gdLGccllykz6VDL7XByHNSRO52wUciQlHSZ2yi3Ueh8PtV/z/s8z/s+7969BCJpx2yIUHkk
 q5AzYVLcDK17tdZ7bPdqg9/x6jQLKr23S0BV52kxaqsuC6EGl+dxqqyiU0Cpm92opcEJAaWb
 HMKoAUMBTlV2fBBSRT9qUSop5SlGtS58wSj9bBZ2zoLWFGoA3biiRmldeQpO1698wujCriv0
 x1SjgK55Ek+/35xE6JzhEkA3jCTgdIa+HNA1PXH0ou6At/iamXsQGxYazSqczvibhXQPlKAR
 DbYx37+WChOA0VoFCAKSrjBjWqQCZoSELAVwrNOAqIDIVCwBuJxpwQuLABpatEJO4BryOyaF
 vFACYGfPOMIXpo7fQ/dRzoWTzlA1p8I5bEXeBfB1ujlnQkg1AtcWkwAnWJJX4UJZ/fZYlDwE
 XxZqMQ6LSXeYOlMg4OPsYMWzlu2dRORpOD3WjHKDIDkqhDMjWRhvugB1s1k7+1nCaaN+B9vC
 npy0nYZEACd6K4V8kQbgwO08wLvc4FjvOs6dAyEdoNbgxNMecO5dE+CvZAGH5/ZwNGKC2XUP
 EJ4Ww+QkCe8+DPONVf9iW9/0IzymYWJ7FcpfqB3At8WleCawy/8fpgagHFizUUpZMKt0lrM3
 HZWMTBklD3YMDJfpgOm1ejaNP5+D5f6ANkASQGoupkYb/CQYE62MlbUBSCBSK/FlrYkSBzGx
 t1hF+HVFVBirbAP7CFRqLXYpnvKVkMFMJHuDZSNYxV9VQIhsEoBP4v4WKoVxGNqKqW1M/9U1
 dqKq/fJD3yh7RrCXPFlsn9unDqgv8xevnu/zSne5py+a8z67Udnm4TPlsL45/Pig3sv9YrCl
 uavNPDaV46mraop9FB53qj52OPXzzK7M5BeSom8akYtGrjni6WI9fqkyuTs+N9Bgt7iRfWeo
 TuacIEWVIYzzUUShZP4AF1lGHVYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pc33fHGZzZaGTRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgs/bmWxaOtcxmpx
 8MMTVostbyayOvB5rJm3htFj77cFLB6bVnWyeWz/9oDVY97JQI/73ceZPDYvqfe4/e8xs8fk
 G8sZPXbfbGDz6NuyitFj8+lqj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
 zWOtjEyV9O1sUlJzMstSi/TtEvQyTl1ezlKwW6bi+dMV7A2Mx8W7GDk5JARMJGYdeczexcjF
 ISSwlFFiyvn97BAJGYmT0xpYIWxhiT/Xutggij4xStyYuIwJJMEmYCjR9RYiISLQySgxrfsj
 2ChmgRXMEq/2zWUBqRIWCJf4v2UJM4jNIqAqsWfeerCxvAI2Et2v5zBBrJCXWL3hAFgNp4Ct
 xKs7+8F6hQTyJfYu3sc2gZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42nbs55Yd
 jF3vgg8xCnAwKvHwWtzaHSfEmlhWXJl7iFGCg1lJhNdvPVCINyWxsiq1KD++qDQntfgQoynQ
 UROZpUST84ExnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXGN
 jcHkaUdvfBT6Ejxv997jWb+WnH7DNeVkrXS6e88f70keBtMN1574aCzOfa9PmH27teX9paeL
 lUQikrZusdBheOX4/EY1k6iWzSz9Gne1F9V2e344KV5bszHh27k32zkNlHYkm0Q6pJ9J8sw6
 47TWp/V72KkpP5r0nL2VPSNaxWd7q8tyPFdiKc5INNRiLipOBAALtjL0uQIAAA==
X-CMS-MailID: 20200513133258eucas1p1eba6e0ced0c749655f028206d5f84b7a
X-Msg-Generator: CA
X-RootMTR: 20200513133258eucas1p1eba6e0ced0c749655f028206d5f84b7a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133258eucas1p1eba6e0ced0c749655f028206d5f84b7a
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133258eucas1p1eba6e0ced0c749655f028206d5f84b7a@eucas1p1.samsung.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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

It is a common operation done by DRM drivers to check the contiguity
of the DMA-mapped buffer described by a scatterlist in the
sg_table object. Let's add a common helper for this operation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 23 +++--------------------
 drivers/gpu/drm/drm_prime.c          | 26 ++++++++++++++++++++++++++
 include/drm/drm_prime.h              |  2 ++
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 12e98fb..9f2d13e 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -471,26 +471,9 @@ struct drm_gem_object *
 {
 	struct drm_gem_cma_object *cma_obj;
 
-	if (sgt->nents != 1) {
-		/* check if the entries in the sg_table are contiguous */
-		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
-		struct scatterlist *s;
-		unsigned int i;
-
-		for_each_sg(sgt->sgl, s, sgt->nents, i) {
-			/*
-			 * sg_dma_address(s) is only valid for entries
-			 * that have sg_dma_len(s) != 0
-			 */
-			if (!sg_dma_len(s))
-				continue;
-
-			if (sg_dma_address(s) != next_addr)
-				return ERR_PTR(-EINVAL);
-
-			next_addr = sg_dma_address(s) + sg_dma_len(s);
-		}
-	}
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size)
+		return ERR_PTR(-EINVAL);
 
 	/* Create a CMA GEM buffer. */
 	cma_obj = __drm_gem_cma_create(dev, attach->dmabuf->size);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 282774e..1d2e5fe 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -826,6 +826,32 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
 EXPORT_SYMBOL(drm_prime_pages_to_sg);
 
 /**
+ * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
+ * @sgt: sg_table describing the buffer to check
+ *
+ * This helper calculates the contiguous size in the DMA address space
+ * of the the buffer described by the provided sg_table.
+ *
+ * This is useful for implementing
+ * &drm_gem_object_funcs.gem_prime_import_sg_table.
+ */
+unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
+{
+	dma_addr_t expected = sg_dma_address(sgt->sgl);
+	struct sg_dma_page_iter dma_iter;
+	unsigned long size = 0;
+
+	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+		if (sg_page_iter_dma_address(&dma_iter) != expected)
+			break;
+		expected += PAGE_SIZE;
+		size += PAGE_SIZE;
+	}
+	return size;
+}
+EXPORT_SYMBOL(drm_prime_get_contiguous_size);
+
+/**
  * drm_gem_prime_export - helper library implementation of the export callback
  * @obj: GEM object to export
  * @flags: flags like DRM_CLOEXEC and DRM_RDWR
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index 9af7422..47ef116 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -92,6 +92,8 @@ void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
 struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 				     int flags);
 
+unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
+
 /* helper functions for importing */
 struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 						struct dma_buf *dma_buf,
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
