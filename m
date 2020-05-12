Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4040EC54E90
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16551207FF
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T9HOX3Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16551207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E92C2870B2;
	Tue, 12 May 2020 09:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1_ZIv8HNe_7; Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D71486FCB;
	Tue, 12 May 2020 09:01:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72CB6C0894;
	Tue, 12 May 2020 09:01:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD74BC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C9F2588496
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g+whrPJ9D6kW for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 25D7788326
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:20 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090118euoutp016d0cdb076593738f3aa37eaa05b0ca01~OPFqh4ifv2545625456euoutp01D
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090118euoutp016d0cdb076593738f3aa37eaa05b0ca01~OPFqh4ifv2545625456euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274078;
 bh=LANz/nyu8DV77Z78ejKJQdltlPOf4e5b46TWqMiQeyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T9HOX3ZdqRSX5PUUnznPtJs++vjqpzGMpNF/B/C7ksr29oZnTZlZUcBHCK1h8g8UY
 +SWl2fNFCc1QUrB7qhp0lyOLJ+TsAC4V19WK/krsiWiQBvBZJRnzMZAW+SuuEFAGVs
 uPypJVRMHPTbVBugSimrhVlEtgu9A4gREJTzrBD4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090118eucas1p198633515d1bbe299cc514d15142e04df~OPFqS3qDA3053130531eucas1p1o;
 Tue, 12 May 2020 09:01:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.6B.60698.ED56ABE5; Tue, 12
 May 2020 10:01:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090117eucas1p1179ea62b61b45fae70630e66e434ffb3~OPFp2cLDX1612716127eucas1p1g;
 Tue, 12 May 2020 09:01:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090117eusmtrp15c58dbf9459f63539ed08635a4f7afeb~OPFp1zwhK0188101881eusmtrp1L;
 Tue, 12 May 2020 09:01:17 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-28-5eba65de16bb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.F2.07950.DD56ABE5; Tue, 12
 May 2020 10:01:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090117eusmtip1d62f8b1449dbdc944fcec14d9a1115b7~OPFpVX97m1148011480eusmtip1W;
 Tue, 12 May 2020 09:01:17 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/38] drm: omapdrm: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:38 +0200
Message-Id: <20200512090058.14910-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87r3UnfFGRxdzm3Re+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
 j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
 nzfJBXBHcdmkpOZklqUW6dslcGWsXPuDpWC9aMWvY5tYGhhPCHYxcnJICJhI/HvRyAhiCwms
 YJTYd5G7i5ELyP7CKLHj5mYWCOczo8SXhvWsMB0HN/1ggkgsZ5TY8H0vO1zLtp5/7CBVbAKG
 El1vu9hAbBGBVkaJE708IEXMAoeYJLa0XmUBSQgLBEvcnvUGzGYRUJWYc/06E4jNK2AnMXXP
 MmaIdfISqzccALM5geL35/9hgYjvY5c499cawnaRmLZ1FhOELSzx6vgWdghbRuL05B6wHyQE
 mhklHp5byw7h9DBKXG6awQhRZS1x59wvoFM5gM7TlFi/Sx8i7ChxqqsXLCwhwCdx4y04wJiB
 zEnbpjNDhHklOtqEIKrVJGYdXwe39uCFS1Dne0h0PtrBBgnfo4wSk25XTGCUn4WwawEj4ypG
 8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAdHT63/GvOxj3/Uk6xCjAwajEw9thtDNOiDWx
 rLgy9xCjBAezkghvSyZQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalF
 MFkmDk6pBsbYnZ93hH6aKnFnyZfzf6efMPdhixCofOnbvFvO4E7Z/oVPk++e+v6uxD/R0DdO
 hyf2auP2b6pHUqfx+qlXlpnvnVh641OjoZSein3cfslry/TEVD6E9z5Nvz3FtePJZCenVgaL
 i9+T5+jwrjtY0lwf1zTz6Ibfyz5sKrZearJdiHnpE8+1P1YqsRRnJBpqMRcVJwIAF+opq0MD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7p3U3fFGWzq1LLoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrBarJ9/i82B
 x2PNvDWMHnu/LWDx2P7tAavH/e7jTB6bl9R73P73mNlj8o3ljB67bzawefRtWcXocfzGdiaP
 z5vkArij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
 9DJWrv3BUrBetOLXsU0sDYwnBLsYOTkkBEwkDm76wdTFyMUhJLCUUaKh6wUzREJG4uS0BlYI
 W1jiz7UuNoiiT4wSN2ceYwJJsAkYSnS9hUiICHQySkzr/sgO4jALnGCSuLd3PiNIlbBAoMSz
 vc1go1gEVCXmXL8O1s0rYCcxdc8yqHXyEqs3HACzOYHi9+f/YQGxhQQKJR5dfcsygZFvASPD
 KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAY2Xbs55YdjF3vgg8xCnAwKvHwdhjtjBNiTSwr
 rsw9xCjBwawkwtuSCRTiTUmsrEotyo8vKs1JLT7EaAp01ERmKdHkfGD85pXEG5oamltYGpob
 mxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYHTcuSfJ/uvu9JVcBTKX3Pdvmllw+2+D
 ytZp2zLrLi2//ljm37Sgn6KpShH3DBtubXZpOqFvd69u2wvXGKeHOW/kpxy+ktDxmDMgOf7V
 LckJHevS0iWyFHT4JHp2HZi70mX53ugPX8oEdY+9+LhiunXUhd88V7g3vjhq0lit3l8kq//3
 zVWe+ElKLMUZiYZazEXFiQBoAy1dpwIAAA==
X-CMS-MailID: 20200512090117eucas1p1179ea62b61b45fae70630e66e434ffb3
X-Msg-Generator: CA
X-RootMTR: 20200512090117eucas1p1179ea62b61b45fae70630e66e434ffb3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090117eucas1p1179ea62b61b45fae70630e66e434ffb3
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090117eucas1p1179ea62b61b45fae70630e66e434ffb3@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
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

Fix the code to refer to proper nents or orig_nents entries. This driver
checks for a buffer contiguity in DMA address space, so it should test
sg_table->nents entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index c259411..cbcb361 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -48,7 +48,7 @@ struct omap_gem_object {
 	 *   OMAP_BO_MEM_DMA_API flag set)
 	 *
 	 * - buffers imported from dmabuf (with the OMAP_BO_MEM_DMABUF flag set)
-	 *   if they are physically contiguous (when sgt->orig_nents == 1)
+	 *   if they are physically contiguous (when sgt->nents == 1)
 	 *
 	 * - buffers mapped through the TILER when dma_addr_cnt is not zero, in
 	 *   which case the DMA address points to the TILER aperture
@@ -1279,7 +1279,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 	union omap_gem_size gsize;
 
 	/* Without a DMM only physically contiguous buffers can be supported. */
-	if (sgt->orig_nents != 1 && !priv->has_dmm)
+	if (sgt->nents != 1 && !priv->has_dmm)
 		return ERR_PTR(-EINVAL);
 
 	gsize.bytes = PAGE_ALIGN(size);
@@ -1293,7 +1293,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 
 	omap_obj->sgt = sgt;
 
-	if (sgt->orig_nents == 1) {
+	if (sgt->nents == 1) {
 		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
 	} else {
 		/* Create pages list from sgt */
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
