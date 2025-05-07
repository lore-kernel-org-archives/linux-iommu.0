Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33A289818
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628967; cv=none; b=KXrzeCXANhP6G0n5OZWPSb8ugT14ekdaScw1ZaZaQU9lbeiZYWYyvHiQdH0p1xbPLn3nIur2Smwj3tCrI6xCk5QDhBTUHRtWi4+iw0kzSC1kXkFJNn3z6G222WPkPcogwid5EBNPHney6vAQJmwx6htR8VU6THUM77d2dYmXUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628967; c=relaxed/simple;
	bh=7DunRLFldUeiMTf+UYtSN6FMcB3hN60Iv5yKAvtTt0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ponAmiDWdLeHsljtM6QN3jfhvKJiJs4xsI2vYggev+Lp0M60qr6xWxQYGRDvzV5t+BobGhfTiy7QzccAQSu1vKF4JinPdcoJk0ZQlbu/pgLdw+rIbovYk3tWKPvj+NCibPfiLf6QO7AMqczl/Fqyn0eX/jP65XG9VpHDXsDSXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d9Evnz9V; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d9Evnz9V"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250507144244euoutp0247e8fd1483c5df5a560bc0ab782d1ecb~9Rcn3w1bH0382903829euoutp02y
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:42:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250507144244euoutp0247e8fd1483c5df5a560bc0ab782d1ecb~9Rcn3w1bH0382903829euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746628964;
	bh=mdz+cXEDZljQjj2QHVAL79wyw6IZ/e07fNnVY+iBXtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9Evnz9VsLfmbn0AKxp+0qI5a3c1Rj/fY+g81UV/Jo6OCwbj/aftq/2NjRGsRtc9J
	 Am3pdiZqSXjG8av2hmZ0LKAcJePbcyxFLgk8IILY2gQ0wtGqD4W22tMQwqB1PHJqRZ
	 PWxRbZ8go7ktkhJpRijPlJIFLpJzPZeR55+9Wn84=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250507144243eucas1p223283ee32d1675125dc77c2457253443~9RcnYuNDg1729917299eucas1p2Z;
	Wed,  7 May 2025 14:42:43 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250507144242eusmtip25a0a7410ff09476124e2b33381e9f69a~9RcmtVAvp0180601806eusmtip2E;
	Wed,  7 May 2025 14:42:42 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] media: omap3isp: use sgtable-based scatterlist
 wrappers
Date: Wed,  7 May 2025 16:42:03 +0200
Message-Id: <20250507144203.2081756-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507144203.2081756-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507144243eucas1p223283ee32d1675125dc77c2457253443
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507144243eucas1p223283ee32d1675125dc77c2457253443
X-EPHeader: CA
X-CMS-RootMailID: 20250507144243eucas1p223283ee32d1675125dc77c2457253443
References: <20250507144203.2081756-1-m.szyprowski@samsung.com>
	<CGME20250507144243eucas1p223283ee32d1675125dc77c2457253443@eucas1p2.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgtable's nents.

Fixes: d33186d0be18 ("[media] omap3isp: ccdc: Use the DMA API for LSC")
Fixes: 0e24e90f2ca7 ("[media] omap3isp: stat: Use the DMA API")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/ti/omap3isp/ispccdc.c | 8 ++++----
 drivers/media/platform/ti/omap3isp/ispstat.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispccdc.c b/drivers/media/platform/ti/omap3isp/ispccdc.c
index dd375c4e180d..7d0c723dcd11 100644
--- a/drivers/media/platform/ti/omap3isp/ispccdc.c
+++ b/drivers/media/platform/ti/omap3isp/ispccdc.c
@@ -446,8 +446,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 		if (ret < 0)
 			goto done;
 
-		dma_sync_sg_for_cpu(isp->dev, req->table.sgt.sgl,
-				    req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt,
+					 DMA_TO_DEVICE);
 
 		if (copy_from_user(req->table.addr, config->lsc,
 				   req->config.size)) {
@@ -455,8 +455,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 			goto done;
 		}
 
-		dma_sync_sg_for_device(isp->dev, req->table.sgt.sgl,
-				       req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(isp->dev, &req->table.sgt,
+					    DMA_TO_DEVICE);
 	}
 
 	spin_lock_irqsave(&ccdc->lsc.req_lock, flags);
diff --git a/drivers/media/platform/ti/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
index 359a846205b0..d3da68408ecb 100644
--- a/drivers/media/platform/ti/omap3isp/ispstat.c
+++ b/drivers/media/platform/ti/omap3isp/ispstat.c
@@ -161,8 +161,7 @@ static void isp_stat_buf_sync_for_device(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_device(stat->isp->dev, buf->sgt.sgl,
-			       buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_device(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
@@ -171,8 +170,7 @@ static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_cpu(stat->isp->dev, buf->sgt.sgl,
-			    buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_cpu(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_clear(struct ispstat *stat)
-- 
2.34.1

