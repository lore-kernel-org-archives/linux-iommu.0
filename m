Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3962F3C2F
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662480; cv=none; b=JwKuF6iUx3+Y3HtVRgV0msj1gzQQ4S+Egg5mnPVoI0U4ZmuFcYOVZmMMoYh9RolgNPypAegR+/LLO2gDeQueF3H5KBk8x7BIlqsG7sCUgzZA71yeWmGJU3y2jQ56GNKGntxaTZ1bqZqzTTRqAuyB/2bzRhI4p9aJPo7UNzH09bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662480; c=relaxed/simple;
	bh=yuUDmVMvgxXqB9rDPx4gcql1xgvyC39B2Fu/k0legb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+RGIj5oL7blTc9G1jHtas25+T7bKoESRdfupUtZazXnHJXd9YTnmKK4ZEUfwt89yvMOG2xOtqnMDHNdVTwAA2FBJaTjGDTgz52OZuhZCeEH8L1vPIIvT1JSPlbtDgs9xkgbSXrWsozKeTPimUN+ZZxq3mTu/Fmf3HcqO4oC2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QkoWHSdJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QkoWHSdJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so747427b3a.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662477; x=1753267277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7cvuMytsIqdpckbaG4B9pE2XfMgVLihHPB3qJC2jIQ=;
        b=QkoWHSdJYq/DPj0G6X2yrwKW8E2rrhRI9cguG8UxTvXJEq0SPrwUkutfoMoWlRS+fC
         l9LEwI065YYjzuLbsx7c2052XG3gb1DX2O88FEo5YkXVFOe3IZd6BXYiTU4l7JUWzT3z
         4C/4hprwSqftLmL5iWvKdvnIXEyQDbzTztIziPS2+7qgvYLEgz7wkh6UrMoTk6SlRc93
         IX0or5VEk/HkRz4HfdVw0mMVqBjfK6zCUshkepVJUcOdI/EPieFBZWWREMTwJWmH1zH6
         +hnyODO/7We/U8ycsRhltnT+eFgaa8NVvad2hqqBV4/FgU8RKTovkm7RhcyGjEPW2mNS
         272g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662477; x=1753267277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7cvuMytsIqdpckbaG4B9pE2XfMgVLihHPB3qJC2jIQ=;
        b=I3oRihes0rAEkAHKFZlxweTT52rE0SZNaNLJBLE9POtdPKBtmUnD0Q4reUj7yA0PgJ
         b8jURiozOS+oIroNZdvNqJBBde+N8hV0wEkYJFjIm3f+C7nakVAA9gJwwT9CZK3eTPnG
         eIOr+j0v6bjqnHmj6h9RBsaObJAlqv13vNmmE85gfj0uMZYGtY+ZPAp44PkzT6eHurrh
         +29HOg+DHvJ+PzBHfENf8fj5HI/xD+GHoqGxvP18UiAU2sxFT3k3V2SKgQ8JrnXhhzGZ
         BX4w95huOrhklF4J4j30CRRGkQ8fmZHSvSmf6/d6LmCu+be8RbNWw3W3US7H0Efss9dU
         gZEg==
X-Forwarded-Encrypted: i=1; AJvYcCXsQVObGmjPaGdqAmbeEiSYDJ6Y0a2mYzYbMFQEXFtBTNbhH+69uLl92q+FU196zt63Jxw/Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ+PkuzNf/kOz1iLR6rSodr30b1th+mImJeYOOup/t6i6c5zRZ
	RCWldaXk17RRpm6COB/9MQnLHqJDsBQMGra/bQ8HVEAuIyjlDNHx62cEgwxV75OAtrw=
X-Gm-Gg: ASbGnctDExAi+R6zgT0MYiAEouCDbAI/T5r0NlKp7pcCJ7gKfDmkZWli9m/JFZd7XGb
	N/ngedh26OJdbwX64kfCvzLa1AOd+uYHUw6/5is/+O75nq8V1u5OrPjVPqcZvIaun8Pav2S0zJF
	+4gIpHBX0+Le+xrz0ydPdiojLXQwsCJ/fETJitwlWpM/COo85rpaklR2tjPeI4FItDT3Qdq7i3f
	+l7fM6eSPSDygXZA9YZ9F4I5M4zvVKhWhIgIBQihzW+M9/UfAR5DVpEAfmos/sEd669RvbWwMzx
	3U0/jHLZk+MI27NCNFMfyWkEnQO4rzv7UadQK9BtT/eyRuKNt6eTzvpcP7PF7XGgRjTNCICKWNU
	ql1x9YzckoicFXH7GRqD2jTxOG8fo8DQS
