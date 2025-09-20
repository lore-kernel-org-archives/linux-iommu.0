Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810392D5942
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400741; cv=none; b=GTniKAQCJTcHJlNqKKE3xSB1QTKBofi4n6JXgcvV7ZAUEbu7J5uK+xd9dkVUUFIPOMTcNskJBsmydegatHedAbNpwIepCtekPxgCnUuV9bA0AvbgHpLqgE8daS5t46GX//tGFdQB5GNx3I0Z/5ESgQ+8W68s3jo55kyKTgEDSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400741; c=relaxed/simple;
	bh=+bv/mDRCnIUT3XE/Rkr1oTo8c54UCDlO89DbD/uj+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLuY2ZWcL1WM0korVCib53+hzxIaD46hRh5wg38FCCCMRorzy/LvHeZeonwRRbaP//GtKwx/mN2jlwbRq74tASQtFBtGISpSFRWxiodk+a2+yu1U9ElxnKv51XEYYL/ZsBhs6A1qrUKxRo46T46ylxXdU1E87HRNeCstJ2lspg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eWhljcHs; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eWhljcHs"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-893630dba34so122139339f.1
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400738; x=1759005538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whvw7GIAV0QOBLqmpln8l+jITmzsNllZxDqiVF4ag+w=;
        b=eWhljcHsXI1qpCSNy/nLUKKCFmMMW/bboEuiuCD1tTG9wRTD0WPXDEhKlAJxrrE1IY
         1j70R+f/D3WWekBSlF7jpqHQesxTamZhbFP0Z+7EBbQmuR16/1vHASoT7+/5rZ73NKbM
         LulL12CZKup4ivQwyzlO69aY2hf/BqWVGXbPx5GiXyJKEH7AYlld9wY0GBI8AK6yiCjj
         YIazX0AnmFFSICXsoOhN04F06C9TVvM4evnFE7os5Hz5lHrqe42VU0jLz81Tw6beTc/6
         lAdIm2kWRUNNCKXr8HLPkFhZGCwEGBZSYg8WWC3+Y6LMeqI/RdbFAgIhpozfcuVtsrcZ
         vN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400738; x=1759005538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whvw7GIAV0QOBLqmpln8l+jITmzsNllZxDqiVF4ag+w=;
        b=PX4FSm3iQYChm+APYjWJfvETieq3zQHk3SOnAAcwQ8ZeKsSELPwARJCa0q9qTea8cS
         k5OAmYn+9lmEkbTk2y6QOCFq8hU2/bzm1XoF+0iDptR1dkK4Go3UslEP3pC+dv5B9hjY
         ruJebKaqML9XGgA0CiM2caZkJIhZQKp1ePbzmn4jrwLxM0RriqQc+XUn5xF/2rOI2V11
         9UjxYCTiSSiZ8kBJuZDmgb+5iWS8sV6aBpb6FqxWFH3BJK+tJ5IkiXDmhEYw8U5PGnuI
         D3ZVy+8dVun7IPTqbUeKLLuyTX1Mc1er2OalTtpV9qJI2OVuo9AtHDOYcWWpe5xt2HQP
         1mNQ==
X-Gm-Message-State: AOJu0YzjsXS1RQU2pjVmjrstR4mtaNVd6mRRg5bUGYlSAN9olm+RWxWg
	Op6DzWf8oEVAQaGiv/EUIrOaltfHwD09Lq1EeLtaBndAPwLUGXa5/xK62fmoL1uRQUbItx3MtQ0
	rlhNkkuY=
X-Gm-Gg: ASbGncswMsBk5//SwJ7L8d+zqhEj4UTVSToFgvH8+MCYMDdFyeAImWt89JBgb+p9qAh
	tFO8inXr/mCiXT9u+Wmw7T6DubBaqE7+xQf3acERXdINPCW7fD3u73Xr1SNu4oos8veRRDBsnlB
	Fu7K6BVrsTPgKZzgnZaRZp6KdzF0d4gM7hY/Zu8x+6M05wYoQyHOW4vypFk2OzXXM+0VhkoALY0
	blMY0vpvBNDWOd8hfnvM6ji0irYkccfa/r2hmHQda63+YsF72hOngn8iEh9weaD2yRrMtR6fVb6
	MJWWg0CMcHxkXEVjS71BMmgduY7nET6MAydXG2No8vmvtkVB+/W6h8c+kzO96mrlOmaI51VU3w8
	pKBmiE4nLTMILMEhjSla+99zp
X-Google-Smtp-Source: AGHT+IGphbpA8LUETpViwfc9r4c9ghsEimyNiVY0lUzG9ZGVUA6JiRqkq6yLPztHpengD8OD1tX9pg==
X-Received: by 2002:a05:6602:26cb:b0:887:690b:2594 with SMTP id ca18e2360f4ac-8ad5eb39575mr1149464339f.5.1758400738371;
        Sat, 20 Sep 2025 13:38:58 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3772sm284226539f.6.2025.09.20.13.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:57 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 04/18] iommu/riscv: Add IRQ domain for interrupt remapping
Date: Sat, 20 Sep 2025 15:38:54 -0500
Message-ID: <20250920203851.2205115-24-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is just a skeleton. Until irq-set-affinity functions are
implemented the IRQ domain doesn't serve any purpose.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/Makefile   |   2 +-
 drivers/iommu/riscv/iommu-ir.c | 114 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  36 +++++++++++
 drivers/iommu/riscv/iommu.h    |  12 ++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index b5929f9f23e6..9c83f877d50f 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o iommu-platform.o
