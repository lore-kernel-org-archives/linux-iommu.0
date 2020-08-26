Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7076C433E5
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD6720707
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qRhovLhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD6720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A183B86B74;
	Wed, 26 Aug 2020 06:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfGwR1Tpa_Ws; Wed, 26 Aug 2020 06:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B918F86B66;
	Wed, 26 Aug 2020 06:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3606C0891;
	Wed, 26 Aug 2020 06:35:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12197C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05C0E87BD4
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZDHkUJ4DarXE for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 09E1887D3D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:41 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063540euoutp029e19f26f437fb4bfcbff0678aa874816~uvexXX8ZI1514215142euoutp02U
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063540euoutp029e19f26f437fb4bfcbff0678aa874816~uvexXX8ZI1514215142euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423740;
 bh=fkZVc8mxrViKGq1m+SA4AMzfXtvDxoZigCi16n/nZN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qRhovLhOxhAVGQLNt4TnUVgXkuUjgmJhcFeRVevxr6obRzE9QUouBbm/x0NQRNsxt
 3yKHRlIm7fgS6wtydp+deCionHj8SMFxnZfBoVWEsEC1Qn1PFeWyiGBz0rZ2P7x+dW
 OR9GPDVUDdyPp7M0zkdgiROhm3XJ4bviQaTqFqe0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063540eucas1p2c358f2e50627bbbc18d9796acfcdc51c~uvexApwGR0398303983eucas1p2W;
 Wed, 26 Aug 2020 06:35:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C4.BD.05997.CB2064F5; Wed, 26
 Aug 2020 07:35:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063539eucas1p2cb72ff20abae82c3e027833f958fd7a1~uvewoaD2e0398803988eucas1p2y;
 Wed, 26 Aug 2020 06:35:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063539eusmtrp2b1cd87ced431127ab25c1ac7b6caf444~uvewn0XjF0466204662eusmtrp2X;
 Wed, 26 Aug 2020 06:35:39 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-dc-5f4602bc4c92
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.53.06017.BB2064F5; Wed, 26
 Aug 2020 07:35:39 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063539eusmtip214ade432c4e70739a2f2694a482e2769~uvev__IqW0302003020eusmtip2r;
 Wed, 26 Aug 2020 06:35:39 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 20/32] drm: virtio: fix common struct sg_table related
 issues
Date: Wed, 26 Aug 2020 08:33:04 +0200
Message-Id: <20200826063316.23486-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87p7mNziDdafZ7XoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2eHbrJLPFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNVi
 +dl5bA68HmvmrWH02PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HN4/2+q2we
 fVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXF36nSmgmfqFY8OmjYwXlDoYuTkkBAwkfi98ilL
 FyMXh5DACkaJX5/XMUI4XxglLm19A+V8ZpSYvPQtO0zL6a7LrBCJ5YwSGz8dZ4Fr+fj3G1gV
 m4ChRNfbLjYQW0SglVHiRC8PSBGzwAsmiba/mxlBEsICQRJ3V/4As1kEVCVu9u8Hsjk4eAXs
 JA51JkFsk5dYveEAM4jNCRQ+3t3PBjJHQuAYu8Sv4wuYIIpcJK7d2cIGYQtLvDq+BepUGYn/
 O+czQTQ0M0o8PLeWHcLpYZS43DSDEaLKWuLOuV9sIJuZBTQl1u/Shwg7SjRe72ICCUsI8Enc
 eCsIEmYGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFD2B4SG5veM0ECaCIwtOZtZJ/AKD8L
 YdkCRsZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYganp9L/jX3Yw7vqTdIhRgINRiYd3
 AZtrvBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCe
 WJKanZpakFoEk2Xi4JRqYKxuq+h02cvpNXd+mpnKvB23lV68eWkvcvTqxncHjghKf9RMqw55
 qXUkac4jw9u9vXo5P2a06Kt9vf9/1WZbxo7fUbcTZz993tQU03QsOWeJaeJCBp9v5ZmNPtX5
 zy87VH7a5xjqJRkkw6RyQVFn82r/eXv1vmU+5Di2z0Am70p4nYNGr5dGhRJLcUaioRZzUXEi
 ALGmim9JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7q7mdziDbYu1LDoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2eHbrJLPFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNVi
 +dl5bA68HmvmrWH02PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HN4/2+q2we
 fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl3F36nSmgmfqFY8OmjYwXlDoYuTkkBAwkTjddZm1i5GLQ0hgKaPEyu7ZLBAJGYmT
 0xpYIWxhiT/XuthAbCGBT4wSc9+pgdhsAoYSXW9B4lwcIgKdjBLTuj+ygzjMAh+YJP79/QeU
 4eAQFgiQ+HUlC6SBRUBV4mb/fkaQMK+AncShziSI+fISqzccYAaxOYHCx7v7oXbZSpxeO4N5
 AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRsu3Yzy07GLveBR9iFOBgVOLhXcDm
 Gi/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYSTc4HRnBeSbyh
 qaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGWXxv1p+uaXTR/8ge3Bjv
 8KI7X/LAG27pmUsEZy3+uvDnlO0/TKewPG9XnJYRHHpD16Nx9WOOGTYb9gRYvH5aLMbxuflr
 fkynrMfEqtNt25Z+n5gfbjV3/YoJc6u8C9k7DRg8OMITey33qyy6MHvG6tjk+N21i2TXOh2r
 z59wTNltavAUVaZqJZbijERDLeai4kQAo99vS6gCAAA=
