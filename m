Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13642C8184D
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDA62082E
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lg820GM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDA62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C89EF8708C;
	Tue, 12 May 2020 09:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-GiPcW2g6H2; Tue, 12 May 2020 09:01:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4F6F86FC5;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E347C0893;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0993CC0178
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E01EF86D1E
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YK-x0HTqC9sa for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5C62A86F90
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:29 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090127euoutp02aed0282f07628c0fde217dce88325fd9~OPFy8y4KY0533205332euoutp02H
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090127euoutp02aed0282f07628c0fde217dce88325fd9~OPFy8y4KY0533205332euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274087;
 bh=xtDX8BGviEtRbw+qtq0o+AFcOoflB3PW51+MeG/P9Vc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lg820GM3RJ2Vk9G+aHjUNmqDKvzsnvaruNn4fDDm2Jp8pRTSuDuRJfh2xvKAVPHQ7
 XlH3z1UVUuvUt+BdFDmmvsd96ESzEqJEsqDYy8GlVkVGNwpLI/wo1mlN2CGC+M9hCz
 DkEtaYPfl0orQVl6m5YCDLgB57lpm02/rSfSYvXI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090126eucas1p101f5e02ec36131b74e821bce14c6f3d0~OPFyakiNr1621116211eucas1p1b;
 Tue, 12 May 2020 09:01:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.7B.60698.6E56ABE5; Tue, 12
 May 2020 10:01:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090126eucas1p1ad8d5dfd09fce31d9a18691a76e9fa75~OPFyGFKV-3053030530eucas1p1y;
 Tue, 12 May 2020 09:01:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200512090126eusmtrp2164e8a1f47e23be294d333ff632cca58~OPFyFSfRJ0472704727eusmtrp2W;
 Tue, 12 May 2020 09:01:26 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-57-5eba65e6d790
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.45.08375.6E56ABE5; Tue, 12
 May 2020 10:01:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090125eusmtip1a261b1781c3fc6a5fbeaa821d4407673~OPFxT4e8k1257212572eusmtip1w;
 Tue, 12 May 2020 09:01:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 32/38] staging: ion: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:52 +0200
Message-Id: <20200512090058.14910-32-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUxTQRSGnbv1gtRcKpGJGpcaTdCIVohOhBBJTJxHDT4Y96JXINJCWkFR
 EguoURTiTsMugggUi2IuWipLRZFFsKgEFYqkiMGNpZYgAtpyXd6+85//n3NyMiwpc9Dz2Sj1
 EV6jVkbLGU9KePqjffUAb9q71vRTgdLamgg0NNXLoLt6I42Svi1Dv4RLJDK3TkjQK+cQg1Ju
 GhlUUvaEQPm1QeiWbjkqMY8T6PurPgLds3fS6KUpm0HlDT0SJBh0NKof7qdRc49DgvI7JySb
 fLBQLdDYkGsAeCpnhMS2mscUfjSWT+Ebo04ad3eaGVw19p7GtTkGCe4930jgysKT+N20ncRX
 uooBrn6jY/BQzWsGp98vBVu9d3oGH+Sjo+J5zZqQ/Z6RelsxEZsVcizLWkDrgCEgFXiwkAuE
 X2qtdCrwZGXcbQAre0uAWHwHsM6cS4iFA8AP2Vfpv5GB62V/IsUAtgo28l/EbKlk3C6GU8DU
 r6kz7MOdBvBZmpfbRHIXaDhYUTHTmMuFweThceBmilsO0651zLCUC4HmD62EOG4xLKuoI93s
 4dJ78yYp90OQy2Hh2wb7n502w0qnlRF5LvzUeF8i8kL462EeIQZSAOxrK5eIxQUAXybrgegK
 gt1tE64069rPDxpNa0Q5FLZkVtFuGXJzYNdXb7dMuvCykEGKshSePSMT3StgZuOdf2PrX3SQ
 ImN4pt9IiRd6AuB40znyIlic+X9YPgClwJeP06oieG2Amj/qr1WqtHHqCP8DMap7wPUVW6Yb
 nQ9AzWS4BXAskHtJz657uFdGK+O1CSoLgCwp95GeinJJ0oPKhOO8JmafJi6a11rAApaS+0oD
 Cgb3yLgI5RH+MM/H8pq/XYL1mK8DLR47NvZEK5O25P3UNwjnNiv0hRfXB9lpyv9z8mqmalUo
 dzqycFXKwqmx8KX9uTv0daP2Wbvbo+pns2FdxSi3umHRhsRdto6MbeWf1aZ5lniHky9qb760
 XdFs8xt9npgWeMi372O5JH1ekjHMy1rUpAoe0WUt+RZ2QmoSDNuDD8gpbaRSsZLUaJW/AQqa
 asmGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7rPUnfFGTRuVLToPXeSyeL93/ts
 FhtnrGe1aHynbPF/20Rmiz1nfrFbXPn6ns2iefF6NouVq48yWSzYb22xrEHVYuWeH0wWX648
 ZLLY9Pgaq8XlXXPYLNYeuctusW1NA6vFwQ9PWC1O3f3MbrHg2i92BxGPbbu3sXqsmbeG0ePv
 3I/MHvf2HWbx2PttAYvHwk9fWT3uXNvD5rH92wNWj/1z17B73O8+zuSxeUm9x+1/j5k9Jt9Y
 zuix+2YDm8f7fVfZPPq2rGIMEIzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIy
 VdK3s0lJzcksSy3St0vQy5hxbzlTwWy7itkXF7E2MK4x7mLk5JAQMJF4Nm01axcjF4eQwFJG
 iV0/7jNDJGQkTk5rYIWwhSX+XOtigyj6xCixYkMXWBGbgKFE11uIhIhAJ6PEtO6P7CAOs8AM
 Vol1B+6xg1QJCwRKtJ85wwhiswioSvROvQRm8wrYSex5eoYJYoW8xOoNB8CmcgLF78//wwJi
 CwkUSjy6+pZlAiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIExuu3Yz807GC9tDD7E
 KMDBqMTD22G0M06INbGsuDL3EKMEB7OSCG9LJlCINyWxsiq1KD++qDQntfgQoynQUROZpUST
 84HpI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PlZ+EdAfb3
 vtRutVxY7LAqIN3ZR7t9ed9DV5nHa14nXFm611aDZd2f97cm3M/ayf7UJ9un5t/JA3ERy699
 WRnhNk8/e/WjubfsBOxnutoumJatvGbn9wMfNaSMJvXv+H+M44ShWqfdO0/Gtgtx81Zo5vT9
 lvgs7PdCaMfBqf9trD1uOmf+8JBSYinOSDTUYi4qTgQAcfEsvOcCAAA=
