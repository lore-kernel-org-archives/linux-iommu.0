Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EFBC47254
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2282078C
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ecd4bNb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2282078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 311268899D;
	Mon,  4 May 2020 12:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywf9pUhBMP7C; Mon,  4 May 2020 12:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE3D2883F8;
	Mon,  4 May 2020 12:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D341FC088C;
	Mon,  4 May 2020 12:54:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0E71C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC7CC883F8
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sv6b9+yM978 for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 660E5887BB
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:21 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125419euoutp02f7c84346befa67ef4426344c5470a5e8~L1G1X5yqy1771917719euoutp02g
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125419euoutp02f7c84346befa67ef4426344c5470a5e8~L1G1X5yqy1771917719euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596859;
 bh=EVazr+cXLNtZz54aJWiekXBsP8o9spxnq0Q4oG69wq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ecd4bNb8EjmNpv0P3N36eH+6DjXF+KHpVWMzRqCfua3pyNZgRjv2xusws536qidMQ
 1MtXaySAb22/7+pPGUbBvKGkkal0MSjkuoofZa2khwSyFiqFD6uLVkcwcDYATCeLB1
 UkKUaeUGsBGUoi/pn9jEbSlbt0uIxla/hDD3zJho=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200504125419eucas1p13f96494d03af14a472a7468fc3e170cf~L1G075V3x1058810588eucas1p1i;
 Mon,  4 May 2020 12:54:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.D2.60679.B7010BE5; Mon,  4
 May 2020 13:54:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96~L1G0om3GJ1174211742eucas1p1c;
 Mon,  4 May 2020 12:54:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504125418eusmtrp21cec5b9ca8d0de30aeeacfc622a49999~L1G0n1nws2826928269eusmtrp2U;
 Mon,  4 May 2020 12:54:18 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ab-5eb0107bf1dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.69.08375.A7010BE5; Mon,  4
 May 2020 13:54:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125418eusmtip225eeda603c17f6f2568f2a347c8f0b38~L1Gz-sE3x0241302413eusmtip2Y;
 Mon,  4 May 2020 12:54:18 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/21] drm: virtio: fix sg_table nents vs. orig_nents misuse
Date: Mon,  4 May 2020 14:53:51 +0200
Message-Id: <20200504125359.5678-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSezBUUQDG59x79+61WV3LjDM0qW3SE6nM3BmPamjm1h+V/rFD1JbrMezS
 LvKYhgplo9LLq8GUQR5LXnlMRFibbPKIUoMoZUIzWEOiXZf67zu/7/vON3PmEKigimNOBEhD
 GZlUHCTEeVh124LGOpos8943MsijkjVqhHqWVsqhVqpTUKp3bhqnnha1IlROowP17aMapWZ7
 RxCqfPQ9h+qpe4RTJS2fuVTTrzEOld+ZhR/m08VZxYB+oc3B6OfaYQ49dFOF0BW5MfTg8ihK
 3xvIB3T9h1icnm7ow+lblYWAninffGqDB8/RhwkKCGdkts7neP593cNYyAMYoZpPA7FgyEQB
 DAhIHoQPO4sRBeARArIAwNmJK0BvCMhZAJXtl1ljBsDWiQ7OemP8TQpgjXwAp3LLOOxB18jr
 T1pN4aQdVEwqcL02JeMBbE821IdQ8jsCE/5UrG6YkG4wMbUe02uM3A4rqm+vcj7pBGszBjB2
 zhIWlb1EFYAgDHQ8PXmH/h5IvubCwfYiwGZcYfxgGs5qEzihquSyehNcqc1G2MI1AEc0JVz2
 kARgz9W0tbYD/KRZxPULKLkLltbZsvgIvJ83h+kxJI3gwKSxHqM6ebc6FWUxH95IELBpK5ih
 Uv6bberqXovQcDLOnn2fVwAWaH8jd4Blxv+tHAAKgRkTJpf4MfL9UuaSjVwskYdJ/WwuBEvK
 ge4zdSyrZmtA3dL5ZkASQGjIF82Uegs44nB5pKQZQAIVmvJr4nSI7yOOjGJkwWdlYUGMvBlY
 EJjQjH/g8Q8vAeknDmUCGSaEka27CGFgHgu2nmgjxMePbVF6Oj8xcteOS0ezbHydAuNb3Pum
 Fr+mZqbE1HvtrS2JmPGwCDiZmGls9e6nlfDiSkOEo8hlz5lGEddKVLX01jA/aGffRt9Qt0Uf
 pb1rp3N/Vvr8mPWCRuIxue26unTULVx9Wnm0QhuFbzxU1eWizl7BMkU541+iPYWY3F9stxuV
 ycV/AbKNHBlIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7pVAhviDOYuNbboPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2eHbrJLPFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNVi
 +dl5bA68HmvmrWH02PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HN4/2+q2we
 fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl3H10gOWgqkSFce/z2BsYLwv3MXIySEhYCLx/MxExi5GLg4hgaWMEt0HmxghEjIS
 J6c1sELYwhJ/rnWxQRR9YpS4+GkdWIJNwFCi6y1EQkSgk1FiWvdHdhCHWeADk8S/v//YQKqE
 BfwlZq/cCDaWRUBVYvO2fjCbV8BWYuesGywQK+QlVm84wNzFyMHBCRSf2asOEhYSyJe4+/Qf
 ywRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2XbsZ+bdzBe2hh8iFGAg1GJhzfi
 8/o4IdbEsuLK3EOMEhzMSiK8O1qAQrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjOO8knhD
 U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MIekHj505vuwz6x4F8QOb
 dM8erzvxK5azf57GuabPUhVpmxVuZ7p6TV2TwWS4746f8Y4Cl1X3Vvz90vzQWv+BhNS7Cd9/
 GL/7cvJtR6Xormu7Xhm/spLOPMOXwsC0ewrbM6/UlXn5vwNV/ij8/3JqtvO3p7+Wfd9xL+Xi
 GsMNOro5DqmvbMRfcSmxFGckGmoxFxUnAgAuUHJ8qwIAAA==
X-CMS-MailID: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
X-Msg-Generator: CA
X-RootMTR: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96@eucas1p1.samsung.com>
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
 drivers/gpu/drm/virtio/virtgpu_object.c | 11 ++++++-----
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  8 ++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6ccbd01..12f6bee 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -73,7 +73,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 		if (shmem->pages) {
 			if (shmem->mapped) {
 				dma_unmap_sg(vgdev->vdev->dev.parent,
-					     shmem->pages->sgl, shmem->mapped,
+					     shmem->pages->sgl,
+					     shmem->pages->orig_nents,
 					     DMA_TO_DEVICE);
 				shmem->mapped = 0;
 			}
@@ -157,13 +158,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	}
 
 	if (use_dma_api) {
-		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
+		shmem->pages->nents = dma_map_sg(vgdev->vdev->dev.parent,
 					   shmem->pages->sgl,
-					   shmem->pages->nents,
+					   shmem->pages->orig_nents,
 					   DMA_TO_DEVICE);
-		*nents = shmem->mapped;
+		*nents = shmem->mapped = shmem->pages->nents;
 	} else {
-		*nents = shmem->pages->nents;
+		*nents = shmem->pages->orig_nents;
 	}
 
 	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9e663a5..661325b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -604,8 +604,8 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+				       shmem->pages->sgl,
+				       shmem->pages->orig_nents, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1020,8 +1020,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+				       shmem->pages->sgl,
+				       shmem->pages->orig_nents, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
