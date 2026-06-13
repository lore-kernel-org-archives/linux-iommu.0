Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6C381B0D
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333912; cv=none; b=bjNRzKeroSKAOQC1LDYWVyy3/xBBq99X171K5ZBPgTTWVEwgRUDazZjdRC8YKqjEethuSKO2fQ1PYkq/f7vC7Oq7fM69wN086iO9Xro32MlZIG+tsS7ZsLs87C/PmwoBYw58HDV4jrqPIrqSZ+COkNqpa2lvnvuPCDOvePKvd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333912; c=relaxed/simple;
	bh=YKShoX65LVO0XZhx3YTVduiOdaRxm/z7AzofXLKM1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rY6nXTU2G7xNpMm3poIU+O6GTP0YEUFdHysn1xJ0r/0TnICyCq4MSODAlRQtSxL3ZVsf88+6lkI09AuZYKTZn/Fb8o5KHE7CCa9Po/28kai1zpFEaGawVPWbwUIoxJjavYBJ7dkvyYOJhm7hnd4/E69Yv0HZ/8PV/TEUsKVYubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLPQJ3VC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLPQJ3VC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490be03d47bso16719155e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333908; x=1781938708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRmyPRAFuevqTsUvI5TWwwBpkZJdoLOQStZBNs50ckM=;
        b=GLPQJ3VCRqYMW1WMYNpLNaeMfLIpmCrWKtC0JjaO8zbs+KaC+X5d+tOAwBzsfEvRja
         OlL3h3P6Rjrwyq00qRJPxr4HPwU+1DyTdDOtcR/qj+6FfV81WCrasvMmHSQReo96Vptz
         qtf9TUOEGLjUZEKF/wwBsgNa56vaOTjMh1u/nFrnpLT3AYt0WwlOQ30soJveTU5CAtic
         zST8efIiMQBkM4Gjt397ulFOQiUkj1O/iyI/xvbIwCFnWG5V8K9NrxLtAUlVzfg5IU6k
         xU3fK2JlZgOpHcK3U5ZCFniTON0hgV3adgQNwSCCsauYqSs2+0KU1EU8TK1AhG4SZysA
         nQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333908; x=1781938708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRmyPRAFuevqTsUvI5TWwwBpkZJdoLOQStZBNs50ckM=;
        b=OgRCeWMqDfzJ0NpX6OxxiYADAQzj5LH733IbdHmm254VCTYbiZEjT1p9KQPeh/w/Tw
         tbi6W6CRPEpXzdniZENhbfK5oEE2hWG9tQUDWNdLFr4zT5CXA5y5wDkIwpZoZA+EAG0S
         W9NQdqbzd8HLF9iGB3m8GBlo/GpdqFk91ElF9gep+q89gohRhSV1bcQBAGVJcsTlSOyi
         0l7qFgW23DOCyhnC+zBuNRwUPaIpVABQRgjx0EdZ1tgPPnSDkHozM2I/mEDMsjBcoej/
         v33jthGvjJsYaSbpsFT5U8ncOiHc+26MJYxEsKPiT+8zElIPPx0HEV2rgg4vWw7sGzzv
         fE9g==
X-Forwarded-Encrypted: i=1; AFNElJ8VHghoIhxiIOqJagqBvTVR3KLZnMGzJAqCz/lXXYfL2HRE7Y3Co34Yhv/2aCJRSCht3/4WEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytB7IE1DobDexd4cvPzO+fAI+HGunNYuYd5MzcLVMpRk9IHt3z
	XHtZGThaPXF89r8uSpsXgoytO8MhO2BYWbFR0XmAabi956sv1cOR1WZO
