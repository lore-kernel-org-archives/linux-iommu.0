Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091D4C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1C92083B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cfx4Oi3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1C92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B732C86DEF;
	Fri,  4 Sep 2020 13:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Zd+0Y0SXXjs; Fri,  4 Sep 2020 13:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B96F686D5E;
	Fri,  4 Sep 2020 13:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9742CC0893;
	Fri,  4 Sep 2020 13:35:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B294C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6684B2E1AD
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LCgGlE+cd0H for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:35:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by silver.osuosl.org (Postfix) with ESMTPS id C6BF120113
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:35:00 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904133459euoutp01b8fc3a65d6a4870d7c1aa42fee063d4b~xmAcl_XS_0722107221euoutp01Z
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:34:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200904133459euoutp01b8fc3a65d6a4870d7c1aa42fee063d4b~xmAcl_XS_0722107221euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599226499;
 bh=AcRKJe24m0Gk33OJEZM4FNrE7pej7lBb34uGE2+zBsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cfx4Oi3K1ffkpa8B3JTFxh9e2DJWOpo0PoO+iC5Jwr/r5qYK4zbn2xMmsAyLb3Y1l
 WO+GRy3zNJxS73eyLD06ghzsh0vWa8w1ZnMNCTCS+seGyERT8tTFDBP7SgiUEI497S
 a/TNCh36j8Of4V2BJWZ/jsOfyqatFMuOz0huK6wg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200904133458eucas1p1637fbed78aec3e28849fe7a9fe21176f~xmAcSNplP0118801188eucas1p1v;
 Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.66.05997.282425F5; Fri,  4
 Sep 2020 14:34:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200904133458eucas1p214dd6899a77591ed50834e9fc85ae157~xmAb9QM4T1446814468eucas1p2c;
 Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200904133458eusmtrp2029fa82bf569a174404c6e52d258ef62~xmAb8lXQ60905709057eusmtrp2f;
 Fri,  4 Sep 2020 13:34:58 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-53-5f52428214c7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.A0.06017.282425F5; Fri,  4
 Sep 2020 14:34:58 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904133457eusmtip1adff83376c3fd1d1a6ba5c5bd665abaf~xmAbWYRsj1944019440eusmtip1h;
 Fri,  4 Sep 2020 13:34:57 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 08/30] drm: i915: fix common struct sg_table related issues
Date: Fri,  4 Sep 2020 15:16:49 +0200
Message-Id: <20200904131711.12950-9-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxVcRjH+51z7rnHzdXpMp5uL7bbtNVCXv44TYilndU/sWrNlG6cYXnb
 PYhWy0useSmUMhpKy/tLXCryOoUZ2WWXikrYUFTeohrd66D/vs/3+Ty/7/P77UfhsjaRnAoI
 DuNUwcpABSkhat8s91jGunp4H5ruPcik9HRizLPMChGzWpuGM/0L30mmqOQ1xmSnVmNMXpMD
 U9BXgZiGRxgz3z+CMVWjWhHTV/eQZMrahsVMy48xEdOUpRUf3caW5pQitmExj2DzX01i7PPF
 zyI2p9Od/ZTUjrHVT26wH1ZGcfbuYAFi699Fk+xtdTFi56r2nDL0lBzx5QIDIjiVtdNFiX9G
 4ZI4NGl35NPkRSwaFUAiMqCAtoeZliKUiCSUjC5EkN6SiwnFPILx1j+4npLRcwjGPvIbE/k5
 MYQAFeigIjWxOZH2tlisp0jaBhKnE0m9NqHjEXSkGOohnG7DQZOnRfqGMe0OhRNpaxBBW0BN
 mWZtWEo7ws+mLlKIM4eSyua1NQxoJ6jJHBPpDwJaKwZN9zghQMdgeOQeLmhjmGpXiwW9C1Zf
 ChcCOg7BSE+ZWCiSEfTFZiKBcoChnt+6OEq3336oqLMWbBdo/KrG9TbQRjA4vV1v4zqZXvtg
 3ZbCrQSZQO+DrPbyzdiWXs36OizkZwyQwgulIbjf10ymIvOs/2F5CBUjMy6cD/LjeNtg7ooV
 rwziw4P9rHxCgqqQ7m91rbTPv0B1fy+1IppCCkPpFmcPb5lIGcFHBbUioHCFidS1u+uCTOqr
 jLrKqUK8VeGBHN+KdlKEwkxq93jyvIz2U4ZxlzkulFNtdDHKQB6NkqXO5A6Gs/tl0pjN8tSS
 9MuZuAqYsZufOeno6VbOlTQk+bsd59o6Gu5cd27MHvwWmTuBZleSDe3J8EAX+ekF07GEqgFb
 YmucqnTQtNaLs/F7f/iEla2PzCISzZ5z9Zyy3lupkWu746+FRsgtYzr7U9U3i8OWrYdG6428
 zkoUBO+vtDmAq3jlPxF+QY9XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7pNTkHxBtPXS1v0njvJZLFxxnpW
 i//bJjJbXPn6ns1i5eqjTBazJ2xmsliw39pi+eX1jBZ7FzJZfLnykMli0+NrrBaXd81hs1h7
 5C67xcEPT1gt9s+6xu7A77Fm3hpGj73fFrB4LN7zkslj+7cHrB7zTgZ63O8+zuSxeUm9x+1/
 j5k9Jt9Yzuix+2YDm0ffllWMHp83yQXwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
 m8daGZkq6dvZpKTmZJalFunbJehlTF3xg72gW7ZiWc83pgbG5RJdjJwcEgImEovnNbKA2EIC
 SxklNiw1gIjLSJyc1sAKYQtL/LnWxdbFyAVU84lR4tXsv2AJNgFDia63EAkRgU5GiWndH9lB
 EswCZ5glfm/wBrGFBfwlrjxYwQxiswioSmxdewmshlfAVuLj/tNsEBvkJVZvOABWwylgJ7F1
 xhNWiItsJT7MWcwygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAY2nbs55YdjF3v
 gg8xCnAwKvHwMtgHxQuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0FET
 maVEk/OB8Z1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHxasPS
 rbHJ7lmXpllnu91q2yfq9/QDI2PRurDt4YnV+2abqb73OPj0ZrfygUWusdO2Ge98+9tpi3JV
 2f7sGUvXOVVliDybxvT37Ssf94YHs1a22YRFpMw+nchUFjcl9NUzAbE5aTuvuOxw/n9o89oJ
 D/c5eCW82LYpTH7XwtvMD3P+u2xilrjmrsRSnJFoqMVcVJwIAA4dYVq3AgAA
