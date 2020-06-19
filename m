Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E448C433EC
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BD0208B8
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RZWZFZiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BD0208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3EFE288159;
	Fri, 19 Jun 2020 10:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7L4N70qXF9kQ; Fri, 19 Jun 2020 10:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0EF1889956;
	Fri, 19 Jun 2020 10:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01665C0892;
	Fri, 19 Jun 2020 10:37:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30B32C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1DA88877A8
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xIKJxVs1T9-x for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 78D3287700
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:07 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103706euoutp029a3c36edb323092b9cbe9af9f1ebb94a~Z66Jv_PWb2363023630euoutp02i
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200619103706euoutp029a3c36edb323092b9cbe9af9f1ebb94a~Z66Jv_PWb2363023630euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563026;
 bh=Xz5Z61X+A6u/FrMD8ciD40ug8xujs/WBHWVc8ZYxDIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RZWZFZiU9uaK5hCckHSKOUW4U3SYq9HwAyrRqHgCZuTY0ptyEKGO35ufvRT/OuWCE
 q/s47IGq1Wz9yIKJl/3KbkUV9/xSbO/nqUbphnQC0PrXT+Le6la4WOTgXqDUTN38WO
 IiyUcbppCmgiKO4IiRbRHHCXes5Zs24xWSfwBwPg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200619103705eucas1p10b8740637e53bc8dde52e03b3c391a35~Z66JbWtwp0705907059eucas1p1H;
 Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 01.AC.06456.1559CEE5; Fri, 19
 Jun 2020 11:37:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103705eucas1p2d81a91b989d5aed5c7da6897173905cd~Z66JD4jOp3081530815eucas1p2c;
 Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103705eusmtrp168f0ba22988a309be3c4615aa1a9502b~Z66JDKJtI0959609596eusmtrp1H;
 Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-56-5eec95513d50
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.0B.06017.1559CEE5; Fri, 19
 Jun 2020 11:37:05 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103704eusmtip21079cff67347dd72f5c34fbc65f764d9~Z66ITSibC0302303023eusmtip2Q;
 Fri, 19 Jun 2020 10:37:04 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 18/36] drm: rockchip: use common helper for a scatterlist
 contiguity check