X-Google-Smtp-Source: AGHT+IEQo8BTjEA8dv3qComAn579iCusbeX0bf7sGC5ygFF46Xvcz6+6fNZHsSta4XexDcpmpBEqRg==
X-Received: by 2002:a05:6a21:3285:b0:231:c73:7a76 with SMTP id adf61e73a8af0-237e041c1b8mr4454127637.2.1752662476512;
        Wed, 16 Jul 2025 03:41:16 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:15 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Date: Wed, 16 Jul 2025 16:10:57 +0530
Message-ID: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) is a static ACPI table to communicate
IOMMU information to the OS. The spec is available at [1].

The changes at high level are,
	a) Initialize data structures required for IOMMU/device
	   configuration using the data from RIMT. Provide APIs required
	   for device configuration.
	b) Provide an API for IOMMU drivers to register the
	   fwnode with RIMT data structures. This API will create a
	   fwnode for PCIe IOMMU.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 MAINTAINERS                 |   1 +
 arch/riscv/Kconfig          |   1 +
 drivers/acpi/Kconfig        |   4 +
 drivers/acpi/riscv/Kconfig  |   7 +
 drivers/acpi/riscv/Makefile |   1 +
 drivers/acpi/riscv/init.c   |   2 +
 drivers/acpi/riscv/init.h   |   1 +
 drivers/acpi/riscv/rimt.c   | 520 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi_rimt.h   |  28 ++
 9 files changed, 565 insertions(+)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..426540c1fa3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -345,6 +345,7 @@ L:	linux-acpi@vger.kernel.org
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/acpi/riscv/
+F:	include/linux/acpi_rimt.h
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d71ea0f4466f..67bbf3b7302d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,7 @@ config RISCV
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_RIMT if ACPI
 	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac..4381803c308c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -546,6 +546,10 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+if RISCV
+source "drivers/acpi/riscv/Kconfig"
+endif
+
 config ACPI_PPTT
 	bool
 
diff --git a/drivers/acpi/riscv/Kconfig b/drivers/acpi/riscv/Kconfig
new file mode 100644
index 000000000000..046296a18d00
--- /dev/null
+++ b/drivers/acpi/riscv/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ACPI Configuration for RISC-V
+#
+
+config ACPI_RIMT
+	bool
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index a96fdf1e2cb8..1284a076fa88 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -2,3 +2,4 @@
 obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
+obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 673e4d5dd752..7c00f7995e86 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -10,4 +10,6 @@
 void __init acpi_arch_init(void)
 {
 	riscv_acpi_init_gsi_mapping();
+	if (IS_ENABLED(CONFIG_ACPI_RIMT))
+		riscv_acpi_rimt_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 0b9a07e4031f..1680aa2aaf23 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -2,3 +2,4 @@
 #include <linux/init.h>
 
 void __init riscv_acpi_init_gsi_mapping(void);
+void __init riscv_acpi_rimt_init(void);
diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
new file mode 100644
index 000000000000..bd108f624ba0
--- /dev/null
+++ b/drivers/acpi/riscv/rimt.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI: RIMT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include "init.h"
+
+struct rimt_fwnode {
+	struct list_head list;
+	struct acpi_rimt_node *rimt_node;
+	struct fwnode_handle *fwnode;
+};
+
+static LIST_HEAD(rimt_fwnode_list);
+static DEFINE_SPINLOCK(rimt_fwnode_lock);
+
+#define RIMT_TYPE_MASK(type)	(1 << (type))
+#define RIMT_IOMMU_TYPE		BIT(0)
+
+/* Root pointer to the mapped RIMT table */
+static struct acpi_table_header *rimt_table;
+
+/**
+ * rimt_set_fwnode() - Create rimt_fwnode and use it to register
+ *		       iommu data in the rimt_fwnode_list
+ *
+ * @rimt_node: RIMT table node associated with the IOMMU
+ * @fwnode: fwnode associated with the RIMT node
+ *
+ * Returns: 0 on success
+ *          <0 on failure
+ */
+static int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
+			   struct fwnode_handle *fwnode)
+{
+	struct rimt_fwnode *np;
+
+	np = kzalloc(sizeof(*np), GFP_ATOMIC);
+
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->rimt_node = rimt_node;
+	np->fwnode = fwnode;
+
+	spin_lock(&rimt_fwnode_lock);
+	list_add_tail(&np->list, &rimt_fwnode_list);
+	spin_unlock(&rimt_fwnode_lock);
+
+	return 0;
+}
+
+/**
+ * rimt_get_fwnode() - Retrieve fwnode associated with an RIMT node
+ *
+ * @node: RIMT table node to be looked-up
+ *
+ * Returns: fwnode_handle pointer on success, NULL on failure
+ */
+static struct fwnode_handle *rimt_get_fwnode(struct acpi_rimt_node *node)
+{
+	struct fwnode_handle *fwnode = NULL;
+	struct rimt_fwnode *curr;
+
+	spin_lock(&rimt_fwnode_lock);
+	list_for_each_entry(curr, &rimt_fwnode_list, list) {
+		if (curr->rimt_node == node) {
+			fwnode = curr->fwnode;
+			break;
+		}
+	}
+	spin_unlock(&rimt_fwnode_lock);
+
+	return fwnode;
+}
+
+static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
+					    void *context)
+{
+	acpi_status status = AE_NOT_FOUND;
+	struct device *dev = context;
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
+		struct acpi_rimt_iommu *iommu_node = (struct acpi_rimt_iommu *)&node->node_data;
+
+		if (dev_is_pci(dev)) {
+			struct pci_dev *pdev;
+			u16 bdf;
+
+			pdev = to_pci_dev(dev);
+			bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
+			if ((pci_domain_nr(pdev->bus) == iommu_node->pcie_segment_number) &&
+			    bdf == iommu_node->pcie_bdf) {
+				status = AE_OK;
+			} else {
+				status = AE_NOT_FOUND;
+			}
+		} else {
+			struct platform_device *pdev = to_platform_device(dev);
+			struct resource *res;
+
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+			if (res && res->start == iommu_node->base_address)
+				status = AE_OK;
+			else
+				status = AE_NOT_FOUND;
+		}
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		struct acpi_rimt_pcie_rc *pci_rc;
+		struct pci_bus *bus;
+
+		bus = to_pci_bus(dev);
+		pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
+
+		/*
+		 * It is assumed that PCI segment numbers maps one-to-one
+		 * with root complexes. Each segment number can represent only
+		 * one root complex.
+		 */
+		status = pci_rc->pcie_segment_number == pci_domain_nr(bus) ?
+							AE_OK : AE_NOT_FOUND;
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_rimt_platform_device *ncomp;
+		struct device *plat_dev = dev;
+		struct acpi_device *adev;
+
+		/*
+		 * Walk the device tree to find a device with an
+		 * ACPI companion; there is no point in scanning
+		 * RIMT for a device matching a platform device if
+		 * the device does not have an ACPI companion to
+		 * start with.
+		 */
+		do {
+			adev = ACPI_COMPANION(plat_dev);
+			if (adev)
+				break;
+
+			plat_dev = plat_dev->parent;
+		} while (plat_dev);
+
+		if (!adev)
+			return status;
+
+		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
+		if (ACPI_FAILURE(status)) {
+			dev_warn(plat_dev, "Can't get device full path name\n");
+			return status;
+		}
+
+		ncomp = (struct acpi_rimt_platform_device *)node->node_data;
+		status = !strcmp(ncomp->device_name, buf.pointer) ?
+							AE_OK : AE_NOT_FOUND;
+		acpi_os_free(buf.pointer);
+	}
+
+	return status;
+}
+
+static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
+					     void *context)
+{
+	struct acpi_rimt_node *rimt_node, *rimt_end;
+	struct acpi_table_rimt *rimt;
+	int i;
+
+	if (!rimt_table)
+		return NULL;
+
+	/* Get the first RIMT node */
+	rimt = (struct acpi_table_rimt *)rimt_table;
+	rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
+				 rimt->node_offset);
+	rimt_end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				rimt_table->length);
+
+	for (i = 0; i < rimt->num_nodes; i++) {
+		if (WARN_TAINT(rimt_node >= rimt_end, TAINT_FIRMWARE_WORKAROUND,
+			       "RIMT node pointer overflows, bad table!\n"))
+			return NULL;
+
+		if (rimt_node->type == type &&
+		    ACPI_SUCCESS(rimt_match_node_callback(rimt_node, context)))
+			return rimt_node;
+
+		rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_node,
+					 rimt_node->length);
+	}
+
+	return NULL;
+}
+
+static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
+{
+	struct acpi_rimt_pcie_rc *pci_rc;
+
+	pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
+	return pci_rc->flags & ACPI_RIMT_PCIE_ATS_SUPPORTED;
+}
+
+static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32 deviceid)
+{
+	struct fwnode_handle *rimt_fwnode;
+
+	if (!node)
+		return -ENODEV;
+
+	rimt_fwnode = rimt_get_fwnode(node);
+
+	/*
+	 * The IOMMU drivers may not be probed yet.
+	 * Defer the IOMMU configuration
+	 */
+	if (!rimt_fwnode)
+		return -EPROBE_DEFER;
+
+	return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
+}
+
+struct rimt_pci_alias_info {
+	struct device *dev;
+	struct acpi_rimt_node *node;
+	const struct iommu_ops *ops;
+};
+
+static int rimt_id_map(struct acpi_rimt_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
+{
+	if (rid_in < map->source_id_base ||
+	    (rid_in > map->source_id_base + map->num_ids))
+		return -ENXIO;
+
+	*rid_out = map->dest_id_base + (rid_in - map->source_id_base);
+	return 0;
+}
+
+static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
+					       u32 *id_out, int index)
+{
+	struct acpi_rimt_platform_device *plat_node;
+	u32 id_mapping_offset, num_id_mapping;
+	struct acpi_rimt_pcie_rc *pci_node;
+	struct acpi_rimt_id_mapping *map;
+	struct acpi_rimt_node *parent;
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
+		id_mapping_offset = pci_node->id_mapping_offset;
+		num_id_mapping = pci_node->num_id_mappings;
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+		plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
+		id_mapping_offset = plat_node->id_mapping_offset;
+		num_id_mapping = plat_node->num_id_mappings;
+	} else {
+		return NULL;
+	}
+
+	if (!id_mapping_offset || !num_id_mapping || index >= num_id_mapping)
+		return NULL;
+
+	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
+			   id_mapping_offset + index * sizeof(*map));
+
+	/* Firmware bug! */
+	if (!map->dest_offset) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
+	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		*id_out = map->dest_offset;
+		return parent;
+	}
+
+	return NULL;
+}
+
+static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
+					       u32 id_in, u32 *id_out,
+					       u8 type_mask)
+{
+	struct acpi_rimt_platform_device *plat_node;
+	u32 id_mapping_offset, num_id_mapping;
+	struct acpi_rimt_pcie_rc *pci_node;
+	u32 id = id_in;
+
+	/* Parse the ID mapping tree to find specified node type */
+	while (node) {
+		struct acpi_rimt_id_mapping *map;
+		int i, rc = 0;
+		u32 map_id = id;
+
+		if (RIMT_TYPE_MASK(node->type) & type_mask) {
+			if (id_out)
+				*id_out = id;
+			return node;
+		}
+
+		if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+			pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
+			id_mapping_offset = pci_node->id_mapping_offset;
+			num_id_mapping = pci_node->num_id_mappings;
+		} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+			plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
+			id_mapping_offset = plat_node->id_mapping_offset;
+			num_id_mapping = plat_node->num_id_mappings;
+		} else {
+			goto fail_map;
+		}
+
+		if (!id_mapping_offset || !num_id_mapping)
+			goto fail_map;
+
+		map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
+				   id_mapping_offset);
+
+		/* Firmware bug! */
+		if (!map->dest_offset) {
+			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+			       node, node->type);
+			goto fail_map;
+		}
+
+		/* Do the ID translation */
+		for (i = 0; i < num_id_mapping; i++, map++) {
+			rc = rimt_id_map(map, node->type, map_id, &id);
+			if (!rc)
+				break;
+		}
+
+		if (i == num_id_mapping)
+			goto fail_map;
+
+		node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				    rc ? 0 : map->dest_offset);
+	}
+
+fail_map:
+	/* Map input ID to output ID unchanged on mapping failure */
+	if (id_out)
+		*id_out = id_in;
+
+	return NULL;
+}
+
+static struct acpi_rimt_node *rimt_node_map_platform_id(struct acpi_rimt_node *node, u32 *id_out,
+							u8 type_mask, int index)
+{
+	struct acpi_rimt_node *parent;
+	u32 id;
+
+	parent = rimt_node_get_id(node, &id, index);
+	if (!parent)
+		return NULL;
+
+	if (!(RIMT_TYPE_MASK(parent->type) & type_mask))
+		parent = rimt_node_map_id(parent, id, id_out, type_mask);
+	else
+		if (id_out)
+			*id_out = id;
+
+	return parent;
+}
+
+static int rimt_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct rimt_pci_alias_info *info = data;
+	struct acpi_rimt_node *parent;
+	u32 deviceid;
+
+	parent = rimt_node_map_id(info->node, alias, &deviceid, RIMT_IOMMU_TYPE);
+	return rimt_iommu_xlate(info->dev, parent, deviceid);
+}
+
+/*
+ * RISC-V supports IOMMU as a PCI device or a platform device.
+ * When it is a platform device, there should be a namespace device as
+ * well along with RIMT. To create the link between RIMT information and
+ * the platform device, the IOMMU driver should register itself with the
+ * RIMT module. This is true for PCI based IOMMU as well.
+ */
+int rimt_iommu_register(struct device *dev)
+{
+	struct fwnode_handle *rimt_fwnode;
+	struct acpi_rimt_node *node;
+
+	node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_IOMMU, dev);
+	if (!node) {
+		pr_err("Could not find IOMMU node in RIMT\n");
+		return -ENODEV;
+	}
+
+	if (dev_is_pci(dev)) {
+		rimt_fwnode = acpi_alloc_fwnode_static();
+		if (!rimt_fwnode)
+			return -ENOMEM;
+
+		rimt_fwnode->dev = dev;
+		if (!dev->fwnode)
+			dev->fwnode = rimt_fwnode;
+
+		rimt_set_fwnode(node, rimt_fwnode);
+	} else {
+		rimt_set_fwnode(node, dev->fwnode);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_IOMMU_API
+
+static int rimt_plat_iommu_map(struct device *dev, struct acpi_rimt_node *node)
+{
+	struct acpi_rimt_node *parent;
+	int err = -ENODEV, i = 0;
+	u32 deviceid = 0;
+
+	do {
+		parent = rimt_node_map_platform_id(node, &deviceid,
+						   RIMT_IOMMU_TYPE,
+						   i++);
+
+		if (parent)
+			err = rimt_iommu_xlate(dev, parent, deviceid);
+	} while (parent && !err);
+
+	return err;
+}
+
+static int rimt_plat_iommu_map_id(struct device *dev,
+				  struct acpi_rimt_node *node,
+				  const u32 *in_id)
+{
+	struct acpi_rimt_node *parent;
+	u32 deviceid;
+
+	parent = rimt_node_map_id(node, *in_id, &deviceid, RIMT_IOMMU_TYPE);
+	if (parent)
+		return rimt_iommu_xlate(dev, parent, deviceid);
+
+	return -ENODEV;
+}
+
+/**
+ * rimt_iommu_configure_id - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ * @id_in: optional input id const value pointer
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	struct acpi_rimt_node *node;
+	int err = -ENODEV;
+
+	if (dev_is_pci(dev)) {
+		struct iommu_fwspec *fwspec;
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		struct rimt_pci_alias_info info = { .dev = dev };
+
+		node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX, &bus->dev);
+		if (!node)
+			return -ENODEV;
+
+		info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     rimt_pci_iommu_init, &info);
+
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (fwspec && rimt_pcie_rc_supports_ats(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+	} else {
+		node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_PLAT_DEVICE, dev);
+		if (!node)
+			return -ENODEV;
+
+		err = id_in ? rimt_plat_iommu_map_id(dev, node, id_in) :
+			      rimt_plat_iommu_map(dev, node);
+	}
+
+	return err;
+}
+
+#endif
+
+void __init riscv_acpi_rimt_init(void)
+{
+	acpi_status status;
+
+	/* rimt_table will be used at runtime after the rimt init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the RIMT table mapping.
+	 */
+	status = acpi_get_table(ACPI_SIG_RIMT, 0, &rimt_table);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get table, %s\n", msg);
+		}
+
+		return;
+	}
+}
diff --git a/include/linux/acpi_rimt.h b/include/linux/acpi_rimt.h
new file mode 100644
index 000000000000..fad3adc4d899
--- /dev/null
+++ b/include/linux/acpi_rimt.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2024-2025, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#ifndef _ACPI_RIMT_H
+#define _ACPI_RIMT_H
+
+#ifdef CONFIG_ACPI_RIMT
+int rimt_iommu_register(struct device *dev);
+#else
+static inline int rimt_iommu_register(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
+#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_RIMT)
+int rimt_iommu_configure_id(struct device *dev, const u32 *id_in);
+#else
+static inline int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* _ACPI_RIMT_H */
-- 
2.43.0

