Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B7205AB6
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882810; cv=none; b=EB5ZmUtIUdgXtcf45oYGKgefkXn4uw6LUaB83BF8kq1VMUJwzvpmO7rwLy5B+xbq0TbXS2oB0eoYDYfsUlPztaEKrDUJ/3b9qAPKvYf7UdtntRVaiTZImLAML9USS0p5s09dW2BDYBaqYHhAvOlX4/Q9sIewPCwMYekNQ6xsnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882810; c=relaxed/simple;
	bh=RtnslbLXAI6fWAT6u5Jma/xqdzvggE3RkXqnsCbB4vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQr3H7qYO5yTSXsn8sE1M+EXtnnoKrUvKjMlOqO2yuFIDHWIWr3qVIS5ACtfZFDG8YM615p9OVbFEtJuAutfFB+lWBM4Aj/cp9EQnM9lTFs0TqT37ofv87q3t0oBG+YEm0hkF28+dmWmtTVbR60tv+QnsrbxYR7UKnj+ARsIZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxLUg/l6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxLUg/l6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43620a5f81bso6371115e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736882807; x=1737487607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8zbHHjDHwUKprLOJl/lBp+WlB/iIXKfc0w2QQvt1CM=;
        b=dxLUg/l6h6G+bb0GaCi/karqC0gf9U5ZBb8tZU5Iovp7GCh6nbRgIUnKLCXet4t+Xa
         dR0xAcOLOw9e//8Q1tvDzYZVMSP7uZR+urMcbt1hDvqC8TpOOFBzrwcZfeEM/9ROBpai
         UEm7O0ZPZWmhVjtlRsW3rZkmtCJEprdM0PKV5xJdc/gYJhxFXTTgsUL5EqdOJHDqvPeA
         +DcGOrZHqsjr8z8yzuYmNCOBe3+W8eiYpW7Dknm9uQe0jJWndYcbs9nwRTqsHk7APRq+
         eatXvRsYDpefEG8MLRNE2f8IoD3aEMJ7Q8mN6atqzDZF8dOCZCNek2XcvuLNwNDANgBH
         i2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882807; x=1737487607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8zbHHjDHwUKprLOJl/lBp+WlB/iIXKfc0w2QQvt1CM=;
        b=f1gtTgn4u6kxoorutqMz/rEQxofH5GcypMGJMeuuVJPA63cn1PDvucebWGwiY/9elI
         PnlS6YgO5LN+2Rpfzmm6qAMbdeEl1OqA+6NoNjs09ccqVPKHgbWSAtX1DB0VILQvfY02
         om7Hl11jIR8U5SDaRemRzTUuKb7tY35EsH0oRHq5+0p8rzHcPhuhl+qRpHxfXduOTGLC
         hmHD5m0hEoEBuFiCEL65Eg2jPA/8R/tnfqT1+mkCBqZHaVaYMkQKyhdqjmbApDtEZGFx
         tvdOhjDbv3uETrvobIwfcrKo1CaGhpdyz4RDl0Wfg/FdnsdyNHD/ATBMQeF0PjXcnwLa
         D1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXKlRPeTGQFLfvZ9Hvcc4PSS8QbWrD+wJEAQLVQdnOEjl0brFP9r5MBxlUMZIsIAiduuq1P4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHQUeb+S82HynDTtha6NyOVyHAPqIOgUOf22i37AYThW9zSrRx
	RhBRJTHqC40srQLjZO19LjqRXskVA0picbZMZUjdwyPJaP3FJGfAoZv2wMJDg2s=
X-Gm-Gg: ASbGnculDbKY1v4DCUpM93N54OBbu4399zafsABMEle9NfpYuNDQ1eVroHhzyj4RfNz
	bL+KhxxAxI6Ak3Z/JG14dPv+63l2AZamUyFXrRXjuMNB25fPeK72AXqvTLA+F1EjPrNE1NnEVMB
	Bga4OQHNHrTqqgFRpM3nH5jKZeklEXTodHGLTf5q+gWyZMToO+lL5FQtsgg5F4aJCk76aUJmwA3
	Nv2MAH5YG3iYHR/AzVRaTTrdagL/Dpk00ndeGBXqkkupfRVgdICxB8+tqJ2R5nFqyPjL4U=
X-Google-Smtp-Source: AGHT+IEnD9Q/PlL16atUZuQr3zo7osv/8GJqa0PNvMI0cYgqaJuTOZ+Meucj00enp/jZftDOrIqvJQ==
X-Received: by 2002:a05:600c:3c8f:b0:434:f7f0:189c with SMTP id 5b1f17b1804b1-436e27007e9mr105673595e9.7.1736882807013;
        Tue, 14 Jan 2025 11:26:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15552826f8f.79.2025.01.14.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:26:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] iommu: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 20:26:42 +0100
Message-ID: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
 drivers/iommu/mtk_iommu.c                   | 9 +++++----
 drivers/iommu/mtk_iommu_v1.c                | 3 ++-
 drivers/iommu/rockchip-iommu.c              | 3 ++-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0e4cbb2c64d7..358072b4e293 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
@@ -4321,7 +4322,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	 */
 	if (!!(reg & IDR0_COHACC) != coherent)
 		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
-			 coherent ? "true" : "false");
+			 str_true_false(coherent));
 
 	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
 	case IDR0_STALL_MODEL_FORCE:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 79afc92e1d8b..de205a34ffc6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #include <linux/fsl/mc.h>
 
@@ -2106,7 +2107,7 @@ static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
 	}
 
 	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
-		   cnt == 1 ? "" : "s");
+		   str_plural(cnt));
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ab60901f8f92..034b0e670384 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
+#include <linux/string_choices.h>
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
@@ -510,7 +511,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			bank->parent_dev,
 			"fault type=0x%x iova=0x%llx pa=0x%llx master=0x%x(larb=%d port=%d) layer=%d %s\n",
 			int_state, fault_iova, fault_pa, regval, fault_larb, fault_port,
-			layer, write ? "write" : "read");
+			layer, str_write_read(write));
 	}
 
 	/* Interrupt clear */
@@ -602,7 +603,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 			larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
 
 		dev_dbg(dev, "%s iommu for larb(%s) port 0x%lx region %d rgn-bank %d.\n",
-			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+			str_enable_disable(enable), dev_name(larb_mmu->dev),
 			portid_msk, regionid, upper_32_bits(region->iova_base));
 
 		if (enable)
@@ -630,8 +631,8 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		}
 		if (ret)
 			dev_err(dev, "%s iommu(%s) inframaster 0x%lx fail(%d).\n",
-				enable ? "enable" : "disable",
-				dev_name(data->dev), portid_msk, ret);
+				str_enable_disable(enable), dev_name(data->dev),
+				portid_msk, ret);
 	}
 	return ret;
 }
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index b6de1ca00cef..a565b9e40f4a 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <asm/barrier.h>
 #include <asm/dma-iommu.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
@@ -243,7 +244,7 @@ static void mtk_iommu_v1_config(struct mtk_iommu_v1_data *data,
 		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
-			enable ? "enable" : "disable", portid);
+			str_enable_disable(enable), portid);
 
 		if (enable)
 			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4b369419b32c..323cc665c357 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 
 #include "iommu-pages.h"
 
@@ -611,7 +612,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 
 			dev_err(iommu->dev, "Page fault at %pad of type %s\n",
 				&iova,
-				(flags == IOMMU_FAULT_WRITE) ? "write" : "read");
+				str_write_read(flags == IOMMU_FAULT_WRITE));
 
 			log_iova(iommu, i, iova);
 
-- 
2.43.0