X-CMS-MailID: 20200904133458eucas1p214dd6899a77591ed50834e9fc85ae157
X-Msg-Generator: CA
X-RootMTR: 20200904133458eucas1p214dd6899a77591ed50834e9fc85ae157
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133458eucas1p214dd6899a77591ed50834e9fc85ae157
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133458eucas1p214dd6899a77591ed50834e9fc85ae157@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Robin Murphy <robin.murphy@arm.com>,
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

This driver creatively uses sg_table->orig_nents to store the size of the
allocated scatterlist and ignores the number of the entries returned by
dma_map_sg function. The sg_table->orig_nents is (mis)used to properly
free the (over)allocated scatterlist.

This patch only introduces the common DMA-mapping wrappers operating
directly on the struct sg_table objects to the dmabuf related functions,
so the other drivers, which might share buffers with i915 could rely on
the properly set nents and orig_nents values.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 11 +++--------
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  7 +++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 2679380159fc..8a988592715b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -48,12 +48,9 @@ static struct sg_table *i915_gem_map_dma_buf(struct dma_buf_attachment *attachme
 		src = sg_next(src);
 	}
 
-	if (!dma_map_sg_attrs(attachment->dev,
-			      st->sgl, st->nents, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC)) {
-		ret = -ENOMEM;
+	ret = dma_map_sgtable(attachment->dev, st, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret)
 		goto err_free_sg;
-	}
 
 	return st;
 
@@ -73,9 +70,7 @@ static void i915_gem_unmap_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct drm_i915_gem_object *obj = dma_buf_to_obj(attachment->dmabuf);
 
-	dma_unmap_sg_attrs(attachment->dev,
-			   sg->sgl, sg->nents, dir,
-			   DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(attachment->dev, sg, dir, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
index debaf7b18ab5..be30b27e2926 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -28,10 +28,9 @@ static struct sg_table *mock_map_dma_buf(struct dma_buf_attachment *attachment,
 		sg = sg_next(sg);
 	}
 
-	if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir)) {
-		err = -ENOMEM;
+	err = dma_map_sgtable(attachment->dev, st, dir, 0);
+	if (err)
 		goto err_st;
-	}
 
 	return st;
 
@@ -46,7 +45,7 @@ static void mock_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			       struct sg_table *st,
 			       enum dma_data_direction dir)
 {
-	dma_unmap_sg(attachment->dev, st->sgl, st->nents, dir);
+	dma_unmap_sgtable(attachment->dev, st, dir, 0);
 	sg_free_table(st);
 	kfree(st);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
