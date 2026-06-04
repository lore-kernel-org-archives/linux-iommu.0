Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BC47ECD1
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581183; cv=none; b=ml4a7/ZXLQWi7LEXAj+BiI6C8IMcveHC2jteOBaJJqsB18jvQd8mir3NVZFJcnsU+y1mW1k2VjO4JZcBYF9Lm29N9GbwD0rrcv26HwwswbRpe/dOyxe9Db/mL7CdHN6LWLUAIwc3BB55e0OvnC6pTAjE+CFik+DgNZIozUzkvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581183; c=relaxed/simple;
	bh=W36aVe4XoVMHBTmbHT/sY2wCfTe4v14esBNFui5pE/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKvMr1xE0iLuMDd4JQ3LmXVk3G9s9AGIhUWVt7B8cGR2i8XY1iacyQPMfoHCI0E7fGGXmi8p/vWzNIPzVWgafay7/oeymL9I5wfoQDub/+obbOqLBtq6BDD4vr5oISnfZei2sA6WJGJDX0alL+Bvo50y+7V1Ikw7l7xeZoioIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtJlnBxA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtJlnBxA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-46013161068so387175f8f.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581180; x=1781185980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvTkXFm0z4CjuuOw/gsrhETvrrwMcV/B+e1Vnh/OZd8=;
        b=WtJlnBxAsI3F1n9Lvh8ZChFHaZEcTdhyptUafOfshm/AUPHbT9mtjVVaHgZJ2UI/bE
         YVAl2PZKauB3Rhzm0+iaXQpKUBiREisktI/Yjvcp0xmATScOV0QjT9QK6QR98wdL5JHq
         7hH6H+fJf6bddXQ0AerQZqwx1LCraGoKsr1T/AvmIYB7UEYByfeGtGv1Y2V7HfDOt9oU
         I5Slq8vyLwoA0UdhrtcsP9Jd6EoYY+nkW+t6AcSmptgo+aEblt6NzbjXoQwNd1vMiW8R
         rP4LXa8Nx/90HqysCnbQvekEm6oT9HNqW5zN0PkZLLx1jNuNuZGb0cZXLB0481ZpDThd
         iCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581180; x=1781185980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvTkXFm0z4CjuuOw/gsrhETvrrwMcV/B+e1Vnh/OZd8=;
        b=dn2D02/s2wIWyEjXdQbCTZ4Ryt7aD0AkRe9uvq70j02oZWt1EmC89fJ8bLEDKgFXij
         8iwz8pmcaMIuXWy9tUjF5MillYMKmFhv/R24+sna4ogcFEtK1EZFxAucjKu4x0Qc61QO
         DB85baH+PCakEHkQVtGPnoZk7R7+7FSZ1VjOOLKwCJBevOOPKo5w+8tr57g3PzDbvjv8
         ltaUh+ZYTqLe2K9VDo79kgEWtrQP8U52rJtGtrw9dm8EOC1IcU0DpYUeS5Hge8BdnsCY
         7yaE/W/AwzNVLYNv69CFCRolQiciJeYcvom2Fn8K2mWAyMpVR0RftUwQBS5sHmuuv67h
         sbTA==
X-Forwarded-Encrypted: i=1; AFNElJ+Bk+xMGS44IPlZWe5p+BrKraInbzeiQwOj2Rsxbi3BYVO9g6lDbA9KTGXaH1UsX/z5Kh3Clw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVQ/6y1TyMv6qlScbr/S3aRwfD8siCYkHbRGGdbWhE9oi20Qr5
	w6I30rjd1xZyfip13q+eun6sL2goF10ume1LGEYWWRM2yO85aLrrCYss
X-Gm-Gg: Acq92OGubefrHpN39Gh1T7/2ptqn8SnCzUnkpmSC/FZj9+to4CJpoH0Agjp9RYhedom
	PAvwNesycPRqZ3VAJ2nS/vTuZMJyKIR5XAREWVZphZMCJU9qVkT4kDYs5vOvYzIzpcjvHYkAkor
	BEXTcYsUWIvO5Y0CZs2mP3bSn46IBNbzXI9F/ezLQvJiL+6E5zh0bA2YGdJs14NjylQmXLa/0Tw
	oCTgN690K4SXGy70TVNRsbUUBGOVecq9qRdiJhtxA3CfmOwxtXGW3ickc12GUHCbE7vzhWn5ZB7
	yJ0+YueSMhOvV2KMN9nrtCAxC9BtlRfPAmcoIAQQr3tQCVzRC6p5rjID7XrbFJmvHxLfTuAolYs
	d90p2h7JikbuGAxvww1yjEbYoRpbdxFkMOXW2oLFmSsl7dooa/dYUQn61DvVBaNzE0Oj3x0ycUM
	wAD6uu356/wVX7dK+WldIpXGxDbC74eoUYyNREoqgJmGac6lfwMeAjA/JzgHIKEd0=
