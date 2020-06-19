Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37991C433FE
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE7621582
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OgTkirsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE7621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0ACC87568;
	Fri, 19 Jun 2020 10:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_Rt4CvVB5Wd; Fri, 19 Jun 2020 10:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B6C486E4E;
	Fri, 19 Jun 2020 10:37:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0452FC0892;
	Fri, 19 Jun 2020 10:37:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0798C0865
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ACEAC89956
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S+OQTGjj0RmC for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 77E4789969
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:18 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103717euoutp026ddc0979a7773046ae196c25db101582~Z66T94mkx2414824148euoutp02I
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200619103717euoutp026ddc0979a7773046ae196c25db101582~Z66T94mkx2414824148euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563037;
 bh=mzLIyVTZpzYfnKpa4gX5M1szjJk3Wzuil/t51kYHhjU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OgTkirsddpsb6k4dUnD21tj8nHE5nc9lB4wxDqLGxxLTxWioLXMEE0HdzVYxYd1jy
 bY1101TBRZ4M+qShbyUL0gYrbMSjVT9lrIZ/jQSBMuum+crCCspzE2EubeMXXT1D6q
 mi9y/rYTVvIbSaEl/KoXbQQaO1wL0Nxn/NHObi0s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200619103716eucas1p162a56c5b084f03b07a1e1f00fe2e53d7~Z66TgIjHe0704707047eucas1p1C;
 Fri, 19 Jun 2020 10:37:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.AD.05997.C559CEE5; Fri, 19
 Jun 2020 11:37:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200619103716eucas1p1b7c50f7b421fb29829050b9355e3e644~Z66THeSaL0706007060eucas1p14;
 Fri, 19 Jun 2020 10:37:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103716eusmtrp19beba6ed65a603a1c08b57cb53ea06b1~Z66TG3meQ1007310073eusmtrp1I;
 Fri, 19 Jun 2020 10:37:16 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-12-5eec955c60c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.1B.06017.C559CEE5; Fri, 19
 Jun 2020 11:37:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103715eusmtip298b27b150d32f56203c96b474d54e50a~Z66Sd2Ghv0111401114eusmtip2P;
 Fri, 19 Jun 2020 10:37:15 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 33/36] rapidio: fix common struct sg_table related issues
Date: Fri, 19 Jun 2020 12:36:33 +0200
Message-Id: <20200619103636.11974-34-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm27nsuJydpuCHVsIiQclrEYc0yZA43SCoP5qXlh7vOtucZf5w
 6LRYGi0RdUhoCJrXvKSls1SsKeYUNZ2ppBmaec15wZma85j9e573fZ73efj4CETQhNkQEbHx
 jCRWFC3EeWj9p40eJ//suUBX/Ywdlanr5FDfS/UIVZ1bhVE79SqEGlhdxKlXZR85VMEHD2pl
 YIJD1UwOYlR/Yz5OVbSPcansnnWEal36gV3g0+UvygHdvFaA0u/UY1w6Y06B0Q1r4xj97YmW
 Q9cWJdMj25MInaUvBnTTsBynn9aVAtpQc/yGuR/PM4SJjkhgJC5ed3jhQ9OdnLgBwYNajRyT
 g67DSmBGQPIMXDcMcZSARwjIEgCbc8b3yQqAhpIanCUGAEe38rj/LLUNGxi7KAZQ2dENDixr
 hTOoSYWTblA5r8RN2IpMA7Aj09yEEXKBA9sNjiZsSV6DlcbNvasoeRLmbc7sXiUIPukF6zQo
 G2YHy163ICZstjueVbTuBUNSx4XbKW0IK/KBut40jMWW8Je2br/pUdiVlYGyhlQAJ3QVXJZk
 ANifkgtYlQcc1RlxUzJCOsCqRhd27A3fpGv2CkHSAurnj7D9LeDz+hyEHfPh43QBq7aHam3l
 QWxrb99+NRp+nZzdfywVgLmFy/gzYKf+H1YAQCmwZmTSmDBG6h7L3HeWimKkstgw52BxTA3Y
 /VJd29qVt6Dxz902QBJAaM7/eWs2UICJEqSJMW0AEojQin+xuytQwA8RJT5kJOIgiSyakbYB
 WwIVWvNPv5wJEJBhongmimHiGMm/LYcws5GDattB76lpK1wV1PIZr31/0789ams1NGl5RDzc
 qR5yvnxOvLy0Q/ks+vbhc4WeqCzclTjrpWpeKZMrkpNcnL4Izes3ppPpSHWrOO56ZLBDYWL0
 lXn7qUcJRQG/85e5J3gL7saGdn3CvaRL7orQqw3MqfOpt/0OtRwzNvsqHFI0QlQaLnJzRCRS
 0V/Z4WygTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7oxU9/EGaw9y27Re+4kk8WjVTeY
 LTbOWM9q8X/bRGaLK1/fs1msXH2UyWLBfmuLL1ceMllsenyN1eLyrjlsFmuP3GW3mHr+O7PF
 wQ9PWB14PdbMW8PosffbAhaPnbPusnv0vGlh9dj+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
 u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
 TUpqTmZZapG+XYJexvXnJ5kKrghVbN7TwNrAeJq/i5GTQ0LARGLz9p+sXYxcHEICSxklFrxc
 xQKRkJE4Oa2BFcIWlvhzrYsNougTo8STqbeYQBJsAoYSXW8hEiICnYwS07o/soM4zALfmCQm
 Lb3FBlIlLOAjse7Xb3YQm0VAVWLm75dAYzk4eAXsJLbsgdomL7F6wwFmEJsTKPy65SDYZiEB
 W4nlC94zT2DkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwarYd+7llB2PXu+BDjAIc
 jEo8vC9CXscJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBNE5mlRJPz
 gRGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB8ZDlDLNfl/Vb
 LtQHx95bLzf16aGWb5W6a0WSlVZslUqR8pv/5Hb7bqcoizWCWifeHBMJX20W/aD/fPwttzCt
 hOkxTxr+vbvBzjXntFpFSe2isLlnij9dsXbeHzhH6Olnx/7Luf2fuB3uHe2pnFD1p/pG/rSI
 G9bF2+frBTws8N81jU2HRzakQImlOCPRUIu5qDgRAL+/YhqwAgAA
X-CMS-MailID: 20200619103716eucas1p1b7c50f7b421fb29829050b9355e3e644
X-Msg-Generator: CA
X-RootMTR: 20200619103716eucas1p1b7c50f7b421fb29829050b9355e3e644
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103716eucas1p1b7c50f7b421fb29829050b9355e3e644
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103716eucas1p1b7c50f7b421fb29829050b9355e3e644@eucas1p1.samsung.com>
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
---
 drivers/rapidio/devices/rio_mport_cdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 451608e960a1..98c572627c8c 100644
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
@@ -930,9 +929,8 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
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
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
