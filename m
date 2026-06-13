Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999838423D
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333907; cv=none; b=lWg2yjseFnyemPiunSrEPdWYstTIR13gk3jvA6OC2G/c5pyibarq8lakK4qSDa0NrhoPM5bfT59jhDcXih/M+MTJ1QySRoAKOxlPOJKiSwP4IvsCJGaYqBpygbbVXhAOr7wjdHs1bxzpc80mHc3rwaSpuiqBgsd+ZZO3+DgMVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333907; c=relaxed/simple;
	bh=S9wsoFfpviCH54ht1kILwTO8iq9EJE4/9BCGA0UKyVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnBPJO5zYv3wSQWmrsAbL0E2JmSutOrY7feEBbAaTqu1y5jzjqB49A06XJTEL98QYHpOg+DT5DYdi87U+/Mz696tevOhInFacan54k/3R63Q3lv3ntaQyBOB1b3ZOK6ve8DWGFMFzWcHOAAONtkT5/DT+mJdvnI1c/n7/IX4GpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHXUU3d3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHXUU3d3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490be03d47bso16718795e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333904; x=1781938704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
        b=CHXUU3d36kIRH2BHS8TvGXeed4aD0TlFFthvq8VCnsmMDJB/z9sO8VX2EXKG4P/uwA
         N7UZ47/N4Qce9S7o5ccHy8TvRbP/OwMgGNmkk5k6DKZHBJ20yuVeEr3m+0F2TSN1T59E
         k9sVBahXDrPB37lJK+G8Yqt6ZdzaL1cPfa3Zbmv4k0YlbRCiOwhdCVl7X/kUTT96SM1Y
         HSmlbmMsGZVCdUnoLISgd7gS5mk5YLGmnQSkHiym3Q5AJAng0nb18zJhDKzLscn6nRNn
         NtBhlrx728dH3PY8euD13rhRP5ssFuoiGpuiTf/Ytn66NcbwbuEmgZeNRAK572mYJrSQ
         BYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333904; x=1781938704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
        b=UTQTXBVAYjmiqb994pzHeBdwM7tnfSX6NrIj09BuuTSSjLjQE7LPDMyfE5TbcCnox5
         1scLV14JAS3lqT5RAz/N0kKc7QSi1pcF5NdrbYuwRhMR/6ldBODzd5d7SVZKgkFqil+2
         d+6MX4E6A13vVikvhNbMw2MbqEHqqi1V1S2KxRm4sKmJr4qP7WqkF2vDASTGk9AbgU5g
         DbPURy1bSmzneQbXL3JFvMxWoqZnc4wkZ9WO6Rmh9ef9dAPJzXmFZX7UdLrEh93J2cZz
         qY6D4DabW6fnUQ0QyM2plnA0uoV2zEqyN857NVN9Y6JaUKRt0ruTlsyO8c6y0AKD6dvu
         Mi0A==
X-Forwarded-Encrypted: i=1; AFNElJ88fdo20EnCAIsvBU2tPTgK+6QdDgcCUelx9K+OGtKjwpTCRpbBSXn3Y1D9WN0u8fQQUjuIgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGta/q+SUtBA3RICJazLDyt9xvlgVdcyulcKN2PbzZfyuEaoNi
	STSj84bTcWc4rg3Zt0VP2xiUdYRXKOEA/Z7XDIDOymfTwVowKXVrNNHL
X-Gm-Gg: Acq92OFqDKnBEVPtNY3vJFdvColEZ9B8gocWGlFRNWgLRIEh1CpVbTZpBAND0AH06GI
	o4aXOcSznFv4UmNfL5eXPjJpJtiSTnY0uiBhJ0zsOsN2DYdgEgWa64axvKF6JgHIMfojSmceGCG
	97LIr2yWFuY7Wu3ZQdy5b1y+FhnWeV1qlN/NY0lMMMcoNlWBt4PD7KaVQc2FOcm9Zee7pn0QFe9
	7lbzIVBeBxzP2Hg7YZjDbtYI06a2SCTERhQxeMXih2Mn0/XY9uUR8jdDzXB2YJyoEISNkUYPjb5
	+Fsk9ira5ofHr0wAyLqPrl9H72a8iC5uoXJV56YTNKqsNiWXAyJEcTExhIfsATcqLZm86mkzLiB
	adwIXtO4h/Jh2Rta09yu+pvLA4kFnjppzG1578cRVHsvIaxcE/vtoGclaYHZOjixML1aaJXQUnT
	o1lbIYoMXVc5/CQFNsf/qrKwZjgFZaJC8x50wakztowQ==
X-Received: by 2002:a05:600c:820c:b0:490:45bb:8dd9 with SMTP id 5b1f17b1804b1-490ec4cde5bmr72801305e9.8.1781333904245;
        Fri, 12 Jun 2026 23:58:24 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:23 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 1/9] accel: rocket: Introduce per-SoC rocket_soc_data
Date: Sat, 13 Jun 2026 09:01:08 +0200
Message-Id: <20260613070116.438906-2-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

Add a per-SoC data structure carried in the OF match table, currently
holding only the NPU AXI address width, and use it for the per-core DMA
mask instead of a hardcoded 40-bit value.  No functional change: the
RK3588 AXI master is 40-bit.  This prepares for SoCs with a narrower
address width.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  7 ++++++-
 drivers/accel/rocket/rocket_core.h | 11 +++++++++++
 drivers/accel/rocket/rocket_drv.c  |  6 +++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba645a..09c445af7de73 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -21,6 +22,10 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	core->soc_data = of_device_get_match_data(dev);
+	if (!core->soc_data)
+		return dev_err_probe(dev, -EINVAL, "missing SoC match data\n");
+
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
@@ -52,7 +57,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(core->soc_data->dma_bits));
 	if (err)
 		return err;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..8ee105a0be40e 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -12,6 +12,16 @@
 
 #include "rocket_registers.h"
 
+struct rocket_core;
+
+/**
+ * struct rocket_soc_data - per-SoC configuration data
+ * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ */
+struct rocket_soc_data {
+	unsigned int dma_bits;
+};
+
 #define rocket_pc_readl(core, reg) \
 	readl((core)->pc_iomem + (REG_PC_##reg))
 #define rocket_pc_writel(core, reg, value) \
@@ -31,6 +41,7 @@ struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
 	unsigned int index;
+	const struct rocket_soc_data *soc_data;
 
 	int irq;
 	void __iomem *pc_iomem;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..384c38e13acce 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -213,8 +213,12 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.dma_bits = 40,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.39.5

