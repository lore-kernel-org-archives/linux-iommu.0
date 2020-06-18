Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF0C43459
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E1C20890
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m4D9YoDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E1C20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CA980896A0;
	Thu, 18 Jun 2020 15:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uz-njFyVo5sv; Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A36878968D;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5AFC0892;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5CDC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84D6E895CB
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVgX90QwJei7 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 420C5895C5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154030euoutp01baa000276cac8a054fc1e6a35e45aee3~ZrZxv1Fly1845018450euoutp01C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200618154030euoutp01baa000276cac8a054fc1e6a35e45aee3~ZrZxv1Fly1845018450euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494830;
 bh=sMb+Mv9Dts6uUUOaPB9xk7pdpjF26BUiX5CJmeVUofs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m4D9YoDtavHq+3LzGxxaZhVpC0sSsQQZzfLVKx0H40E+hsAz32mC27bV//3smkpDP
 D4R+Ex4klaoyU5pxyBkyuorGWQbuf0+obQNKc0UvmUco5j3wfH9FxePuvxhTjmPKgt
 To26Z5c6l8oWo0e9cJM+PLp3YFH3FfU9PVGTHJEI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154030eucas1p1df9f9ba2d8f63e37ed6574baa6b41401~ZrZxezWVE0074000740eucas1p1D;
 Thu, 18 Jun 2020 15:40:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.1F.61286.EEA8BEE5; Thu, 18
 Jun 2020 16:40:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d~ZrZxHjXT80608706087eucas1p2Z;
 Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154029eusmtrp1efb981a9bc98b975c3e96d2e9e3a2289~ZrZxGzYWS2169821698eusmtrp1k;
 Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-dc-5eeb8aeec338
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.E9.07950.DEA8BEE5; Thu, 18
 Jun 2020 16:40:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154029eusmtip1cf112f2b00c4845d77120cb512973c04~ZrZwbXNA50864308643eusmtip1M;
 Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 23/36] drm: vmwgfx: fix common struct sg_table related
 issues
Date: Thu, 18 Jun 2020 17:39:44 +0200
Message-Id: <20200618153956.29558-24-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7rvul7HGVw7wm/Re+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVq8OXKM0eLyrjlsFmuP3GW3OPjhCavF
 6k5HB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fn
 TXIe7+a/ZQvgjuKySUnNySxLLdK3S+DK+Nb9lL2gT7xia8sv9gbGBcJdjJwcEgImEkf3z2ft
 YuTiEBJYwSix5uBnNgjnC6PEwqlXGSGcz4wSd3ufsMO0vHx+DqpqOaPElTfbWOFaOj4uZQSp
 YhMwlOh628UGYosItDJKnOjlASliFvjLJHHp8SRWkISwQJDE2nmHmUBsFgFViXU/5oE18ArY
 STxa9I4JYp28xOoNB5hBbE6g+OnjrWDbJAQOsUs8/dIFVeQisah9IpQtLPHq+BaoW2UkTk/u
 YYFoaGaUeHhuLTuE08MocblpBiNElbXEnXO/gFZzAN2nKbF+lz5E2FHiXt8mRpCwhACfxI23
 giBhZiBz0rbpzBBhXomONiGIajWJWcfXwa09eOESM4TtIbH48CWwRUICExklbl1LnMAoPwth
 1wJGxlWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBqen0v+OfdjB+vZR0iFGAg1GJh9ch
 /HWcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Y
 kpqdmlqQWgSTZeLglGpgtPZoK9vKO/PDjoMTWT5fajvOLT75rPH6exHblf8e3cbteevg9L7y
 5ZeaCrKnl7ix//LT1ZsyX7lSTa3W/9zFui3a4f6y0SI6q58vc5u7zqpVlnl1gHZuc07B51su
 BvMUA52nXMy2Vl8dckMj7EnPHG3JZaJe842Cly9Kfl3WmJwnovRG/MIDJZbijERDLeai4kQA
 AgRoZ0kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7pvu17HGby5aWLRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVq8OXKM0eLyrjlsFmuP3GW3OPjhCavF
 6k5HB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fn
 TXIe7+a/ZQvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
 LdK3S9DL+Nb9lL2gT7xia8sv9gbGBcJdjJwcEgImEi+fn2PrYuTiEBJYyihxZH0jI0RCRuLk
 tAZWCFtY4s+1LqiiT4wSDzfPZANJsAkYSnS9hUiICHQySkzr/sgOkmAWaGaWOP+yFsQWFgiQ
 WH/iIFicRUBVYt2PeWDNvAJ2Eo8WvWOC2CAvsXrDAWYQmxMofvp4K9hmIQFbiecf2tgmMPIt
 YGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgp24793LKDsetd8CFGAQ5GJR7eFyGv44RY
 E8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnAKM4riTc0NTS3
 sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC45fRs5a9lRQ57tS6s5W9+pSJs
 Zrd6qrnJpC9PXX5u62TJn/PHMY3/RaOg2mW9z3O/2iZnuasse+f15rqoygWHBW9emGydxMmd
 U8617YTFtCuf73U2vjzgc7u+4i+7d9HkstN/ReU1vCq3FF4TKdnz8bwX04qAeG1mzqB19lbR
 RyJfSK7zm2arxFKckWioxVxUnAgANn8hQqoCAAA=
X-CMS-MailID: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
X-Msg-Generator: CA
X-RootMTR: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Roland Scheidegger <sroland@vmware.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
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
Acked-by: Roland Scheidegger <sroland@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index bf0bc4697959..49ed6add6969 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -362,8 +362,7 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
 
-	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
-		DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 }
 
@@ -383,16 +382,8 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 static int vmw_ttm_map_for_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
-	int ret;
-
-	ret = dma_map_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.orig_nents,
-			 DMA_BIDIRECTIONAL);
-	if (unlikely(ret == 0))
-		return -ENOMEM;
 
-	vmw_tt->sgt.nents = ret;
-
-	return 0;
+	return dma_map_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 }
 
 /**
@@ -449,10 +440,10 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 		if (unlikely(ret != 0))
 			goto out_sg_alloc_fail;
 
-		if (vsgt->num_pages > vmw_tt->sgt.nents) {
+		if (vsgt->num_pages > vmw_tt->sgt.orig_nents) {
 			uint64_t over_alloc =
 				sgl_size * (vsgt->num_pages -
-					    vmw_tt->sgt.nents);
+					    vmw_tt->sgt.orig_nents);
 
 			ttm_mem_global_free(glob, over_alloc);
 			vmw_tt->sg_alloc_size -= over_alloc;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
