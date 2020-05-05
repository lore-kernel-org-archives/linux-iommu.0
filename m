Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF093C54E7E
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F602075E
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VJ7NU9VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F602075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6CB6D233D8;
	Tue,  5 May 2020 08:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lBB51gWXygRh; Tue,  5 May 2020 08:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D120223DA9;
	Tue,  5 May 2020 08:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B52CEC088F;
	Tue,  5 May 2020 08:46:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0414C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C1C6D86CB6
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id soduTcVq1QL6 for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 445A289557
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084636euoutp012ae9f5a1b890962f87c0f6b001246bc3~MFX1fs-TR0378903789euoutp01Q
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200505084636euoutp012ae9f5a1b890962f87c0f6b001246bc3~MFX1fs-TR0378903789euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668396;
 bh=DJPcD9jbk/Lex0Y0F7DDavP4KTp0dTOHgeuNqpXt0rA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJ7NU9VZe3zWi+6GC9zuz0Kgd4+wECU1AJeUrdBcqjCKokXeasNS6+ICiCkRT/IAI
 HU4kpVmPJdS01cHO0bkMh+SWyEAs4UN9TOkmlhkriVqdtYoaBMUTZC2toPOjPyMTxI
 Cr14zy8gCd+pXHlOGpde5yAFikVsQRlLcK8UblQ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084636eucas1p1556b405c643e81e4223f988e755d6352~MFX1JDFvm0601906019eucas1p1S;
 Tue,  5 May 2020 08:46:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.42.60679.CE721BE5; Tue,  5
 May 2020 09:46:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084635eucas1p14800a1e2598364d168adecd57b94225c~MFX0uoviv2432424324eucas1p1F;
 Tue,  5 May 2020 08:46:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084635eusmtrp1dc0d5b9410bc5e6ab59d6587df8ea0c0~MFX0tven10942509425eusmtrp1Y;
 Tue,  5 May 2020 08:46:35 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-51-5eb127ec5581
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.31.07950.BE721BE5; Tue,  5
 May 2020 09:46:35 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084634eusmtip17b13175d9e7b9f0d75c2d6392ec1b55b~MFXzzS5Aw0309403094eusmtip1V;
 Tue,  5 May 2020 08:46:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/25] staging: ion: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:46:09 +0200
Message-Id: <20200505084614.30424-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUzMYRzvud/9XjqOX1fTM7TmvMZKYfYYWoztyZp5mQ0jHX6rVndxV5F/
 HOZYr9RSWtml9OKu7ko7VEpJF6dYpZhSyWxeEr2pdHF3v+S/z/fz8ny+++5hCMkQuZAJV0Rz
 SoUsUkqJhKbGiZfe31aWBftOfGVRUsszARq09lCoLNNAogvfl6I/pusEqn4xSaP20UEKXcoz
 UKhY91SAtLWbUYF6OSquHhegkfY+ASrv7yBRW2U2hUoaumlk0qtJVPfjI4medw/TSNsxSQe4
 YVOVicT6W3qArTk/Cfy+5okQPxrTCnHu0CiJuzqqKXx/rJfEtTl6GvckmAX4Xv55/G66n8Bp
 bwoBrnqrpvBgzWsKJ1fcBXtcDou2nOQiw2M55Vr/EFFYx7tScEqz5qzF+pBWg9xl8cCZgewG
 2DOSRMYDESNhiwBMGEqZGUYAnEx+S/HDMIAXyhrJf5H06U8zQiGAzSmd1GzE+vsVZXdRrB+M
 H4h3YDf2MoBNSXPtJoJNJOFno9EhuLL7Yca9UmDHQnY5bC22OCrErD/8ZJgg+DpPqDM+dmBn
 G9/f2uVog2wOA5u1HyjetAM2NRQDHrvCL+YKmseLoSUtUcgHLgHY11JC80MigG0XM2cSm2FX
 y6TtJca2nxc0VK7l6W3wy5VR2k5Ddh58M+BipwkbTDVlEDwthlc1Et69AmaZS2dr6161zlgw
 rMn15Q/01LbBqFF4DXhm/e/SAnAXuHMxKnkop1qn4M74qGRyVYwi1OdElLwc2H6iZdo88gBU
 Th2vBywDpHPFB4cNwRJSFquKk9cDyBBSN3HBuDFYIj4pizvHKaOOKWMiOVU9WMQIpe7i9bc/
 H5WwobJoLoLjTnHKf6qAcV6oBoeJ/bpNgfUDEalk2yENp03yCTxecSToaLRr+1nNrhZWdJMR
 w16laWr3kss+wTVeUW6pdxbP12WN67dT3kEe6rwFnX57G9wrpb4H3OtueERE7lvl0pkO1/yi
 4qYCThfNdw7ItqJyhX9syEFNSdhWhJ12biws+ej0U+ydb5jj/1sqVIXJ/FYTSpXsL1WrQ6mF
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7qv1TfGGcx8bGzRe+4kk8X7v/fZ
 LDbOWM9q0fhO2eL/tonMFnvO/GK3uPL1PZtF8+L1bBYrVx9lsliw39piWYOqxco9P5gsvlx5
 yGSx6fE1VovLu+awWaw9cpfdYtuaBlaLgx+esFqcuvuZ3WLBtV/sDiIe23ZvY/VYM28No8ff
 uR+ZPe7tO8zisffbAhaPhZ++snrcubaHzWP7twesHvvnrmH3uN99nMlj85J6j9v/HjN7TL6x
 nNFj980GNo/3+66yefRtWcUYIBilZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
 qqRvZ5OSmpNZllqkb5egl3Ht9jrGgjbtitN/d7I3MC5U6WLk5JAQMJGY+u8ZWxcjF4eQwFJG
 ienrd7JCJGQkTk5rgLKFJf5c64Iq+sQoMWXSOUaQBJuAoUTXW4iEiEAno8S07o/sIA6zwAxW
 iXUH7rGDVAkLBEp87rwKZrMIqEpcWnkabCyvgJ3Es/U/mSFWyEus3nAAzOYEij++dIcNxBYS
 KJT4cP476wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3TbsZ9bdjB2vQs+xCjA
 wajEw7vh6/o4IdbEsuLK3EOMEhzMSiK8y35siBPiTUmsrEotyo8vKs1JLT7EaAp01ERmKdHk
 fGD6yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKh4rbLaZo7q
 +82bfdy7tkcaXItd/K5xzp8p13acCldw/BA3wdL1Q1rp2Vv7bE7G3L/tNDu/QDnC1SHuePLX
 bHax4GObT5SGTDuq6nrn9NeM6Cnaj046cbd/WXfvcauvzZzNvuYcnxdLOi7W/fc8LvLtu5hV
 Pv9n3bWZ6yOxXGW93f0fLCJJ+xcosRRnJBpqMRcVJwIAyC1XnucCAAA=
