Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA6C47247
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5B5206CC
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gs3+muHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5B5206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0345988767;
	Tue,  5 May 2020 08:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6gojbRjSheOG; Tue,  5 May 2020 08:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A8A8884E8;
	Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FDC3C088C;
	Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5F9C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4B60489567
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jUoGLedWV4RE for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DE7AB89557
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:35 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084634euoutp01e80d8746b61bf90b14af144fecfb638d~MFXzRYa7x0374903749euoutp01S
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200505084634euoutp01e80d8746b61bf90b14af144fecfb638d~MFXzRYa7x0374903749euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668394;
 bh=rhbjcVyJciQI9BrVNHTHpqVxfzl3IrypYzdEF9vtEFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gs3+muHWzOnJts9lSetvJ6bgn64Zhsz/jR/l1q58EzGlQhGwtyq0Ce72lzz6fHQOi
 XaWS4q6a+RvTPfgN4Bk97soVLqHPWhRvf+PC+i3oICdonZxDJDYURedkEQjky/OKoK
 OfKQx+paiNaIxnhIPIPDjOEzFc6/znm5Ett02Bz8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084634eucas1p130922399efe589caaf1389d9ebaa05f6~MFXy7krN32432424324eucas1p1C;
 Tue,  5 May 2020 08:46:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 37.CF.61286.9E721BE5; Tue,  5
 May 2020 09:46:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084633eucas1p19798e1fb42c9430a93d668bc585e58da~MFXyp7kGd2423624236eucas1p17;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084633eusmtrp1fd8b72215c31bd7374169b1f06dbb9cd~MFXypSze20942509425eusmtrp1N;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-af-5eb127e99851
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.14.08375.9E721BE5; Tue,  5
 May 2020 09:46:33 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084633eusmtip14f22af47e0947852337ec2e00ed99015~MFXyHKj0e0580805808eusmtip1_;
 Tue,  5 May 2020 08:46:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/25] drm: host1x: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:46:06 +0200
Message-Id: <20200505084614.30424-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1zXSmA1IcCwkv1UhsgiCyiPoxESGa+DFGPxSNAROKVUYglCUd
 dk0AAbVsUYmIDRIimwK1bEEosgpUIVRZBQEFERENiAJFMKItA/h37lneubl5BCqswUREQHAY
 Iw+WysS4Ka+6ffm147RtuWR/j/4wlaZ7hVDlWWqM+lt9B6X6Fr/j1JOSNoTKbXSlFvrGEapi
 YgCjejXZOKVYUOKUqnWUTzXPfcKoZU0O76iALs0pBXS9PpdH1ypH+fQz/RhGf0jRInRlfiw9
 vDqB0hmDRYCuG4rD6fSqYkDPV+w6vfWC6RFfRhYQwcid3S+a+g+3tyGhCzBqrLALxIE/FsnA
 hIDkIVg3O4smA1NCSD4G8EtlG+CGBQAzdQPryjyAS1MNvI3IePoAnxOKAExQF2Cbkdr2e4jR
 hZMuMHkmGTdiSzIJwJdpZkYTSn5EoOJtN2oULEgP2J+iAEbMI21gV8f7tQoB6Q7r8pYAV2cN
 S8qa1vwmBn6iZwQ3PgTJdj6cm5xAOdNxOPQwEeewBfyqreJzeCfszEjlcYEEAMd1Kj43pALY
 ez1rvcIVjuhWDGnCsN9eqNY4c/QxONLfgBlpSJrDwZntRho1wLvV91GOFsBbN4Scew9Uap9u
 1ja/6VlfjYa9tZr1O7YB+CC+AL8NrJX/y3IBKAZWTDgb5MewLsFMpBMrDWLDg/2cLocEVQDD
 f+pc1f6sAYs9l1oASQCxmcBzXi0RYtIINjqoBUACFVsKCn+VSYQCX2l0DCMP8ZGHyxi2Bewg
 eGIrwcFH095C0k8axgQyTCgj31ARwkQUB2S6XK+aH/FxU6KMQK1vgL9y8UxC47bQd2d1pzwk
 w6524FyM14qs1c08zWJyPFL1wtZuX1ModqV5xpHVnyw/oYrtnq2fta/JTlLXbtn9/LeXZ4fN
 zXy1wuc84lD47VrOyNJVV1FXHpF4QJ6gybTzTonSd4kwYk7x2c2hT5jmLBfzWH+piz0qZ6X/
 ALsGINZLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7ov1TfGGWxYr2nRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzaLzyyw2i7VH7rJbHPzwhNXi
 5655LA68HmvmrWH02PttAYvHzll32T22f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6bDWwe
 fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl3H72FGmgi8SFQ+WnWVsYPwr3MXIySEhYCLxsO8aO4gtJLCUUeJCRzFEXEbi5LQG
 VghbWOLPtS62LkYuoJpPjBJXOz4zgyTYBAwlut5CJEQEOhklpnV/ZAdxmAVeMUl8+NPKCFIl
 LBAg0dR2BmwFi4CqxNlT91hAbF4BO4ndi78zQqyQl1i94QDYVE6g+ONLd9ggTiqU+HD+O+sE
 Rr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNl27Gfm3cwXtoYfIhRgINRiYc34vP6
 OCHWxLLiytxDjBIczEoivMt+bIgT4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgHOeVxBua
 GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCcqvhwo3506RkZraqqmA/z
 XQP8KsMdT+XOqyi4cM3g/qGT6zVtOjXU3IpD75yJrkrMEyjJFtT8K3IpdNKWP2yv3wamB0wv
 mHLK8IouQ7Cdx6qYeyEFXU4LLBsPBj1klFgfMd0x7FDNwgqnCR+eRF+OvnRXKN1AX17LdaeB
 31aZs8+vMK1x91JiKc5INNRiLipOBADU/IzZqwIAAA==
