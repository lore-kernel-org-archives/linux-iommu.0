Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EACFC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530502070A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BM2TYRU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530502070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 370DB88927;
	Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HiOUOBBd3Bh; Thu, 18 Jun 2020 15:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 53D3C8899D;
	Thu, 18 Jun 2020 15:40:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA93C08A5;
	Thu, 18 Jun 2020 15:40:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFEEFC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D714887C13
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q6Yqt8rf2SLc for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 46B9787C02
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154019euoutp024ced78445b056554a2a3e4bd6e0e6059~ZrZnVLtNY1254412544euoutp02W
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154019euoutp024ced78445b056554a2a3e4bd6e0e6059~ZrZnVLtNY1254412544euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494819;
 bh=MqT40NSX2hFbmyPasraeZB6y//Q28ZVdzAVMaxtMZLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BM2TYRU11NKYlfv+/fdF9BvK6LPrvmrFCvBlVe0Dh37zuEuEylD67ussbhTtjo3eO
 2b2/oFtONww6nhdsHwBeq5t6VeQjVTSXmJ0aMS3X8PPMr9zC3gcgsnyPdWkvrCN6mj
 elUhL3dGrS9jnImCwRme5mLMnKtGBo4qfTjwcwvY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200618154019eucas1p2d67fbfd901798698c28a153faec6ea32~ZrZnAcJYb2977729777eucas1p2-;
 Thu, 18 Jun 2020 15:40:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.60.60698.3EA8BEE5; Thu, 18
 Jun 2020 16:40:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154018eucas1p259b2d1c250b2078772b091212325f93e~ZrZmrQgZ80501005010eucas1p2X;
 Thu, 18 Jun 2020 15:40:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154018eusmtrp28c05d58a5da917d59bf0bb279c56477c~ZrZmqoAKa0370403704eusmtrp2c;
 Thu, 18 Jun 2020 15:40:18 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-1d-5eeb8ae39f29
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.EE.08375.2EA8BEE5; Thu, 18
 Jun 2020 16:40:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154018eusmtip16b0cf50bb6921ca0c67990095bc31987~ZrZl93tAK0833608336eusmtip1N;
 Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/36] drm: exynos: use common helper for a scatterlist
 contiguity check
Date: Thu, 18 Jun 2020 17:39:28 +0200
Message-Id: <20200618153956.29558-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGeXcuO1tOTtPwRTNpaFaUd+KQJSVFpxuU9KnUmnpQUadsaqkf
 skSRpaaOSCQvyULzmqbTFi5d6Qzzkve8YLaCplnexWXa5tH69vu/z/O8z5+Xl0CEKsyWCJfE
 MlKJOFKE81FV+1rPUb18JtBtcRSlMrvfc6javBqM2lTlINTA8i+cel7RxqFyJ7NRqviNN7U0
 MMWh6vRDGNWvfoJTeT0aDlX1boJLtc59xag8hQE/ZUlXFlYCunmlGKUbVz5j9OQDHYd+qbxL
 j23oEVoxUgro15+ScTqrvhzQi3X7rvCv80+EMJHh8YzU1ecWP2zw6R805u2uO1UGLUgGLTw5
 4BGQ9IIlxh9ADviEkCwDUHlvlWMWhOQSgM0diaywCGBn0xy+kygyzGGsUApgRkUtwg6mxKOa
 TNTswkl3KJ+VbyWsyVQAOzItzCaETEfgUE4RMAtWZABUVw9jZkZJJ9jcOIGYWUCehMr0VYSt
 c4AVL1q2mEf6wE5d6lY1JNu5MKtSyWVNZ2BBwzzGshWc1tVvn++Fm6+KOGwgBcCp7iouO2QA
 2H8/D7AubzjebTTtSpj2OwRr1K5mhORpOD3ux6IlHJndbTYjJsxVPUbYYwFMTxOydxyA+brq
 f62tvX3b69NwuOE3l32gHABVbTNINnDI/99VDEA5sGHiZFGhjMxTwtx2kYmjZHGSUJfg6Kg6
 YPpNnRu65SagWQ/SApIAIgvB92szgUJMHC9LiNICSCAia4FvV2egUBAiTkhkpNE3pXGRjEwL
 7AhUZCPwLDEECMlQcSwTwTAxjHRH5RA822TQ98E9wlgfH2Tz0WN+bVMfE1GpXzAuHu84UnB5
 vvDGnhHns55ujo5t5+yCNr41KBA94aXI7wkZW0jqUP/MeqipcWrX+GpSndWFwYX+TWUZuN/o
 4AU5/iyGzJodt9+/7qKoGluzt7/YK7jk4d/VOp2WpMS8F45d9Tqvnf+SclBSLkJlYWL3w4hU
 Jv4LlAduXUkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7qPul7HGcx8r2nRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
 wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
 +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
 LLVI3y5BL+Pqwr8sBYe5K9a+PMTYwHiAs4uRk0NCwERi/ssPrF2MXBxCAksZJU5NecAOkZCR
 ODmtgRXCFpb4c62LDaLoE6NE77VGJpAEm4ChRNdbiISIQCejxLTuj+wgDrPABGaJ+y2rGUGq
 hAWiJX7c/wFmswioSuzdfpcZxOYVsJVY0vGdGWKFvMTqDQfAbE4BO4nTx1vBVgsB1Tz/0MY2
 gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBo2Xbs5+YdjJc2Bh9iFOBgVOLhfRHy
 Ok6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOS8knhD
 U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M6TVWuUn+gpdKs3Zf/NU+
 S9/33bLtUxe03lCv0qs8X6x7d8bl7E3TYne6RvnVn0hp2BWtHrpo1o+Fh+sFbxsetFBadvbS
 q/3FMVLsT9eXbJGT1LwvlaDiqdsnnrB15VWx0NW1S5VzmRbZ9GV+WuFUOOmw6au98Wc330i8
 cFyJ7/6p+pkxDw//UmIpzkg01GIuKk4EAJreD6esAgAA
X-CMS-MailID: 20200618154018eucas1p259b2d1c250b2078772b091212325f93e
X-Msg-Generator: CA
X-RootMTR: 20200618154018eucas1p259b2d1c250b2078772b091212325f93e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154018eucas1p259b2d1c250b2078772b091212325f93e
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154018eucas1p259b2d1c250b2078772b091212325f93e@eucas1p2.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Inki Dae <inki.dae@samsung.com>, Daniel Vetter <daniel@ffwll.ch>,
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
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index efa476858db5..1716a023bca0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -431,27 +431,10 @@ exynos_drm_gem_prime_import_sg_table(struct drm_device *dev,
 {
 	struct exynos_drm_gem *exynos_gem;
 
-	if (sgt->nents < 1)
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size) {
+		DRM_ERROR("buffer chunks must be mapped contiguously");
 		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Check if the provided buffer has been mapped as contiguous
-	 * into DMA address space.
-	 */
-	if (sgt->nents > 1) {
-		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
-		struct scatterlist *s;
-		unsigned int i;
-
-		for_each_sg(sgt->sgl, s, sgt->nents, i) {
-			if (!sg_dma_len(s))
-				break;
-			if (sg_dma_address(s) != next_addr) {
-				DRM_ERROR("buffer chunks must be mapped contiguously");
-				return ERR_PTR(-EINVAL);
-			}
-			next_addr = sg_dma_address(s) + sg_dma_len(s);
-		}
 	}
 
 	exynos_gem = exynos_drm_gem_init(dev, attach->dmabuf->size);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
