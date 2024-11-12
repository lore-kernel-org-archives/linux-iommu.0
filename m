Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5381531C4
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418510; cv=none; b=YstZ+83HyNXaaYerfIxxJBN9HcaIQ3RizLQ/wfmpyMx0P+cfPisn/E810c8E5fTMW5gdeg9ZM6ZXgbzAp454I7HgJvjo44QQ6d1qG8tjictZhckUci0yjIQIndxMRi7eQn5yHsT7Of6W8Cr0ozjb9y41gcueEzE7PBi2lf3eZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418510; c=relaxed/simple;
	bh=EOXvOTztZpJCM4q327HIKFrJDyDFi92aRkdhqB9a5FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaJuhDnMjDpDkdilQ/kdIVxFsOc0bpv36k60XwWLpuPLTPi6osu+vkQVHkGHFMMcLlqguW8BT8UfpP1SVzBsAJyBrwmcCqHTZsl1RukxW0HyxmE21Iy8eAg2wUVwkoqJqCwQ+Ucg2MU2qkQQQTYQhu5gj3PwyVwM8G28HxOIMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a1VDC6jO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a1VDC6jO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314f38d274so71418065e9.1
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 05:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731418507; x=1732023307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJIMNBzuMK7h+qGksPtnaBGirglhm92ygI/WSEl5z9I=;
        b=a1VDC6jOH+5Xt6l+Kx7cEGx/JeeG2f49SHp9ZyVOw8/FZRhfkaYFPTLOK3qD/neQ59
         RZJouz25RKLO5aRS4Cmlq2Zi9Kglvwyip9p7PyP3lwJEzeJCZF6B6RdIzMm0pISt2YAB
         +ewbaB2XBwMV1hX2ddUoqDRGvlmeotuKGgYMs/1hsnOqA2ihp5Ne1QHDSMrDHKxDt9EL
         wi5c5U0+4rbNvWz2lEAB4ccRJQsBq0/pCbaYK/LGkC4PhO3fHwefrGfEYPWqexBcRyIK
         qm8G47xFZITbQOyvGZEEv62LzsJruHgcYh2jjbzR2U53NI1wmCmulVPqkp56stRzhn9a
         GrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418507; x=1732023307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJIMNBzuMK7h+qGksPtnaBGirglhm92ygI/WSEl5z9I=;
        b=b9vR4KhSjfldZwFFBWcujXffl3tuhuY8X+U4+xSkLHetVdoE7/38ZnrbytKNEuHiWo
         2/be0L44FSQ3/IJ1l9BwAlBdtYm02vlFmV6ZlSzq+7/9o13FOF/BiBy04bKkmyh1ddFN
         4qM34qYndnXyO8pDGO6vvDeYGz9O6VsfKYL98hYAXCH1/z0QQCCTB3WvR3ET/lwglgd5
         whBMSLTwrzEsz1uaBmmV67SV6gIU9t/q6OW5uOY1PAoh2eJLoSmBMS3CGCoQp1rOB//f
         IKlCZ8XVI0npauGX8GsKcZAxvr2Y/C5qYlQ6z/cDncdiXEeqkwx5JfsEtX7zB62kOtVT
         TsnQ==
X-Gm-Message-State: AOJu0YwTF1E3ZunpsmG5q8RzzILb0loVwmTEPIibgJubCcsXoT7ZWWB1
	DX0XxbTyV3umzNmAOu7bRxud6gzHgzewxnFHqG2MtDIluVZ0fG+YjYZM4Qm1a3UcqgU4X4zuEB4
	0Md4=
X-Google-Smtp-Source: AGHT+IG/Z7mx614mpiSG+bVLADanukSwztBdE+h0N2Kt0vduWKMvN0NDCdisoOsaoV/RL2Zy6lGUTA==
X-Received: by 2002:a05:600c:458e:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432b74fed94mr166289775e9.6.1731418507263;
        Tue, 12 Nov 2024 05:35:07 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432cf118daesm12548325e9.0.2024.11.12.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:35:06 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	samuel.holland@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH v2 1/1] iommu/riscv: Add support for platform msi
