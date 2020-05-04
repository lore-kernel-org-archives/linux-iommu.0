Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC09C54E7F
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E772075E
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BI3SS6Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E772075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00F7F87F74;
	Mon,  4 May 2020 12:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czmCVTI5gB04; Mon,  4 May 2020 12:54:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FC0988072;
	Mon,  4 May 2020 12:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3916AC088C;
	Mon,  4 May 2020 12:54:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77CA5C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B5B8880EE
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngBhA1hqQzOu for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0357A880DF
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125425euoutp024bfe4e282d86e05acc12668d41dc1e56~L1G63gL6D1960119601euoutp02H
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125425euoutp024bfe4e282d86e05acc12668d41dc1e56~L1G63gL6D1960119601euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596865;
 bh=nL6s2qmhXVj8ojZqxdlRyULSFgOINvfslVF6oVYkjYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BI3SS6WgGwHE6z6hb8H2c3rnXkhkt7VLJTt0LS0pGoNowiCWFFnG2ql+QKz4aVIG0
 HeTD9424iZz7JBQObzI4cdFbEUO2GRQqSFI65na/9OWtkwAJX4vgpVhtiq+hPkHN5J
 o3ApZuT2se/h5vL6bEMG2R1V/FFj6Z6e1KB/wh+8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200504125425eucas1p18f24436a94facbca4aad0c4973fc3bb1~L1G6Z0i_m1058810588eucas1p1l;
 Mon,  4 May 2020 12:54:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 93.E2.60679.08010BE5; Mon,  4
 May 2020 13:54:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125424eucas1p2a654aa95d553e10422dcb5125f960a49~L1G6KQaoN0599205992eucas1p2E;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200504125424eusmtrp1f37551067796b55c518d1f9421bfaf01~L1G6JlmPT2497724977eusmtrp1i;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-bd-5eb01080de42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.06.07950.08010BE5; Mon,  4
 May 2020 13:54:24 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125424eusmtip27a30e28a337f5989f1eb1fc1e87c59b2~L1G5df-nc0241002410eusmtip2K;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/21] staging: ion: fix sg_table nents vs. orig_nents
 misuse
