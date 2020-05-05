Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77CAC4725E
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934482075A
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AcddHW2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934482075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 861D18825E;
	Tue,  5 May 2020 08:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4wOEAtdInhh; Tue,  5 May 2020 08:46:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E12BD87DE2;
	Tue,  5 May 2020 08:46:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8491C088C;
	Tue,  5 May 2020 08:46:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA7EC0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3BCAA850E9
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fGCtYCOWSnyY for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EE0DE854F8
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:31 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084630euoutp02d6e781d3e4890773fc522effa02e6d98~MFXvgI_fJ2639926399euoutp02C
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200505084630euoutp02d6e781d3e4890773fc522effa02e6d98~MFXvgI_fJ2639926399euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668390;
 bh=RAL/kVrQn3ABTB/9OyAXiXBaS4eDpAUEBvBDOAmejTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AcddHW2Ku3Lm0RPoZWCmo5mzLoTTjxm8ofDgWZ9TT2kSkVQ3dYkANqwrsPzg+X6Bc
 TCFtI8TzMjj/qcKa3d/6xePxbte76j5Mw4+Qgyt03gSLm+TjtD860Rw99yzz0v4asO
 H7eMkI7wGF3VFsP3c4a23PcGClRqJQ6XUl/FZWPM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084630eucas1p1cb2107de9a66d414e9041526ee473613~MFXvUFf5x2422924229eucas1p18;
 Tue,  5 May 2020 08:46:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.01.60698.6E721BE5; Tue,  5
 May 2020 09:46:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200505084629eucas1p23d2d6a53451e67e2b0a3544eb696008b~MFXu05eIF1948219482eucas1p2Q;
 Tue,  5 May 2020 08:46:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084629eusmtrp124d65a6a9a9d8be703fa6427f75aa98a~MFXu0Isly0942509425eusmtrp1D;
 Tue,  5 May 2020 08:46:29 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-38-5eb127e692ea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.14.08375.5E721BE5; Tue,  5
 May 2020 09:46:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084629eusmtip1a56cd20ec71b7a3ecae72184bf9fc36e~MFXuRtPEk0686606866eusmtip1J;
 Tue,  5 May 2020 08:46:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/25] drm: panfrost: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:45:59 +0200
Message-Id: <20200505084614.30424-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGe89tZ+LsOA1fNAxGJZaXRKMDhiX04RB9iBCMSGvlSU23bCct
 /dJIM52amtFFKzSs2bxPWV4rtblUtFArr3nNamRFm6YSs52O2bff/3mf5/+8vLwkKm3F3clY
 5QVWpZTHywgHzNC5/Np3zqs2ctfcCEHn9HUhdO2dapxeNeSj9ODCd4J+Um5E6OLnwbR1cAqh
 9TPvcHqg6R5BV74cF9GrLQ0iuu3HLE5fr+wn9kuYigcVgGkYLwVM62Ixxuh1mQTzdHESZyay
 TAhTV3qZGbXNoEzBkBYwzcNqgrlerwOMRe952PGYw94oNj42iVX5h5x0iDGXGEFCrvSSJc+E
 q8H9jRogJiEVBJtqWxANcCClVBmAj/LTcGGwAljYqEWFwQJgr/Yu/i/yLevXWkQLoK3DANYj
 091tgHcRVADUzGsInl2pqwC+ynHkTSg1i8Chpcq/q1yoMKjRmEU8Y9Q2qFv8hPEsoUJgWo4Z
 CHVbYHnNC5RnsV2f6R8j+EWQ6hbBioU6TDAdgB36XkRgF2g21YsE3gx7CrIxIZAK4FRfpUgY
 sgEcuHJnrSIYjvWt2NeS9vt5w+omf0EOhW9HLSJehpQTHJp35mXUjjcMt1FBlsCMdKng3g4L
 TVXrtW1v+lGBGai7MbH2qEYAx01qLA9sKfxfVgyADrixiZwimuUClexFP06u4BKV0X6nzyn0
 wP6pemymhQbw7PepdkCRQOYoOWqpjpTi8iQuWdEOIInKXCWPl2oipZIoeXIKqzp3QpUYz3Lt
 wIPEZG6SwIdfIqRUtPwCG8eyCazq3ylCit3VIHMxnTOqrTv3THuHdRWdiLfuKziu7rMe+rC8
 EjQ1MmSzNZ+/ObXhSPiw9UxnvuK7z0hwbJn4Z7TnwblS6cnVjSlV5nDXiN1JJUzL+8ZG32uG
 MHO2c8D07OSu1LyvuUomtNPDZ6Loc9RWr/w4Rf14pzjcCXGRNN2qv3225mOGdtOSDONi5AE7
 UBUn/wMce5yEUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7pP1TfGGfy8rmzRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFv/37GC3OPjhCatF
 39pLbA68HmvmrWH02HF3CaPH3m8LWDw2repk89j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
 u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
 TUpqTmZZapG+XYJexquFRxkL+oUqPk84ztrAOJe/i5GTQ0LAROJd93emLkYuDiGBpYwSO7s7
 GSESMhInpzWwQtjCEn+udbFBFH1ilJjbOYsdJMEmYCjR9RYiISLQySgxrfsjWIJZ4A2TxKWr
 ESC2sECQxKaGVrBJLAKqEqu+PWcBsXkF7CRael9BbZOXWL3hADOIzQkUf3zpDhuILSRQKPHh
 /HfWCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGzbZjPzfvYLy0MfgQowAHoxIP
 b8Tn9XFCrIllxZW5hxglOJiVRHiX/dgQJ8SbklhZlVqUH19UmpNafIjRFOioicxSosn5wIjO
 K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKLBEP/e4ZvpVuzvr
 ko6ZP8j6OrkvlVO52mOj1YS+uLpLJ1KyLs5+Mvf/9YMVgVtE/x4PNNnKqGg1MZIj3i5x1tpV
 yxeaPA0SlQ2yLbYqfJf8vf7F8x+ur/1fHkhh0omvFPH6fZC1R/ZAz2/LnZ1z49PvFpawid90
 SFM8e0BqWoVL9r3wXIMeJZbijERDLeai4kQAAmqGlbACAAA=
X-CMS-MailID: 20200505084629eucas1p23d2d6a53451e67e2b0a3544eb696008b
X-Msg-Generator: CA
X-RootMTR: 20200505084629eucas1p23d2d6a53451e67e2b0a3544eb696008b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084629eucas1p23d2d6a53451e67e2b0a3544eb696008b
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084629eucas1p23d2d6a53451e67e2b0a3544eb696008b@eucas1p2.samsung.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 17b654e..95d7e80 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ed28aeb..9926111 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
