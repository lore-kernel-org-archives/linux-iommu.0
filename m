Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10509C433E8
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84AC206FA
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EL2HBQxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84AC206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4EEB87C2C;
	Thu, 18 Jun 2020 15:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shqcavrAIAKq; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5D4787C1E;
	Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92BA3C0892;
	Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71CD8C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C017888DA
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mycH65qoYYbT for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6243088893
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:23 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154021euoutp01e53ef272fa19c01ed093267a9091c591~ZrZpTBUqT1844818448euoutp010
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200618154021euoutp01e53ef272fa19c01ed093267a9091c591~ZrZpTBUqT1844818448euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494821;
 bh=3Uytyvwzt4UX7mjIW5nSX3tNMM/3bhp/av3KF6qTx7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EL2HBQxnN2kdb+a95a3OPv2ohNo5d8J3gdWk2Gl/fF+CyzjJG7IgZlS+0AIbuwTQh
 DMA86r6imcOLEFr+6eNYjII3vZisHBZWIIq6xidOPLZsWMWgynPDk4cEiRCdaLNqk3
 50U5fWYKJW87P75aueU4Dk+7pRzXLBDt/9pZhy7o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200618154021eucas1p24f39a100f171d5d25c5ee8d07d8d9418~ZrZo_MlaL2924929249eucas1p2D;
 Thu, 18 Jun 2020 15:40:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.1F.61286.5EA8BEE5; Thu, 18
 Jun 2020 16:40:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154020eucas1p2d823db666c8706f63ed352fee3c3c90c~ZrZonBZyE2977729777eucas1p2D;
 Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154020eusmtrp26d0f44624adb3f9ba83ef666d47b06f2~ZrZomaX4t0399203992eusmtrp2W;
 Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-c8-5eeb8ae51fa0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.EE.08375.4EA8BEE5; Thu, 18
 Jun 2020 16:40:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154020eusmtip171024e854b53111fcce79a4f25a51737~ZrZn8u3lF0744107441eusmtip1y;
 Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/36] drm: lima: fix common struct sg_table related issues
Date: Thu, 18 Jun 2020 17:39:31 +0200
Message-Id: <20200618153956.29558-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c7Z2Y6XxWmafixJGiSUeE3hhCUmIuefQDIwAi8zTyrpJjtq
 GpSiGDovZJm3TEdI5mWbN2YqTl3pDHHaFDXTvBVhYlpeQgNtp6P23+97n/d5n5eXD0dF7ZgY
 j5cl0wqZNEHCt+bpBndH3b4qVyM8l5qtyELTe4RsKddi5IGuGCUnttf5ZH3jAEKqev3IzepW
 Prk1sYiQrcuTGDneVcUn1e/mBGT/xheM3FBvIwFCqqm6CVA9Oyoe1Vk5J6A6dhYwaj7fiFBt
 tRnUp/1llHo6XQeo7o+ZfKqovQFQm61nQmxuWV+OoRPiU2mFh3+UdVzftwOQ9Fmctm64kQmq
 HZTACoeED/wwlcdTAmtcRLwGsKVqFmMFEbEFoL4+nhM2AdzfKwJHjr69PQEn1AHYpq8XHDvy
 Rq+xzCe8oHJNyWfZnsgBcKjQljWgxDgCawayeKxgR4TABa0BYZlHnIPdJv2/aCHhD7M0pRiX
 5gwbm/tQlq0s9WFjDsYOgoReAItMWgHXFAQ1k+bD9ezgd2P7Yd0JHnTWIJwhG8BFk1rAPQoA
 HM8qP3T4wVnTnmVX3LLfeajt8mAREldh9poXhyfg9NpJthm14BNdGcqVhTD3kYib4QIrjZrj
 1P4xM8oxBXd+zmDcsYoBLO8rRx8D58r/WSoAGoAjncIkxtKMl4y+585IE5kUWaz7bXliK7D8
 peF94683YNscbQAEDiS2woCw1QgRJk1l0hMNAOKoxF4YODIcIRLGSNPv0wp5pCIlgWYM4DTO
 kzgKL75cCRcRsdJk+i5NJ9GKIxXBrcSZoHHqiuelukEHeVf07+mcah6tzY0vDvft3akzE+Nh
 HeDOVBm5EhksTlOJSyvzU8eY0Iie+bY/jbXGghmdPnO35Pq6MqgiMAoZan+FSm7uFp8Fg8G7
 Tipfh4KHuldyl1MVz0LVNqqMkn3Xtz6y5z+8FQ/cvJtLXUcWNUstzNwLCY+Jk3pdQBWM9C8J
 2LnwRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7pPul7HGaw+YWDRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8XneJjaLL1ceMllsenyN1eLyrjlsFmuP3GW3OPjhCavF
 h7VfmRx4PdbMW8PosffbAhaPnbPusnts//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
 +rasYvT4vEkugDtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
 LLVI3y5BL+PA8/+MBfekKt4fCmlgnCfWxcjJISFgInHg1y/2LkYuDiGBpYwS/+f/YYFIyEic
 nNbACmELS/y51sUGUfSJUaLtzn1mkASbgKFE11uIhIhAJ6PEtO6PYKOYBW4zSZyZOwGsSljA
 T+LyhB1gNouAqsTuc/vAxvIK2Ek0rZsGtUJeYvWGA2A1nEDx08dbweJCArYSzz+0sU1g5FvA
 yLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMFa2Hfu5eQfjpY3BhxgFOBiVeHhfhLyOE2JN
 LCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wPjOK8k3tDU0NzC
 0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Ol0V+BnQV3OrQXPzj2UYtL5IYE
 zyU5w6/+vWp5ipUpUmfybNOObTcRLGc8eKOU/X+ep0vKQ6aPMWxhuxc5tBpNKZrYHvHLT/eR
 yIXj8hO/qR80LXXr9Ha59KTJTr65WERk/4FEq5L4H+/cPh2YtsW6+OPdk+Ep3YuW8LV4t19b
 kSZwg/vQGSWW4oxEQy3mouJEAHJLSFCrAgAA
