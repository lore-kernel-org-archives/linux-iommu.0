Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE171E54
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457960; cv=none; b=b2lS2LnUU62PcFBTRCAC435j2oM3WAoIYN0pZEStwHEVVKc6FYUgCQq1sdSQFO+hb3NDxD+miguMw4FpfTjRbncrPU5lWq1+d2hrZsCBtFDzcjMNNuAKRVYhpP6Ph32RnkVW0dhSMUsyztvWh5JxHSRfA/Q8fTdbijbsRmRaZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457960; c=relaxed/simple;
	bh=YIKqdpWL0hqo585obF9uqFUFMgR3tR9V53JwdMpOJfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBezeyhJCsf6r5fv5Y+dNItthRGHOub98HR8Qx0HhTuSPamR6fVFpIsEGrj3PkYj2rPWqpsef1Kk7xwvI2nryCXZH/UFcppgvSkRUW6EmtOBICRqjSUF/sWTSvKGVm7WIOumvM4ehguXHQk1ZR+p6N9L/DpuOjqU3uTGn1EOvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZKYjQ0iU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZKYjQ0iU"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee12766586so899268b3a.0
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713457958; x=1714062758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHKal/vvH8z/ottSej913pkTRK3eYWZvnHgxtvD4TF0=;
        b=ZKYjQ0iUR2Ni0LWgUXyCI1gGRuaFkYhKJiL9Nyb1G6GBSlo+rIKcQ+iG7mx4fWbp5i
         chmw5slGfOQDrrZTDdoVI0C2xDePLJgmDR8I+lcbffDb9kyUd2jWMw0Q6U5RqQ7IxnVj
         WcU+tq3WKg0ep46wvYI0p17QOYUVBNl0ObRS2z6a0MC7ze0avIRDEE7pyeXzrCEibogI
         4t2SKQ1ypqCe26VNp/gk1UxcdfY2pGaa5wW0UVfBM0fNHxhhfq10w6PkhaTgzBhNy5VV
         5MJipEWQqqhjMQih4PwRNxQVaYS/UsdHN1DVxiwJQxPeY29jdm15IVRakiDIxQP9oP+4
         69BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457958; x=1714062758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHKal/vvH8z/ottSej913pkTRK3eYWZvnHgxtvD4TF0=;
        b=BRbfn8u2OhPJaMYU2+FYBAxGZttGhKlnI41AQCshx8LhVSRnsPbbn6FhpTpqsBIwVC
         rU0dg3LsN7KS2GQV6EdC1wYyC5UBIjJyMHm+GQLkifrLxIUPeHPpHrmWMFD6ehaPGjZ0
         2ndk9c6GWTN0KxhT0zE4vlfpJm02pyv6ZlAbqsnkpoJq1OfvCMA30tlmoCztAMl+Y/W2
         TUMReCfj7PVhNVEbzku/pXmzWgCykupn9V0M6RKDqc2a2MktzMpXyMepv1S86YpEgRFu
         7eEJF9yH0cYBNAWEDIdppECv8mZSinGfIwFvu6FdMGsJTF3DwM9c9dvrdht5AeID+mPW
         khww==
X-Forwarded-Encrypted: i=1; AJvYcCWcXsXqEbmH0/PiLCQxtXBPDbxuJ3TwQqwzyxvDaU7KVWYRI53KWMhE5ysisbsp7LUAEKimxu8hhd1Df82F02Rt7Rh17Ic=
X-Gm-Message-State: AOJu0YxnSf/XzEMRCwlpvXfQA7+Nz8ClOLBYb9EjYKUvx0AcP6kOQdm4
	zqjQaT+7Y5LHM5q54CC1gXl1R5VNGWx2d++/vJnp12BAxb3fS5HdveG4DpBJay4=
