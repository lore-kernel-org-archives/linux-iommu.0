Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC473C4345C
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26D9208E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ludYorbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26D9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1ADA86B8C;
	Wed, 26 Aug 2020 06:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9pzJvrtpccEl; Wed, 26 Aug 2020 06:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0297286BCB;
	Wed, 26 Aug 2020 06:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D871BC0891;
	Wed, 26 Aug 2020 06:35:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60884C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 451CD86B13
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qK1NMF2iIuNV for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8089286B60
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063543euoutp026717dedc4d8410120e8c42c923d83fc0~uvezs0Yf91510015100euoutp02h
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063543euoutp026717dedc4d8410120e8c42c923d83fc0~uvezs0Yf91510015100euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423743;
 bh=K2OO+ArQpNbr9py9lvtOZt7FGEEqICWRpeqEX/cK+vw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ludYorbefgNijss76Xrw6Cddy0RaLRlCRmio4lY+aG6mcpt9JbRNIgkUA+kuXxOZ1
 hFO3jzXHwR+Wqhvs9nfmL2R2E8e9ygtIy1qEpAMdQIUNVI+WVVuOWuEoIghXulCGDV
 SnWOLTVbTYAcZ139d8shGe+Bt8jrvMIwMAcbWV6k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063542eucas1p2ada057cab94cea9000995fd1ebfe1387~uvezOnfVE0398303983eucas1p2Y;
 Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.5D.06318.EB2064F5; Wed, 26
 Aug 2020 07:35:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063542eucas1p1713d37f4589ddaca27e1968b5fe44027~uvey3rdEC1474114741eucas1p1q;
 Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200826063542eusmtrp20c68a6c1cdb7a94833204a11b04ea18d~uvey2-q7f0466204662eusmtrp2c;
 Wed, 26 Aug 2020 06:35:42 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-f1-5f4602beede1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.53.06017.EB2064F5; Wed, 26
 Aug 2020 07:35:42 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063541eusmtip294447d0154a85766f83400ec8c228562~uveySDRKu2993829938eusmtip2k;
 Wed, 26 Aug 2020 06:35:41 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 24/32] drm: host1x: fix common struct sg_table related
 issues
