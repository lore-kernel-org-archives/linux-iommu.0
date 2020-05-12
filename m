Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E7C54E92
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F9720714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DVFT3l2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F9720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB5652046F;
	Tue, 12 May 2020 09:01:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id By5ChoW3-SY3; Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 265A124F76;
	Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09041C016F;
	Tue, 12 May 2020 09:01:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9D07C088E
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C4EDB86F89
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqtPuiIPF7CU for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A045086FAF
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:21 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090120euoutp01246f3b3ae914b9ce7a0ac8e933a79fe3~OPFsCVKNv2629726297euoutp01b
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090120euoutp01246f3b3ae914b9ce7a0ac8e933a79fe3~OPFsCVKNv2629726297euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274080;
 bh=8RXUaYJ0XAx8gHgVoRx7PyyDslr7uCrC5/8lRvvZF0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DVFT3l2sUuKwchTEywUkN78aEJqU+u8VmoNkiTfGpAeSVBn+EX4SvIWVUcI1FuU1q
 uToIQr59EsBaTgoYi5xuDpTn7Xn1ss5I4+0UKOcVBUpiVtc34OfG3F74mQstH12xm/
 VDcgQKudTE/PLqSqbpnmBsA0Nyo3SC4oST7FXtTw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512090119eucas1p122c54f3d790a8b4aabadddef138cb482~OPFr3VH7q1613916139eucas1p1j;
 Tue, 12 May 2020 09:01:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id BD.22.60679.FD56ABE5; Tue, 12
 May 2020 10:01:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090119eucas1p2b3e1a858d8893f8d209d5c19fcbab941~OPFrnFDm92669826698eucas1p2a;
 Tue, 12 May 2020 09:01:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090119eusmtrp135da908616aff3d712df2ee287b888a2~OPFrmVeew0188101881eusmtrp1P;
 Tue, 12 May 2020 09:01:19 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-b6-5eba65dfb313
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.F2.07950.FD56ABE5; Tue, 12
 May 2020 10:01:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090118eusmtip1b5259b1f4905ccb99e71fb00c788aaf8~OPFrBXLlK1352813528eusmtip1K;
 Tue, 12 May 2020 09:01:18 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/38] drm: rockchip: use common helper for a scatterlist
 contiguity check
Date: Tue, 12 May 2020 11:00:41 +0200
Message-Id: <20200512090058.14910-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfyyUcRjf99778d5x9nZsvqNlu8WWys9qb2lUS73/WP1RS1l0eIdy6F6U
 yphiuZxxSjpCWDg/k9BdhROnNNMdxqr5Ve0oY/mVuk53Xum/z+fzPJ/n8+zZgyICNcsBjYqJ
 JyUxomghm8ds6Vnt3z1GqoI9mjR7cVn/Gwb+pKCBha+15CL44NIcG6+u6Wbga5PfWPhDeTJe
 2u6DLw5OMPCmqWEWrlcVsfEf42sIXvf6EwfvnP/MOmRD1BbXAuLlcimTaF0eZxFjd7QM4mlF
 CvHBNIUQeSOVgFCPprKJP4p2JpHdrARE63AxQiw0bTtpfY53MJyMjkokJe6+F3iR+e0mVlya
 zdXeag07FXy1kgIUhdgemFlyQgp4qACrAvBneRegySKARTOZZsI1kwUA27JTLNhiKF7tYtB6
 JYCj38lNQ7l+GbEU2JgnlM5K2RZsh6UD2CuztmAEy0egcumYBdtiITCjam19EBNzhoaMwvV+
 PuYLH+SqGXSYE6xp7FifyTXrYyVGpiUMYjoOND2rAXTTUWhsNCI0toUz2mYOjbfCvrysDcNN
 ACf66zg0yQJQn1aw4faBH/t/sS3HQLAdsEHlTt/lMFztc6KhDRyZ3ULvbwPlLfcRWubD2xkC
 eoYLVGjrN1M7B3Qb2xBwQE7rAqwbQMUQmQOcFP+jSgFQAnsygRJHkJRXDHnFjRKJqYSYCLew
 WHETML9Un0m72AZUxlANwFAgtOZ7eDwPFrBEiVSSWAMgigjt+LeizBI/XJR0jZTEhkgSoklK
 AxxRptCe7102fV6ARYjiyUskGUdK/lUZKNchFVQF9HBBYJDjfPj7fXHGL69eFIbHhxq8duWY
 PORvG8kjsoBQRZhB7u2m1OquW7XJjHyJzgdVlJ85na87bph85FKm11WkrVw86zrXEbxze9C7
 zup7Q+p0v3Qq0KQ/5XAgNTelXqvb73CZWcrtSF656z99Q+UcNqsx5HJ++6sf+wmZVKTI0xWR
 UKK/MYuwBU4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7r3U3fFGaz5rmTRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMln8f/Sa1WLupFqLBfutLb5cechksenxNVaLy7vmsFl8evCf2WLt
 kbvsFgc/PGF14PNYM28No8febwtYPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH7psNbB5/
 Z+1n8ejbsorRY/u1ecwenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
 mSrp29mkpOZklqUW6dsl6GVM2/+PtaCJr+LEykNsDYzPuLsYOTkkBEwk5v08zNTFyMUhJLCU
 UeJE+wtmiISMxMlpDawQtrDEn2tdbBBFnxgl3r46xASSYBMwlOh6C5EQEehklJjW/ZEdxGEW
 mMcssXwVyFwODmGBWIlp+8VAGlgEVCVetM1mA7F5BewkZk7czQSxQV5i9YYDYJs5geL35/9h
 AbGFBAolHl19yzKBkW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjZduznlh2MXe+C
 DzEKcDAq8fB2GO2ME2JNLCuuzD3EKMHBrCTC25IJFOJNSaysSi3Kjy8qzUktPsRoCnTURGYp
 0eR8YGTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgzE+af6hN
 WeHmxk8nb0sYL7Ve43Cq8irTpCe7Nec5z4/xEAi6fXZX61M50cqr6aL/t/w7+7xuhsetfiGh
 CdwdT086rNYQzlsndFR0g5FXg/KroKVVrloGK+Ym213Lmft0suoSQZtlDe/WNVZ1tApmiOy8
 epjVRHPDYQ/XORd/vdctMG6w2+4WqMRSnJFoqMVcVJwIAJ5cyOe0AgAA
X-CMS-MailID: 20200512090119eucas1p2b3e1a858d8893f8d209d5c19fcbab941
X-Msg-Generator: CA
X-RootMTR: 20200512090119eucas1p2b3e1a858d8893f8d209d5c19fcbab941
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090119eucas1p2b3e1a858d8893f8d209d5c19fcbab941
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090119eucas1p2b3e1a858d8893f8d209d5c19fcbab941@eucas1p2.samsung.com>
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
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
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
