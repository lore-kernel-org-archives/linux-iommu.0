Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25446C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00FC21744
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQo5o0E2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRfXUkkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00FC21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4C6F86CF6;
	Fri, 21 Aug 2020 02:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGggpg8EuhOc; Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6758386CE0;
	Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6114FC0889;
	Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF79C08A2
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 071C723042
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id boHuV-1de2Ev for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F40D22E96
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:02 +0000 (UTC)
Message-Id: <20200821002947.075507468@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=R6JxsviuQwbwX1XcXkkzKQyT+T09StpqXEtTQLkEikY=;
 b=DQo5o0E2WeO60HEbPpznUfv/fyHaZz6TzI8gYCMBjgqs4f3s7extmvfXyO7EAhTksKFRKq
 mvtWArIM2U1VOhePfnms1RYw8XDK9WpqVobucAP6JaquG3rVNS2CLVdbHu/TBc3qsigxVg
 uHbxWuIZd26AsH63CUHieyPhvEjiStO37f1hYv54ZnHBkcQKk6bzmSD7/A/Fxdkkb/Syij
 YxqKenD82ZQdMn2h5p5d73A+PqERU4aI52sNyvm88zGFFhHt0oeiD1bMCVY5n3i8KBw+kn
 t0SxvyiQ+H8LfApRgesHYdyXcQ/KzNm81G0Ix1yA/VCHh/asmwD6xUUwXIf3EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=R6JxsviuQwbwX1XcXkkzKQyT+T09StpqXEtTQLkEikY=;
 b=BRfXUkkOYf/yCGZZ1rSc74TlbnMx60yjOLHMFdtEViH1OQED5w/ZEnmHNmx+f/pGQQFIDh
 05oW78opN0GrQEDA==
Date: Fri, 21 Aug 2020 02:24:42 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 18/38] x86/irq: Initialize PCI/MSI domain at PCI init time
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-irq--Initialize-PCI-MSI-domain-at-PCI-init-time.patch"
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
 Jonathan Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
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

No point in initializing the default PCI/MSI interrupt domain early and no
point to create it when XEN PV/HVM/DOM0 are active.

Move the initialization to pci_arch_init() and convert it to init ops so
that XEN can override it as XEN has it's own PCI/MSI management. The XEN
override comes in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/irqdomain.h |    6 ++++--
 arch/x86/include/asm/x86_init.h  |    3 +++
 arch/x86/kernel/apic/msi.c       |   26 ++++++++++++++++----------
 arch/x86/kernel/apic/vector.c    |    2 --
 arch/x86/kernel/x86_init.c       |    3 ++-
 arch/x86/pci/init.c              |    3 +++
 6 files changed, 28 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -51,9 +51,11 @@ extern int mp_irqdomain_ioapic_idx(struc
 #endif /* CONFIG_X86_IO_APIC */
 
 #ifdef CONFIG_PCI_MSI
-extern void arch_init_msi_domain(struct irq_domain *domain);
+void x86_create_pci_msi_domain(void);
+struct irq_domain *native_create_pci_msi_domain(void);
 #else
-static inline void arch_init_msi_domain(struct irq_domain *domain) { }
+static inline void x86_create_pci_msi_domain(void) { }
+#define native_create_pci_msi_domain	NULL
 #endif
 
 #endif
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -8,6 +8,7 @@ struct mpc_bus;
 struct mpc_cpu;
 struct mpc_table;
 struct cpuinfo_x86;
+struct irq_domain;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
@@ -42,12 +43,14 @@ struct x86_init_resources {
  * @intr_init:			interrupt init code
  * @intr_mode_select:		interrupt delivery mode selection
  * @intr_mode_init:		interrupt delivery mode setup
+ * @create_pci_msi_domain:	Create the PCI/MSI interrupt domain
  */
 struct x86_init_irqs {
 	void (*pre_vector_init)(void);
 	void (*intr_init)(void);
 	void (*intr_mode_select)(void);
 	void (*intr_mode_init)(void);
+	struct irq_domain *(*create_pci_msi_domain)(void);
 };
 
 /**
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *msi_default_domain;
+static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
@@ -192,7 +192,7 @@ int native_setup_msi_irqs(struct pci_dev
 
 	domain = irq_remapping_get_irq_domain(&info);
 	if (domain == NULL)
-		domain = msi_default_domain;
+		domain = x86_pci_msi_default_domain;
 	if (domain == NULL)
 		return -ENOSYS;
 
@@ -243,25 +243,31 @@ static struct msi_domain_info pci_msi_do
 	.handler_name	= "edge",
 };
 
-void __init arch_init_msi_domain(struct irq_domain *parent)
+struct irq_domain * __init native_create_pci_msi_domain(void)
 {
 	struct fwnode_handle *fn;
+	struct irq_domain *d;
 
 	if (disable_apic)
-		return;
+		return NULL;
 
 	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
 	if (fn) {
-		msi_default_domain =
-			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-						  parent);
+		d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
+					      x86_vector_domain);
 	}
-	if (!msi_default_domain) {
+	if (!d) {
 		irq_domain_free_fwnode(fn);
-		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
 	} else {
-		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
+	return d;
+}
+
+void __init x86_create_pci_msi_domain(void)
+{
+	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
 #ifdef CONFIG_IRQ_REMAP
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -713,8 +713,6 @@ int __init arch_early_irq_init(void)
 	BUG_ON(x86_vector_domain == NULL);
 	irq_set_default_host(x86_vector_domain);
 
-	arch_init_msi_domain(x86_vector_domain);
-
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
 	/*
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -76,7 +76,8 @@ struct x86_init_ops x86_init __initdata
 		.pre_vector_init	= init_ISA_irqs,
 		.intr_init		= native_init_IRQ,
 		.intr_mode_select	= apic_intr_mode_select,
-		.intr_mode_init		= apic_intr_mode_init
+		.intr_mode_init		= apic_intr_mode_init,
+		.create_pci_msi_domain	= native_create_pci_msi_domain,
 	},
 
 	.oem = {
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <asm/pci_x86.h>
 #include <asm/x86_init.h>
+#include <asm/irqdomain.h>
 
 /* arch_initcall has too random ordering, so call the initializers
    in the right sequence from here. */
@@ -10,6 +11,8 @@ static __init int pci_arch_init(void)
 {
 	int type;
 
+	x86_create_pci_msi_domain();
+
 	type = pci_direct_probe();
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
