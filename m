Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49EC2D0F6
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DFE2083B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ViBcznyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DFE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95FE886C92;
	Fri,  4 Sep 2020 13:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v92ZUHFvVerx; Fri,  4 Sep 2020 13:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6D5B86D62;
	Fri,  4 Sep 2020 13:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97E22C0052;
	Fri,  4 Sep 2020 13:35:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6A66C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8941286D46
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kaIt12QAFXUW for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9175386DD9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:12 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133511euoutp02e38b7e8d65f207e6f2c107454afb50c3~xmAn1VYwO2890028900euoutp02y
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904133511euoutp02e38b7e8d65f207e6f2c107454afb50c3~xmAn1VYwO2890028900euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226511;
 bh=xw6Uqswd7WHaRkaUiL5EjLFx27XSMmDCF+NgXqXXIkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ViBcznyMcYpPhEGvk78/v0XC+FUGq5tpLugyZSv7Eh+bhkbqMJBFLqsetFpfhgjk0
 uSvVwB7AHyTcbSawA8t202gcgs6eqXcmMNMCEUE6eg8lQW+AbaoF++LYaG9j/LXOB9
 ZjmWe6tAB0pQRkHR9JcLLnT/gAJLP/6R7WUgyfds=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133510eucas1p28cb3ab11e0cd8252df9971f2b6538bb0~xmAnisOUN0694006940eucas1p2r;
 Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E1.76.05997.E82425F5; Fri,  4
 Sep 2020 14:35:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9~xmAnJ01ij1156611566eucas1p1N;
 Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200904133510eusmtrp211be072e4bd9dc8f560679e64325523b~xmAnJLXC90977009770eusmtrp2Z;
 Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-7e-5f52428e5c8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.B0.06017.E82425F5; Fri,  4
 Sep 2020 14:35:10 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133509eusmtip126e2d5705c6ff916666e9063e629bd26~xmAmkb-_D1683216832eusmtip1Z;
 Fri,  4 Sep 2020 13:35:09 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 27/30] rapidio: fix common struct sg_table related issues
Date: Fri,  4 Sep 2020 15:17:08 +0200
Message-Id: <20200904131711.12950-28-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu3Lu7XYeT25Q8WSoMeqj4jrygaKnQJXuY/wRF2sqbim7aro+U
 KMtezAdTCZ/ZCsXynelMw9Tlq8wVKmrp0qUJxkzJpRTl2rqz/vvO7/u+833nx8FRYQfmgMdJ
 k2mZVJwg4vI5qv4fGve84IgoL32BL5mreYWQn2omUfJJcSNGGlX5KDn2fZlLPq7tQ0hllz9p
 GNMhZPPcOEaOdpRzyfpeLY+8+3YdJXtW5rEDAqquog5QnWtKDtVequVROfobGNW2NotRM9kD
 CPW08io1tTGHUoWT1YB6/j6TS+W11ABqtdkp3PoUPyCaTohLpWWegWf5sYXGeiwpb9ulaxNa
 LBNUCeXACofEPmjIyubIAR8XEo8A1JZNIWZCSBgA1H0DLLEK4OfBbnTTcS9nGGWJagDfdI1a
 VCbHeJOCY1ZxCW8oX5JzzdiOuAngYK61GaPEVwT2rrqasS1xHFYVT/29lUPsgtmLLBYQgbCh
 fILDpjnD2iY22co0by2ex8xhkHjNgz1dGoQVhULj7TxLPVv4ZaCFx+Kd0Nh+H2ENWab3aOp5
 7CEHwNHrxYBV+cNpzU9TVdxUzwU2dniaISQOQkX/BRbawMmlrWx/G1igKkLZsQDeuWVZ425Y
 OtDwL7Xn3YilDQX1fTrLfvIBrPy9gCqAc+n/LCUANcCeTmEkMTTjI6XTPBixhEmRxnicT5Q0
 A9OPGtoYMDwDHb/OqQGBA5G1YEtQRJQQE6cy6RI1gDgqshMEDw9FCgXR4vQMWpYYJUtJoBk1
 2IFzRPYC34eLZ4REjDiZjqfpJFq2ySK4lUMmcIt0CKc8/S8eHhpacWpTrAU06FXLM15Gbgnj
 ta5zWrm8vTWkKEP1QX2yCwkcmQ4NKxKUfIxGlNnGHFWYW4ALGeEuda6O1ce3V/A6y2Tdjmn9
 I/sXrhT6yMsUubl7ZtP8SpQ2R4IcrblK/d6llpd+h1wqTzwI6Tn2ou7o6UZ1p4jDxIq9XVEZ
 I/4DUX+Zmk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7p9TkHxBqvmSFn0njvJZPFo1Q1m
 i40z1rNa/N82kdniytf3bBYrVx9lsliw39riy5WHTBabHl9jtbi8aw6bxdojd9ktpp7/zmxx
 8MMTVgdejzXz1jB67P22gMVj56y77B49b1pYPbZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH
 7psNbB59W1YxenzeJBfAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
 k5Kak1mWWqRvl6CXMfn/WtaCPrGKxut3WRsYlwp1MXJySAiYSMztOcvcxcjFISSwlFHiWNdp
 FoiEjMTJaQ2sELawxJ9rXWwQRZ8YJSZdXQtWxCZgKNH1FiIhItDJKDGt+yM7iMMs8I1JYtLS
 W2wgVcICvhI7vneBjWIRUJXofnmbGcTmFbCTWDfnOtQ6eYnVGw6AxTmB4ltnPAGrFxKwlfgw
 ZzHLBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjZtuxn1t2MHa9Cz7EKMDBqMTD
 y2AfFC/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4HxnRe
 SbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGtujVfkKbjgZeeiWg
 PyF3wYfOSXzNXFEzbcSEu1ziz8Q7XBbmYG2wdEryFSp99PCXxPpP3isyX/Hfcb4q7djrW3Jy
 8YKU5R5FJguan6Zz/Vh7S2CeudDOU/t1N3BVuV6dEPgv8Ju88x6m6QtDT3XZRa6dN/v8Dsbt
 DjUOiR3uDltXbyg6pZuqxFKckWioxVxUnAgABjvtbLECAAA=
X-CMS-MailID: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
X-Msg-Generator: CA
X-RootMTR: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Alexandre Bounine <alex.bou9@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matt Porter <mporter@kernel.crashing.org>,
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a30342942e26..89eb3d212652 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -573,8 +573,7 @@ static void dma_req_free(struct kref *ref)
 			refcount);
 	struct mport_cdev_priv *priv = req->priv;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, &req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		unpin_user_pages(req->page_list, req->nr_pages);
@@ -814,7 +813,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	struct mport_dev *md = priv->md;
 	struct dma_chan *chan;
 	int ret;
-	int nents;
 
 	if (xfer->length == 0)
 		return -EINVAL;
@@ -930,15 +928,14 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, &req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
 	}
 
-	ret = do_dma_request(req, xfer, sync, nents);
+	ret = do_dma_request(req, xfer, sync, req->sgt.nents);
 
 	if (ret >= 0) {
 		if (sync == RIO_TRANSFER_ASYNC)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
