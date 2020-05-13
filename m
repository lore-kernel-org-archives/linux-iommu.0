Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37492C2D108
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB860207FB
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XSk79eSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB860207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E52A2871D7;
	Wed, 13 May 2020 13:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wjrhnsm0JXot; Wed, 13 May 2020 13:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D753D8721E;
	Wed, 13 May 2020 13:33:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2B0FC0178;
	Wed, 13 May 2020 13:33:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CF27C0178
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E274887242
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFmsCXibMnbt for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EC54686FC9
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:14 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133312euoutp02d47c6b703fd8e77b09b80590da6ef1c1~OmcWw2Yff3216632166euoutp02-
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133312euoutp02d47c6b703fd8e77b09b80590da6ef1c1~OmcWw2Yff3216632166euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376792;
 bh=ajKNWEur/j3kJDi0IDcqqrpxOyKZtcQE79V0/ItRN54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XSk79eSBjGEf2sl4moZbV/T1FelXSd3C3yvaz8Q6R71/RyzgIVLC+H9BS1t9M195n
 7E9taSGOzV1MVwdJs4s7uWzTVELDgra0U4XhhJO5owXJTzqYFkB3QP3ILif8+3uB8S
 hLUD+LvZ2s0T5TpJiJzvvfI1Jc04IUJbVHO6/aUA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133312eucas1p16340b6ab9117a7a566eae1f10d7cd477~OmcWdqnBl2351423514eucas1p1P;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.C5.61286.817FBBE5; Wed, 13
 May 2020 14:33:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133312eucas1p15e5e3bb3ba8e74b923fdccc7decab375~OmcWEGqe42350623506eucas1p1P;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133312eusmtrp17dc4ab0646eab5d47fd06026993facb4~OmcWDYKbj1050610506eusmtrp1P;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5f-5ebbf7185db5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.1A.08375.817FBBE5; Wed, 13
 May 2020 14:33:12 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133311eusmtip13c56d5e5984716aad8f7f67e38b9ce08~OmcVQ2X460693306933eusmtip1D;
 Wed, 13 May 2020 13:33:11 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/38] drm: rockchip: use common helper for a scatterlist
 contiguity check
Date: Wed, 13 May 2020 15:32:28 +0200
Message-Id: <20200513133245.6408-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7v3bnfT2XUKnizSBiUK+aAHt2xhIXUpiv6TitSlFzWdyq5a
 RtJS0pqPTPGB1ZiPNB/TZbaFEurUNAwzFfGZb9KZFeosg1yb1+y/z/d7vj++v3M4OCJqwZzx
 iOg4Wh4tjRJzBaju3frHg/BnU6B3m9KFzOx5zyFfFtZhpFn3GCEHTN+5ZGV1B4c0Ty9i5LOc
 JFLd7EuuDkxxyPqZQYzsb3zKJZcnzQipaR/nka0/ZjE/O6pGVQOot2tqlNKvTWLURHonh3pV
 dpca3ZhBqNyhCkA1DSu41J+iZpTKaqgClH5QhVAr9Xsv2V4RnAiloyISaLnXyWBBeEltF4hN
 sbulz9NyFOCLjRLwcUgchrW6DqAEAlxEvADQOPEEZcUqgGXJaoQVKwA+N4xy/o1omka2UhUA
 rmmGedsjLaPVmDXFJXygcknJtbIjcR/ArkxbKyNEPgKrTGes7EAEwWyTfjOPEvuhNkvFs7KQ
 kMBPqhYu2+YCq7UtiJX5Ft841rzZDIlBHizIL8DYkD/s16i32AEaOxt4LO+B3bkZWwMpAE71
 aHisyACwP7kQsClfONbz21KHW9Zzh3WNXqx9ChZv9G3akLCDQ0v27AXsYI6uAGFtIXyQKmLT
 B2BRZ+12bWtvH8IyBRVp5Vuv1QbgUr6Rkw1civ6XqQGoAk50PCMLoxmfaPqmJyOVMfHRYZ4h
 MbJ6YPlX3Rudy2+Aqe+6ARA4ENsKyZGmQBEmTWASZQYAcUTsKLxYZ7GEodLE27Q8JkgeH0Uz
 BrAbR8VOwkMlC9dERJg0jo6k6Vha/u+Ug/OdFUCrEHY3J+coj1z+/DDd3iU1ScDsGpzsOztf
 eWwuNXN8X3HkOTDrGhuUXZ7agfqtBH1zdZfMu5n1xy/ssMn4IOGPrS+Xulb635MUl3mnhXSE
 3+GnHF3wiH9t1urCpxeDbUodvAR5JjfUcFoYINkZ0K6auzFlP/Er9irXaDz/9VGvGGXCpT4e
 iJyR/gVAyx62UwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7oS33fHGTR8YrHoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSz+P3rNajF3Uq3Fgv3WFl+uPGSy2PT4GqvF5V1z2Cw+PfjPbLH2
 yF12i4MfnrA68HmsmbeG0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo+/
 s/azePRtWcXosf3aPGaPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
 TJX07WxSUnMyy1KL9O0S9DIWrTvBWNDMV7F96gamBsbn3F2MnBwSAiYSa3ffYuli5OIQEljK
 KPGxvY0VIiEjcXJaA5QtLPHnWhcbRNEnRolZB76zgyTYBAwlut5CJEQEOhklpnV/ZAdxmAXm
 MUssX3WYqYuRg0NYIFbizO8akAYWAVWJDX3zwJp5BWwlLs47wAaxQV5i9YYDzCA2J1D81Z39
 LCC2kEC+xN7F+9gmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERg924793LyD8dLG
 4EOMAhyMSjy8Frd2xwmxJpYVV+YeYpTgYFYS4fVbDxTiTUmsrEotyo8vKs1JLT7EaAp01ERm
 KdHkfGBk55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYNTdupiv
 +rL9JGG5aYknGtXvrFb8EXz50qy3YR/j9IJnGK/qeMm9c+tnxzlh4r1rN+5643zj/dPkHdKe
 01sfNoq01xzgm1TQVJOf9XxDoM4Dp+NV8myLmKy1E6/yTfs7W2P6VdfF/msvlfnezfm6407d
 797Eo9XP/N/sFY+6FunFxRLaeV7CQlKJpTgj0VCLuag4EQDTlMswtAIAAA==
X-CMS-MailID: 20200513133312eucas1p15e5e3bb3ba8e74b923fdccc7decab375
X-Msg-Generator: CA
X-RootMTR: 20200513133312eucas1p15e5e3bb3ba8e74b923fdccc7decab375
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133312eucas1p15e5e3bb3ba8e74b923fdccc7decab375
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133312eucas1p15e5e3bb3ba8e74b923fdccc7decab375@eucas1p1.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 0d18846..21f8cb2 100644
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
@@ -498,7 +481,7 @@ static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
 	if (!count)
 		return -EINVAL;
 
-	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
+	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
 		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
 			     DMA_BIDIRECTIONAL);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
