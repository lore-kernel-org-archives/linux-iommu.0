Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230AC81830
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2892020714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j++Gxhxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CDA6F87079;
	Tue, 12 May 2020 09:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8SYbp6Nm2R4; Tue, 12 May 2020 09:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 057BD86C2B;
	Tue, 12 May 2020 09:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0062C0893;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3210CC0893
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1F12C89161
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ESk-8W6+6JB for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 69E1B88DB4
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:31 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090129euoutp02d8e2126d097d9d5ed905647af7374b22~OPF1MRUq10453404534euoutp02j
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090129euoutp02d8e2126d097d9d5ed905647af7374b22~OPF1MRUq10453404534euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274089;
 bh=E1NfBBxSojUDLapgMB8Y02kKeGolZNH/an6hkCuIGIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j++GxhxxYfM+r97XJyq3crmV1wh9UHsrUuYP5jz3KXE0uNJs18EY/ymxDbrZHSJc0
 90/79NoA5mByXgeBL8Lc+TlVx5AFpjovZhhMJuC9QLjJvcQi3RxOQd9MtM6QdIBNS3
 Olx/BkrKLEOJHSiwyniJdAY5X4y1iMpUthxgjTx4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090129eucas1p2e54bcc15c8de5a27e05eb20ec668d4ef~OPF06qyG02180321803eucas1p2C;
 Tue, 12 May 2020 09:01:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.67.61286.9E56ABE5; Tue, 12
 May 2020 10:01:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090129eucas1p2e67c8a9adafb202970a59c3412cd887a~OPF0orOhz2661826618eucas1p2n;
 Tue, 12 May 2020 09:01:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090129eusmtrp1cc27ec6d1a740863c5c174195c999886~OPF0n7TdP0188101881eusmtrp1f;
 Tue, 12 May 2020 09:01:29 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-b4-5eba65e97ca9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.03.07950.9E56ABE5; Tue, 12
 May 2020 10:01:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090128eusmtip14ace71a0d963c54a40acb63ce54fcc29~OPF0Csyzt1181011810eusmtip1w;
 Tue, 12 May 2020 09:01:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 36/38] samples: vfio-mdev/mbochs: fix common struct
 sg_table related issues
Date: Tue, 12 May 2020 11:00:56 +0200
Message-Id: <20200512090058.14910-36-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7ovU3fFGXyerWTRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9tMWdqocWW03MZLb5cechksenxNVaLy7vmsFmsPXKX3eLg
 hyesDrwea+atYfTY+20Bi8f2bw9YPe53H2fy2Lyk3uP2v8fMHpNvLGf02H2zgc2jt/kdm0ff
 llWMHp83yQVwR3HZpKTmZJalFunbJXBlHGvkLLglVDG9o5+tgfEyfxcjJ4eEgInE3NVTWEBs
 IYEVjBIr7ll0MXIB2V8YJZaffcYO4XxmlHi9dCkTTMfMl/uhEssZJT6/fMIM13J0/RRGkCo2
 AUOJrrddbCC2iEAro8SJXh6QImaBa0wSb/++Y+1i5OAQFkiQWP+aG6SGRUBV4lnXNLBeXgE7
 idYFzewQ2+QlVm84wAxicwLF78//wwIyR0LgELvEm3MXmSGKXCRa1v6HOk9Y4tXxLVDNMhKn
 J/dANTQzSjw8t5YdwulhlLjcNIMRospa4s65X2wgFzELaEqs36UPEXaUeHvyKBNIWEKAT+LG
 W0GQMDOQOWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwCeo0D4lDX+axQQLoKKPEnrMvmCcwys9C
 WLaAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYFo6/e/4px2MXy8lHWIU4GBU4uHt
 MNoZJ8SaWFZcmXuIUYKDWUmEtyUTKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS
 1OzU1ILUIpgsEwenVANj38EnC+87sVhn8htIVHO7zDLco1Jz2cp2+T0Z3wMPdG+deLL81INN
 DD9jVe26uD0FcmfNUOXVz8049rFQ+bpJ7dnPqsJcHoViXKFe5hMK1eO3hW3uilv528p9QmWO
 s+6LVSf3ty8+cOHMQp/Dh881aRzf80/EO/fO6SaOmrO6v38+nqnLy1ahxFKckWioxVxUnAgA
 Y96ihUcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7ovU3fFGazp5bfoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2mDO10GLL6bmMFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObR2/yOzaNv
 yypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyjjVyFtwSqpje0c/WwHiZv4uRk0NCwERi5sv97F2MXBxCAksZJf5P2ccOkZCRODmt
 gRXCFpb4c62LDcQWEvjEKLHmRiGIzSZgKNH1FiTOxSEi0MkoMa37I1gzs8A9Jom96/xAbGGB
 OIkT+1eBDWIRUJV41jWNEcTmFbCTaF3QDLVMXmL1hgPMIDYnUPz+/D8sEMsKJR5dfcsygZFv
 ASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAo2Xbs55YdjF3vgg8xCnAwKvHwdhjtjBNi
 TSwrrsw9xCjBwawkwtuSCRTiTUmsrEotyo8vKs1JLT7EaAp01ERmKdHkfGAE55XEG5oamltY
 GpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYJx4rCTj8sS0OqO3sY+XX356vPtV
 +PfVNmcmXtL+4rhp4V3D43yL8y6y1G/bs1vnzNRSkz7267tSP8g1fWK4dWlhyGLx5t981sGM
 RYLqTEdC1TJbFVyUGZXNnm8+Ncd8ue18Z9ddc9lOn/658dK6i/5+oT8fCPXtPdpQ/bN9f6rs
 KYuAJXZcakJKLMUZiYZazEXFiQCA1aSZqAIAAA==
X-CMS-MailID: 20200512090129eucas1p2e67c8a9adafb202970a59c3412cd887a
X-Msg-Generator: CA
X-RootMTR: 20200512090129eucas1p2e67c8a9adafb202970a59c3412cd887a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090129eucas1p2e67c8a9adafb202970a59c3412cd887a
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090129eucas1p2e67c8a9adafb202970a59c3412cd887a@eucas1p2.samsung.com>
Cc: kvm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Kirti Wankhede <kwankhede@nvidia.com>,
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

While touching this code, also add missing call to dma_unmap_sgtable.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 samples/vfio-mdev/mbochs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 3cc5e59..f2c62e0 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -846,7 +846,7 @@ static struct sg_table *mbochs_map_dmabuf(struct dma_buf_attachment *at,
 	if (sg_alloc_table_from_pages(sg, dmabuf->pages, dmabuf->pagecount,
 				      0, dmabuf->mode.size, GFP_KERNEL) < 0)
 		goto err2;
-	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
+	if (dma_map_sgtable(at->dev, sg, direction))
 		goto err3;
 
 	return sg;
@@ -868,6 +868,7 @@ static void mbochs_unmap_dmabuf(struct dma_buf_attachment *at,
 
 	dev_dbg(dev, "%s: %d\n", __func__, dmabuf->id);
 
+	dma_unmap_sgtable(at->dev, sg, direction);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
