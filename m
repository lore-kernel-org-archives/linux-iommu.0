Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F4C433EB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F464207BB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhEvEN53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHm30rz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F464207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2882E22F26;
	Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnqB0SHvHegd; Fri, 21 Aug 2020 02:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB5B723018;
	Fri, 21 Aug 2020 02:17:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9B77C0894;
	Fri, 21 Aug 2020 02:17:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44AF6C0889
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 178EB88607
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gFIKdnMCys36 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E56BB885FB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:18 +0000 (UTC)
Message-Id: <20200821002948.379447552@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=/s0W3ueaG6RtDzEeGUOI0RGBVruM5KofEMx/9DI9MLQ=;
 b=lhEvEN53FVmm7WaATrlbrU5ndLFii2LKbFg5sOWGT7H+n7al6/w9HhdVruRVrDYtOIEFMv
 JDlX8SKzQY5EyF2uM472V9qjU3IMvsqzbOWjOd6lcSAS2lis/6p6/43NObKcwJMcaROLRT
 isNBG1VfW+VhAscmgCqMl6CbeQFaiqBUuhrbm4zGR06CHqJiGmm5tFrJul177II1iXHN6U
 JqiLxD/1koJNOnYePuc93IRS5OQ3wiHQUabnterO5JENke8VWJNXDg7Kxk4q9L0IZdzV8Z
 kO1OfD/dFzMjxmvoxXA6WcJ00IcS9QOm0WtLGabMefC5f/FLnv7iSqVJmJfmxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=/s0W3ueaG6RtDzEeGUOI0RGBVruM5KofEMx/9DI9MLQ=;
 b=QHm30rz5+fz6MVN5gJxMivl2CwMWIfo/V05Ng5lEi8dMBMkPwGvNfN6ORhWZ6ka1Rkg62S
 pVIbqqFvU832pWBw==
Date: Fri, 21 Aug 2020 02:24:55 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 31/38] x86/irq: Cleanup the arch_*_msi_irqs() leftovers
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-irq--Cleanup-the-arch_msi_irqs-leftovers.patch"
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

Get rid of all the gunk and enable CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: linux-pci@vger.kernel.org
---
 arch/x86/Kconfig                |    1 +
 arch/x86/include/asm/pci.h      |   11 -----------
 arch/x86/include/asm/x86_init.h |    1 -
 arch/x86/kernel/apic/msi.c      |   22 ----------------------
 arch/x86/kernel/x86_init.c      |   18 ------------------
 arch/x86/pci/xen.c              |    7 -------
 6 files changed, 1 insertion(+), 59 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
+	select PCI_MSI_DISABLE_ARCH_FALLBACKS
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -105,17 +105,6 @@ static inline void early_quirks(void) {
 
 extern void pci_iommu_alloc(void);
 
-#ifdef CONFIG_PCI_MSI
-/* implemented in arch/x86/kernel/apic/io_apic. */
-struct msi_desc;
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void native_teardown_msi_irq(unsigned int irq);
-void native_restore_msi_irqs(struct pci_dev *dev);
-#else
-#define native_setup_msi_irqs		NULL
-#define native_teardown_msi_irq		NULL
-#endif
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -277,7 +277,6 @@ struct pci_dev;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irq)(unsigned int irq);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -182,28 +182,6 @@ static struct irq_chip pci_msi_controlle
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-
-	domain = irq_remapping_get_irq_domain(&info);
-	if (domain == NULL)
-		domain = x86_pci_msi_default_domain;
-	if (domain == NULL)
-		return -ENOSYS;
-
-	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-}
-
-void native_teardown_msi_irq(unsigned int irq)
-{
-	irq_domain_free_irqs(irq, 1);
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -145,28 +145,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi __ro_after_init = {
-	.setup_msi_irqs		= native_setup_msi_irqs,
-	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
 
 /* MSI arch specific hooks */
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-
 void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -401,11 +401,6 @@ static void xen_pv_teardown_msi_irqs(str
 	xen_teardown_msi_irqs(dev);
 }
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	WARN_ON_ONCE(1);
-}
-
 static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 				     struct device *dev,  int nvec)
 {
@@ -482,8 +477,6 @@ static __init void xen_setup_pci_msi(voi
 		return;
 	}
 
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-
 	/*
 	 * Override the PCI/MSI irq domain init function. No point
 	 * in allocating the native domain and never use it.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
