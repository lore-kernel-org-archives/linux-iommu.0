Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C911553B9
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617483; cv=none; b=urFVI7wHK90+VI7j9KWF5zh7WAuvDXbFnCExUCkbQ4wK3cIzP2GR6E0Zsj9yIUTtRAgG5u58BoqJFTfusuOD3G95rMyk7ZC0PyCgG84UQReV3Jg/IC1pvbFFhs4tbGqQfWt+D35y0K1rhRl2PnAUBE6VYW1U2GF3bIzHd2SqqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617483; c=relaxed/simple;
	bh=DcOSw2ew0c3URNrUO3l1Ipvi4bfVqwYuFrqb7c+A5RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXqC7KlgOJZpuD/Ov1vnfNsp4HpfEUbvjGuQPllCt8BIi4yNh54vNryx/khmWMaD+JvRW2i8o1LpNIpYPSQIDp6Cn69mIYhdMCuHffAV8QlXIslr4RHOIfbpn/+afMB4KD0CPDobbkdsvjNUq8f17zj21ZvqfWBiiHGM/YrPXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=x8WVrmED; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="x8WVrmED"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so155381b3a.3
        for <iommu@lists.linux.dev>; Wed, 05 Jun 2024 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717617482; x=1718222282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ/AEFSFwdT9H/GgMZYFdqgb9wNJbl1T6o8nBqHR0q8=;
        b=x8WVrmEDjDziPfOb5WLB1bcy41IsPJGAnBWQ5o6I6v9MZKDTtNUP9iT2D1FH6FfMuz
         i4AVIrjd6VTSBTgM0bklB42YJlTWUXVs5IOkWvQB6nXlo0LhWyEJ3Wk5E1Wzbgd7Q3fV
         3YnDZSb6Hn4TsTVAgF4NhBHQx6JwaiVbUuRoNBUcdJ5B5qg+x/W5N0XXTBt28EN8ETMU
         bHDwK+5vjg7ma50dlemsbBzPF4qCC9lFlOBlXuFp5k7PT6PA+0rscGUXbHh/LTWmcB1X
         JVjXBF43rJ5wH0jCiQa/o+702e7hz57JvXjpPPAko2n8/t9FnZGnn6qvpN1HS9ISnuDU
         /WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617482; x=1718222282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZ/AEFSFwdT9H/GgMZYFdqgb9wNJbl1T6o8nBqHR0q8=;
        b=AGpb9vnqP/czu/UvEHSzStgznRteXdkyeqBBx23umGdSn0YuGd0dKuq+JOVSjTfJ4W
         hUbLoGo+uPI9il9TvFYKpmfUzMuyWlPhMeFmHQwj5f7bumtSbqHYVTK2hZTdmr9NDMa1
         +an1hLe8DBhM8lHiHhU9SryjOsv+welHVWQtIPHTdq/2AB0AAkmauzX6DRVWp0x6EFoj
         E8kqP7Ey7FZUAzy57Bj8RCObF9FGU2dtaUzeLOQE8iZ/rEnPidrYDmcqHX/eh/fjmzGs
         LnD5CUgQ+JFMeLywNeydrJLxf+NEAzdOAXXlNIFggGJY4f6YiDyVWA0TsV/OsLZp+cHU
         Ex+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkjtm+H2eIo2BJpZ4doEtGGgcOLyHU6hb1ap1B968af4ttoWu48Yf2MBLWVq/IjLdUvCyK366v1ZXPtWztRdeV1QVcj1w=
X-Gm-Message-State: AOJu0YyeZa7pkm2AfijJ6ZYR3uzTIcQkBN8tgMfv3dXk8dVmwl70spge
	gVV2B4/kSBpoufr64DBxodgSqwNc+GOhuyrEPeAUv7H2v3de0f8Tz7Yl4N6R7w0=