X-Received: by 2002:a05:6000:180a:b0:45e:d6b2:e6a5 with SMTP id ffacd0b85a97d-460218654afmr9596752f8f.34.1780581180021;
        Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/9] accel: rocket: Add RK3568 SoC support
Date: Thu,  4 Jun 2026 13:52:49 +0000
Message-Id: <20260604135255.62682-4-midgy971@gmail.com>
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

The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Unlike the RK3588 it must be powered
on and de-idled through the PMU, and its PVTPLL clock started via SCMI,
before the NPU is reachable.  Add rk3568_soc_data with an noc_init
callback performing this bring-up.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  9 +++++
 drivers/accel/rocket/rocket_core.h |  3 ++
 drivers/accel/rocket/rocket_drv.c  | 53 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 09c445af7de73..a8de876365873 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	if (core->soc_data->noc_init) {
+		err = core->soc_data->noc_init(core);
+		if (err) {
+			pm_runtime_put_sync(dev);
+			rocket_job_fini(core);
+			return err;
+		}
+	}
+
 	version = rocket_pc_readl(core, VERSION);
 	version += rocket_pc_readl(core, VERSION_NUM) & 0xffff;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d6421251670dc..66d138a8ed773 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -18,10 +18,13 @@ struct rocket_core;
  * struct rocket_soc_data - per-SoC configuration data
  * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ * @noc_init: Optional callback to power on and de-idle the NPU NOC bus.
+ *            Required on RK3568, where this is done through the PMU.
  */
 struct rocket_soc_data {
 	unsigned int num_cores;
 	unsigned int dma_bits;
+	int (*noc_init)(struct rocket_core *core);
 };
 
 #define rocket_pc_readl(core, reg) \
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index c18840e5aff76..5a72d0b5f4dff 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -9,9 +9,11 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include "rocket_device.h"
 #include "rocket_drv.h"
@@ -217,12 +219,63 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+/*
+ * On RK3568 the NPU NOC bus is gated and idle out of reset and must be
+ * powered on and de-idled through the PMU before the NPU is reachable.  PMU
+ * registers use a write-mask protocol: the upper 16 bits enable writes to the
+ * matching lower 16 bits.
+ *
+ * The NPU's high-speed clock is a PVTPLL managed by TF-A via SCMI and must be
+ * running before the NOC acknowledges the de-idle request.  Force a real SCMI
+ * rate change (an intermediate rate defeats the clock framework's
+ * unchanged-rate shortcut) now that the power domain is on and clocks enabled.
+ */
+#define ROCKET_RK3568_SCMI_CLK	2
+
+static int rk3568_noc_init(struct rocket_core *core)
+{
+	struct regmap *pmu;
+	unsigned int val;
+	int ret;
+
+	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 600000000UL);
+	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 1000000000UL);
+
+	pmu = syscon_regmap_lookup_by_phandle(core->dev->of_node, "rockchip,pmu");
+	if (IS_ERR(pmu))
+		return dev_err_probe(core->dev, PTR_ERR(pmu),
+				     "failed to get PMU regmap\n");
+
+	/* Power on the NPU power domain (PWR_GATE_SFTCON bit 1 = 0). */
+	regmap_write(pmu, 0xa0, BIT(1 + 16));
+
+	/* Disable NPU NOC auto-idle (NOC_AUTO_CON0 bit 2). */
+	regmap_write(pmu, 0x70, BIT(2 + 16));
+
+	/* Request NPU bus de-idle (BUS_IDLE_SFTCON0 bit 2 = 0). */
+	regmap_write(pmu, 0x50, BIT(2 + 16));
+
+	/* Wait for the bus to report active (BUS_IDLE_ST bit 2 = 0). */
+	ret = regmap_read_poll_timeout(pmu, 0x68, val, !(val & BIT(2)), 10, 1000);
+	if (ret)
+		dev_err(core->dev, "timed out waiting for NPU bus de-idle\n");
+
+	return ret;
+}
+
+static const struct rocket_soc_data rk3568_soc_data = {
+	.num_cores = 1,
+	.dma_bits = 32,
+	.noc_init = rk3568_noc_init,
+};
+
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_cores = 3,
 	.dma_bits = 40,
 };
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "rockchip,rk3568-rknn-core", .data = &rk3568_soc_data },
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
-- 
2.39.5