X-CMS-MailID: 20200618154020eucas1p2d823db666c8706f63ed352fee3c3c90c
X-Msg-Generator: CA
X-RootMTR: 20200618154020eucas1p2d823db666c8706f63ed352fee3c3c90c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154020eucas1p2d823db666c8706f63ed352fee3c3c90c
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154020eucas1p2d823db666c8706f63ed352fee3c3c90c@eucas1p2.samsung.com>
Cc: lima@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Qiang Yu <yuq825@gmail.com>,
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
Reviewed-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_gem.c | 11 ++++++++---
 drivers/gpu/drm/lima/lima_vm.c  |  5 ++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 155f2b4b4030..11223fe348df 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -69,8 +69,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		return ret;
 
 	if (bo->base.sgt) {
-		dma_unmap_sg(dev, bo->base.sgt->sgl,
-			     bo->base.sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
 		sg_free_table(bo->base.sgt);
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
@@ -80,7 +79,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		}
 	}
 
-	dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
+	ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret) {
+		sg_free_table(&sgt);
+		kfree(bo->base.sgt);
+		bo->base.sgt = NULL;
+		return ret;
+	}
 
 	*bo->base.sgt = sgt;
 
diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
index 5b92fb82674a..2b2739adc7f5 100644
--- a/drivers/gpu/drm/lima/lima_vm.c
+++ b/drivers/gpu/drm/lima/lima_vm.c
@@ -124,7 +124,7 @@ int lima_vm_bo_add(struct lima_vm *vm, struct lima_bo *bo, bool create)
 	if (err)
 		goto err_out1;
 
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter, bo->base.sgt->nents, 0) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, 0) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       bo_va->node.start + offset);
 		if (err)
@@ -298,8 +298,7 @@ int lima_vm_map_bo(struct lima_vm *vm, struct lima_bo *bo, int pageoff)
 	mutex_lock(&vm->lock);
 
 	base = bo_va->node.start + (pageoff << PAGE_SHIFT);
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter,
-			     bo->base.sgt->nents, pageoff) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, pageoff) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       base + offset);
 		if (err)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