X-CMS-MailID: 20200505084633eucas1p19798e1fb42c9430a93d668bc585e58da
X-Msg-Generator: CA
X-RootMTR: 20200505084633eucas1p19798e1fb42c9430a93d668bc585e58da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084633eucas1p19798e1fb42c9430a93d668bc585e58da
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084633eucas1p19798e1fb42c9430a93d668bc585e58da@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org,
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
 drivers/gpu/host1x/job.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index a10643a..850115e 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -166,11 +166,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dev, sgt, dir);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dev = dev;
 			job->unpins[job->num_unpins].dir = dir;
@@ -217,7 +215,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) && host->domain) {
-			for_each_sg(sgt->sgl, sg, sgt->nents, j)
+			for_each_sg(sgt->sgl, sg, sgt->orig_nents, j)
 				gather_size += sg->length;
 			gather_size = iova_align(&host->iova, gather_size);
 
@@ -229,9 +227,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = iommu_map_sg(host->domain,
+			err = iommu_map_sgtable(host->domain,
 					iova_dma_addr(&host->iova, alloc),
-					sgt->sgl, sgt->nents, IOMMU_READ);
+					sgt, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
 				err = -EINVAL;
@@ -241,12 +239,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			job->unpins[job->num_unpins].size = gather_size;
 			phys_addr = iova_dma_addr(&host->iova, alloc);
 		} else if (sgt) {
-			err = dma_map_sg(host->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(host->dev, sgt, DMA_TO_DEVICE);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dir = DMA_TO_DEVICE;
 			job->unpins[job->num_unpins].dev = host->dev;
@@ -647,8 +642,7 @@ void host1x_job_unpin(struct host1x_job *job)
 		}
 
 		if (unpin->dev && sgt)
-			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->nents,
-				     unpin->dir);
+			dma_unmap_sgtable(unpin->dev, sgt, unpin->dir);
 
 		host1x_bo_unpin(dev, unpin->bo, sgt);
 		host1x_bo_put(unpin->bo);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
