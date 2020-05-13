Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD9C2D106
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D32207CB
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M7tywKAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D32207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E6EB870ED;
	Wed, 13 May 2020 13:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eH_di8Z6OpQl; Wed, 13 May 2020 13:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B6FEA871FB;
	Wed, 13 May 2020 13:33:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1E2AC0178;
	Wed, 13 May 2020 13:33:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD693C0890
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A834288211
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ahgx6Wc+-WKe for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E1272881D2
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:14 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133313euoutp0204d83ca580da2622f4455eb601853d2d~OmcXbqBpD0034400344euoutp02T
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200513133313euoutp0204d83ca580da2622f4455eb601853d2d~OmcXbqBpD0034400344euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376793;
 bh=iJsOj7yiyEFeyetX/zCHD13aCbDDq1L8pigjwt4kk7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M7tywKAGKgP3waAOZ1nVNG8hgqJz/IkFpsml/rWyrzZDF8Ll75Wbt7L27PuVGZTUD
 gjY4Zc5rZKhkZDg/MggjbN/iKrnc81dx0Z6EnlSkAwGk28X8ucDrsU2uINn4gfWNTd
 L9IdEX2TOSp+QqRC4a+ts0+KwmCrEtB5Z8DfiyDs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133313eucas1p14755da98e4c430f99840ffbf4b524ebf~OmcXHUczV2164721647eucas1p17;
 Wed, 13 May 2020 13:33:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.C5.61286.917FBBE5; Wed, 13
 May 2020 14:33:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133312eucas1p2fc1186c0aeee2367898fc0c146f1ed52~OmcWwDzS91832718327eucas1p2b;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133312eusmtrp1bfa286fa54fc03c086370de9c5f8d92e~OmcWvQqNV1050610506eusmtrp1Q;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-60-5ebbf71926ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.1A.08375.817FBBE5; Wed, 13
 May 2020 14:33:12 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133312eusmtip12e592ada7c238820e4b042f9c6a599c2~OmcWEljUR0693406934eusmtip1W;
 Wed, 13 May 2020 13:33:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 22/38] drm: rockchip: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:29 +0200
