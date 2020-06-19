Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437AC43458
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAEA208B8
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ywpk7BzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAEA208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D688589943;
	Fri, 19 Jun 2020 10:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ba-QTswL0ape; Fri, 19 Jun 2020 10:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63DCB89934;
	Fri, 19 Jun 2020 10:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB3FC0865;
	Fri, 19 Jun 2020 10:37:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD953C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B770527D20
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80rm+xICUVV2 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 9065127DBF
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:17 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103716euoutp02627f1729424bf084f593992b98267301~Z66TKQ8Fj2414424144euoutp02K
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200619103716euoutp02627f1729424bf084f593992b98267301~Z66TKQ8Fj2414424144euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563036;
 bh=uHaHrVj9uEjHIe4StK4tJYVPskphxegmYKiq5klM8TA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ywpk7BzBeYG4URoO85FgwCZ6eE7ka6tKbmpPLXnvQNtmx7gNCZtrb94Si5p9QMs1g
 5eQB4DVpdg1xBGQvUFQIo3VqMYgKLoVnX4gCDv38OzfSpA0ddUQPOJekJhlNuooMlT
 ONjCTkX6eg88s2xtUd7GIny6Vmp+GZlSxIkFgcnk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200619103715eucas1p178ac18d358f7b184d050b81e0692bc0f~Z66S2WkkY0708707087eucas1p1T;
 Fri, 19 Jun 2020 10:37:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.9D.05997.B559CEE5; Fri, 19
 Jun 2020 11:37:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200619103715eucas1p12d01355499fbecb8632472b1b8230e6f~Z66SdoRi91690716907eucas1p1L;
 Fri, 19 Jun 2020 10:37:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103715eusmtrp151c83cc7d772b85505181748195fd8f4~Z66Sc413D1007310073eusmtrp1H;
 Fri, 19 Jun 2020 10:37:15 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-10-5eec955b45c4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D8.1B.06017.B559CEE5; Fri, 19
 Jun 2020 11:37:15 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103714eusmtip2a2a161e08a6c2f452a3d0a0868c0a625~Z66R25A5u0247402474eusmtip2f;
 Fri, 19 Jun 2020 10:37:14 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 32/36] misc: fastrpc: fix common struct sg_table related
 issues
Date: Fri, 19 Jun 2020 12:36:32 +0200
Message-Id: <20200619103636.11974-33-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTYRTGee/Hdrc2uV2lvag0WiQkaZ/EBUPUFG4QZBR9krXssknbqi0t
 Q8g0paZZzj5smJiTsrnSVKzW+tgsZ4yW2Cgro4aWqZmCVrSmtes1++93nnOe9zkcXgKlHHgk
 kaU7zOp1So1CIMbaOn69iNt54WvGsqYnK+kz3mcIPWnqENK3Kxtx+k9bOUr7vo8K6EJLo4C+
 0fAUoWseJdATPj9CN/e9wumX9ioBffPJeyHtHOvHk6SMrdoGmN8BE2Ae/KjBmDs/PuLMoys2
 IfOhxI0wLXXHmXdTfShT0XMdMPff5AuYslYrYMab56dLdojX7GM1WTmsfmniHrG6+PkH/KCP
 PPr653ssH4xJjUBEQHIVDHbbUSMQExRZD6ClohfjiwkArZ7ATDEOYEv7KeSfpfpKP8YxRV4H
 0GPdNOv4OFQq5BoCcjk0jhgFHEeQRQB2npFwQyg5hMDqqtM41wgnN0Or/9o0Y+Qi6O4MTLOU
 TIQ9Zp+QT5PDhqbHKMeikD580olzD0HSK4S206aZlVLhoNeM8xwOh9ytM+Zo6KkoxXhDIYB+
 700hX5QC+LKgEvBTCbDXGwjtSoT2Wwwb7Ut5ORkWOhpwToZkGOwZmcvJaAhNbZdQXpbCU8UU
 Px0Dze5bs7HOrm6UZwZee2ZB+AuVA/gpYEHOAbn5f1gNAFYgY7MNWhVrWKFjj8QblFpDtk4V
 n3lA2wxCf8oz5Z64C+zBvS5AEkAhkX7ZPJxB4cocQ67WBSCBKiKkKc89GZR0nzL3GKs/sFuf
 rWENLhBFYAqZdGXt4C6KVCkPs/tZ9iCr/9dFCFFkPohqcm81p/YaI3x5LrVKU5Z2vyh6nfxb
 1YZdWme1LPFqYM69gdWWAknXZ7AkSVf+dpstOKU+Kqpb+DnTYhOHRdePTra2L9gyTyZxCM+n
 nUB+Fl9eHabIM629WBITGaScmpRNqapAip8dWL+d6FTE1cYmPJQf2thR1udIP6dJPqvADGrl
 8lhUb1D+BZXP3jBPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7rRU9/EGRx+I2PRe+4kk8XfScfY
 LTbOWM9q8X/bRGaLK1/fs1k0L17PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZrD1yl93i
 4IcnrA68HmvmrWH0+P1rEqPH3m8LWDy2f3vA6rF/7hp2j/vdx5k8Ni+p97j97zGzx+Qbyxk9
 dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
 m5TUnMyy1CJ9uwS9jLaz91kLrghUXP9+l6WB8QNvFyMnh4SAicS8uU9Yuhi5OIQEljJKfPiz
 lA0iISNxcloDK4QtLPHnWhcbRNEnRomXZ0+xgyTYBAwlut5CJEQEOhklpnV/ZAdxmAU+MUkc
 uXYabJSwQJDEnvv/wDpYBFQljp/4BTaWV8BO4sasK+wQK+QlVm84wAxicwLFX7ccBKsRErCV
 WL7gPfMERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNm27GfW3Ywdr0LPsQowMGo
 xMP7IuR1nBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Y
 03kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjlXzWHHJ+mOOdG
 9Py/B5+2Rln7OZ7NemSlEL7oe5e4/7QdLJucOOWFuc6ZtRwreVLzsDa5RfrqWYtYpxkrr8YJ
 Trn8KEpAsSXm56FD33mZ8wRi/f4W8jT9vNJW9fxixFOJHcqRv5s11pecbxMtemPNaKnW4db0
 7g0z+15l4a63Ydfdrnb0X1ZiKc5INNRiLipOBAD1t5sVsQIAAA==
X-CMS-MailID: 20200619103715eucas1p12d01355499fbecb8632472b1b8230e6f
X-Msg-Generator: CA
X-RootMTR: 20200619103715eucas1p12d01355499fbecb8632472b1b8230e6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103715eucas1p12d01355499fbecb8632472b1b8230e6f
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103715eucas1p12d01355499fbecb8632472b1b8230e6f@eucas1p1.samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7939c55daceb..9d6867749316 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -518,7 +518,7 @@ fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = &a->sgt;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+	if (!dma_map_sgtable(attachment->dev, table, dir, 0))
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -528,7 +528,7 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 				  struct sg_table *table,
 				  enum dma_data_direction dir)
 {
-	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+	dma_unmap_sgtable(attach->dev, table, dir, 0);
 }
 
 static void fastrpc_release(struct dma_buf *dmabuf)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