+obj-y += iommu.o iommu-ir.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
new file mode 100644
index 000000000000..08cf159b587d
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IOMMU Interrupt Remapping
+ *
+ * Copyright © 2025 Ventana Micro Systems Inc.
+ */
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#include "iommu.h"
+
+static struct irq_chip riscv_iommu_ir_irq_chip = {
+	.name			= "IOMMU-IR",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
+						unsigned int irq_base, unsigned int nr_irqs,
+						void *arg)
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
+		data->chip = &riscv_iommu_ir_irq_chip;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
+	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
+	.free = irq_domain_free_irqs_parent,
+};
+
+static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
+	.prefix			= "IR-",
+	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
+				  MSI_FLAG_PCI_MSIX,
+	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS |
+				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
+struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *iommu,
+						    struct device *dev,
+						    struct riscv_iommu_info *info)
+{
+	struct irq_domain *irqparent = dev_get_msi_domain(dev);
+	struct irq_domain *irqdomain;
+	struct fwnode_handle *fn;
+	char *fwname;
+
+	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
+	if (!fwname)
+		return NULL;
+
+	fn = irq_domain_alloc_named_fwnode(fwname);
+	kfree(fwname);
+	if (!fn) {
+		dev_err(iommu->dev, "Couldn't allocate fwnode\n");
+		return NULL;
+	}
+
+	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
+						&riscv_iommu_ir_irq_domain_ops,
+						info);
+	if (!irqdomain) {
+		dev_err(iommu->dev, "Failed to create IOMMU irq domain\n");
+		irq_domain_free_fwnode(fn);
+		return NULL;
+	}
+
+	irqdomain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	irqdomain->msi_parent_ops = &riscv_iommu_ir_msi_parent_ops;
+	irq_domain_update_bus_token(irqdomain, DOMAIN_BUS_MSI_REMAP);
+
+	dev_set_msi_domain(dev, irqdomain);
+
+	return irqdomain;
+}
+
+void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info)
+{
+	struct fwnode_handle *fn;
+
+	if (!info->irqdomain)
+		return;
+
+	fn = info->irqdomain->fwnode;
+	irq_domain_remove(info->irqdomain);
+	info->irqdomain = NULL;
+	irq_domain_free_fwnode(fn);
+}
+
+int riscv_iommu_ir_attach_paging_domain(struct riscv_iommu_domain *domain,
+					struct device *dev)
+{
+	return 0;
+}
+
+void riscv_iommu_ir_free_paging_domain(struct riscv_iommu_domain *domain)
+{
+}
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a44c67a848fa..db2acd9dc64b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -17,6 +17,8 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
@@ -1026,6 +1028,9 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
 		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->msiptp, new_dc->msiptp);
+		WRITE_ONCE(dc->msi_addr_mask, new_dc->msi_addr_mask);
+		WRITE_ONCE(dc->msi_addr_pattern, new_dc->msi_addr_pattern);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1276,6 +1281,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	riscv_iommu_ir_free_paging_domain(domain);
+
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
@@ -1305,15 +1312,28 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	int ret;
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
+	ret = riscv_iommu_ir_attach_paging_domain(domain, dev);
+	if (ret)
+		return ret;
+
 	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
 		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 			   RISCV_IOMMU_PC_TA_V;
 
+	if (domain->msi_root) {
+		dc.msiptp = virt_to_pfn(domain->msi_root) |
+			    FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE,
+				       RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
+		dc.msi_addr_mask = domain->msi_addr_mask;
+		dc.msi_addr_pattern = domain->msi_addr_pattern;
+	}
+
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
@@ -1466,6 +1486,8 @@ static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args
 static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	const struct imsic_global_config *imsic_global;
+	struct irq_domain *irqdomain = NULL;
 	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_info *info;
 	struct riscv_iommu_dc *dc;
@@ -1489,6 +1511,18 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
+
+	imsic_global = imsic_get_global_config();
+	if (imsic_global && imsic_global->nr_ids) {
+		irqdomain = riscv_iommu_ir_irq_domain_create(iommu, dev, info);
+		if (!irqdomain) {
+			kfree(info);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	info->irqdomain = irqdomain;
+
 	/*
 	 * Allocate and pre-configure device context entries in
 	 * the device directory. Do not mark the context valid yet.
@@ -1499,6 +1533,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		if (!dc) {
+			riscv_iommu_ir_irq_domain_remove(info);
 			kfree(info);
 			return ERR_PTR(-ENODEV);
 		}
@@ -1516,6 +1551,7 @@ static void riscv_iommu_release_device(struct device *dev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
+	riscv_iommu_ir_irq_domain_remove(info);
 	kfree_rcu_mightsleep(info);
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 1d163cbd9e4d..640d825f11b9 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -27,11 +27,15 @@ struct riscv_iommu_domain {
 	int numa_node;
 	unsigned int pgd_mode;
 	unsigned long *pgd_root;
+	struct riscv_iommu_msipte *msi_root;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	struct irq_domain *irqdomain;
 };
 
 struct riscv_iommu_device;
@@ -86,6 +90,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *iommu,
+						    struct device *dev,
+						    struct riscv_iommu_info *info);
+void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info);
+int riscv_iommu_ir_attach_paging_domain(struct riscv_iommu_domain *domain,
+					struct device *dev);
+void riscv_iommu_ir_free_paging_domain(struct riscv_iommu_domain *domain);
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-- 
2.49.0

