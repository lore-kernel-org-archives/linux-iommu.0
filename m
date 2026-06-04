Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFC47ECDE
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581181; cv=none; b=dQc6IklbOUDZWJDX4hNdUUnIT5asqEKMb/Hm4gzygpdYR550K9FeRk0NANmbjmH3mYuKqyZUoOWd52esBMusuHo5HOCJRktKhJ015MxTtY71kJiq6mRkt/DJIStseLa3FGMg0+akeEC7alTVfBy3iKaRt9BiM99lKrDv9T0N+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581181; c=relaxed/simple;
	bh=DzZKakHuN52Xow3vnp9cNnLc4W+yXF/Ljm2JhcvRG7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNnnxwFG1vk1O+TPjmdRRa5J+bH5a5XtS3PB/mjxe2X3ML+oKN/Jft2TGrJEf+3CX3vq6MtheybVs23mJT1wEj/h+sB1PADEJe/8+9aKQtOXCXmEYCsSs2s8ZxAMQvA5x+TcQfxevxOmmd6TgnWnvhLMQl+HR/SSG7P9xHEWZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxidnXOF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxidnXOF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef82204c6so426080f8f.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581178; x=1781185978; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoHc1Zlbr3pNOE70Y4k5QiMyrmoz//QwwHMvtTDGYPc=;
        b=pxidnXOFixPH4xgeFm8U/t9G4iGSL+WzPTHystVtnGQQCy5rImRX0Xy6ttc0jsDYch
         Z84SW53U2UE94cBBxMSokfuREg5zY0yBsvnys8Z9f6aK4y2U1mk+CYevtx3PbQBd5LJE
         T+CFam+MjPKyBlIGBeCK2BZO0zek1A4ZpS66d6i9/+jDV5zwSRJMKvPDQyEjONpzHukg
         H2a1JFmtCWbQebpwb1S0OHifBhc+evf25WdmzJgHd9RrwExsQDs5seL55e0F10fBJmD5
         GDGb/YubFRYK3hls/DPqyeFW+3NxNKl53lSrx/8QT0T4/zyx1zicqHfSmhdzTY8YFUjK
         CoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581178; x=1781185978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoHc1Zlbr3pNOE70Y4k5QiMyrmoz//QwwHMvtTDGYPc=;
        b=LPH95wiZ+ZcHk1/HhIuH+eAg+LUS6AaJ1DkVnDec9SVWYyWjY0D+Z+ClZFRS35LyXF
         1d5NJVtwbPG2bNjjFwyXhJrnPqInmXo20Gvs/vps0T1VllwA9LdgTLxbpN6agPr7c5Eq
         CkLCcElkYBnwGlOrDOLhdI7HCqrhL2xPyu1UBFGemHKuRxwrKRUt1BvVEhE+C6EqSZBk
         pM9a/nh7cTNT/o8/Lq1MQpEgctT0+bO1vodG3YmyIU9DhrMcn6ZZj0vLL7Z9Onk+Hdwm
         AwOB86bQjRkvrbmt/ZNUpnM2GWcjnunjkIIcedqzGKkyVuHqhEwkKUMFGfLhsor2wa69
         piMw==
X-Forwarded-Encrypted: i=1; AFNElJ9JEIUNbg9SiauvOv+6dghw23Pwpzanctqu30CUhoAgYX7muH7l5/FN/BW1gYNVB7cL9Debog==@lists.linux.dev
X-Gm-Message-State: AOJu0YyefgZ1wGzSZFc5PFIp7DVjJC2HfxrmLN5sQxmvC3ZAmoEOWmcv
	lXkOxo3PgQoo6lKE22wcupdBQvueUn3kSkXF1h+av6D5OXbz+8+XTMAy
X-Gm-Gg: Acq92OF6gslVvj+WlqtVAmf7Bo5BpajgPGYDsduHwYUU3MwncldyAw0boDe16FAkkAP
	u1yJeOc+PfzQ6f4thbIgNhkRwsBzqAAvpPlOrgy3I1CA++swejwfoymwx8Ya42L7Re55W/fH/qr
	Dh2JGtceaKuOFKRaLxOx3bPr3q9FxiJnsM0EgJC7BROKfB6QC2TopNqCzQRnNh4+mMKaNWCj2yP
	tgQ2Sh7uQY0S4E11OnF9JZ0phPUbFUawypa/yJQuZcXGeSJumneIAZDEaxnNKB9isVedQLEVAdB
	mx+Pb+dbS+h8XOHG04YW2adOrhOQ8PGesFSD4RUlj7hBPAlg/PDMqGZ/xoUMUqOskNV62uDd5qi
	xKgC3cM29u6GV9hkXtRTOTYBMNlxMlpGy84OzZObejT3N93O40PKUX5otGvVAzD55H8DDstK1eY
	8eL1MnuyJ3QKaD+OuXPJmPAOKEjPfFJgHk2q4sdCM9y/nyHcvffJHpqzAC6oW4MA4=
X-Received: by 2002:adf:f8c4:0:b0:460:e0f:8d19 with SMTP id ffacd0b85a97d-4602179121cmr10232727f8f.9.1780581177846;
        Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/9] accel: rocket: Introduce per-SoC rocket_soc_data
Date: Thu,  4 Jun 2026 13:52:47 +0000
Message-Id: <20260604135255.62682-2-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