X-CMS-MailID: 20200505084635eucas1p14800a1e2598364d168adecd57b94225c
X-Msg-Generator: CA
X-RootMTR: 20200505084635eucas1p14800a1e2598364d168adecd57b94225c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084635eucas1p14800a1e2598364d168adecd57b94225c
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084635eucas1p14800a1e2598364d168adecd57b94225c@eucas1p1.samsung.com>
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Christian Brauner <christian@brauner.io>,
 Daniel Vetter <daniel@ffwll.ch>, Joel Fernandes <joel@joelfernandes.org>,
 Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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
 drivers/staging/android/ion/ion.c             | 25 +++++++++++--------------
 drivers/staging/android/ion/ion_heap.c        |  6 +++---
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51ea..9274298 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -147,14 +147,14 @@ static struct sg_table *dup_sg_table(struct sg_table *table)
 	if (!new_table)
 		return ERR_PTR(-ENOMEM);
 
-	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
+	ret = sg_alloc_table(new_table, table->orig_nents, GFP_KERNEL);
 	if (ret) {
 		kfree(new_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	new_sg = new_table->sgl;
-	for_each_sg(table->sgl, sg, table->nents, i) {
+	for_each_sg(table->sgl, sg, table->orig_nents, i) {
 		memcpy(new_sg, sg, sizeof(*sg));
 		new_sg->dma_address = 0;
 		new_sg = sg_next(new_sg);
@@ -224,12 +224,13 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
+	int ret;
 
 	table = a->table;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
-		return ERR_PTR(-ENOMEM);
+	ret = dma_map_sgtable(attachment->dev, table, direction);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return table;
 }
@@ -238,7 +239,7 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sgtable(attachment->dev, table, direction);
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -296,10 +297,8 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	}
 
 	mutex_lock(&buffer->lock);
-	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
-				    direction);
-	}
+	list_for_each_entry(a, &buffer->attachments, list)
+		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
 
 unlock:
 	mutex_unlock(&buffer->lock);
@@ -319,10 +318,8 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	}
 
 	mutex_lock(&buffer->lock);
-	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-				       direction);
-	}
+	list_for_each_entry(a, &buffer->attachments, list)
+		dma_sync_sgtable_for_device(a->dev, a->table, direction);
 	mutex_unlock(&buffer->lock);
 
 	return 0;
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 0755b11..f2f7ca7 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -38,7 +38,7 @@ void *ion_heap_map_kernel(struct ion_heap *heap,
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
+	for_each_sg(table->sgl, sg, table->orig_nents, i) {
 		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
 		struct page *page = sg_page(sg);
 
@@ -71,7 +71,7 @@ int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 	int i;
 	int ret;
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
+	for_each_sg(table->sgl, sg, table->orig_nents, i) {
 		struct page *page = sg_page(sg);
 		unsigned long remainder = vma->vm_end - addr;
 		unsigned long len = sg->length;
@@ -142,7 +142,7 @@ int ion_heap_buffer_zero(struct ion_buffer *buffer)
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	return ion_heap_sglist_zero(table->sgl, table->nents, pgprot);
+	return ion_heap_sglist_zero(table->sgl, table->orig_nents, pgprot);
 }
 
 int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot)
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d1..34f6e81 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -162,7 +162,7 @@ static void ion_system_heap_free(struct ion_buffer *buffer)
 	if (!(buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE))
 		ion_heap_buffer_zero(buffer);
 
-	for_each_sg(table->sgl, sg, table->nents, i)
+	for_each_sg(table->sgl, sg, table->orig_nents, i)
 		free_buffer_page(sys_heap, buffer, sg_page(sg));
 	sg_free_table(table);
 	kfree(table);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
