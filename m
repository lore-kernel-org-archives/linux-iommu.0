Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE89C43458
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0F121775
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEmgTzBx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+P8E/4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0F121775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D1CB988606;
	Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7bbQpdXAEv5; Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 555FE885E7;
	Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA07C0889;
	Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF75C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B70486CF9
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poLlQY3vgh-T for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F21786CD7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:22 +0000 (UTC)
Message-Id: <20200821002948.664301259@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=IwU9izKFyrpGzvPqUYbXOT7wStkGGFUidxtSyI7gSuU=;
 b=BEmgTzBxRO6uP/nQragORSfmUBwF9g5jAN8GwWNyIDqCY4t9h3ubI9++1vqwr8KU9IbZLO
 p10e+l66E+ryn4Ttlv8e/y2BBV7V+gjAbAuCb1GFvddNAGXqQChjTpRKq59SWiJZXpfZov
 jFshF4WsVdOngCAm3eagjJnbmGf9AGKSdFN0+AlyAkysQTGaD26h6xR6sSFnWKMkmNNiyX
 H0B2uy0Y4GfLOEL62Z00xUZqtRMKBpIUPpxUPgTf8Bp78w+wI4nVXHV5xQE1J39tbV6jKL
 MrW0YTdmu4U3XmeAtdJSVC5lYS5hw8biIfLfcbKqGDhb/BSiRo5tRLn9JtrWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=IwU9izKFyrpGzvPqUYbXOT7wStkGGFUidxtSyI7gSuU=;
 b=T+P8E/4ofySSwCHEUhHzxsNh0HImJ7FPAu6EkeURZr78qBWqiOVLSSqiG1nrI+PJMJvkx8
 Dwt9OYTzDoUQoeCw==
Date: Fri, 21 Aug 2020 02:24:58 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI MSI
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-msi--Let-pci_msi_prepare---handle-non-PCI-MSI.patch"
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

Rename it to x86_msi_prepare() and handle the allocation type setup
depending on the device type.

Add a new arch_msi_prepare define which will be utilized by the upcoming
device MSI support. Define it to NULL if not provided by an architecture in
the generic MSI header.

One arch specific function for MSI support is truly enough.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
---
 arch/x86/include/asm/msi.h          |    4 +++-
 arch/x86/kernel/apic/msi.c          |   27 ++++++++++++++++++++-------
 drivers/pci/controller/pci-hyperv.c |    2 +-
 include/linux/msi.h                 |    4 ++++
 4 files changed, 28 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -6,7 +6,9 @@
 
 typedef struct irq_alloc_info msi_alloc_info_t;
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
+#define arch_msi_prepare		x86_msi_prepare
+
 #endif /* _ASM_X86_MSI_H */
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -182,26 +182,39 @@ static struct irq_chip pci_msi_controlle
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+static void pci_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
+	struct msi_desc *desc = first_msi_entry(dev);
 
-	init_irq_alloc_info(arg, NULL);
 	if (desc->msi_attrib.is_msix) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 	}
+}
+
+static void dev_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
+{
+	arg->type = X86_IRQ_ALLOC_TYPE_DEV_MSI;
+}
+
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	init_irq_alloc_info(arg, NULL);
+
+	if (dev_is_pci(dev))
+		pci_msi_prepare(dev, arg);
+	else
+		dev_msi_prepare(dev, arg);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
+EXPORT_SYMBOL_GPL(x86_msi_prepare);
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= x86_msi_prepare,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1532,7 +1532,7 @@ static struct irq_chip hv_msi_irq_chip =
 };
 
 static struct msi_domain_ops hv_msi_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= arch_msi_prepare,
 	.msi_free	= hv_msi_free,
 };
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -430,4 +430,8 @@ static inline struct irq_domain *pci_msi
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
+#ifndef arch_msi_prepare
+# define arch_msi_prepare	NULL
+#endif
+
 #endif /* LINUX_MSI_H */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