X-CMS-MailID: 20200512090126eucas1p1ad8d5dfd09fce31d9a18691a76e9fa75
X-Msg-Generator: CA
X-RootMTR: 20200512090126eucas1p1ad8d5dfd09fce31d9a18691a76e9fa75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090126eucas1p1ad8d5dfd09fce31d9a18691a76e9fa75
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090126eucas1p1ad8d5dfd09fce31d9a18691a76e9fa75@eucas1p1.samsung.com>
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
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/staging/android/ion/ion.c             | 25 +++++++--------
 drivers/staging/android/ion/ion_heap.c        | 44 ++++++++-------------------
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 3 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51ea..2db041d 100644
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
+	for_each_sgtable_sg(table, sg, i) {
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
index 9c23b23..79f2794 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -20,8 +20,7 @@
 void *ion_heap_map_kernel(struct ion_heap *heap,
 			  struct ion_buffer *buffer)
 {
-	struct scatterlist *sg;
-	int i, j;
+	struct sg_page_iter piter;
 	void *vaddr;
 	pgprot_t pgprot;
 	struct sg_table *table = buffer->sg_table;
@@ -38,14 +37,11 @@ void *ion_heap_map_kernel(struct ion_heap *heap,
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
-		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
-		struct page *page = sg_page(sg);
-
-		BUG_ON(i >= npages);
-		for (j = 0; j < npages_this_entry; j++)
-			*(tmp++) = page++;
+	for_each_sgtable_page(table, &piter, 0) {
+		BUG_ON(tmp - pages >= npages);
+		*tmp++ = sg_page_iter_page(&piter);
 	}
+
 	vaddr = vmap(pages, npages, VM_MAP, pgprot);
 	vfree(pages);
 
@@ -64,32 +60,19 @@ void ion_heap_unmap_kernel(struct ion_heap *heap,
 int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 		      struct vm_area_struct *vma)
 {
+	struct sg_page_iter piter;
 	struct sg_table *table = buffer->sg_table;
 	unsigned long addr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
-	struct scatterlist *sg;
-	int i;
 	int ret;
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
-		struct page *page = sg_page(sg);
-		unsigned long remainder = vma->vm_end - addr;
-		unsigned long len = sg->length;
+	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
+		struct page *page = sg_page_iter_page(&piter);
 
-		if (offset >= sg->length) {
-			offset -= sg->length;
-			continue;
-		} else if (offset) {
-			page += offset / PAGE_SIZE;
-			len = sg->length - offset;
-			offset = 0;
-		}
-		len = min(len, remainder);
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
+		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
 				      vma->vm_page_prot);
 		if (ret)
 			return ret;
-		addr += len;
+		addr += PAGE_SIZE;
 		if (addr >= vma->vm_end)
 			return 0;
 	}
@@ -109,15 +92,14 @@ static int ion_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
 	return 0;
 }
 
-static int ion_heap_sglist_zero(struct scatterlist *sgl, unsigned int nents,
-				pgprot_t pgprot)
+static int ion_heap_sglist_zero(struct sg_table *sgt, pgprot_t pgprot)
 {
 	int p = 0;
 	int ret = 0;
 	struct sg_page_iter piter;
 	struct page *pages[32];
 
-	for_each_sg_page(sgl, &piter, nents, 0) {
+	for_each_sgtable_page(sgt, &piter, 0) {
 		pages[p++] = sg_page_iter_page(&piter);
 		if (p == ARRAY_SIZE(pages)) {
 			ret = ion_heap_clear_pages(pages, p, pgprot);
@@ -142,7 +124,7 @@ int ion_heap_buffer_zero(struct ion_buffer *buffer)
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	return ion_heap_sglist_zero(table->sgl, table->nents, pgprot);
+	return ion_heap_sglist_zero(table, pgprot);
 }
 
 void ion_heap_freelist_add(struct ion_heap *heap, struct ion_buffer *buffer)
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d1..eac0632 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -162,7 +162,7 @@ static void ion_system_heap_free(struct ion_buffer *buffer)
 	if (!(buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE))
 		ion_heap_buffer_zero(buffer);
 
-	for_each_sg(table->sgl, sg, table->nents, i)
+	for_each_sgtable_sg(table, sg, i)
 		free_buffer_page(sys_heap, buffer, sg_page(sg));
 	sg_free_table(table);
 	kfree(table);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