Date: Mon,  4 May 2020 14:53:59 +0200
Message-Id: <20200504125359.5678-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTYRDNt9tul6aFpZDwiURiIxI0nPpjBc8Ek03wh1GJN1plAwRaSJc7
 MSKoaAHlMIpIEJWEoyAITUXkBimXUKUQRG4kBiKHoQIlSm1ZxH9v3rw3bzIZHBW1cu3xEFkk
 LZdJwsQYn6NuM/S63iIqAjyMFQiZ1tOBkG+yy7mkUZ2BkrXdazxS92sBI4uVHxAyv8GHLK5d
 RUi9bgIhK6cGuGRfTS5GlrWO8MimxW9csnNkiXfUkirNKwXUaH0Lh6pbzudQwwO1GPV2eZxL
 jaVoEKqq4Cb1dX0KpbIGCwH1/ksCRi3U92PUA1UJoJYqd5wUXuAfDKTDQqJpufvhq/zgZ9N+
 EWrnWOP4RyQB5O5UAByHxH7YmHJCAfi4iCgCULcywGULPYDzhgIeWywBOJpeaupYbDiSNYub
 qkIAc5KVYMuirP+EmlUY4QkVcwrMjG2JOwC2pwnMIpRIQqHWmALMDRviFGzXT2+IOIQTNDxe
 2TALiUNQVTaCsHGOUFnRiJqXtTDxT9OczXMgMcSDkxnsHEj4wg7V9831bOCsRsVjsQPsykrl
 sIYkACd6ynhskQpgX2L2ptsHDvesYeYElHCB5TXuLH0M5mn7EfZKlnBwztpMoyaYqX6CsrQQ
 3rsrYtW7YY7m9VZsk/YzymIKZk9WbZ6xxXSt+WkkHTjm/A/LB6AE2NFRjDSIZrxkdIwbI5Ey
 UbIgt+vh0kpg+q2udY2+GtT8vtYMCByIBcJzS+UBIq4kmomTNgOIo2JbYfVtEyUMlMTF0/Lw
 K/KoMJppBttxjthOuO/lzGURESSJpENpOoKW/+siuIV9AmDKt+1djcc98tz+nBW86B0bcg01
 WN3Pj1s1yEfHUH9Hv4uR74yZz2P1ZxyGHef8yg60Wbmo3PWFw+fnH3rLThe/uhG46xHmHTUT
 4D1SqF5AYqyVTOLEkRSvnlin4/wfFr4l2llF2kKDi65bM4421fl3zhVXTxYlrQkv/XSwFjiJ
 OUywxHMPKmckfwFtt0aZVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7oNAhviDCZN0LPoPXeSyWLjjPWs
 Fv+3TWS22HPmF7vFla/v2SxWrj7KZLFgv7XFyj0/mCy+XHnIZLHp8TVWi8u75rBZrD1yl93i
 4IcnrBan7n5md+DzWDNvDaPHvX2HWTz2flvA4nHn2h42j+3fHrB63O8+zuSxeUm9x+1/j5k9
 Jt9Yzuix+2YDm8f7fVfZPPq2rGL0+LxJLoA3Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
 z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j9lPvgm3qFf8fnGVqYJyj2MXIySEhYCLRfvwDaxcj
 F4eQwFJGiRPPzzFBJGQkTk5rYIWwhSX+XOtigyj6xCjR178SrIhNwFCi6y1EQkSgk1FiWvdH
 dhCHWaCbWeL6omlA7RwcwgIBEru2S4I0sAioSvyc9p0ZxOYVsJXYsvYu1DZ5idUbDjCDlHMC
 xWf2qoOEhQTyJe4+/ccygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAo2nbs55Yd
 jF3vgg8xCnAwKvHwbvi6Pk6INbGsuDL3EKMEB7OSCO+OFqAQb0piZVVqUX58UWlOavEhRlOg
 myYyS4km5wMjPK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+Ol
 zzJNPgUTDhRLFj/fem7xsZO/7iqurD0vylZdeUA/YJkCxza7V/2fc59kOprOdJa87mpb+5Vx
 ton7sopHNRN8XKbc23PAKKfLNdj26wsRnvXvwtg3u51289exT/7JWH1k0n82mdQdQVp/GBev
 2DzJ4cdC9S6mJ4VLp/2J/HKHX6Q53FNmlYsSS3FGoqEWc1FxIgAuM6M4uAIAAA==
X-CMS-MailID: 20200504125424eucas1p2a654aa95d553e10422dcb5125f960a49
X-Msg-Generator: CA
X-RootMTR: 20200504125424eucas1p2a654aa95d553e10422dcb5125f960a49
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125424eucas1p2a654aa95d553e10422dcb5125f960a49
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125424eucas1p2a654aa95d553e10422dcb5125f960a49@eucas1p2.samsung.com>
Cc: devel@driverdev.osuosl.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sumit Semwal <sumit.semwal@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
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
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/staging/android/ion/ion.c             | 17 +++++++++--------
 drivers/staging/android/ion/ion_heap.c        |  6 +++---
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51ea..b14170c 100644
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
@@ -227,8 +227,9 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = a->table;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
+	table->nents = dma_map_sg(attachment->dev, table->sgl,
+				  table->orig_nents, direction);
+	if (!table->nents)
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -238,7 +239,7 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sg(attachment->dev, table->sgl, table->orig_nents, direction);
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -297,7 +298,7 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
+		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->orig_nents,
 				    direction);
 	}
 
@@ -320,8 +321,8 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-				       direction);
+		dma_sync_sg_for_device(a->dev, a->table->sgl,
+				       a->table->orig_nents, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
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