X-CMS-MailID: 20200826063539eucas1p2cb72ff20abae82c3e027833f958fd7a1
X-Msg-Generator: CA
X-RootMTR: 20200826063539eucas1p2cb72ff20abae82c3e027833f958fd7a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063539eucas1p2cb72ff20abae82c3e027833f958fd7a1
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063539eucas1p2cb72ff20abae82c3e027833f958fd7a1@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
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
 drivers/gpu/drm/virtio/virtgpu_object.c | 36 ++++++++++++++-----------
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 12 ++++-----
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index e83651b7747d..a0559d3ed362 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -72,9 +72,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 
 		if (shmem->pages) {
 			if (shmem->mapped) {
-				dma_unmap_sg(vgdev->vdev->dev.parent,
-					     shmem->pages->sgl, shmem->mapped,
-					     DMA_TO_DEVICE);
+				dma_unmap_sgtable(vgdev->vdev->dev.parent,
+					     shmem->pages, DMA_TO_DEVICE, 0);
 				shmem->mapped = 0;
 			}
 
@@ -158,13 +157,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	}
 
 	if (use_dma_api) {
-		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
-					   shmem->pages->sgl,
-					   shmem->pages->nents,
-					   DMA_TO_DEVICE);
-		*nents = shmem->mapped;
+		ret = dma_map_sgtable(vgdev->vdev->dev.parent,
+				      shmem->pages, DMA_TO_DEVICE, 0);
+		if (ret)
+			return ret;
+		*nents = shmem->mapped = shmem->pages->nents;
 	} else {
-		*nents = shmem->pages->nents;
+		*nents = shmem->pages->orig_nents;
 	}
 
 	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
@@ -174,13 +173,20 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 		return -ENOMEM;
 	}
 
-	for_each_sg(shmem->pages->sgl, sg, *nents, si) {
-		(*ents)[si].addr = cpu_to_le64(use_dma_api
-					       ? sg_dma_address(sg)
-					       : sg_phys(sg));
-		(*ents)[si].length = cpu_to_le32(sg->length);
-		(*ents)[si].padding = 0;
+	if (use_dma_api) {
+		for_each_sgtable_dma_sg(shmem->pages, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
+			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
+			(*ents)[si].padding = 0;
+		}
+	} else {
+		for_each_sgtable_sg(shmem->pages, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
+			(*ents)[si].length = cpu_to_le32(sg->length);
+			(*ents)[si].padding = 0;
+		}
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 53af60d484a4..7947b1047bd0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -302,7 +302,7 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
 		return NULL;
 	}
 
-	for_each_sg(sgt->sgl, sg, *sg_ents, i) {
+	for_each_sgtable_sg(sgt, sg, i) {
 		pg = vmalloc_to_page(data);
 		if (!pg) {
 			sg_free_table(sgt);
@@ -603,9 +603,8 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
-		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    shmem->pages, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1019,9 +1018,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
-		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    shmem->pages, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
