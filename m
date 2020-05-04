Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF07C54E48
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9792075E
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fa4K6YxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9792075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D50287D86;
	Mon,  4 May 2020 12:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLeVVmiNYD9O; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3754288072;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24698C088E;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C4EAC0893
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 818A72563C
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oaZT8yd7EPUl for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 0CB2B22EE7
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:26 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125424euoutp02d1bb8b7bddc08621a3cd790cefab8004~L1G6CvytR1779417794euoutp02f
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125424euoutp02d1bb8b7bddc08621a3cd790cefab8004~L1G6CvytR1779417794euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596864;
 bh=zHKjZwTbMZQRumKBMI2AAMfiZVQYV7hkyoAsi6A5YUc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fa4K6YxE0WKI8AbXSk+jj/nQOBw9hyMeKhrzJ57J2LSfAawk4LRm/0lMKMOQGcVul
 sdB6vOA5qQwaPFi5go8O5pD7YEK4WFfaI4ZwWytk19LrGrY/LgTVPEYSUW22upxjsm
 05tVFRr3GJ03XaCYaJ7oJ7GRNgTbwpVe0T7suRBc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200504125424eucas1p2e4b016b14b89fc7a00c20e03f6732b26~L1G5no84j2227522275eucas1p2y;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.12.60698.08010BE5; Mon,  4
 May 2020 13:54:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125423eucas1p24639a2eae17ebc634e022a6c7d448981~L1G42B__p0599805998eucas1p2I;
 Mon,  4 May 2020 12:54:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200504125423eusmtrp11a647a9bbbb95e4ac1ed778c7a476de2~L1G4wG4_32470624706eusmtrp1r;
 Mon,  4 May 2020 12:54:23 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-64-5eb01080774f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.06.07950.F7010BE5; Mon,  4
 May 2020 13:54:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125422eusmtip2100181fd77b643d825ae7bf11205545f~L1G4FjbSs0350103501eusmtip23;
 Mon,  4 May 2020 12:54:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/21] dmabuf: fix sg_table nents vs. orig_nents misuse
Date: Mon,  4 May 2020 14:53:57 +0200
Message-Id: <20200504125359.5678-19-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUgUURzm7Rw7mmvjavo8StjohDywPyYsSTIYwkIIyYSsTcdVctV2PFIK
 Fy2pzU1bwysr3QTvM9nEtPLIzQwrNbF0PVNREI1dlUy0Hafsv+/3He9778cjEHEd5kRERscx
 imhplAS3RHVdvz4dUZJ1IR5TkxaUurdbQNXn1WLUpu4hQg0sL+JUeeU7AVX0xpsyDUwIqIap
 QYzqby7EqepOg5BqW/qBUR8MRuFJK7rqaRWgW1eKUHpksAWnX66MY/TYfb2AflGSQg9vTCF0
 9lApoF99U+L0g8YKQBsb9gTsCLY8HsZERSYwCnefK5YR+o4NPLbf7oZu/IlQCcpsVIAgIHkU
 akuCVcCCEJNlAE7cC1cBSzM2AdinbcH4wQhgTv4zAefiAgVjmUJeKAVw9bsJ3Y4Y1KsI58JJ
 T6haUOEctiPvAPhebcWZELJdAAvLZ1FOsCXPwN+auS0TSu6DxqrhrbCIPAGzTCrA17nCyrq3
 CHdXCzOfrz7AnQPJZiHcrO/GeI8fbH2kw3lsC+f1jUIeu8Ce7AyUD6SZH9dbLeSHDAD7U/P+
 NnjDkd41nGtAyEOwttmdp33hUs60kF+SNRxasOFoxAw1ulyEp0XwbrqYd++HBfqa7dq2z30I
 j2mYVrOC8wvqAHCyqQvLAq4F/8uKAKgADkw8K5cxrFc0k+jGSuVsfLTMLTRG3gDM/6hnQ7/c
 BF6vX20HJAEkVqIgY22IGJMmsEnydgAJRGInarptpkRh0qRkRhFzWREfxbDtwJlAJQ4iL+3c
 JTEpk8Yx1xgmllH8UwWEhZMSOMdHgVSf0ZmYusngNHt9TfZ8oNbdtJo7mizTNIV3soljaY4V
 gW0X7DNtRnel+z8n4tCUtfPKvbpzM1/VnY+Lj20khCnO7tQaDqY2BgRZe4j7YvxdRsp6nKdV
 twbtPK47WnnN3vy4Lve9uDjZEKr5ojEsa36KunefCj1dWewn0EpQNkLqeRhRsNI/Td9DXUMD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xe7r1AhviDFqfc1v0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xcEPT1gtTt39zO7A
 47Fm3hpGj73fFrB43Lm2h81j+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
 501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
 ehnHD/9jK7gsUrHtwVz2BsYVgl2MnBwSAiYSs+73s4PYQgJLGSVezY2BiMtInJzWwAphC0v8
 udbFBlHziVFieoMFiM0mYCjR9RYkzsUhItDJKDGt+yM7iMMscIJJ4vSMr2DdwgJeEr8nvQTr
 ZhFQlfi85jYziM0rYCsx4UsXI8QGeYnVGw4AxTk4OIHiM3vVIZblS9x9+o9lAiPfAkaGVYwi
 qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHRse3Yzy07GLveBR9iFOBgVOLh3fB1fZwQa2JZcWXu
 IUYJDmYlEd4dLUAh3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgdGbl5JvKGpobmFpaG5sbmx
 mYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbNIkfXX3qY9v72YdG68hU6OwI0fqYdSHm3
 qP2OuOXJoPV1HOm6Tu7rYyZInng2K+wDB3duzM8kW6ZVh5tipb4vcNF8I/c3ubnz/jKzxdl2
 IVO+ec9k2uyVXrJb1aPH+eXGpwdmLy7bo+N26sm7vuNv3ioViuornMyadsQp8MYMRrbbHad5
 6nqVWIozEg21mIuKEwF/RK8UpAIAAA==
X-CMS-MailID: 20200504125423eucas1p24639a2eae17ebc634e022a6c7d448981
X-Msg-Generator: CA
X-RootMTR: 20200504125423eucas1p24639a2eae17ebc634e022a6c7d448981
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125423eucas1p24639a2eae17ebc634e022a6c7d448981
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125423eucas1p24639a2eae17ebc634e022a6c7d448981@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sumit Semwal <sumit.semwal@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/dma-buf/heaps/heap-helpers.c | 7 ++++---
 drivers/dma-buf/udmabuf.c            | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 9f964ca..b923863 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -144,8 +144,9 @@ struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = &a->table;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
+	table->nents = dma_map_sg(attachment->dev, table->sgl,
+				  table->orig_nents, direction);
+	if (!table->nents)
 		table = ERR_PTR(-ENOMEM);
 	return table;
 }
@@ -154,7 +155,7 @@ static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
 				   struct sg_table *table,
 				   enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sg(attachment->dev, table->sgl, table->orig_nents, direction);
 }
 
 static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index acb26c6..ea0cf71 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -63,7 +63,8 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					GFP_KERNEL);
 	if (ret < 0)
 		goto err;
-	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
+	sg->nents = dma_map_sg(dev, sg->sgl, sg->orig_nents, direction);
+	if (!sg->nents) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -78,7 +79,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
+	dma_unmap_sg(dev, sg->sgl, sg->orig_nents, direction);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