Message-Id: <20200513133245.6408-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURzGPbt3d9fhxm0zPJppDCws0tQ+3FKjoJf7SaKMwtDc9KKSb2y+
 QySuTJbapmgiZVKmOd9q6hSXLG02TTFT0/mGmvYhxXw3LNK83Znfnv/vPA/P/xwOjohauU54
 VGwCLY+VRkswPqr/sPnpuONPQ8iJRQ1O5vR2ccg3RXVccluvQcjB9UWMrKzq4JDbX+e55NO8
 O2Sp0ZdcG5zmkLqZIS450PIEI1emthGyxjTBI9uWZrlnhVR1STWgWjdKUappY4pLTT40c6j6
 srvU2NYMQuVbKgBlGEnHqD/FRpTKbdACqmmoBKFWdS6X7YL4fuF0dFQSLfc8E8qPzOxTceLn
 XVJe5M+BdDDsqAK2OCROwo5FA0cF+LiIeAVgo3aaxw5rABYZhjHGJSJWARxQeu8mdEMPENZU
 AWBG89peQvOxHGVcGOEFVQuqf2l74j6AnTl2jEaIQgRq1y+qAI6LiUD4uyCAwSjhBh9NjnEY
 LSD8oUb5ErBlrrDq9TuE0bY7fG7ciDJdkOjnwfllDY81nYcTz+ZQVovhnLnByp1hd362NaAE
 cLq3hscO2TvXySiyVvjC8d5fGLMRQrjDuhZPFp+DK6YNHoMhIYSWhX3s/kKYp3+MsFgAszJF
 rPswLDbX/q9t6+u3WihY8C2FfZ73ACrzKoAauBbvdZUCoAUOdKIiJoJWeMXSyR4KaYwiMTbC
 IywuRgd2PlX3lnmlGaz3y9oBgQOJnYAcNYSIuNIkRWpMO4A4IrEXBNTtIEG4NDWNlsfdkidG
 04p2cABHJQ4Cn+ffg0VEhDSBvk3T8bR895SD2zqlA1hu6CnI+9x4Xb3s7bZpCRXeaxze3+Xi
 9qU4IDfeOOtzRe1/DdKXVIJKpDPrRkmCz+klmT5Yxjcd8gRmi196d8VIzdsgYZisetX5YKdI
 7V5uY6yu90/mJY6KsZu14U2nUn/YUDVp8YViU3JgT6s++WoqNXThyLNj3mXaBSUmQRWRUq+j
 iFwh/QsZ/Y7HUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7oS33fHGby8YGjRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMln8f/Sa1WLupFqLBfutLb5cechksenxNVaLy7vmsFl8evCf2WLt
 kbvsFgc/PGF14PNYM28No8febwtYPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH7psNbB5/
 Z+1n8ejbsorRY/u1ecwenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
 mSrp29mkpOZklqUW6dsl6GW0XehiKngtV7F48ivGBsbrkl2MnBwSAiYSm661M3cxcnEICSxl
 lPgw9zQTREJG4uS0BlYIW1jiz7UuNhBbSOATo0T33SoQm03AUKLrLUici0NEoJNRYlr3R3YQ
 h1lgHrPE8lWHwSYJCwRJTJm1iB3EZhFQlei/fxsszitgKzGxeSkjxAZ5idUbDjCD2JxA8Vd3
 9rNAbMuX2Lt4H9sERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNn27Gfm3cwXtoY
 fIhRgINRiYfX4tbuOCHWxLLiytxDjBIczEoivH7rgUK8KYmVValF+fFFpTmpxYcYTYGOmsgs
 JZqcD4zsvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjCIrr1u/
 +6//X++dqIbX03TRc6/T2lP/HRBYve2vT4+12vQb03cGybs7WvcmfN15IC+UNT8/SrRyzo+Z
 t/ZXz5piE2zfOV03Sfqzv51Un2Hx4++KNmqRy3zUH/NNaw9T+LB2hrOoltv+JbIhkQdCHjqE
 L8z+W726dDFDQt3rliUS21hPvD16T4mlOCPRUIu5qDgRAEdPIEG0AgAA
X-CMS-MailID: 20200513133312eucas1p2fc1186c0aeee2367898fc0c146f1ed52
X-Msg-Generator: CA
X-RootMTR: 20200513133312eucas1p2fc1186c0aeee2367898fc0c146f1ed52
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133312eucas1p2fc1186c0aeee2367898fc0c146f1ed52
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133312eucas1p2fc1186c0aeee2367898fc0c146f1ed52@eucas1p2.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 21f8cb2..566557b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -36,8 +36,8 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	rk_obj->dma_addr = rk_obj->mm.start;
 
-	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
-			   rk_obj->sgt->nents, prot);
+	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
+				prot);
 	if (ret < rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -98,11 +98,10 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
 	 * without relying on symbols that are not exported.
 	 */
-	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
+	for_each_sgtable_sg(rk_obj->sgt, s, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
-			       DMA_TO_DEVICE);
+	dma_sync_sgtable_for_device(drm->dev, rk_obj->sgt, DMA_TO_DEVICE);
 
 	return 0;
 
@@ -350,8 +349,8 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 		if (private->domain) {
 			rockchip_gem_iommu_unmap(rk_obj);
 		} else {
-			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
-				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			dma_unmap_sgtable(drm->dev, rk_obj->sgt,
+					  DMA_BIDIRECTIONAL, 0);
 		}
 		drm_prime_gem_destroy(obj, rk_obj->sgt);
 	} else {
@@ -476,15 +475,13 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 			struct sg_table *sg,
 			struct rockchip_gem_object *rk_obj)
 {
-	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
-			       DMA_BIDIRECTIONAL);
-	if (!count)
-		return -EINVAL;
+	int err = dma_map_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
+	if (err)
+		return err;
 
 	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
-		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
 		return -EINVAL;
 	}
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
