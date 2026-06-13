Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3973384CEC
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333915; cv=none; b=h1bUEDGRGvwFvTB4jMbMM0GOrSuXJDH58Id3FPiDrh7UmDIGL+hIGMMdH5glZbs7vy9C2QVjbVXMbGaCQtZHzFAeBaTJ85+/PaE0x/DBvuQhxKeqPPd0kj+M+ExuOFzci2gZF9Fj6HgBXhAiObdJ8HK4cfAjZcW9U5eb1K2I3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333915; c=relaxed/simple;
	bh=DeWG1uBjzQKbTfUIz2n8sQDA8/VxiIMWnBV+69O9kJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/JLIqwZOeuVvWmPXx4NYNtfHAkOHzff2yjMCYuzhzN/nIbE+AT9Mh3H8nWnOoFoDojtClS06erIS/fd/uZcpr8049mSH12ds0j22RTgOUEHyp444qnBk3XOS3IBz1fiGJhN2W7KOuKVVsN8Bae8OYE8F0hS5fKBaiXPQQSfbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P42C9PiI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P42C9PiI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso15819655e9.3
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333912; x=1781938712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
        b=P42C9PiID/j5fsYWDoZb4KwN9Z43lTdIXWTCHWf5/bpKyZVmq6si71FG1XhkE3hZAv
         r1OPZDE1yBlSbi9SSp4hqOsOWjFsUKzpTNJ7T2lGmJ7V/8hEhGcmFIKj2lNj1ciLvsCn
         iVZW3fKRZRLOBp9f8qfjFSclg+FuPcTi//nQaqERvvBufi2QN/ATnWJHI8w1INuAwZPS
         08U7ruChDgAAZSOCw6JfFZT16ozSx7RozvDo0xl35/jsob1IGPd6xKrg/MgEqdO5U/Jn
         fmhMxoxTxjr94YGql5kBXmuAp6TK0uJ0ymx6u5Fm5yPyaZ88m729owYEJ1DxUmnAjaEI
         V8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333912; x=1781938712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
        b=leQ2V73PMxHahB0zaPocFognBLNlKHRDCDBM4SKPj7HjjgJdrKl5PA5rjwwQQfc16q
         RvfUpHhZmnIAyMVDjQ08MFYz/xiFh7fl5EIg35mTJJTOX0ib+YhdTh+WSAvUoRwdTeb1
         Ah+Nxj2Z7Nsq6PSvoxKgMRxKz3MJ2tndSOC3xMbe6bo36sE+gt2c9vkOPYSUm1BhGUjX
         FJMFNftfRtJ4dlhASv0UJhr8qqLJjutwDPRuRhpzcJ7vzOK7MGAHdoc41BIEDQDkTVhJ
         WKAAM9vahEwO298ZMRJhu/uVK5KMzZKTYtgc6unTaNDP0nwS7P/HI9vSPOVnm4/DoLrI
         bbbA==
X-Forwarded-Encrypted: i=1; AFNElJ+vw2W1T2U/moOMw24CiQlePZ9Ojrarmx4Otr4mIS9yWSB1nWn2AOPO/KA4PTcwPuirxDMc/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpznq1w0Q+aVqLy+k+PiFQjSWeGEfxhCIiJ9slpgrBV8T7Fu0C
	bsRZxBMHi7i33fy0/7zNH7f2tlNdSWz3OHuWn+M2IzyOCXwsyw/IvWXF
