Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B62C433E5
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A6A20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3vMcCO5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaLcOn7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A6A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA9A886EC8;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+1h9eVpGvIg; Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0974581DF8;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E920BC07FF;
	Wed, 26 Aug 2020 12:01:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A700C088B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 209B7868E1
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q91KYIFyJme5 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1CFD88685B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:39 +0000 (UTC)
Message-Id: <20200826112333.992429909@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=uyV0Ooe8la51Jnp77nt5kHoXNowVvxYDrd/gBP6ezcA=;
 b=r3vMcCO5kVJoLxyaJXMRvQSRf0p5/OGnF/WKafYbVkxf73vWkXM4WpLDagC8RIussDA9FA
 Z87sCOntwSOkvEvcfa23hhyGS8N5+rQKjn6N3DXV6zRu0SehipqRnVtQk6thMW0cRHJCQw
 s6AbtG7QZZjCDyVIZe4sremiWbKPKkkBZWJYYVYg0y/0R/DJTubkggNm9bF6bhi1Fr+VS6
 esCTxRDlbM7pOE9L9f87wTeSuQe5JVr7e7G21g7yr4MP/PrrJgmbkFGYfMRYmdSx5MnKFS
 Jhhm7doKaaGdC0Vxt7yUbhc4feRODqr8cyK4hlcJdNzQKlaHb+b9BtpLWbDUQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=uyV0Ooe8la51Jnp77nt5kHoXNowVvxYDrd/gBP6ezcA=;
 b=OaLcOn7vpa94RSWbulmNHe5y7ULz7MCbpuIZVBMKBxG+dioNO9BaYdtsZsuaf5DNzpPKZr
 aa38DKgbmHeoijDw==
Date: Wed, 26 Aug 2020 13:17:02 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thomas Gleixner <tglx@linutronix.de>

The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
requires them or not. Architectures which are fully utilizing hierarchical
irq domains should never call into that code.

It's not only architectures which depend on that by implementing one or
more of the weak functions, there is also a bunch of drivers which relies
on the weak functions which invoke msi_controller::setup_irq[s] and
msi_controller::teardown_irq.

Make the architectures and drivers which rely on them select them in Kconfig
and if not selected replace them by stub functions which emit a warning and
fail the PCI/MSI interrupt allocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Make the architectures (and drivers) which need the fallbacks select them
    and not the other way round (Bjorn).
---
 arch/ia64/Kconfig              |    1 +
 arch/mips/Kconfig              |    1 +
 arch/powerpc/Kconfig           |    1 +
 arch/s390/Kconfig              |    1 +
 arch/sparc/Kconfig             |    1 +
 arch/x86/Kconfig               |    1 +
 drivers/pci/Kconfig            |    3 +++
 drivers/pci/controller/Kconfig |    3 +++
 drivers/pci/msi.c              |    3 ++-
 include/linux/msi.h            |   31 ++++++++++++++++++++++++++-----
 10 files changed, 40 insertions(+), 6 deletions(-)

--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -56,6 +56,7 @@ config IA64
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select NUMA if !FLATMEM
+	select PCI_MSI_ARCH_FALLBACKS
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -86,6 +86,7 @@ config MIPS
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
+	select PCI_MSI_ARCH_FALLBACKS
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_SYSCALL			if PCI
 	select PPC_DAWR				if PPC64
 	select RTC_LIB
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,6 +185,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC
 	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select PCI_SYSCALL if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
+	select PCI_MSI_ARCH_FALLBACKS
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -56,6 +56,9 @@ config PCI_MSI_IRQ_DOMAIN
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
+config PCI_MSI_ARCH_FALLBACKS
+	bool
+
 config PCI_QUIRKS
 	default y
 	bool "Enable PCI quirk workarounds" if EXPERT
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -41,6 +41,7 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -67,6 +68,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
@@ -103,6 +105,7 @@ config PCIE_XILINX_CPM
 	bool "Xilinx Versal CPM host bridge support"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	select PCI_HOST_COMMON
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -58,8 +58,8 @@ static void pci_msi_teardown_msi_irqs(st
 #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
 #endif
 
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /* Arch hooks */
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_controller *chip = dev->bus->msi;
@@ -132,6 +132,7 @@ void __weak arch_teardown_msi_irqs(struc
 {
 	return default_teardown_msi_irqs(dev);
 }
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
 void pci_msi_unmask_irq(struct irq_data *data);
 
 /*
- * The arch hooks to setup up msi irqs. Those functions are
- * implemented as weak symbols so that they /can/ be overriden by
- * architecture specific code if needed.
+ * The arch hooks to setup up msi irqs. Default functions are implemented
+ * as weak symbols so that they /can/ be overriden by architecture specific
+ * code if needed. These hooks must be enabled by the architecture or by
+ * drivers which depend on them via msi_controller based MSI handling.
+ *
+ * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
+ * stubs with warnings.
  */
+#ifdef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-void arch_restore_msi_irqs(struct pci_dev *dev);
-
 void default_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
+/*
+ * The restore hooks are still available as they are useful even
+ * for fully irq domain based setups. Courtesy to XEN/X86.
+ */
+void arch_restore_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
 struct msi_controller {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
