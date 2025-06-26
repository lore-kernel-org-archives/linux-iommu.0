Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2012F2C48
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949351; cv=none; b=ikybi1RQK95mU4yx2InqtIgiACHdrGp8duVZ4yn8vEVmkAv5YIaQ0lGKeGRhYVDh7PQb0/SgDmCcZJoNnH80EySmRW/S7wE1GcwWJHChFF91KRLxo1ttqviu7ZrjHUoCs/eWDuTmjc7F2yd91zkPhIsFxww6HJkBlju683eEa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949351; c=relaxed/simple;
	bh=2YbxWDKkWzF/hrfarNwCwHEuFXFu1PTSS/T9Ua8h/fw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0JNB5zDrye5zh5OEPaFG/8PXh3iVp1qLqa9+CGHA6Zg/3SNtFsWYZMcDaieF/yFqDm/CmZxKgwtEOresfsmGKRTTcign9LYoEoDmuLCr6njvETCjEKrXYNtBBGSPqPF/sM8vUFUTYxgVxoh6LNcX6Y92D1btHiSsSwqQbS+AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBNVBbGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hu4Ik2sS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBNVBbGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hu4Ik2sS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNjg0O+kLNNyFjc7xxt7Q9QXmsuAoIbeUlbK6jR0NwA=;
	b=BBNVBbGQ16Br1lhhpuC+60IMd9GkidQ+yvVQpHQQISmpf7xEq+W29EHNFxkxk4YsGYdyYv
	MXcuJlMiFO8DwzzCyA2hLxx25iM4YOhUO9HrDYCWZaT/+xSEcAEe1lhGt1yZbq1ceCiJj+
	7T4X4qy/ipKkL0ukP/8iQ1Ef5w6pajdLVnRncren2Z6H+EOArz/UynOQkZoaslr49L8yq2
	PaZOFbjDSAMNprB4pHHOxXfe41p3YnAXsR57H5ektWlppXfsrHSxkKsgx3q4yTITVhpA5t
	+UTE/oAqMmw1Q/bpoLn34HEmqyWZHJh4Sv9Qh18YBKBotGpNaOiC39PouGg7GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNjg0O+kLNNyFjc7xxt7Q9QXmsuAoIbeUlbK6jR0NwA=;
	b=Hu4Ik2sSQhHxN4/mUhNkIL4sC7rN2FcvkR1yX18WFNY+RklHPWPFB4Ob9W4CcM1vGwQ+rZ
	+1zPN25gC8zBQbDQ==
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
Subject: [PATCH 1/2] iommu/amd: Convert to msi_create_parent_irq_domain() helper
Date: Thu, 26 Jun 2025 16:48:54 +0200
Message-Id: <92e5ae97a03e4ffc272349d0863cd2cc8f904c44.1750858125.git.namcao@linutronix.de>
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
switch the AMD IOMMU remapping over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241204124549.607054-9-maz@kernel.org
---
 drivers/iommu/amd/Kconfig |  1 +
 drivers/iommu/amd/iommu.c | 26 ++++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 994063e5586f0..ecef69c11144d 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -7,6 +7,7 @@ config AMD_IOMMU
 	select PCI_ATS
 	select PCI_PRI
 	select PCI_PASID
+	select IRQ_MSI_LIB
 	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3117d99cf83d0..0cb7c077d388f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
@@ -3970,29 +3971,30 @@ static struct irq_chip amd_ir_chip =3D {
=20
 static const struct msi_parent_ops amdvi_msi_parent_ops =3D {
 	.supported_flags	=3D X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_=
MSI,
+	.bus_select_token	=3D DOMAIN_BUS_AMDVI,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
 	.prefix			=3D "IR-",
 	.init_dev_msi_info	=3D msi_parent_init_dev_msi_info,
 };
=20
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
-	struct fwnode_handle *fn;
+	struct irq_domain_info info =3D {
+		.fwnode		=3D irq_domain_alloc_named_id_fwnode("AMD-IR", iommu->index),
+		.ops		=3D &amd_ir_domain_ops,
+		.domain_flags	=3D IRQ_DOMAIN_FLAG_ISOLATED_MSI,
+		.host_data	=3D iommu,
+		.parent		=3D arch_get_ir_parent_domain(),
+	};
=20
-	fn =3D irq_domain_alloc_named_id_fwnode("AMD-IR", iommu->index);
-	if (!fn)
+	if (!info.fwnode)
 		return -ENOMEM;
-	iommu->ir_domain =3D irq_domain_create_hierarchy(arch_get_ir_parent_domai=
n(), 0, 0,
-						       fn, &amd_ir_domain_ops, iommu);
+
+	iommu->ir_domain =3D msi_create_parent_irq_domain(&info, &amdvi_msi_paren=
t_ops);
 	if (!iommu->ir_domain) {
-		irq_domain_free_fwnode(fn);
+		irq_domain_free_fwnode(info.fwnode);
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
-	iommu->ir_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT |
-				   IRQ_DOMAIN_FLAG_ISOLATED_MSI;
-	iommu->ir_domain->msi_parent_ops =3D &amdvi_msi_parent_ops;
-
 	return 0;
 }
=20
--=20
2.39.5