Date: Fri, 19 Jun 2020 12:36:18 +0200
Message-Id: <20200619103636.11974-19-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUgUURzHeTszu+Oya9Mq+bBIWOhGzTIZssS0YqIgi0CSXJ10PMhV2VHT
 IpJSC9NMLa/UREzXK83Eq0PXa8vVrdTMo1IzKI/VPNEgN9dR++/zvr/vl+/vPR6OSBowc9w/
 MIRRBNIBUr4QrWpdem957tGEbL/q5z4yXvuORz5PK8NIfVUiQnbPT/HJwuIWHqn/Po6RWUk3
 yJx6e3Kue5hHVoz0YGRXXSafnBnSI2Rp81cBqfr9A3M0pkqySwD1eiEHpaoXhjBq8J6aR73I
 u0kNLI8gVHJvAaBe9kXyqb8Z9Sh1v7IIUNU92Qg1W7HdReQmPOLNBPiHMQprB0+h32hWLggu
 FoWP5SVhkUApjAVGOCRs4cBwtCAWCHEJoQTw82IRyh3mAEx4k7Y2mQUwpb2Qvx5JHO9FuEEB
 gJmpbbyNSIeqhGdw8QkbGKuLXU2YEtEAvo0XGRghUhBYNH/SwCaEB2wr0yAGRokd8Ndk5CqL
 CQeoa36IcG0WsLi8YZWNVvTxKBVmKINEpwB+q+1HOdNxWJmei3FsAsfUlQKOt0FNchzKBW4D
 OKwtFXCHOAC7bqUBzmUPv2j/rKyKr6y3B5bVWXPyMTiozEYNMiSMYa9uM3cBY5hUlYpwshje
 jZFw7p0wQ/1so1b1oXNtfwr25X7CuAdKBHBp4Sl4ACwy/pflAFAEzJhQVu7LsDaBzFUrlpaz
 oYG+Vl5B8gqw8q80y+qZGjDfebkREDiQisSOruMyCUaHsRHyRgBxRGoqdurQyCRibzriGqMI
 8lCEBjBsI9iKo1Iz8cHcUXcJ4UuHMFcYJphRrE95uJF5JLBImIjKF9oqMze1zzXFuJh6RSer
 9eWnFddND7v0x/VfGBQlL9Knsu8sXjyaQE03fWSnZi9ZaFsnd2mdnZpcFTq38z4NSYeUZ2K8
 3F231L5KsWtJkB2gfYBdTfQTZ+Mal/LSE49tdJ7NZBZpOZ1OhE8vFOp388PzuzSys6FqNy8p
 yvrRNnsRBUv/A2lp00FTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7qBU9/EGbQeE7ToPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSz+P3rNajF3Uq3Fgv3WFl+uPGSy2PT4GqvF5V1z2Cw+PfjPbLH2
 yF12i4MfnrA68HmsmbeG0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo+/
 s/azePRtWcXosf3aPGaPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
 TJX07WxSUnMyy1KL9O0S9DJezl3EWLCap+LVkkmsDYwruLoYOTkkBEwkJr6+wQxiCwksZZQ4
 8qMQIi4jcXJaAyuELSzx51oXWxcjF1DNJ0aJxquTwRrYBAwlut5CJEQEOhklpnV/ZAdxmAXm
 MUssX3WYCaRKWCBW4l7jTxYQm0VAVeLFuwawbl4BO4m3R6YwQ6yQl1i94QCYzQkUf91ykBXi
 JFuJ5QveM09g5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMHq2Hfu5ZQdj17vgQ4wC
 HIxKPLwvQl7HCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQUROZpUST
 84GRnVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbEhLFbj+5Sm
 DV8/PPhlzfq3v5L7gpTLRGn/DrvwytOOb2xmtOkFG1g88p778rCq9uX7AaqtW7SmGky0f9oo
 UfpsZumUv7Xu/5mNY0tnPlSbdPNP6fvrws+nya54VMK2LPH/xb5JB5dHWu1iY7p17pwSq9br
 s7IhfkwPOl/l1nherVArOPqq6I4SS3FGoqEWc1FxIgDAFerKtAIAAA==
X-CMS-MailID: 20200619103705eucas1p2d81a91b989d5aed5c7da6897173905cd
X-Msg-Generator: CA
X-RootMTR: 20200619103705eucas1p2d81a91b989d5aed5c7da6897173905cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103705eucas1p2d81a91b989d5aed5c7da6897173905cd
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103705eucas1p2d81a91b989d5aed5c7da6897173905cd@eucas1p2.samsung.com>
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 linux-rockchip@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
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

Use common helper for checking the contiguity of the imported dma-buf.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index b9275ba7c5a5..2970e534e2bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -460,23 +460,6 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return sgt;
 }
 
-static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
-						     int count)
-{
-	struct scatterlist *s;
-	dma_addr_t expected = sg_dma_address(sgt->sgl);
-	unsigned int i;
-	unsigned long size = 0;
-
-	for_each_sg(sgt->sgl, s, count, i) {
-		if (sg_dma_address(s) != expected)
-			break;
-		expected = sg_dma_address(s) + sg_dma_len(s);
-		size += sg_dma_len(s);
-	}
-	return size;
-}
-
 static int
 rockchip_gem_iommu_map_sg(struct drm_device *drm,
 			  struct dma_buf_attachment *attach,
@@ -498,7 +481,7 @@ rockchip_gem_dma_map_sg(struct drm_device *drm,
 	if (!count)
 		return -EINVAL;
 
-	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
+	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
 		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
 			     DMA_BIDIRECTIONAL);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
