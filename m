Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202DC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC49E2078E
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l8ZplvoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC49E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A7D4D228A0;
	Fri,  4 Sep 2020 13:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EQQTsfS2vLz; Fri,  4 Sep 2020 13:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B3E92E186;
	Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92622C0894;
	Fri,  4 Sep 2020 13:35:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF63C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D3C386D5F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMuEJulym-xW for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 31C5F86D7B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:05 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133503euoutp01334525416826c899baf45fed29ba6c78~xmAg0SB540721507215euoutp01h
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133503euoutp01334525416826c899baf45fed29ba6c78~xmAg0SB540721507215euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226503;
 bh=l+uE0Uw/hmYgweTMJTNZUtDyKghxm7SM+gopIC5qQSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l8ZplvoW20A9Syt7Adirzg1qySQxeE/ho6uu7gd6rTG/FdI/FNmEpbGHx+EVvpIpg
 dicp532i9zN62EP7vI3CD9OfH5QkkTFBU0TQvKrH4dgj6ZKXG/jcNnjISTtZrr5JFX
 7Oxc6Z2nIyocpmSzPJddvOEYKzjM4JYXFq/GhaLc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904133503eucas1p2c5b8774cd10d214618af91db641a78f4~xmAgbZ7rk1447814478eucas1p2q;
 Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.11.06456.782425F5; Fri,  4
 Sep 2020 14:35:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770~xmAgB2t020116001160eucas1p1y;
 Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200904133502eusmtrp25a0e98b8339aded79c9ecf382d66e707~xmAgBH-Ja0977109771eusmtrp2C;
 Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-4a-5f5242876b10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.BE.06314.682425F5; Fri,  4
 Sep 2020 14:35:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133502eusmtip1d5af0b81300a8a7631cc0e8fd4073377~xmAfZq8YZ1624216242eusmtip1p;
 Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 15/30] drm: rockchip: use common helper for a
 scatterlist contiguity check
Date: Fri,  4 Sep 2020 15:16:56 +0200
Message-Id: <20200904131711.12950-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTURjGO7sfu063btPo2Jcx+qAgbRR0wbKMqItEH0L/VGYzLxa6GbtZ
 KUXDSmXNSgsbo3RmaK7l59Iyam2la1lLl4pmMW1SZJmfszLacl6z/37Pc97nvO97OAQiNmPz
 iaOK44xSIUuR4AK0rumXY3X2ltj4Ndq2QCrXYedR1dpKjPLV5SFUm2cQp8rvNvIo38evGHUz
 /wylN0dSY229PKrG3YFRbxtu4NRIjw+h7j3/wKcsQ33YZhFtLDQC+vG4HqXrx3sw2nXRxqNr
 b5+lu71uhL7aWQboR10qnP6jM6P0JZMB0PUdhQg9WrN4d9A+wYZEJuXoCUYZEXVIcERXegk9
 9iHoVJbRhKhAu0ANAghIroOljzJxNRAQYvIOgK+s3QgnxgDMtTTxODE6KSbe8NWAmIpoahWc
 Xwago8qMzyR+lwzy/PfipBSqB9S4n0PICwC+yA3yM0IWINDg2ebnYPIQdNf7pupRchkc/9aH
 +llIRsEfrmt8br4weLfqKeLngEn/vrYP8zeDZAcfmpwuwBVtheWXL08HgmG/zTTNC6HvYRGP
 C5wDsNdxj88JDYBvM7XT6Uj43jGB+3dDyJWwsiGCs6NhgdeJciuLYOfAHG4BEcyvu45wthDm
 ZIm56uVQZ6uYaWtpcSIc0/BJcT/KPVAegJoLBdgVEKb730wPgAHMY9JYeRLDShXMyXBWJmfT
 FEnhh1PlNWDyWzV7bSMPgMeZYAUkASRBwlmbYuPFmOwEmy63AkggkhDhltfNB8XCRFl6BqNM
 jVempTCsFSwgUMk84dpbX+LEZJLsOJPMMMcY5b9THhEwXwWiN+rxPk3Dw+WWIsO71NqY7K4y
 +P3mbJPSo9qzuyuxuO3jdu/E/p+fLSJXy44YYVx8RVHgp21/ftLDhiWuuVKwFNWrV7Qa229V
 nK7zZsFFc1XiAy+7VT32KF/v2Dn7QIl1Y6suwR0a1hgOLDHDwH4jdO9Qxs71Oc92VZ8nk9US
 lD0ik65ClKzsL76WlwNSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7ptTkHxBkdW6Fv0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBb/H71mtZg7qdZiwX5riy9XHjJZbHp8jdXi8q45bBafHvxntlh7
 5C67xcEPT1gd+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuix+2YDm8ff
 WftZPPq2rGL02H5tHrPH501yATxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
 pkr6djYpqTmZZalF+nYJehmzlvWxFNzlqWhbs4W5gfEqVxcjB4eEgIlEz+a8LkYuDiGBpYwS
 F26/YOxi5ASKy0icnNbACmELS/y51sUGUfSJUeLM13tsIAk2AUOJrrcQCRGBTkaJad0f2UEc
 ZoF5zBLLVx1mAqkSFoiT6DgwE8xmEVCV+PbmCQuIzStgJ/H9/hR2iBXyEqs3HGAGsTmB4ltn
 PAFbLSRgK/FhzmKWCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGz7ZjPzfvYLy0
 MfgQowAHoxIPL4N9ULwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAh01
 kVlKNDkfGNl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYyz78
 573D/V031uQ8j/0lF7U/782W7uvRztWXK75itJA9+k/4xQzlqwWh9z1YVpvaCitENnsuc4vp
 Yvivq3ZzkfrC2KMzpRk26l/dqj7hoP+P3auvp3x8tF9Ekf30xd7WR3/t41Y+CnQTN2Y+ck/k
 xjqhCepGC6flSK2Q+q/AEx0etkQk7LubEktxRqKhFnNRcSIAEvCk4rQCAAA=
X-CMS-MailID: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
X-Msg-Generator: CA
X-RootMTR: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133502eucas1p10c2344eef1f77b82c455215056fd5770@eucas1p1.samsung.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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
