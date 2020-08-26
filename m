Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB0C433F8
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390CD208A9
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LHIOiXOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390CD208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AB3F86B84;
	Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7779HlUahZN; Wed, 26 Aug 2020 06:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ABC6386BB5;
	Wed, 26 Aug 2020 06:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 912F6C0893;
	Wed, 26 Aug 2020 06:35:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34C26C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1801086B2D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id em5wff1Xovcj for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B10068682F
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063544euoutp01a3c45af7dfc48103d75d167ebf775a2a~uve0zF6ih2036420364euoutp01P
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200826063544euoutp01a3c45af7dfc48103d75d167ebf775a2a~uve0zF6ih2036420364euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423744;
 bh=oVvlfd4BWRvKpcZfemLuoBrPFcZ7vE33qi6qHPEMJzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LHIOiXOl4NdQ14j/YWrOqeDwDnfe3pXiGC9iOhJroTrMCdiliXxni2rXPAhDE+djU
 ZRE0hmaBfcXB77p0Z1fHPNbcBiFUYUnbgCBSXSXe4Om9O0Z8P8i6e4IgDj7IYNS59i
 yFObAyUPyOgagX0W9tJc5A4MB5rp3jjMCfRNro0A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063543eucas1p2cb08458745623e01c2dd54a90f7b5dbe~uve0iKHxn0401704017eucas1p2R;
 Wed, 26 Aug 2020 06:35:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.5D.06318.FB2064F5; Wed, 26
 Aug 2020 07:35:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063543eucas1p1c2fde4802f125f25caa02f4453b8a284~uve0FMnM01612416124eucas1p1G;
 Wed, 26 Aug 2020 06:35:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063543eusmtrp2bfcc55ce9f0dab62403256f07a080b7a~uve0Ef8MV0466204662eusmtrp2f;
 Wed, 26 Aug 2020 06:35:43 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-f8-5f4602bf3068
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.53.06017.FB2064F5; Wed, 26
 Aug 2020 07:35:43 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063542eusmtip245070e33f084c8888faa54b4ff35c656~uvezdXjrB0092300923eusmtip2S;
 Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 26/32] dmabuf: fix common struct sg_table related issues
Date: Wed, 26 Aug 2020 08:33:10 +0200
Message-Id: <20200826063316.23486-27-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7r7mdziDb6dMrXoPXeSyWLjjPWs
 Fm/v72a1+L9tIrPFla/v2SxWrj7KZLFgv7XFs1snmS2+XHnIZLHp8TVWi8u75rBZ9GzYymqx
 9shddouDH56wWpy6+5ndgd+j9dJfNo8189Yweuz9toDF4861PWwe2789YPW4332cyWPzknqP
 2/8eM3tMvrGc0WP3zQY2j/f7rrJ59G1ZxejxeZNcAG8Ul01Kak5mWWqRvl0CV8b/s2fYCyZI
 V2xYsJ+pgXGXWBcjJ4eEgIlE27xJTF2MXBxCAisYJf793swM4XxhlHj8aB8bhPOZUWLu9RWM
 MC0Hd36ASixnlDjbvoodrqVr/0lmkCo2AUOJrrddbCC2iEAro8SJXh6QImaBo8wSt9oXsoAk
 hAW8Ja6feQtkc3CwCKhKfL0iAGLyCthJzNiTBbFMXmL1hgNgIzmBwse7+8EWSwi8ZJe4vOAp
 K0SRi8TVV81QtrDEq+Nb2CFsGYn/O+czQTQ0M0o8PLeWHcLpYZS43DQD6h9riTvnfrGBbGYW
 0JRYv0sfxJQQcJSYujgBwuSTuPFWEKSYGcictG06M0SYV6KjTQhihprErOPr4LYevHCJGcL2
 kJiz5SU0RCcySszZ2ck2gVF+FsKuBYyMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT
 2Ol/x7/uYNz3J+kQowAHoxIP7wI213gh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV
 5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDozm/Y66m+wKi5cftnWbNutU/H
 Ji3NS9d/x6VxOGltwLJ9T14+/jz3yG7zZtuZBwTtHoVZiRzgW+K9/E3ojc71deXHX6U2XZWe
 /T/n0vP3MxYfePz5sUvW0vb0K0WuAbX3PKYtDvz/IjemI2OqRdiFlisrtlp+udqzVs1V6Pms
 Q5vupHnvSD3EqMRSnJFoqMVcVJwIAEYbVdhcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7r7mdziDc6clbDoPXeSyWLjjPWs
 Fm/v72a1+L9tIrPFla/v2SxWrj7KZLFgv7XFs1snmS2+XHnIZLHp8TVWi8u75rBZ9GzYymqx
 9shddouDH56wWpy6+5ndgd+j9dJfNo8189Yweuz9toDF4861PWwe2789YPW4332cyWPzknqP
 2/8eM3tMvrGc0WP3zQY2j/f7rrJ59G1ZxejxeZNcAG+Unk1RfmlJqkJGfnGJrVK0oYWRnqGl
 hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb/s2fYCyZIV2xYsJ+pgXGXWBcjJ4eEgInE
 wZ0f2LoYuTiEBJYySuxbdIkZIiEjcXJaAyuELSzx51oXG4gtJPCJUeLBdHcQm03AUKLrbRdY
 s4hAJ6PEtO6P7CAOs8BZZolfz5ezg1QJC3hLXD/zlqWLkYODRUBV4usVARCTV8BOYsaeLIj5
 8hKrNxwA28sJFD7e3Q+1y1bi9NoZzBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQI
 jKdtx35u2cHY9S74EKMAB6MSD+8CNtd4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccX
 leakFh9iNAU6aSKzlGhyPjDW80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB
 9DFxcEo1MM7aek1sJU/BohT91cnpITnCjD/3uB9wleWcmPA+3OHHpOqwhUJ1t5TXb5nUI31g
 895z/88n3bo27VpasNihLJ8dhVOzXi3+vYJn89FpMUFvdqvNXMph8M2G/+3eNgeOG2LXtvdf
 5Y4/HLvfQLPJU+K4fnP/JSlGvrxErUqGvM3Pu/8m/VEOuK7EUpyRaKjFXFScCABe198UvQIA
 AA==
X-CMS-MailID: 20200826063543eucas1p1c2fde4802f125f25caa02f4453b8a284
X-Msg-Generator: CA
X-RootMTR: 20200826063543eucas1p1c2fde4802f125f25caa02f4453b8a284
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063543eucas1p1c2fde4802f125f25caa02f4453b8a284
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063543eucas1p1c2fde4802f125f25caa02f4453b8a284@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
