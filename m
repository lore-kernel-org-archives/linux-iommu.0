Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CE2F272C
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949352; cv=none; b=GcURYcP+zWqueWNGYpElW1B8YQqvJBc/3hUmCJ0HELJlBLohZxwclFyPorQiKb01uPnFS3Rj17JJK3ghs1s7Iw9YJW27RZ/fuO0wfdW6o07dwTu8D3Z8/USmIuPdAPf3/rJ4TSgGteDJUjWIMT0Q2e3VKWKVgl3BS415k1kKni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949352; c=relaxed/simple;
	bh=C0IP1ldijdRmaS+puKQkDDZEbW3+UTuiddetXdu9lN0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpN9XtfiCq6NrrZeoeuVdmEGq1TXIJ6zHfFk/+03Nu7AjkENlvJOCuPZfvRiaSaApT4owHfU+Kqfl2Y6khEP4qKrywm3KU5UyTEH4NZ58tgJxuZkr2w+/ik1RQuYnOpsanx/dDfbKec259ig/5H7KdOrAA2pJZocmu+lc86eRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzbHoiGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6eZxFlM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzbHoiGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6eZxFlM"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RK/wtTylOOst3NoQPmbj1UZ1alu1ISJX0ZCcg+3yGNk=;
	b=IzbHoiGj+9g+AeqRYueTLqqKo2pzmdJzwlgXQAHhiXT5JpRZtBUa6j8rblYJXWcewvc4f1
	/ejYslBo+r17GkM80uKZrqEBG3aN5FYaq1oqep4V3yCp/4KOkoKKPx+8mOj9JSrhu/zHMR
	IdGs1R407AuQr1IWKDpbVKpOQdJMjFZvegTh5DxQUkfiR0Qwq4XlJ0NMX2Hg20cWpL0WpR
	3W6xn1zh5mqtrgWPN2BveBWINIECilb01H4D1CvgDBFO1k+/7Asvs5BHBHkhS7U/v9jblQ
	n78g1A01ZeHnHMdK3dfgu5o28DeUaacG7RqyqCBnzhx6PrQT/HowQs8rYe9QOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RK/wtTylOOst3NoQPmbj1UZ1alu1ISJX0ZCcg+3yGNk=;
	b=S6eZxFlMNrrRZ8j7VzqgbsByaj9JBTsLHnPMjQcFcFh3J3oi5xgNUOCXu/twS7APcQCbup
	HMxYSTYfsZRZOlDQ==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/intel: Convert to msi_create_parent_irq_domain() helper
Date: Thu, 26 Jun 2025 16:48:55 +0200
Message-Id: <169c793c50be8493cfd9d11affb00e9ed6341c36.1750858125.git.namcao@linutronix.de>
In-Reply-To: <cover.1750858125.git.namcao@linutronix.de>
References: <cover.1750858125.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marc Zyngier <maz@kernel.org>

Now that we have a concise helper to create an MSI parent domain,
switch the Intel IOMMU remapping over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241204124549.607054-10-maz@kernel.org
---
 drivers/iommu/Kconfig               |  1 +
 drivers/iommu/intel/irq_remapping.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0a33d995d15dd..c5ce712a37b9f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -200,6 +200,7 @@ source "drivers/iommu/riscv/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
+	select IRQ_MSI_LIB
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_=
remapping.c
index cf7b6882ec755..2ef71ba696b1f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -10,6 +10,7 @@
 #include <linux/hpet.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/crash_dump.h>
@@ -518,8 +519,14 @@ static void iommu_enable_irq_remapping(struct intel_io=
mmu *iommu)
=20
 static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 {
+	struct irq_domain_info info =3D {
+		.ops		=3D &intel_ir_domain_ops,
+		.parent		=3D arch_get_ir_parent_domain(),
+		.domain_flags	=3D IRQ_DOMAIN_FLAG_ISOLATED_MSI,
+		.size		=3D INTR_REMAP_TABLE_ENTRIES,
+		.host_data	=3D iommu,
+	};
 	struct ir_table *ir_table;
-	struct fwnode_handle *fn;
 	unsigned long *bitmap;
 	void *ir_table_base;
=20
@@ -544,25 +551,16 @@ static int intel_setup_irq_remapping(struct intel_iom=
mu *iommu)
 		goto out_free_pages;
 	}
=20
-	fn =3D irq_domain_alloc_named_id_fwnode("INTEL-IR", iommu->seq_id);
-	if (!fn)
+	info.fwnode =3D irq_domain_alloc_named_id_fwnode("INTEL-IR", iommu->seq_i=
d);
+	if (!info.fwnode)
 		goto out_free_bitmap;
=20
-	iommu->ir_domain =3D
-		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
-					    0, INTR_REMAP_TABLE_ENTRIES,
-					    fn, &intel_ir_domain_ops,
-					    iommu);
+	iommu->ir_domain =3D msi_create_parent_irq_domain(&info, &dmar_msi_parent=
_ops);
 	if (!iommu->ir_domain) {
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
=20
-	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
-	iommu->ir_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT |
-				   IRQ_DOMAIN_FLAG_ISOLATED_MSI;
-	iommu->ir_domain->msi_parent_ops =3D &dmar_msi_parent_ops;
-
 	ir_table->base =3D ir_table_base;
 	ir_table->bitmap =3D bitmap;
 	iommu->ir_table =3D ir_table;
@@ -608,7 +606,7 @@ static int intel_setup_irq_remapping(struct intel_iommu=
 *iommu)
 	irq_domain_remove(iommu->ir_domain);
 	iommu->ir_domain =3D NULL;
 out_free_fwnode:
-	irq_domain_free_fwnode(fn);
+	irq_domain_free_fwnode(info.fwnode);
 out_free_bitmap:
 	bitmap_free(bitmap);
 out_free_pages:
@@ -1530,6 +1528,8 @@ static const struct irq_domain_ops intel_ir_domain_op=
s =3D {
=20
 static const struct msi_parent_ops dmar_msi_parent_ops =3D {
 	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_=
MSI,
+	.bus_select_token	=3D DOMAIN_BUS_DMAR,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
 	.prefix			=3D "IR-",
 	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
 };
--=20
2.39.5