X-Gm-Gg: Acq92OG2PBlOjnW0KUNx3Si65pNub5cOaLfFErYWCt7bXOv3Rxl9RZr7nBbM95Y40lC
	08hZSnkdrkcPjuJuGMN76TStKkPIUsNOvOx/zD4bKhTlsMayZhUPd/mgFiDwT7V9Cm7k9bxsR7u
	vBL/BfUACZtDsM/JkN3NnGo7sidTtNNMcElZGRsIjnIQUbqBFkjdXHUGjFkvayzYyFRcg9VvZz+
	Q4Gx2UeQcprw3RrM7F3lrHhGEwOCkos4tc69fOqvDhJVeIazhtroUze2BifJR/T1XmZ4XXDH51g
	f6sP2e4KCimmQgl5KLJ1Z2wl72+9iGqQ5CBW3uOOscZFDUDxlNBd5agd8vXsH4ynTlorS3zbPHE
	I901Rkn4XZe3HR6vQvF7n7wtWdb1m3lmdnBtNIpjadgIPEhtq0z4YU6xIMpHPf3jFWphClNImo+
	m6AmSqDkPj+WsstpjX9xM1CiblHAFMhF2+5CYP6nyyNNFL9mJKnSST
X-Received: by 2002:a05:600c:4709:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-4922007472cmr28836405e9.11.1781333912286;
        Fri, 12 Jun 2026 23:58:32 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:31 -0700 (PDT)
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
Subject: [RFC PATCH v4 3/9] accel: rocket: Add RK3568 SoC support
Date: Sat, 13 Jun 2026 09:01:10 +0200
Message-Id: <20260613070116.438906-4-midgy971@gmail.com>
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

The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Add rk3568_soc_data and its
compatible.

Unlike the RK3588, the RK3568 NPU's compute clock is a PVTPLL managed by
TF-A via SCMI; start it from an noc_init callback with a real rate change
(an intermediate rate defeats the clock framework's unchanged-rate
shortcut).  Powering on and de-idling the NPU NoC are left to the power
domain (genpd), which performs them when the IOMMU supplier is resumed,
so the driver does not poke the PMU directly.

If noc_init fails, unwind through rocket_core_fini() so the core is torn
down completely rather than leaking the runtime-PM and IOMMU state.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  9 +++++++++
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_drv.c  | 31 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 09c445af7de73..779e951596a15 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	if (core->soc_data->noc_init) {
+		err = core->soc_data->noc_init(core);
+		if (err) {
+			pm_runtime_put_sync(dev);
+			rocket_core_fini(core);
+			return err;
+		}
+	}
+
 	version = rocket_pc_readl(core, VERSION);
 	version += rocket_pc_readl(core, VERSION_NUM) & 0xffff;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d6421251670dc..5a145ba8c5a92 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -18,10 +18,13 @@ struct rocket_core;
  * struct rocket_soc_data - per-SoC configuration data
  * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ * @noc_init: Optional callback to bring up the NPU before it is reachable.
+ *            Used on RK3568 to start the PVTPLL compute clock via SCMI.
  */
 struct rocket_soc_data {
 	unsigned int num_cores;
 	unsigned int dma_bits;
+	int (*noc_init)(struct rocket_core *core);
 };
 
 #define rocket_pc_readl(core, reg) \
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index f0beed2d522c7..86484110ad6f0 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -223,12 +224,42 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+/*
+ * The NPU compute clock is a PVTPLL managed by TF-A via SCMI; spin it up
+ * with a real rate change (an intermediate rate defeats the clock
+ * framework's unchanged-rate shortcut).  Powering on and de-idling the NPU
+ * NoC are handled by the power domain (genpd) before the NPU is accessed.
+ */
+static int rk3568_noc_init(struct rocket_core *core)
+{
+	struct clk *npu_clk;
+
+	npu_clk = of_clk_get_by_name(core->dev->of_node, "npu");
+	if (IS_ERR(npu_clk))
+		return dev_err_probe(core->dev, PTR_ERR(npu_clk),
+				     "failed to get the NPU SCMI clock\n");
+
+	if (clk_set_rate(npu_clk, 600000000UL) ||
+	    clk_set_rate(npu_clk, 1000000000UL))
+		dev_warn(core->dev, "failed to set the NPU compute clock rate\n");
+	clk_put(npu_clk);
+
+	return 0;
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

