Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49CCC43457
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3BD2070A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KZMr6zGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3BD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B48E88906;
	Thu, 18 Jun 2020 15:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lsv2bfy88bA; Thu, 18 Jun 2020 15:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B30C1889F1;
	Thu, 18 Jun 2020 15:40:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADAAEC088C;
	Thu, 18 Jun 2020 15:40:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54C3BC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3EFA926285
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id paQ5Ej6RTGyk for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 8F96A2269B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154038euoutp028e5988317de6923b7351049494d753e4~ZrZ4ogzAQ1314513145euoutp02g
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154038euoutp028e5988317de6923b7351049494d753e4~ZrZ4ogzAQ1314513145euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494838;
 bh=i9tfBl9XK1ZIcmVNmOj760Z4Av4MmZkmEeWSykU107Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KZMr6zGKccCjIXwLvtaZvINM5cvedqSKjLsMAlbFaqa/2uidxZv4eJwZw6UlCvaeF
 9YebsQk0pCSOf0hZVeGz5jyKC7bIKsyTqcxutg8SECaAxAFjSsElGDvinxdLb+wtUU
 aDzTWa6ipwlVAyqCaRl33uC2xz3NXA3enEo71oO0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154037eucas1p162bd4bce5ff25284dc35a3b750373f07~ZrZ4YCBn21545815458eucas1p1m;
 Thu, 18 Jun 2020 15:40:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.1F.61286.5FA8BEE5; Thu, 18
 Jun 2020 16:40:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154037eucas1p19a60af169ef9c272b9d1eecf589f6627~ZrZ4Bn1_B1545815458eucas1p1l;
 Thu, 18 Jun 2020 15:40:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154037eusmtrp2e1d1f0ddf5441e208cc3e8e1afc41c0b~ZrZ4A_iTP0370403704eusmtrp2w;
 Thu, 18 Jun 2020 15:40:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-f2-5eeb8af57b24
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.FE.08375.5FA8BEE5; Thu, 18
 Jun 2020 16:40:37 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154036eusmtip1fb60c40ddcb27db26c518640dc3aacde~ZrZ3a9J5Z0742307423eusmtip1Y;
 Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 33/36] samples: vfio-mdev/mbochs: fix common struct
 sg_table related issues
Date: Thu, 18 Jun 2020 17:39:54 +0200
Message-Id: <20200618153956.29558-34-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjuO2fn7GjOjpvgh0nGIsnAGxUeUMTMH4cKuv0oBC8zDypuuja1
 FCRTFzK1NDNNLC0E865zzktKOdQlmpcpy0umov7QoYY6sUma2yn79zzP+7zP873wESi/BXMm
 YuMTGVm8SCzEbTma/l8jHialMcy79J07lTc8gFDNJY0YdaApQKkJ0wZOVdf2IVTFJz+qrOgB
 pR58A6jtiQWEUi0aMGq8swyn6ntnuVTPzyUskEfXva0DdPdOBYdu25nH6LkcHUK3VD6mZ/YX
 UbpwsgrQH6fScTovcx2nn6lrAL2lOnXzeIitfxQjjk1mZF4BEbYxexoVV1rp8Gi6PSEdNNsr
 AUFA8iKcrwpUAluCT34AcKm8msOSbQDzVrU4S7YAVGv6MCWwsW4MVOpRdlAF4N5GNnq0krE8
 iltcOOkDlWtKK3YkFQB+ybOzmFDSgMC13+vWKAEZAfWmSivmkGfhXFkNYsE8MgAOPM/B2TpX
 WNv0GbVgm0N9UKfALEGQ1HJhxVAZwl4RDL+1oqxfAFd1ai6LXeBBRznC+jMBXBiu57IkF8Dx
 jBLAuvzg92EzbglCSXfY2OnFypfhzKtpLptvDyfXHCwyeghfaIpRVubB7Kd81u0GS3UNR7U9
 o/q/z6Hham+R9RQ+WQDgSAueD1xL/3dVAFADnJgkuSSakfvEMw895SKJPCk+2vN+gkQFDr/S
 4L5usx2Y9JFaQBJAaMcLvGsM42OiZHmKRAsggQodeUFfB8P4vChRSiojSwiXJYkZuRacJDhC
 J96F9yuhfDJalMjEMYyUkf2bIoSNczroNt+OG+1o8hGPFRnRW/5TY0OOBwvBsy6hpzPPtc0c
 w38sh6f2GnyvKN2WpVncrq6NEKwYO9mflTtuZphLuVpkZa/1xtVrL8ndFLP0db1CIvCG+Y2+
 Z5bvnNj0bfDfuFeoSDMJnlCl3rtBxm6P/fWt4rTIIUNzd6ZICJ0414UceYzI5zwqk4v+ALRX
 GcFGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7pfu17HGZxYLWbRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9tMWdqocWW03MZLb5cechksenxNVaLy7vmsFmsPXKX3eLg
 hyesDrwea+atYfTY+20Bi8f2bw9YPe53H2fy2Lyk3uP2v8fMHpNvLGf02H2zgc2jt/kdm0ff
 llWMHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
 FunbJehl/N62ib1giWDFrR35DYwb+boYOTkkBEwkTi65xNzFyMUhJLCUUeLC9H3MEAkZiZPT
 GlghbGGJP9e62CCKPjFKPLo3mw0kwSZgKNH1FiIhItDJKDGt+yM7SIJZ4B6TxN51fl2MHBzC
 AnEST0+BhVkEVCXuz1nFBGLzCthJnOzvZoNYIC+xesMBsMWcQPHTx1vBFgsJ2Eo8/9DGNoGR
 bwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAKNl27OfmHYyXNgYfYhTgYFTi4X0R8jpO
 iDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4zgvJJ4Q1ND
 cwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjDNCV88xOhK1dtqtd3p1c/RW
 1HUGTYi8FZc783pN96+0qub/YddXfs0JeHXlfvnWqjZ2Xo66CbeuzfAq6LoicuVD5/ZMF5+r
 ZxoKZNjVfuwxXpiTKCivzDx9JVf0tFnRDyXXfPjzNOKHRXR17fqjHuvXO2iGtN9vO1deKc4+
 4ZWu398liUarGJVYijMSDbWYi4oTAZpEzByoAgAA
X-CMS-MailID: 20200618154037eucas1p19a60af169ef9c272b9d1eecf589f6627
X-Msg-Generator: CA
X-RootMTR: 20200618154037eucas1p19a60af169ef9c272b9d1eecf589f6627
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154037eucas1p19a60af169ef9c272b9d1eecf589f6627
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154037eucas1p19a60af169ef9c272b9d1eecf589f6627@eucas1p1.samsung.com>
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
 samples/vfio-mdev/mbochs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 3cc5e5921682..e03068917273 100644
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