X-Gm-Gg: Acq92OGbUzq3dP949SAPQSJ6USouQlJsKMw5h0qIHgMAkO3nPnEN9vnGERcwc5NbUgD
	pBpZ14i5r7P/EaMyt/YPcfxavRVRmB9Ze9avrCte9r6TQttVhf8RojYGDpyENzZMf6NHNfOwyS8
	LozT2AYvWZr6rAVBkFmhFoLdgMjMYK1vGc2p9E+GEQoiVBaCH0/9/Jf53CbuYmLZgQ20PvSZOCo
	DAhDLnedBiehX+Is/VIqRhN98K3eXq2gYLU9gcQqkKdsh+bdrO24hHHDCUBX+tOlvRIZZdKrQRu
	/ahUE7BDm58gpb2qmkJ8bsf1Dkx0EgYYQ7zmM4ZLE0Em4f0ghLQF5F52G3GLRXtcWlS5UJOGcus
	LooMECVbLnYDA3/k9PDkRNpRR98q+l/pPa3OgflzsRwHeda9xWcpdztWyH8Se+8Q/w2OklkmdIS
	m8egp/w14a/2V1S47iw2WnvG4Qi4QtKUpIj1A+jnictQ==
X-Received: by 2002:a05:600d:8489:20b0:490:b724:507d with SMTP id 5b1f17b1804b1-490ec4cec11mr54479185e9.11.1781333908035;
        Fri, 12 Jun 2026 23:58:28 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:27 -0700 (PDT)
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
Subject: [RFC PATCH v4 2/9] accel: rocket: Derive DMA width and core count from match data
Date: Sat, 13 Jun 2026 09:01:09 +0200
Message-Id: <20260613070116.438906-3-midgy971@gmail.com>
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

The probe already has the per-SoC match data, which now records the core
count and DMA width.  Use it for the cores array allocation and the
device DMA mask instead of re-scanning the device tree for available core
nodes.

While at it, reject a device tree that declares more NPU core nodes than
the SoC has, so the fixed-size cores array can never be overrun.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.h   |  2 ++
 drivers/accel/rocket/rocket_device.c | 15 +++++----------
 drivers/accel/rocket/rocket_device.h |  3 ++-
 drivers/accel/rocket/rocket_drv.c    | 13 ++++++++++++-
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 8ee105a0be40e..d6421251670dc 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -16,9 +16,11 @@ struct rocket_core;
 
 /**
  * struct rocket_soc_data - per-SoC configuration data
+ * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
  */
 struct rocket_soc_data {
+	unsigned int num_cores;
 	unsigned int dma_bits;
 };
 
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e72c5f..6186f4faa3a2a 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -6,18 +6,16 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
 
 #include "rocket_device.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver)
+					 const struct drm_driver *rocket_drm_driver,
+					 const struct rocket_soc_data *soc_data)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *core_node;
 	struct rocket_device *rdev;
 	struct drm_device *ddev;
-	unsigned int num_cores = 0;
 	int err;
 
 	rdev = devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, ddev);
@@ -27,17 +25,14 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
-		if (of_device_is_available(core_node))
-			num_cores++;
-
-	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
+	rdev->cores = devm_kcalloc(dev, soc_data->num_cores, sizeof(*rdev->cores),
+				   GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(soc_data->dma_bits));
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662abc01d3d..2f74e078974e3 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -22,7 +22,8 @@ struct rocket_device {
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver);
+					 const struct drm_driver *rocket_drm_driver,
+					 const struct rocket_soc_data *soc_data);
 void rocket_device_fini(struct rocket_device *rdev);
 #define to_rocket_device(drm_dev) \
 	((struct rocket_device *)(container_of((drm_dev), struct rocket_device, ddev)))
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 384c38e13acce..f0beed2d522c7 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,11 +159,15 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc_data = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	if (!soc_data)
+		return -EINVAL;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
-		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
+		rdev = rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to initialize rocket device\n");
 			return PTR_ERR(rdev);
@@ -172,6 +176,12 @@ static int rocket_probe(struct platform_device *pdev)
 
 	unsigned int core = rdev->num_cores;
 
+	if (core >= soc_data->num_cores) {
+		dev_err(&pdev->dev, "too many NPU core nodes (max %u)\n",
+			soc_data->num_cores);
+		return -EINVAL;
+	}
+
 	dev_set_drvdata(&pdev->dev, rdev);
 
 	rdev->cores[core].rdev = rdev;
@@ -214,6 +224,7 @@ static void rocket_remove(struct platform_device *pdev)
 }
 
 static const struct rocket_soc_data rk3588_soc_data = {
+	.num_cores = 3,
 	.dma_bits = 40,
 };
 
-- 
2.39.5

