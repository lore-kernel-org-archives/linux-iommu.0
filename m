Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE2C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381C220DD4
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FxBnlMw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381C220DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 140D386DE4;
	Fri,  4 Sep 2020 13:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ZuyiamJv6Zv; Fri,  4 Sep 2020 13:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED56C86DE8;
	Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6E37C0890;
	Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3B56C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C750E87501
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZERY3oPiaNZ for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C4C8E87519
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:07 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133506euoutp0162c2934a55854486e9f84ff491a57034~xmAjQzJTS0639206392euoutp01I
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133506euoutp0162c2934a55854486e9f84ff491a57034~xmAjQzJTS0639206392euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226506;
 bh=SpR3GazsqgULIl1GHHRBpKbm/pP749+sIeFIismFd20=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FxBnlMw4UJFkZKd4ZBE/6+4zE1FGBTnNOxHV89LlOIO+2Hux8pT4uOiV2nAEId57o
 sBmudBqlgm6qaM35kypOt7itxg97MD4i0X9fa3L2Y/aL+yPjAMQBkLyh1T8qNXRBm1
 4AYFOB88Bf3gPfD0evkjXlnryZben9UhNWww+uzQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200904133505eucas1p1d740a0d3c0a834c864b05cef4f283402~xmAisopCa1681116811eucas1p1o;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 65.11.06456.982425F5; Fri,  4
 Sep 2020 14:35:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133505eucas1p1a90ac5f422d174fade1152f451eecce7~xmAiQrnCk0118801188eucas1p13;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133505eusmtrp14ff185feab7472c9ead9a2be54aaf45c~xmAiP-Kqw0766507665eusmtrp1D;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-52-5f524289828d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.BE.06314.982425F5; Fri,  4
 Sep 2020 14:35:05 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133504eusmtip11e6253277a4031b4603eb506faa43bf2~xmAhrqt6L1760117601eusmtip11;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 19/30] drm: virtio: fix common struct sg_table related
 issues
Date: Fri,  4 Sep 2020 15:17:00 +0200
Message-Id: <20200904131711.12950-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0gTYRj22+1ut+XknIEfWVqjMo00MeLA0LT+OIIikiCKZVeeW+im7NQs
 iMRq1dJyWm5IhZS0ypblbMkkSyuXDseav5ZZq2arRmJkSYVau67sv+d93ufHx8uHIzIbugDf
 rylmtBq6QI5JhLbuH65Vp7K25aw2v08gq1w9AvKOqRklf9kMCDnwbQIjrzc9EZAND9LIwEgP
 Qn4deCMgW/xDKNlvv4CRlscvRWTn5zGUNPddwtZLqZuXbgLq/lSDkLo39RqlfKcdAsraeIR6
 MetHqFqvGVDtz8sxaqJjEKPOtN4A1GRL7NZ5OyXrcpmC/aWMNjl9j0Tl9p8UFAXiy84Z27By
 4F6sB2IcEmug39Ur0gMJLiOuARh8dxvww1cAp10BlFPJiEkAR0yb/zmu+SYRXmQGsLfGKppz
 NNrOI5wKI1KgflyPcXg+cRzAp1XhnAghPgigbsYKuEUUkQ099578qRASy2Bn1YlQEo5LiXTo
 vJLBt8XBptsP/2SKQ/Rd0xjK5UCiWwRNQ+0oL9oIDRYj4HEUDDpaRTxeCJ21lULecBTANy6L
 iB8qAeyvMP11pMFR10+Ma0aIBNhsT+bpTKgbvirkaEhEQO94JEcjIVhjMyI8LYUndTJevRzW
 O27N1Xa6PQiPKWj47sX4AxlC97UHBdUgrv5/WQMAN0A0U8KqlQybomEOJLG0mi3RKJP2Fapb
 QOg3OWcdX9rAN8/eLkDgQB4uDcvYliND6VL2oLoLQByRz5dm9Tl3y6S59MFDjLYwR1tSwLBd
 IAYXyqOlqZc/KmSEki5m8hmmiNH+2wpw8YJyEC+2KtZm51/sf7vD/2j0w1o4PV6SV7ZJFbso
 IphUnb4hpli3a8ixsrRitjnVrVOA6rvmFRlNSxS+xDrakTe4JUbpsUceNhwzNWZ+YrRnu32F
 KmvbswpvVDkMhHVs17euo6cOhx618NOrYXap+qniSp3MGLY02jkzRR9Yb3krF7IqOiUR0bL0
 b2asy7xJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7qdTkHxBt1fuS16z51kstg4Yz2r
 xf9tE5ktrnx9z2axcvVRJosF+60tnt06yWzx5cpDJotNj6+xWlzeNYfNYu2Ru+wWBz88YbVY
 fnYemwOvx5p5axg99n5bwOKx/dsDVo/73ceZPDYvqfe4/e8xs8fkG8sZPXbfbGDzeL/vKptH
 35ZVjB6fN8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
 pRbp2yXoZVx43MFU8Ey9Ysr0HWwNjBcUuhg5OSQETCRW3P/M3MXIxSEksJRR4uGvU4wQCRmJ
 k9MaWCFsYYk/17rYIIo+MUo0XmwHK2ITMJToeguREBHoZJSY1v2RHcRhFvjAJPHv7z82kCph
 gUCJzZc+gY1iEVCVONjbDlTEwcErYCdxerE9xAZ5idUbDjCD2JxA4a0znoCVCwnYSnyYs5hl
 AiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGxsu3Yz807GC9tDD7EKMDBqMTDy2Af
 FC/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYSTc4HxnFeSbyh
 qaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGbA/XeeVBmy7LJ9QXHLWb
 rbf51iqB2WUNnGcTTx6/+IajVOFW0/PFZ+uZD82USbj4PvNd6omNZsp/nvWp+mdUx/7TP79u
 YiBr7Pecg8c9imdZO1dYLjbaFm6S+uZ8w+LAL/PPrwpqXaDMvvp986fX6y2nLrsU/P/3mnAu
 HYtTZ9r6Xh1pm9s3S4mlOCPRUIu5qDgRAIa+ivyrAgAA
X-CMS-MailID: 20200904133505eucas1p1a90ac5f422d174fade1152f451eecce7
X-Msg-Generator: CA
X-RootMTR: 20200904133505eucas1p1a90ac5f422d174fade1152f451eecce7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133505eucas1p1a90ac5f422d174fade1152f451eecce7
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133505eucas1p1a90ac5f422d174fade1152f451eecce7@eucas1p1.samsung.com>
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
index 842f8b61aa89..00d6b95e259d 100644
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
 
@@ -164,13 +163,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
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
@@ -180,13 +179,20 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
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
index c93c2db35aaf..651d1b0e8e8d 100644
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
