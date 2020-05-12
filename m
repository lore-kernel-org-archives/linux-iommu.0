Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B156C81834
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5249F214DB
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UJLc1gVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5249F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35AC388DFE;
	Tue, 12 May 2020 09:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwJyOKuYrKtm; Tue, 12 May 2020 09:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35A9689165;
	Tue, 12 May 2020 09:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 218DFC088E;
	Tue, 12 May 2020 09:01:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAF1AC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CD15120034
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7wOv387++Xi for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 0B80F1FD7D
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:12 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090110euoutp025dbed323c92db3f1d06f74f961303e67~OPFi1LI0d0453404534euoutp028
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090110euoutp025dbed323c92db3f1d06f74f961303e67~OPFi1LI0d0453404534euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274070;
 bh=m4elOxYuX5foEAKeLy0+yU867Xe9WrnCwWU7agjhaHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UJLc1gVGr9XqwXuBlE1N92qdVfkAngfinGSc44LlUy2m8p/Vnz0SCRYwMhlKGg4H7
 e006rDPirNezDG5VKcFMd2VnhG8DZVi4Ph47RM+WsrKqr+rlLXu3NoFpv236br3FSd
 nPy+HNBcUb09YWkCOvRwJ7gGUTZumjW4htuV0owo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090109eucas1p28fdb5bb29ed6b06e9e336a2e1e275255~OPFiY2PmA2661826618eucas1p2L;
 Tue, 12 May 2020 09:01:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id D1.6B.60698.5D56ABE5; Tue, 12
 May 2020 10:01:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090109eucas1p285ca10dceb29f43aae1c40814e2dec8d~OPFiICqKT2662326623eucas1p2O;
 Tue, 12 May 2020 09:01:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090109eusmtrp1824c3b6384cac839c061f9c0d9c734f6~OPFiGveko0183401834eusmtrp1R;
 Tue, 12 May 2020 09:01:09 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-fb-5eba65d51453
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.E2.07950.5D56ABE5; Tue, 12
 May 2020 10:01:09 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090108eusmtip10b4755b58aa112adb5a9e915d5396de5~OPFhjWtln1283712837eusmtip1f;
 Tue, 12 May 2020 09:01:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/38] drm: prime: add common helper to check scatterlist
 contiguity
Date: Tue, 12 May 2020 11:00:24 +0200
Message-Id: <20200512090058.14910-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUhUURjtzpv35jk68hzNuZgkDC0o5JL9eGBKYcQj+lEQUZnWlC+1HJcZ
 1xxRJp3GScWl0iRcwiWX0dx1LM1xR9Rcc0VNEdLMzC1FLMen+e+c852Pc+7HxRF+E2qGe/kE
 0BIfkbcQ47KrWjd7zgzSGjfbho9WZFx3B4ssTS1Byb9ViQg5sLaEkfmFLSwys8GBXB2YZpFl
 M0Mo2a95i5Hq5gkOmbVcySYVMbko2fhrFiUrfiSiFwypovQiQH1az2RTZQUxGFW9PoVS6R3X
 qckXbSyqPDuCGtuZQajk4TxA1Y1EYlR8RQGgyjvDqJWy49d4d7jn3WlvryBaYuN0n+uZN9MF
 /DTmISsZr0EkaBWogB4OiXOwPyearQJcnE+8BzBK2YUyZBXA3ldKFkNWAJxamOQcrKjq+jjM
 IA/A2Pnmw5XKrOeYzoURdlC1qNrDJkQ0gO1xBjoTQmQicHNFAVQAx42J23C74oTOwyZOwgX5
 EkuHeYQjnK/txZg0C1j44TOiw3qEE5zM2GYz+igHxvc5MvgSLEpP3deN4XxbxX5Tc9iZHLv3
 OEg8A3C6W81hSCyA/fJUwLgc4Hj3FqYrhBCWsERjw8gXoTZNtdcTEoZweNFIJyO7MKkqBWFk
 HlQq+Iz7FExrK/4f2/ilD2EwBVXz4/tXbNm9T9M3TgKwSDsMywSgAAjoQKnYg5ba+9DB1lKR
 WBro42H90FdcBna/VudO21oNqN9+oAUEDoQGPOXZWjc+KgqShoq1AOKI0IQX5bUr8dxFoU9p
 ie89SaA3LdWCYzhbKODZv/vuyic8RAH0E5r2oyUHUxauZxYJwk+/eeypLfXa5G9M3YoYat6Q
 TXE7XKuz/eRK/9+mwglSrK+R441+LyNTvnblJDnnDtEZ/fntgqSmIyUuEnv9Ype8uRu1hmNh
 Cv2tet4c3Wp0ZVQWPnS0KcSkY9FfdjXY3FItN5212YwfyU1wHkzbvqWW2S7fRB71/un5WXP3
 spAt9RTZWSESqegfSAa/TVYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pXU3fFGbw6LWHRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgs/bmWxaOtcxmpx
 8MMTVostbyayOvB5rJm3htFj77cFLB6bVnWyeWz/9oDVY97JQI/73ceZPDYvqfe4/e8xs8fk
 G8sZPXbfbGDz6NuyitFj8+lqj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
 zWOtjEyV9O1sUlJzMstSi/TtEvQylj8+y1iwS6bi8/xpjA2Mx8S7GDk5JARMJLp2X2LvYuTi
 EBJYyijR+/42O0RCRuLktAZWCFtY4s+1LjaIok+MEj933QErYhMwlOh6C5EQEehklJjW/RFs
 FLPACmaJV/vmsoBUCQuES/xdP5sNxGYRUJV43fSeCcTmFbCVeLXzIhvECnmJ1RsOMIPYnAJ2
 Evfn/wHrFRIolHh09S3LBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjaNuxn1t2
 MHa9Cz7EKMDBqMTD22G0M06INbGsuDL3EKMEB7OSCG9LJlCINyWxsiq1KD++qDQntfgQoynQ
 UROZpUST84ExnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFt
 +xFT6x6VxgNit3RnbOIN+tss1vber1yCf1lZQLnU12/hpVeXzy/55e5/+c3dL5WWKaa89+8X
 8wTOvPTPvHWN4zyf+Gxm5cQD3yM9Xn85fld98mTTN3abX6W6RriVWTLtX8ZZIJu19rRSguNV
 h2Mt807Hr94vzLTy3kKWYLf3DYonrzzLVVNiKc5INNRiLipOBABOOWz6uQIAAA==
X-CMS-MailID: 20200512090109eucas1p285ca10dceb29f43aae1c40814e2dec8d
X-Msg-Generator: CA
X-RootMTR: 20200512090109eucas1p285ca10dceb29f43aae1c40814e2dec8d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090109eucas1p285ca10dceb29f43aae1c40814e2dec8d
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090109eucas1p285ca10dceb29f43aae1c40814e2dec8d@eucas1p2.samsung.com>
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
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
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
