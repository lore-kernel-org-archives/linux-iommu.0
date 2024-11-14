Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA501991BA
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601144; cv=none; b=p8xk63rdnc/PnA4wht3poyKsHE418O/0Nrin92A3g/JydjBTeuKjFDXBS+gJ1sv5gDvCBhkgWTZvbZjGeqK4+XYVxBUNQZIvpLmVh7qDEuy70z6h4HMiEpD6UlSaGPxcyrixR5HqNrxKr9BrxwG/hYLwxxsRE0620/jIPfqOxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601144; c=relaxed/simple;
	bh=g5McopJz9YgSe9KWmaVd8HxaSlP+V5h/dFeTAq0VhNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROphYzt1VE/ZeXCsAHapeOBg8aFeU8alBYK0Zqg57aCcL96KsSdj4zi7e3xYU/lelbuJIPp65Cl82VWFFjjZrBP16OSDsFIDVTr10jJLI0EgLjcB3XMXqla5ISPZLYiGdWxCAM9Jd/QJrh+M8jhqNHoaaL4ZCrdOVZNR3m0f3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PSolIHGO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PSolIHGO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so573497f8f.2
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601141; x=1732205941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmyPhlw9y/X/fnXH6ufVz2Fv/AglekMjgv19lGdZt0M=;
        b=PSolIHGOkCtfAOoQUs9Mm8XTGZvoNIcdNRIESIKhCiXMbGdf/6d7H5uoBss5MAhHXo
         zHyZ3pHh7Ujfr0RPL/2a92nB44FN/Vs4ZX6tXUCKoZMdai5CCC48XooijxvQ2gARZYPY
         0YDncGLsSvIWs8VHfLsSysXzK5uLUuiD9/j0w8wHKQZO8SX2KowwSghSV4AnvIRVvudE
         QOMwC+kw7rCRgk+5oJOZ9zzKx2oxexx4JM6dfkqm+KbzXsCwJ2BDf/PSMYeq8dRsHWob
         /SgZaQRy/ViWYN0joTSUdjI2vXhTq19jFyvf50OPy3K3u+mnyvUF2yP9KikBFPb6nekj
         RFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601141; x=1732205941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmyPhlw9y/X/fnXH6ufVz2Fv/AglekMjgv19lGdZt0M=;
        b=Bwy0BGj5xqox+jz46G0YJToEiNwx7Aen8R3ApJKJ36xRe4oclUa//H1Hph2z0uQXRB
         q/XPOokGf5tPqCd4CzD8YxMZAT8szLeuqUm+LFZ5LX4c4/gZjZBwsQj98RYlVFwyPiTB
         F5yICHe7H1SQEOiEXs7Qgcurv2JRGY/nvUYQ5yCa024DQX7Sn9lA6geAHysnITSN2DDn
         atRU1nhWBWy2ew2QiHS47T5uHTUyGSDhxf3ki/Riw+7MJ6GmQ3qh6d5V4wukzVQHHMxs
         x4JnqJSEfa7fuIcd+vCb66oKPaQCMr+D6QIm8cvvYoLfUgGN4eGAqAu+MUzyIAsGkBgu
         gtTQ==
X-Gm-Message-State: AOJu0Yy8sjD8fFuwuoryM7lX7d1ceDi2Pg7NbGF5DnLouUGxYGaBeus6
	K3WPyQHXxSV6hgestocmLMUVF55f5Pw/klkLN0x8PIOZMkroCNQoC+VoPXud8capuFbZvmVzk3m
	ioOw=
X-Google-Smtp-Source: AGHT+IEurYWNfkgEG6OVCqRhsfT6EytEjQqOu8Vk3V55flsbBNhf08vSjr2U+chyzyCkXFZDditk7A==
X-Received: by 2002:a05:6000:2aa:b0:37d:4ef1:1820 with SMTP id ffacd0b85a97d-3820df88797mr5457081f8f.40.1731601141065;
        Thu, 14 Nov 2024 08:19:01 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2da2sm1862201f8f.15.2024.11.14.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:00 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt remapping
Date: Thu, 14 Nov 2024 17:18:53 +0100
Message-ID: <20241114161845.502027-25-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is just a skeleton. Until irq_set_vcpu_affinity() is
implemented the IRQ domain doesn't serve any purpose.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/Makefile   |   2 +-
 drivers/iommu/riscv/iommu-ir.c | 209 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  43 ++++++-
 drivers/iommu/riscv/iommu.h    |  21 ++++
 4 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index f54c9ed17d41..8420dd1776cb 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
+obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-ir.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
new file mode 100644
index 000000000000..c177e064b205
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IOMMU Interrupt Remapping
+ *
+ * Copyright © 2024 Ventana Micro Systems Inc.
+ */
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#include "../iommu-pages.h"
+#include "iommu.h"
+
+static size_t riscv_iommu_ir_get_msipte_idx(struct riscv_iommu_domain *domain,
+					    phys_addr_t msi_pa)
+{
+	phys_addr_t addr = msi_pa >> 12;
+	size_t idx;
+
+	if (domain->group_index_bits) {
+		phys_addr_t group_mask = BIT(domain->group_index_bits) - 1;
+		phys_addr_t group_shift = domain->group_index_shift - 12;
+		phys_addr_t group = (addr >> group_shift) & group_mask;
+		phys_addr_t mask = domain->msiptp.msi_addr_mask & ~(group_mask << group_shift);
+
+		idx = addr & mask;
+		idx |= group << fls64(mask);
+	} else {
+		idx = addr & domain->msiptp.msi_addr_mask;
+	}
+
+	return idx;
+}
+
+static struct riscv_iommu_msipte *riscv_iommu_ir_get_msipte(struct riscv_iommu_domain *domain,
+							    phys_addr_t msi_pa)
+{
+	size_t idx;
+
+	if (((msi_pa >> 12) & ~domain->msiptp.msi_addr_mask) != domain->msiptp.msi_addr_pattern)
+		return NULL;
+
+	idx = riscv_iommu_ir_get_msipte_idx(domain, msi_pa);
+	return &domain->msi_root[idx];
+}
+
+static size_t riscv_iommu_ir_nr_msiptes(struct riscv_iommu_domain *domain)
+{
+	phys_addr_t base = domain->msiptp.msi_addr_pattern << 12;
+	phys_addr_t max_addr = base | (domain->msiptp.msi_addr_mask << 12);
+	size_t max_idx = riscv_iommu_ir_get_msipte_idx(domain, max_addr);
+
+	return max_idx + 1;
+}
+
+static struct irq_chip riscv_iommu_irq_chip = {
+	.name			= "IOMMU-IR",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+};
+
+static int riscv_iommu_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
+					     unsigned int irq_base, unsigned int nr_irqs,
+					     void *arg)
+{
+	struct irq_data *data;
+	int i, ret;
+
+	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
+		data->chip = &riscv_iommu_irq_chip;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_iommu_irq_domain_ops = {
+	.alloc = riscv_iommu_irq_domain_alloc_irqs,
+	.free = irq_domain_free_irqs_parent,
+};
+
+static const struct msi_parent_ops riscv_iommu_msi_parent_ops = {
+	.prefix			= "IR-",
+	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
+				  MSI_FLAG_PCI_MSIX,
+	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS,
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
+int riscv_iommu_irq_domain_create(struct riscv_iommu_domain *domain,
+				  struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct fwnode_handle *fn;
+	char *fwname;
+
+	if (domain->irqdomain) {
+		dev_set_msi_domain(dev, domain->irqdomain);
+		return 0;
+	}
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT)) {
+		dev_warn(iommu->dev, "Cannot enable interrupt remapping\n");
+		return 0;
+	}
+
+	spin_lock_init(&domain->msi_lock);
+	/*
+	 * TODO: The hypervisor should be in control of this size. For now
+	 * we just allocate enough space for 512 VCPUs.
+	 */
+	domain->msi_order = 1;
+	domain->msi_root = iommu_alloc_pages_node(domain->numa_node,
+						  GFP_KERNEL_ACCOUNT, domain->msi_order);
+	if (!domain->msi_root)
+		return -ENOMEM;
+
+	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
+	if (!fwname) {
+		iommu_free_pages(domain->msi_root, domain->msi_order);
+		return -ENOMEM;
+	}
+
+	fn = irq_domain_alloc_named_fwnode(fwname);
+	kfree(fwname);
+	if (!fn) {
+		dev_err(iommu->dev, "Couldn't allocate fwnode\n");
+		iommu_free_pages(domain->msi_root, domain->msi_order);
+		return -ENOMEM;
+	}
+
+	domain->irqdomain = irq_domain_create_hierarchy(dev_get_msi_domain(dev),
+							0, 0, fn,
+							&riscv_iommu_irq_domain_ops,
+							domain);
+	if (!domain->irqdomain) {
+		dev_err(iommu->dev, "Failed to create IOMMU irq domain\n");
+		iommu_free_pages(domain->msi_root, domain->msi_order);
+		irq_domain_free_fwnode(fn);
+		return -ENOMEM;
+	}
+
+	domain->irqdomain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT |
+				    IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	domain->irqdomain->msi_parent_ops = &riscv_iommu_msi_parent_ops;
+	irq_domain_update_bus_token(domain->irqdomain, DOMAIN_BUS_MSI_REMAP);
+	dev_set_msi_domain(dev, domain->irqdomain);
+
+	return 0;
+}
+
+void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_domain *domain = info->domain;
+	struct iommu_resv_region *reg;
+	phys_addr_t base, addr;
+	size_t nr_pages, i;
+
+	if (!domain || !domain->msiptp.msiptp)
+		return;
+
+	base = domain->msiptp.msi_addr_pattern << 12;
+
+	if (domain->group_index_bits) {
+		phys_addr_t group_mask = BIT(domain->group_index_bits) - 1;
+		phys_addr_t group_shift = domain->group_index_shift - 12;
+		phys_addr_t mask = domain->msiptp.msi_addr_mask & ~(group_mask << group_shift);
+
+		nr_pages = mask + 1;
+	} else {
+		nr_pages = domain->msiptp.msi_addr_mask + 1;
+	}
+
+	for (i = 0; i < BIT(domain->group_index_bits); i++) {
+		addr = base | (i << domain->group_index_shift);
+		reg = iommu_alloc_resv_region(addr, nr_pages * 4096,
+					      0, IOMMU_RESV_MSI, GFP_KERNEL);
+		if (reg)
+			list_add_tail(&reg->list, head);
+	}
+}
+
+void riscv_iommu_irq_domain_remove(struct riscv_iommu_domain *domain)
+{
+	struct fwnode_handle *fn;
+
+	if (!domain->irqdomain)
+		return;
+
+	iommu_free_pages(domain->msi_root, domain->msi_order);
+
+	fn = domain->irqdomain->fwnode;
+	irq_domain_remove(domain->irqdomain);
+	irq_domain_free_fwnode(fn);
+}
+
+void riscv_iommu_irq_domain_unlink(struct riscv_iommu_domain *domain,
+				   struct device *dev)
+{
+	if (!domain || !domain->irqdomain)
+		return;
+
+	dev_set_msi_domain(dev, domain->irqdomain->parent);
+}
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 6e8ea3d22ff5..c4a47b21c58f 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -943,7 +943,8 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-#define RISCV_IOMMU_FSC_BARE 0
+#define RISCV_IOMMU_FSC_BARE		0
+#define RISCV_IOMMU_IOHGATP_BARE	0
 
 /*
  * Update IODIR for the device.
@@ -1245,6 +1246,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	riscv_iommu_irq_domain_remove(domain);
+
 	if (domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 	if (domain->gscid > 0)
@@ -1276,10 +1279,30 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	int ret;
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
+	if (riscv_iommu_bond_link(domain, dev))
+		return -ENOMEM;
+
+	if (iommu_domain->type == IOMMU_DOMAIN_UNMANAGED) {
+		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+		if (domain->gscid < 0) {
+			riscv_iommu_bond_unlink(domain, dev);
+			return -ENOMEM;
+		}
+
+		ret = riscv_iommu_irq_domain_create(domain, dev);
+		if (ret) {
+			riscv_iommu_bond_unlink(domain, dev);
+			ida_free(&riscv_iommu_gscids, domain->gscid);
+			return ret;
+		}
+	}
+
 	if (domain->gscid) {
 		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, domain->pgd_mode) |
 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
@@ -1292,10 +1315,9 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 			   RISCV_IOMMU_PC_TA_V;
 
-	if (riscv_iommu_bond_link(domain, dev))
-		return -ENOMEM;
-
 	riscv_iommu_iodir_update(iommu, dev, &dc);
+
+	riscv_iommu_irq_domain_unlink(info->domain, dev);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1389,9 +1411,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.iohgatp = RISCV_IOMMU_IOHGATP_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, &dc);
+
+	riscv_iommu_irq_domain_unlink(info->domain, dev);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1413,15 +1438,24 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.iohgatp = RISCV_IOMMU_IOHGATP_BARE;
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
 	riscv_iommu_iodir_update(iommu, dev, &dc);
+
+	riscv_iommu_irq_domain_unlink(info->domain, dev);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
 	return 0;
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev,
+					 struct list_head *head)
+{
+	riscv_iommu_ir_get_resv_regions(dev, head);
+}
+
 static struct iommu_domain riscv_iommu_identity_domain = {
 	.type = IOMMU_DOMAIN_IDENTITY,
 	.ops = &(const struct iommu_domain_ops) {
@@ -1516,6 +1550,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index dd538b19fbb7..6ce71095781c 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -23,6 +23,12 @@
 #define RISCV_IOMMU_DDTP_TIMEOUT	10000000
 #define RISCV_IOMMU_IOTINVAL_TIMEOUT	90000000
 
+struct riscv_iommu_msiptp_state {
+	u64 msiptp;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+};
+
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
 	struct iommu_domain domain;
@@ -34,6 +40,13 @@ struct riscv_iommu_domain {
 	int numa_node;
 	unsigned int pgd_mode;
 	unsigned long *pgd_root;
+	u32 group_index_bits;
+	u32 group_index_shift;
+	int msi_order;
+	struct riscv_iommu_msipte *msi_root;
+	spinlock_t msi_lock;
+	struct riscv_iommu_msiptp_state msiptp;
+	struct irq_domain *irqdomain;
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
@@ -119,6 +132,14 @@ void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 			  unsigned int timeout_us);
 
+int riscv_iommu_irq_domain_create(struct riscv_iommu_domain *domain,
+				  struct device *dev);
+void riscv_iommu_irq_domain_remove(struct riscv_iommu_domain *domain);
+void riscv_iommu_irq_domain_unlink(struct riscv_iommu_domain *domain,
+				   struct device *dev);
+void riscv_iommu_ir_get_resv_regions(struct device *dev,
+				     struct list_head *head);
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-- 
2.47.0