X-Google-Smtp-Source: AGHT+IG2XaMenN1fYXFjRI1gxwTgHA+I4FeBN59oi5QakFI48hoDIBXjqBc+VBxHZoXQhWiVWMhonQ==
X-Received: by 2002:a05:6a00:3d01:b0:702:5d6c:3c25 with SMTP id d2e1a72fcca58-703e59b05f2mr3831135b3a.18.1717617481647;
        Wed, 05 Jun 2024 12:58:01 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70244900ee9sm8664209b3a.124.2024.06.05.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:58:01 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
Date: Wed,  5 Jun 2024 12:57:45 -0700
Message-Id: <d966bf7174647a949cb0556168aba475a4afe5b8.1717612299.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717612298.git.tjeznach@rivosinc.com>
References: <cover.1717612298.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

Introduce device driver for PCIe implementation
of RISC-V IOMMU architected hardware.

IOMMU hardware and system support for MSI or MSI-X is
required by this implementation.

Vendor and device identifiers used in this patch
matches QEMU implementation of the RISC-V IOMMU PCIe
device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.

MAINTAINERS | added iommu-pci.c already covered by matching pattern.

Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/Kconfig     |   5 ++
 drivers/iommu/riscv/Makefile    |   1 +
 drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/iommu/riscv/iommu-pci.c

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index 5dcc5c45aa50..c071816f59a6 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -13,3 +13,8 @@ config RISCV_IOMMU
 
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_PCI
+	def_bool y if RISCV_IOMMU && PCI_MSI
+	help
+	  Support for the PCIe implementation of RISC-V IOMMU architecture.
diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index e4c189de58d3..f54c9ed17d41 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
+obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
new file mode 100644
index 000000000000..e675acceb290
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright © 2022-2024 Rivos Inc.
+ * Copyright © 2023 FORTH-ICS/CARV
+ *
+ * RISCV IOMMU as a PCIe device
+ *
+ * Authors
+ *	Tomasz Jeznach <tjeznach@rivosinc.com>
+ *	Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/iommu.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "iommu-bits.h"
+#include "iommu.h"
+
+/* Rivos Inc. assigned PCI Vendor and Device IDs */
+#ifndef PCI_VENDOR_ID_RIVOS
+#define PCI_VENDOR_ID_RIVOS             0x1efd
+#endif
+
+#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
+#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
+#endif
+
+static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct riscv_iommu_device *iommu;
+	int rc, vec;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
+		return -ENODEV;
+
+	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+		return -ENODEV;
+
+	rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (rc)
+		return dev_err_probe(dev, rc, "pcim_iomap_regions failed\n");
+
+	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return -ENOMEM;
+
+	iommu->dev = dev;
+	iommu->reg = pcim_iomap_table(pdev)[0];
+
+	pci_set_master(pdev);
+	dev_set_drvdata(dev, iommu);
+
+	/* Check device reported capabilities / features. */
+	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
+	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
+	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
+	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
+	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "unable to use message-signaled interrupts\n");
+	}
+
+	/* Allocate and assign IRQ vectors for the various events */
+	rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc <= 0)
+		return dev_err_probe(dev, -ENODEV,
+				     "unable to allocate irq vectors\n");
+
+	iommu->irqs_count = rc;
+	for (vec = 0; vec < iommu->irqs_count; vec++)
+		iommu->irqs[vec] = msi_get_virq(dev, vec);
+
+	/* Enable message-signaled interrupts, fctl.WSI */
+	if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
+		iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
+		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+	}
+
+	return riscv_iommu_init(iommu);
+}
+
+static void riscv_iommu_pci_remove(struct pci_dev *pdev)
+{
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+
+	riscv_iommu_remove(iommu);
+}
+
+static const struct pci_device_id riscv_iommu_pci_tbl[] = {
+	{PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+static struct pci_driver riscv_iommu_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = riscv_iommu_pci_tbl,
+	.probe = riscv_iommu_pci_probe,
+	.remove = riscv_iommu_pci_remove,
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_pci_driver(riscv_iommu_pci_driver);
-- 
2.34.1