Date: Wed, 26 Aug 2020 08:33:08 +0200
Message-Id: <20200826063316.23486-25-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTQQB1dtvdpVBdFwwTMJg0ESMJUIImmwAeCLgfJh7hRxPFAhtopIW0
 gGBIJBoMlKIcGhEViqLchxXK0YhQgaJolUMFFREQr4hIOAREsMuC/r15x7yXyRAoZRA6EXJl
 LKtSyqIkmEhg6Ji3uDcjQSHSBb0TnWF5jND3cquF9LIhC6X7ZiYwurS8HaF1D33o6b5hhNaP
 vhLSvU03MDptOg+jK9sGcbr150chPd+UL9gjZiryKwDzYFYnYBrzBnGmfvaDkBlKNyPM/aKz
 zNulUZTJ6S8GjHEgGWMu1pYBZkrvcsj2mMg3nI2Sx7Mqz10nRZG/sk1YzB3nhNoJM54MvmzS
 ABsCkjtgYXIDrgEigiJLAMypb0M5gSKnASzodeeFKQAzm9qRtcSfuWkBLxQDWLVQsxq3JuZu
 p2CcCyO9oGZcs4IdyBQAOzPsOBNKjiAw7XW3tYMg7MkjsKA5mPMIyK1waP6zkMNichdMeW/B
 +LYtsLymZWWSjZU3p1/CuHsgacKhOf/C6qQAuHjXCHhsD7+Za3Eeb4bLjQUIHzgP4LClEucP
 WgB7z+WuJnzgO8sCxi1Cye2wusmTp/fCm21zCEdDcj3sH9/I0agVZhuuojwthqkXKN7tCvPM
 Vf9qW1/0oDxmoPHaLOAfKAvA792X8UywJe9/mQ6AMuDIxqkVEazaW8me9lDLFOo4ZYRHWLRC
 D6y/qWvJPNMAmhdDTYAkgMROrMMCQyihLF6dqDABSKASB7H/s64TlDhclniGVUWHqOKiWLUJ
 OBMCiaPY+9bX4xQZIYtlT7FsDKtaUxHCxikZ7AcDOQevd1KHE5LI1CvUa78GyVah47ng9iK9
 pg57JGflOf2KsLSe/iJHo7Gwzs115OUbrevuJK00NGDs975W6Y+AAkvpgZ1p5Ud1UtvO5+OZ
 k/652qiIoA2GqY6lT9p1TriLSBI/KFGGR6dvc3hSMuYbOFn+9Fp8pF+Ls68pUiJQR8q83FCV
 WvYXOwW0gkkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7r7mNziDaZdZLHoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZtH5ZRabxdojd9ktDn54wmrx
 c9c8FgdejzXz1jB67P22gMVj56y77B7bvz1g9bjffZzJY/OSeo/b/x4ze0y+sZzRY/fNBjaP
 vi2rGD0+b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcks
 Sy3St0vQy/g+6RBbwVLpii3vj7M3ML4Q7WLk5JAQMJH4++MLSxcjF4eQwFJGifmfDzJDJGQk
 Tk5rYIWwhSX+XOtigyj6xCjR1/2PHSTBJmAo0fUWIiEi0MkoMa37IzuIwyzwikniw59WRpAq
 YYEAiYPzroGNYhFQlbj/8zmYzStgJ9F67xwbxAp5idUbDoCt5gSKH+/uB4sLCdhKnF47g3kC
 I98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgdGy7djPLTsYu94FH2IU4GBU4uFdwOYa
 L8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAR01klhJNzgdGcl5JvKGp
 obmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkZBLbOJBX88NZl+PHi0Nukl
 g/eUAveje+8235J83ju78J6xUt1JZ3X+QrNfLovOxmhPiDN027OEzaHBWPbQopKtWnvf+6q7
 rD5/s+yjzNfYAk+bIA+LNvHKBX48iyo+NDnf36Vov/35jNPCjDLzLXrrn7mv/lVVfatbsFvW
 8dNbgzYW5bb6FCWW4oxEQy3mouJEAKnmdfKsAgAA
X-CMS-MailID: 20200826063542eucas1p1713d37f4589ddaca27e1968b5fe44027
X-Msg-Generator: CA
X-RootMTR: 20200826063542eucas1p1713d37f4589ddaca27e1968b5fe44027
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063542eucas1p1713d37f4589ddaca27e1968b5fe44027
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063542eucas1p1713d37f4589ddaca27e1968b5fe44027@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org,
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
---
 drivers/gpu/host1x/job.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 89b6c14b7392..82d0a60ba3f7 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -170,11 +170,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dev, sgt, dir, 0);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dev = dev;
 			job->unpins[job->num_unpins].dir = dir;
@@ -228,7 +226,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (host->domain) {
-			for_each_sg(sgt->sgl, sg, sgt->nents, j)
+			for_each_sgtable_sg(sgt, sg, j)
 				gather_size += sg->length;
 			gather_size = iova_align(&host->iova, gather_size);
 
@@ -240,9 +238,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto put;
 			}
 
-			err = iommu_map_sg(host->domain,
+			err = iommu_map_sgtable(host->domain,
 					iova_dma_addr(&host->iova, alloc),
-					sgt->sgl, sgt->nents, IOMMU_READ);
+					sgt, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
 				err = -EINVAL;
@@ -252,12 +250,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			job->unpins[job->num_unpins].size = gather_size;
 			phys_addr = iova_dma_addr(&host->iova, alloc);
 		} else if (sgt) {
-			err = dma_map_sg(host->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(host->dev, sgt, DMA_TO_DEVICE, 0);
+			if (err)
 				goto put;
-			}
 
 			job->unpins[job->num_unpins].dir = DMA_TO_DEVICE;
 			job->unpins[job->num_unpins].dev = host->dev;
@@ -660,8 +655,7 @@ void host1x_job_unpin(struct host1x_job *job)
 		}
 
 		if (unpin->dev && sgt)
-			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->nents,
-				     unpin->dir);
+			dma_unmap_sgtable(unpin->dev, sgt, unpin->dir, 0);
 
 		host1x_bo_unpin(dev, unpin->bo, sgt);
 		host1x_bo_put(unpin->bo);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
