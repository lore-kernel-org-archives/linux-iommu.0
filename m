Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335121A928
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085785; cv=none; b=Ia+wu7+oqEyaLMQiFNgBqaPRVxYm3FjMn8mkQ8jXnObnNVrhi7spTK0ugtyKawcp75qWJQOhjH0BtL7do7CLW/7TLW+OXMr9dwEpx/Og2nCJXIxz0pGpdYB7eamkFoP3GujlVQZeKaz0/uHlmNXlndMSi/8cxxXz/16Q1p469vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085785; c=relaxed/simple;
	bh=iAx8mzEEjM64kl3dReqUnCAxjjZTtPCO99ShqsJi2Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC6sWQr/Bg2IkfRdhgh+FEBucpW86nroS6qScnsZMkjGU81O94l6NwmkUMM19bD0Q+Q8Ii/S6z9pyMmc6VTaZ0CyFwe0DZh1/N01dgWN4teraIii9SY5V3hgC2FJJjHzs9Zb7vqZOUg9Wt0G3Rd3eXYgUx4KyuXjkbu/Rs9P2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=moaFefQz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="moaFefQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750085776;
	bh=iAx8mzEEjM64kl3dReqUnCAxjjZTtPCO99ShqsJi2Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moaFefQzNAqyMxNFZCgYN7/ZIY2A3LlHEqJJ6rErfkLEiDIJsEQi2Yfp4kotwQcp+
	 QvwQJhKsC0De+iTa8FzHuGsLuCo9iVCVy8zseEFKbLpMHGKnXnFqOb4VIrgacktzBt
	 YdcvTsIGhQDxeGRnX541dW7kq/zej4dnrlxJmP4rWM99R2yOoG8D+pRJz037kxiKsh
	 XxSv/pMzunbcGctCR8K0iel2dQx8KbVN2Ibb5az8oVSKt1o87jFrb1tCrH1NadgkZh
	 J37uGjNXVr6h/gJhfRexk9Rw/1Ml8LtGSxlhbixd6H1eljmOvBa7WRflgvCQxkwVkm
	 avMTF2ntxanxg==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4811:e81c:4b33:730c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D829717E35D9;
	Mon, 16 Jun 2025 16:56:15 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 5/5] media: verisilicon: Flush IOMMU before decoding a frame
Date: Mon, 16 Jun 2025 16:55:53 +0200
Message-ID: <20250616145607.116639-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
References: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flush the IOMMU mapping before decoding a frame to ensure that all memory
translations are properly applied.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8542238e0fb1..5a672467d83f 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -11,6 +11,9 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-map-ops.h>
+#include <linux/iommu.h>
+#include <linux/iommu-dma.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -186,6 +189,14 @@ static void device_run(void *priv)
 
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
+	if (use_dma_iommu(ctx->dev->v4l2_dev.dev)) {
+		struct iommu_domain *mmu_dom;
+
+		mmu_dom = iommu_get_domain_for_dev(ctx->dev->v4l2_dev.dev);
+		if (mmu_dom)
+			iommu_flush_iotlb_all(mmu_dom);
+	}
+
 	if (ctx->codec_ops->run(ctx))
 		goto err_cancel_job;
 
-- 
2.43.0