X-Google-Smtp-Source: AGHT+IGBYbl1wbHIwQ3lWmMx5ZaQ5vB8SSg4htQp5CGoXofTgAD73EDRAgHIKteI0VW5uOioE9zfaQ==
X-Received: by 2002:a05:6a00:21d0:b0:6ea:c7bd:90e3 with SMTP id t16-20020a056a0021d000b006eac7bd90e3mr4466325pfj.14.1713457957754;
        Thu, 18 Apr 2024 09:32:37 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm1674755pfl.31.2024.04.18.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:32:37 -0700 (PDT)
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
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v2 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
Date: Thu, 18 Apr 2024 09:32:21 -0700
Message-Id: <4a068da7a7a984a43d419c52310f8ab7d91da46e.1713456598.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713456597.git.tjeznach@rivosinc.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
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

Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 MAINTAINERS                     |   1 +
 drivers/iommu/riscv/Kconfig     |   6 ++
 drivers/iommu/riscv/Makefile    |   1 +
 drivers/iommu/riscv/iommu-pci.c | 154 ++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/iommu/riscv/iommu-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 051599c76585..4da290d5e9db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18975,6 +18975,7 @@ F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/Kconfig
 F:	drivers/iommu/riscv/Makefile
 F:	drivers/iommu/riscv/iommu-bits.h
+F:	drivers/iommu/riscv/iommu-pci.c
 F:	drivers/iommu/riscv/iommu-platform.c
 F:	drivers/iommu/riscv/iommu.c
 F:	drivers/iommu/riscv/iommu.h
diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index d02326bddb4c..711326992585 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -14,3 +14,9 @@ config RISCV_IOMMU
 
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_PCI
+	def_bool y if RISCV_IOMMU && PCI_MSI
+	depends on RISCV_IOMMU && PCI_MSI
+	help
+	  Support for the PCI implementation of RISC-V IOMMU architecture.
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
index 000000000000..9263c6e475be
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -0,0 +1,154 @@
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
+#include <linux/module.h>
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
+	rc = pci_enable_device_mem(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (rc)
+		goto fail;
+
+	pci_set_master(pdev);
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
+		goto fail;
+
+	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+		goto fail;
+
+	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		goto fail;
+
+	iommu->dev = dev;
+	iommu->reg = pci_iomap(pdev, 0, RISCV_IOMMU_REG_SIZE);
+
+	if (!iommu->reg)
+		goto fail;
+
+	dev_set_drvdata(dev, iommu);
+
+	/* Check device reported capabilities / features. */
+	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
+	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
+	switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->caps)) {
+	case RISCV_IOMMU_CAP_IGS_MSI:
+	case RISCV_IOMMU_CAP_IGS_BOTH:
+		break;
+	default:
+		dev_err(dev, "unable to use message-signaled interrupts\n");
+		rc = -ENODEV;
+		goto fail_unmap;
+	}
+
+	/* Allocate and assign IRQ vectors for the various events */
+	rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc <= 0) {
+		dev_err(dev, "unable to allocate irq vectors\n");
+		goto fail_unmap;
+	}
+	for (vec = 0; vec < rc; vec++) {
+		iommu->irqs[vec] = msi_get_virq(dev, vec);
+		if (!iommu->irqs[vec])
+			break;
+	}
+	iommu->irqs_count = vec;
+
+	/* Enable message-signaled interrupts, fctl.WSI */
+	if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
+		iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
+		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+	}
+
+	rc = riscv_iommu_init(iommu);
+	if (!rc)
+		return 0;
+
+fail_unmap:
+	iounmap(iommu->reg);
+	pci_free_irq_vectors(pdev);
+fail:
+	pci_release_regions(pdev);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static void riscv_iommu_pci_remove(struct pci_dev *pdev)
+{
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+
+	riscv_iommu_remove(iommu);
+	iounmap(iommu->reg);
+	pci_free_irq_vectors(pdev);
+	pci_release_regions(pdev);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id riscv_iommu_pci_tbl[] = {
+	{PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, riscv_iommu_pci_tbl);
+
+static const struct of_device_id riscv_iommu_of_match[] = {
+	{.compatible = "riscv,pci-iommu",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
+
+static struct pci_driver riscv_iommu_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = riscv_iommu_pci_tbl,
+	.probe = riscv_iommu_pci_probe,
+	.remove = riscv_iommu_pci_remove,
+	.driver = {
+		.of_match_table = riscv_iommu_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+module_pci_driver(riscv_iommu_pci_driver);
-- 
2.34.1