Date: Tue, 12 Nov 2024 14:35:06 +0100
Message-ID: <20241112133504.491984-4-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112133504.491984-3-ajones@ventanamicro.com>
References: <20241112133504.491984-3-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply platform_device_msi_init_and_alloc_irqs() to add support for
MSIs when the IOMMU is a platform device.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index da336863f152..34b925909816 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -11,18 +11,43 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
 
+static void riscv_iommu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct riscv_iommu_device *iommu = dev_get_drvdata(dev);
+	u16 idx = desc->msi_index;
+	u64 addr;
+
+	addr = ((u64)msg->address_hi << 32) | msg->address_lo;
+
+	if (addr != (addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR)) {
+		dev_err_once(dev,
+			     "uh oh, the IOMMU can't send MSIs to 0x%llx, sending to 0x%llx instead\n",
+			     addr, addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR);
+	}
+
+	addr &= RISCV_IOMMU_MSI_CFG_TBL_ADDR;
+
+	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(idx), addr);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_DATA(idx), msg->data);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_CTRL(idx), 0);
+}
+
 static int riscv_iommu_platform_probe(struct platform_device *pdev)
 {
+	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
 	struct resource *res = NULL;
-	int vec;
+	int vec, ret;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -40,16 +65,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
 	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
 
-	/* For now we only support WSI */
-	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
-	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
-	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
-		break;
-	default:
-		return dev_err_probe(dev, -ENODEV,
-				     "unable to use wire-signaled interrupts\n");
-	}
-
 	iommu->irqs_count = platform_irq_count(pdev);
 	if (iommu->irqs_count <= 0)
 		return dev_err_probe(dev, -ENODEV,
@@ -57,13 +72,58 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
 		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
 
-	for (vec = 0; vec < iommu->irqs_count; vec++)
-		iommu->irqs[vec] = platform_get_irq(pdev, vec);
+	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
+	switch (igs) {
+	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
+	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
+		if (is_of_node(dev->fwnode))
+			of_msi_configure(dev, to_of_node(dev->fwnode));
+
+		if (!dev_get_msi_domain(dev)) {
+			dev_warn(dev, "failed to find an MSI domain\n");
+			goto msi_fail;
+		}
+
+		ret = platform_device_msi_init_and_alloc_irqs(dev, iommu->irqs_count,
+							      riscv_iommu_write_msi_msg);
+		if (ret) {
+			dev_warn(dev, "failed to allocate MSIs\n");
+			goto msi_fail;
+		}
+
+		for (vec = 0; vec < iommu->irqs_count; vec++)
+			iommu->irqs[vec] = msi_get_virq(dev, vec);
+
+		/* Enable message-signaled interrupts, fctl.WSI */
+		if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
+			iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
+			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+		}
+
+		dev_info(dev, "using MSIs\n");
+		break;
+
+msi_fail:
+		if (igs != RISCV_IOMMU_CAPABILITIES_IGS_BOTH) {
+			return dev_err_probe(dev, -ENODEV,
+					     "unable to use wire-signaled interrupts\n");
+		}
+
+		fallthrough;
 
-	/* Enable wire-signaled interrupts, fctl.WSI */
-	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
-		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
-		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
+		for (vec = 0; vec < iommu->irqs_count; vec++)
+			iommu->irqs[vec] = platform_get_irq(pdev, vec);
+
+		/* Enable wire-signaled interrupts, fctl.WSI */
+		if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
+			iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
+			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+		}
+		dev_info(dev, "using wire-signaled interrupts\n");
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
 	}
 
 	return riscv_iommu_init(iommu);
@@ -71,7 +131,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 
 static void riscv_iommu_platform_remove(struct platform_device *pdev)
 {
-	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+	bool msi = !(iommu->fctl & RISCV_IOMMU_FCTL_WSI);
+
+	riscv_iommu_remove(iommu);
+
+	if (msi)
+		platform_device_msi_free_irqs_all(&pdev->dev);
 };
 
 static const struct of_device_id riscv_iommu_of_match[] = {
-- 
2.47.0

