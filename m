Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8945C2D0E0
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22EC20DD4
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r+PfQ9ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22EC20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A24BB86E00;
	Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIOEwBzECkrp; Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 334C886DCB;
	Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC43C08A5;
	Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0D5C0890
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4175D86C39
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKd8f8B8v7cb for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D828186C71
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133505euoutp016c79d1354688735a9dba6f00feb0e700~xmAiZgzT80639206392euoutp01H
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133505euoutp016c79d1354688735a9dba6f00feb0e700~xmAiZgzT80639206392euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226505;
 bh=8SvVp249TnvdrtsN3cK9UiYXaHvxLMtfidsvZb7ATx0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r+PfQ9ZWYG2lYdfz56e6fenQckcSDVK6y6adnzmYlyuJg18feaETuF1AvCC2svdFp
 SUVGVWQnR93QgxTtK9HYy9uwuzsPPOxLfHvDt1FX7p5bJL9k0kaegH+E5jP5OzCvD7
 MuSImBuWB7pFwQngy0CyHMPTBEUjHgyUtmSn4Yhg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133505eucas1p26123743dd9542f9b2808ba52cdc2d1b5~xmAiHT8Sw0693606936eucas1p2Q;
 Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.66.05997.882425F5; Fri,  4
 Sep 2020 14:35:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133504eucas1p10e30fbcb69c2c0627ab7a83fb1b69759~xmAhueCER0117101171eucas1p1q;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904133504eusmtrp14446130178a02ad84a8ee9bd89bdf48d~xmAht28Ev0766507665eusmtrp1C;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-6b-5f524288ec72
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.BE.06314.882425F5; Fri,  4
 Sep 2020 14:35:04 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133504eusmtip1308c574468bbe4478fb8939435cfda1e~xmAhKhkRC1939819398eusmtip14;
 Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 18/30] drm: v3d: fix common struct sg_table related issues
Date: Fri,  4 Sep 2020 15:16:59 +0200
Message-Id: <20200904131711.12950-19-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7odTkHxBpd3Wlv0njvJZLFxxnpW
 i//bJjJbXPn6ns3iQONlRouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfNYu2Ru+wWBz88YXXg
 8Wh6f4zNY828NYwee78tYPHY/u0Bq8f97uNMHpuX1Hvc/veY2WPyjeWMHrtvNrB59G1Zxejx
 eZNcAHcUl01Kak5mWWqRvl0CV8bHg29YCxaJVMy9uoCxgfGdQBcjJ4eEgIlE2+GNTF2MXBxC
 AisYJU7vX8sC4XxhlFh8eBE7hPOZUeL205MsMC2PGg8zQiSWM0q09X9khGtZ8205O0gVm4Ch
 RNfbLjYQW0SglVHiRC8PSBGzwE4miUWdexhBEsICARL3e5+D2SwCqhLX276zgti8AnYSt54t
 Z4JYJy+xesMBZhCbEyi+dcYTVpBBEgL72CWmXPnKCFHkIrFz9SY2CFtY4tXxLewQtozE6ck9
 LBANzYwSD8+tZYdwehglLjfNgOq2lrhz7hdQNwfQfZoS63fpQ4QdJVY9AoUAB5DNJ3HjrSBI
 mBnInLRtOjNEmFeio00IolpNYtbxdXBrD164xAxhe0i8654BDceJjBLdq5ayT2CUn4WwbAEj
 4ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzApHT63/EvOxh3/Uk6xCjAwajEw8tgHxQv
 xJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGan
 phakFsFkmTg4pRoYVZc7BVxb/4zNO1tT9OXLC+aSUdyN+d5WokoOEe0CMU9uNovpf3p7Qldy
 berHino9//xPExcL3C71kazW0X24VFSttNX9powL940sbb3lJ/8rP19ffbdTO4T9fLLfk57l
 R2ZrFnFHRbp+vvLyzKoVMxOmiQafvavffXDZIe2FOrrfDi5vFJuixFKckWioxVxUnAgA65Sr
 5kYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7odTkHxBte3q1j0njvJZLFxxnpW
 i//bJjJbXPn6ns3iQONlRouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfNYu2Ru+wWBz88YXXg
 8Wh6f4zNY828NYwee78tYPHY/u0Bq8f97uNMHpuX1Hvc/veY2WPyjeWMHrtvNrB59G1Zxejx
 eZNcAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
 XsbHg29YCxaJVMy9uoCxgfGdQBcjJ4eEgInEo8bDjF2MXBxCAksZJVbNbGGHSMhInJzWwAph
 C0v8udbFBlH0iVFiztq9LCAJNgFDia63EAkRgU5GiWndH9lBHGaB/UwSl4+cAhslLOAnsWRC
 P5jNIqAqcb3tO9hYXgE7iVvPljNBrJCXWL3hADOIzQkU3zrjCViNkICtxIc5i1kmMPItYGRY
 xSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgj24793LyD8dLG4EOMAhyMSjy8DPZB8UKsiWXF
 lbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5Hxg/OaVxBuaGppbWBqa
 G5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCUYmypO7SR9bNN7GUV3gmz99tYTmwx
 LwwXmHG6Yd1N7gjbr/1/Ntlf453gb3clYes0dhneIxavn3ncmMyW7GntO919QmPTqV2H9luq
 Naklbjxo07nl4cvL3g+C7629u7xrm53hYt/fc6Y8er+oYs8iR2/7hmdaRhNmdzcnlS7oq58t
 8ps11JFbiaU4I9FQi7moOBEA30xTaqcCAAA=
X-CMS-MailID: 20200904133504eucas1p10e30fbcb69c2c0627ab7a83fb1b69759
X-Msg-Generator: CA
X-RootMTR: 20200904133504eucas1p10e30fbcb69c2c0627ab7a83fb1b69759
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133504eucas1p10e30fbcb69c2c0627ab7a83fb1b69759
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133504eucas1p10e30fbcb69c2c0627ab7a83fb1b69759@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
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
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_mmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index 3b81ea28c0bb..5a453532901f 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -90,18 +90,17 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo)
 	struct v3d_dev *v3d = to_v3d_dev(shmem_obj->base.dev);
 	u32 page = bo->node.start;
 	u32 page_prot = V3D_PTE_WRITEABLE | V3D_PTE_VALID;
-	unsigned int count;
-	struct scatterlist *sgl;
+	struct sg_dma_page_iter dma_iter;
 
-	for_each_sg(shmem_obj->sgt->sgl, sgl, shmem_obj->sgt->nents, count) {
-		u32 page_address = sg_dma_address(sgl) >> V3D_MMU_PAGE_SHIFT;
+	for_each_sgtable_dma_page(shmem_obj->sgt, &dma_iter, 0) {
+		dma_addr_t dma_addr = sg_page_iter_dma_address(&dma_iter);
+		u32 page_address = dma_addr >> V3D_MMU_PAGE_SHIFT;
 		u32 pte = page_prot | page_address;
 		u32 i;
 
-		BUG_ON(page_address + (sg_dma_len(sgl) >> V3D_MMU_PAGE_SHIFT) >=
+		BUG_ON(page_address + (PAGE_SIZE >> V3D_MMU_PAGE_SHIFT) >=
 		       BIT(24));
-
-		for (i = 0; i < sg_dma_len(sgl) >> V3D_MMU_PAGE_SHIFT; i++)
+		for (i = 0; i < PAGE_SIZE >> V3D_MMU_PAGE_SHIFT; i++)
 			v3d->pt[page++] = pte + i;
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
