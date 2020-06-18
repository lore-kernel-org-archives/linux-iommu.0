Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A73BC433F4
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5A12070A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dSPyOfm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5A12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 10995204A6;
	Thu, 18 Jun 2020 15:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oz1KEFcbNoac; Thu, 18 Jun 2020 15:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 42FAC26261;
	Thu, 18 Jun 2020 15:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13553C088C;
	Thu, 18 Jun 2020 15:40:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE2BC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 138BA25C08
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DL6aMqJhgxSa for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 82D882214F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:35 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154033euoutp02525852d476190d9d6b965332e90b9934~ZrZ0uGyy81476714767euoutp02F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154033euoutp02525852d476190d9d6b965332e90b9934~ZrZ0uGyy81476714767euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494833;
 bh=oVvlfd4BWRvKpcZfemLuoBrPFcZ7vE33qi6qHPEMJzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dSPyOfm8Xi2QeklVKxSlz4TGAkwFJ+qMqcizVW4gmb5E3UdS1dwydbNbgkKO1aB33
 ipPKyKKMRty3mYOJo0ushhwBjeu/dv2VCjdhfNASwfs9hoWnvt4jwkjt+UL+wygF37
 Fss0GzAQ6wKIwcWopTCbW2fl+dVOKyZCeqWePvM4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154033eucas1p1676e3e922d494242ee5bc56824e10314~ZrZ0IiRMn1547315473eucas1p1l;
 Thu, 18 Jun 2020 15:40:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.DE.60679.1FA8BEE5; Thu, 18
 Jun 2020 16:40:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154032eucas1p207c05c83d16e48c5a48ebd1e7d2862d1~ZrZzugruN0607806078eucas1p2h;
 Thu, 18 Jun 2020 15:40:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154032eusmtrp1e8b53ee40b51b62e4235de887e40e161~ZrZzt5D7O2230622306eusmtrp1G;
 Thu, 18 Jun 2020 15:40:32 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4b-5eeb8af14220
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.E9.07950.0FA8BEE5; Thu, 18
 Jun 2020 16:40:32 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154032eusmtip14ac43baf3309dbdb79015862c26c5318~ZrZzBdlXn0709107091eusmtip1w;
 Thu, 18 Jun 2020 15:40:31 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/36] dmabuf: fix common struct sg_table related issues
