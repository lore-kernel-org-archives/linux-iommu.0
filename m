Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271747F2F3
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581183; cv=none; b=n6+aox0h1BVyoGQddGvxXn9en1AaS7hEjqNv8DPafdUecP9lKYnl+Wc8PSXTKCcxbrHQk619XZFXHGLJ/5gKD7fGTNbYvdNF5B+qUENxuPUD0ux4KvAZNISHU96FgkIar1Br/DcDR5o4bmlXr1VlEJjEBxpDmEH04S6lngNKgBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581183; c=relaxed/simple;
	bh=3gEVhhj+iXOXtZyQzBEw1EMPFfRMLcnW4HxpQXk5wqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjxrSKSBuawKPCQq+8FoFBS6UBlbdZ+v/f1yHc8qzgRovOK9Vm90naJaHvXYogqtL6yZtuLYg6mXCpQpiAD9Mq7YqClJiT78bfG2uSVuHdogE30Xox3E4FFm0Sd4MFYrHBbHIBX1wAAQlAvK01oXlsdlavcPHIrMbIa8IK6IDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYVsuBLI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYVsuBLI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso7271435e9.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581180; x=1781185980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Un/RS4Nm0nYyy9KkMqgz4u8u1TfsaZHefTb9UE6rtQ=;
        b=pYVsuBLIclvRHJocThWIlvxkEXlqoiPIYd1n2oGZ4bHhNc1BNtXWrDpVvjil+gqIak
         xV2KD7bO8/wkuCNJWTsC4+Ax6DCgzL2KqNssTln0/jbKq5WK7CTabPU5L6EDlI6Imjs5
         eX6FoGSgV29b2+S4CfvmdlOzKu18k4epW2thiv/vTp5Gmkrwyqtcj9rJCQQjNzIiRk1G
         lzf/U8vk2FDusNtmHwRRVpqPaeLzJM76/AxhG3LWH3P0RFwVXB9Sb4zvPfuGussCDmMk
         0A3cKi5C+/2Jcr34oXRWq39O7IyW71Cl+jCY2Yd+t0dImtiQDDWpQEOzniPfshAKiXQ+
         4fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581180; x=1781185980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Un/RS4Nm0nYyy9KkMqgz4u8u1TfsaZHefTb9UE6rtQ=;
        b=aOg0s6ubA8obDhjA9T5J/moxWdT2tQSe/HUQdNpMOm4s2Ly6cYsYS6w+XTdfPPgbBO
         tiSHaXc8g5IIgTk8GfKbSHE7uk0Wvj1YYWCFt1UqAmJe9UhscN4IDk1VlSf8iLBuRd5M
         LxWplBsUKoN1I++Z2S7TegBTDUkPqKQ5sUvHTBOFKBQiKn8eNHUyb3L1UT1uIFbkuws+
         iIC8faD5YS6ISAJ/JqV2guqjyYO941u7uEGpe6H52NDnprKmLxRRsqoFkabiB+ayP/z7
         i2oYJtnf5TCnf7eeKl/lU+a3ANVHEtiBDxaOTk3gfijd2WWe042Ozld6Jar1LfMR9EfR
         NFrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YHzxwBZk+JjY8wSJjkrik7GjtZkDoJPYRlrD6n0GZ53ay4lkJ6vjAf/xVZjPNugVKlDtG9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAj9Imt8c57fNT0atAadz5gIE32bUCdVBGnpAlV1o5tCtp3x4F
	vWcvxOxEZAIzC0OMNFEjccPVRHmuAjM5t/RT8P7Vmq1RaGS7IGmSveek
X-Gm-Gg: Acq92OHWqLHxQqqqpgno9qfAUIzacnNIKNtT8xQjiVhykyrNNJCfFwMaQUWz9U52l3n
	rnECJjr9t/YwOicT8Nk1bqZycwuxl5cJS7D5OQHzFCWMNLoquQOdWuncKF8mW7qWKMTIJzyWh3d
	2OSRrETI61Gd1acYJ7uKFuX/rjCExZVFxUCvq7NJ/MrZ2nbUfVx0/+X7InFJQ0t/sxVY0pLvrbQ
	GvEgWmhHoMu6wt8CKXY8RY+DdqwPV4X14VQ4v5fnngkT4xSxXTNCZaA9nllvdl+OBIcJsAkytc9
	CXw4QWf1xNQJTgSYVVJJf0gSZIvza+ZslF3/CAs4Zp5525UPY34A+2YJ/U7h+y79aTMEYPdfAva
	D0oyHAJr8wf7p3KA6ux13ll+GzFwFCNzKjVB7cV4YIyKEcHXxQ9aYrXuOnVZ7doM3PYBaZElm2g
	oL+IvFvwZXPAsStZ5kq48Nb5Ot1zXPlEe8E6c50HkBx640iF2s0fdw7mVYXnzEpeA=
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490b5e9fca9mr132980675e9.1.1780581179316;
        Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:52:58 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/9] accel: rocket: Derive DMA width and core count from match data
Date: Thu,  4 Jun 2026 13:52:48 +0000
Message-Id: <20260604135255.62682-3-midgy971@gmail.com>
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

The probe already has the per-SoC match data, which now records the core
count and DMA width.  Use it for the cores array allocation and the
device DMA mask instead of re-scanning the device tree for available core
nodes.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.h   |  2 ++
 drivers/accel/rocket/rocket_device.c | 15 +++++----------
 drivers/accel/rocket/rocket_device.h |  3 ++-
 drivers/accel/rocket/rocket_drv.c    |  7 ++++++-
 4 files changed, 15 insertions(+), 12 deletions(-)

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
index 384c38e13acce..c18840e5aff76 100644
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
@@ -214,6 +218,7 @@ static void rocket_remove(struct platform_device *pdev)
 }
 
 static const struct rocket_soc_data rk3588_soc_data = {
+	.num_cores = 3,
 	.dma_bits = 40,
 };
 
-- 
2.39.5

