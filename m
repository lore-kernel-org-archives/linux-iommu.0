Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A4C2D112
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E25120693
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cYmrTQQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E25120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C786892B1;
	Wed, 13 May 2020 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yefLxWPffBRF; Wed, 13 May 2020 13:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B8A3893A3;
	Wed, 13 May 2020 13:33:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11A63C0178;
	Wed, 13 May 2020 13:33:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2201C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A60AF8923B
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDF3AsiJJc+P for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E616288611
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133324euoutp02a27f60fa4c4f2a67006ba32436ba720a~Omcho5Z0H3219432194euoutp02T
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133324euoutp02a27f60fa4c4f2a67006ba32436ba720a~Omcho5Z0H3219432194euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376804;
 bh=4Z3VX9b95pVvmo5Br0ewCVmZiro3PYcbGcBRCw5/dy0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cYmrTQQOJQJYIxLbJOjPRjT9kBusZQNHJQBiSPgPHs/jpKQUf8agJzNoBWzwpY1IY
 fC4VkozQemM4WeoUyvG1roOv2ofSd5giJkVaW6SmMFPnBp+B/1X0Oq4yiffK9UfGYa
 /JbRDd0MyqdQQCzALACo3pidCdqOFiFtqAm7zPW4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133324eucas1p142c8a86befd97cefee286cdf022951dc~OmchRgFjH0785407854eucas1p1H;
 Wed, 13 May 2020 13:33:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.D5.61286.427FBBE5; Wed, 13
 May 2020 14:33:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133323eucas1p1519f5901d2a4ee85b781fcc36e9601f7~OmchAzpyr2351423514eucas1p1e;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133323eusmtrp10172f55b09fa88e4e962360e4035a246~OmchAHACf1050610506eusmtrp1h;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-89-5ebbf724c6de
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.47.07950.327FBBE5; Wed, 13
 May 2020 14:33:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133323eusmtip16dd11117bccd96d7b870b4e361de6129~OmcgSp9Av0693306933eusmtip1N;
 Wed, 13 May 2020 13:33:23 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 36/38] samples: vfio-mdev/mbochs: fix common struct
 sg_table related issues
Date: Wed, 13 May 2020 15:32:43 +0200
Message-Id: <20200513133245.6408-36-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGeXcuOy5Pnabgi0XS0MgolxR6RMtCPxxSog+BEKWuPKjpvOw4
 TSFamRVTlyahmZqYoum8tmZoeSudpZmpmddqaBcFzbxikbbtaH37vc//eXj+78tLIGIdZk+E
 R8WxiihZpAQXofqO1Z4DjiuNgQfrnwnp9J5XAro2pxqj1/WZCD2w9AOnH1W0C+jCZk86724s
 revKB/TigFFA100MYnR/Qx5OV74cF9Ktc5PYMZLRFmgB83y5EGXqlz9jzKdUg4B5XHyFGV2b
 QJisoVLANA6rcCY9eRZnNLpywCzU7Tq15YzIK4SNDI9nFdKjwaKwOVUHHmMUX2pSr2AqMLRN
 DawISB2GbzsaUDUQEWKqDEDN12HAHxYBbJyoxs0uMbUA4Id7bpuJd92ZQt5UCuCgdgHhTaZE
 WruPmXHKFapn1JawLZUCYGe6tTmAUIMCOPNnFjMPbKhg2F3ZLjQzSjlBo0FrYZI6Aq+maIR8
 mwOsqGmxFFiZ9OmxZpTXm4Sw8D7Jsy+8XXsT49kGTht0G9mdsCsrzXI3SCUDaOypFPKHNAD7
 r+UA3uUJx3p+mVYlTOs5w+oGKS8fh9/XZ1GzDKmtcGhmu1lGTHhHn43wMglv3RDz7j0w11D1
 r7a1tw/hmYFF+qmNx3oBYElOAZIBHHL/lxUCUA7sWCUnD2U51yg2wYWTyTllVKjLhWh5HTD9
 pa41w/xTsNR3vg1QBJBYk/RIY6AYk8VzifI2AAlEYkuerDZJZIgsMYlVRAcplJEs1wZ2EKjE
 jjxUNHVOTIXK4tgIlo1hFZtTAWFlrwJ2MSspfWpdgPe2Ip94Zzf6Y2cpuBjB/Xbxl/bimQEt
 vW7eSbspqV/o5GvdqKEk/qej/k1lnWeNJtVPOuK/JBStFjx0yC/2SKqNPZu57p4aNMoNP/AY
 VZ52KXNwytqvRqtOXM4p8bV9r1//In8yn6Fq+TaeUER2el3P7l1yd98rQbkwmes+RMHJ/gIq
 KpNhRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7rK33fHGUyYq2fRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9tMWdqocWW03MZLb5cechksenxNVaLy7vmsFmsPXKX3eLg
 hyesDrwea+atYfTY+20Bi8f2bw9YPe53H2fy2Lyk3uP2v8fMHpNvLGf02H2zgc2jt/kdm0ff
 llWMHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
 FunbJehlfGg4xlbwUKhiX9d31gbGG/xdjJwcEgImEhfPTGTvYuTiEBJYyihxas4EVoiEjMTJ
 aQ1QtrDEn2tdbBBFnxglNp1+xQ6SYBMwlOh6C5EQEehklJjW/REswSxwj0li7zo/EFtYIE7i
 0K0+JhCbRUBV4uHxNWA1vAK2Eo2tfewQG+QlVm84wAxicwLFX93ZzwJiCwnkS+xdvI9tAiPf
 AkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRsu3Yzy07GLveBR9iFOBgVOLhtbi1O06I
 NbGsuDL3EKMEB7OSCK/feqAQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wOjOK8k3tDU0NzC
 0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+M0pa8bnhzbMbOm4AFTgdZ+9dam
 VLsem4M/q0U/OCiZTbbPm3K+yuCF3cyoZqFv/b//PK3LcP6hlGVSHplUPnFPgwOv6pK9KYIv
 WPWyLmU4ikxd6vRWQSE2mvWbWmLkhLhb+2xkA1+mrcuTYxXZzJ+1VPbT4mUtL47FSu85cUho
 WcNFjktNXkosxRmJhlrMRcWJAIhhNxSqAgAA
X-CMS-MailID: 20200513133323eucas1p1519f5901d2a4ee85b781fcc36e9601f7
X-Msg-Generator: CA
X-RootMTR: 20200513133323eucas1p1519f5901d2a4ee85b781fcc36e9601f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133323eucas1p1519f5901d2a4ee85b781fcc36e9601f7
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133323eucas1p1519f5901d2a4ee85b781fcc36e9601f7@eucas1p1.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 samples/vfio-mdev/mbochs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 3cc5e59..e030689 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -846,7 +846,7 @@ static struct sg_table *mbochs_map_dmabuf(struct dma_buf_attachment *at,
 	if (sg_alloc_table_from_pages(sg, dmabuf->pages, dmabuf->pagecount,
 				      0, dmabuf->mode.size, GFP_KERNEL) < 0)
 		goto err2;
-	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
+	if (dma_map_sgtable(at->dev, sg, direction, 0))
 		goto err3;
 
 	return sg;
@@ -868,6 +868,7 @@ static void mbochs_unmap_dmabuf(struct dma_buf_attachment *at,
 
 	dev_dbg(dev, "%s: %d\n", __func__, dmabuf->id);
 
+	dma_unmap_sgtable(at->dev, sg, direction, 0);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