Date: Thu, 18 Jun 2020 17:39:48 +0200
Message-Id: <20200618153956.29558-28-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmO3fFyXGafmkpDLpYlFmBJxQpCTogRhf/FGTNOmjopuy40n6U
 mUosNU1BkwwxzXKV5mXmrJarXGs5bF7SVErspqJmW1dv7Xi0/j3v87zP9zy8fBQqbcN9qZPK
 FE6llCfKCFdM1/7bumlaMx6zZcZGMblWM8LcL6nFmQVdAcp0f58imNva5whTbghlPr01o4yj
 exhh6kd6caZLf41gcuqacObusyGSafv6AWdeDtnJne7snet3APvoRznGDvY+JNjmH+9x9t0l
 E8I2VJ5jB+ZHULawrxqwrf3pBDv1uIdg8xprAGuv99/ndtg17ASXePIUpwoKP+Yav9DxikzO
 90utKzcg6UDvrQEuFKS3w8ay15gGuFJS+haAZZlPUHFwAHjzfScpDnYAO3uKyGVLQ1YHIQrV
 ABY3aRFBWLRoH3kJmKCDoWZCQwjYi84C8EWum2BA6UwU1hjOLwqedCQ0XG0FAsboNdDaP7uY
 IKHD4Y3MdkRMC4DaOqGTC+Xi5C2mLFx4CNI2Ej4tq0PFpd3wYd43QsSecMzUuFR1FbQU5mCi
 4QKAw9a7pDjkANiVUQLErVA4aP3jdFPOfoGwVh8k0rtgf7UREWhIu8O+CQ+BRp3wiq4YFWkJ
 vJgtFbfXwlLTvX+xbZ22pWosHGyZA+K1CgC0lBjQfBBQ+j+sHIAa4MOpeUUcx29Vcqc383IF
 r1bGbT6epKgHzo9lmTc5HgD9bKwR0BSQuUm+RI/HSHH5KT5NYQSQQmVekogOS4xUckKedoZT
 JR1VqRM53gj8KEzmI9lWMXpESsfJU7gEjkvmVMsqQrn4pgPeM2qlLYHEVJd1sV/2bNySFJY2
 N+vviHBUVZSl+P20F+zPOJQqNX/oMH1+RoyOpf5805M/NNlyttUYQsWnEjPrV3tn57nHRvzy
 eBx5YHKd2dwY7WGbXZHtY8RLdIE7XrYW65Tag4PTTyvVUTkp0bEhtVUDgUUhDeMfm1nt3uxQ
 GcbHy4M3oCpe/hdEryDvVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7oful7HGew6qGnRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8ezWSWaLL1ceMllsenyN1eLyrjlsFj0btrJarD1yl93i
 4IcnrBan7n5md+DzWDNvDaPH3m8LWDzuXNvD5rH92wNWj/vdx5k8Ni+p97j97zGzx+Qbyxk9
 dt9sYPN4v+8qm0ffllWMHp83yQXwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8da
 GZkq6dvZpKTmZJalFunbJehl/D97hr1ggnTFhgX7mRoYd4l1MXJySAiYSGxuPcvWxcjFISSw
 lFFi48GLzBAJGYmT0xpYIWxhiT/XuqCKPjFKLF24ix0kwSZgKNH1FiIhItDJKDGt+yM7iMMs
 0MMscWnhF0aQKmEBb4n9M3eD2SwCqhLnbv4B6+YVsJNY3HKMCWKFvMTqDQfAVnMCxU8fbwVb
 LSRgK/H8QxvbBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjaNuxn1t2MHa9Cz7E
 KMDBqMTD+yLkdZwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAh01kVlK
 NDkfGN15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYNY2kn/jX
 eJjZv1G/xOj2WNk+va7I/9OGvHeeTlVS/FMVX/s7vi4tvVQc1HYl+7Sbrb3+n+u+5munaaz9
 dZflbIHkgqw6sWPfFp1xuetzZdXiXfPfP2I+9cZmh+seA62XuftePMnbdNvp31rum78SZOQj
 Log+WpAdk3WE913HtvcaM14UG21kUGIpzkg01GIuKk4EADm1sOS2AgAA
X-CMS-MailID: 20200618154032eucas1p207c05c83d16e48c5a48ebd1e7d2862d1
X-Msg-Generator: CA
X-RootMTR: 20200618154032eucas1p207c05c83d16e48c5a48ebd1e7d2862d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154032eucas1p207c05c83d16e48c5a48ebd1e7d2862d1
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154032eucas1p207c05c83d16e48c5a48ebd1e7d2862d1@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/dma-buf/heaps/heap-helpers.c | 13 ++++++-------
 drivers/dma-buf/udmabuf.c            |  7 +++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 9f964ca3f59c..d0696cf937af 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -140,13 +140,12 @@ struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
 				      enum dma_data_direction direction)
 {
 	struct dma_heaps_attachment *a = attachment->priv;
-	struct sg_table *table;
-
-	table = &a->table;
+	struct sg_table *table = &a->table;
+	int ret;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
-		table = ERR_PTR(-ENOMEM);
+	ret = dma_map_sgtable(attachment->dev, table, direction, 0);
+	if (ret)
+		table = ERR_PTR(ret);
 	return table;
 }
 
@@ -154,7 +153,7 @@ static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
 				   struct sg_table *table,
 				   enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sgtable(attachment->dev, table, direction, 0);
 }
 
 static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index acb26c627d27..89e293bd9252 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -63,10 +63,9 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					GFP_KERNEL);
 	if (ret < 0)
 		goto err;
-	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(dev, sg, direction, 0);
+	if (ret < 0)
 		goto err;
-	}
 	return sg;
 
 err:
@@ -78,7 +77,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
+	dma_unmap_sgtable(dev, sg, direction, 0);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
