Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC3DC433E5
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9054A2177B
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5Zw6T7F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vc2HTal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9054A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5989920034;
	Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BbTrDzhCAFV8; Fri, 21 Aug 2020 02:16:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C4B0B22E6E;
	Fri, 21 Aug 2020 02:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB7FEC0895;
	Fri, 21 Aug 2020 02:16:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79F7C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A694E88690
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kID5AU98DxWR for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A286A8868A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:43 +0000 (UTC)
Message-Id: <20200821002945.595723096@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=aZajyY2bgQUgD6w0Oy2gZDy5W+Nr6UhttbpOe6imkbA=;
 b=z5Zw6T7F6WO9tHaOZCWjbBUxhqTz80VOEZ80VDKul4uGQaropOgQb6BcKPfj/9Wlvj5p+r
 OP36RCtabudX4KoYj9f608pdj9pLU9TRu1Q3jtMOtO2cYjb9lxPGXC6A8Lyaz2v72ig0o8
 84sWINgu7TugbF6XX7w85aAfwgzIeXnvMNqvoAI/8Eq1C3pkfYf6UrIPEz0UbebgaIlkom
 eLiT4D2PzUU0fqRqXin5XBuzprxYDvLYrh1l2/kyVxDcs0G9GpxWgzhl5sC/gcvvvzfgGq
 tBUculjkto8xPUOMY648x8PhGxobEoviHKsPdc7al8ctqVpYclUAG75TwMSj7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=aZajyY2bgQUgD6w0Oy2gZDy5W+Nr6UhttbpOe6imkbA=;
 b=2vc2HTalu8tDHI7RloIWqmjANph7va74Zeuk1d1Pk4AqNK9Vj801oDy0Rg8AK4F2IiwyPc
 a3lZ5AHBdtqfsYBg==
Date: Fri, 21 Aug 2020 02:24:27 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 03/38] x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect
 PCI dependency
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline; filename="x86-irq--Rename-X86_IRQ_ALLOC_TYPE_MSI"
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

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 arch/x86/include/asm/hw_irq.h       |    4 ++--
 arch/x86/kernel/apic/msi.c          |    6 +++---
 drivers/iommu/amd/iommu.c           |   24 ++++++++++++------------
 drivers/iommu/intel/irq_remapping.c |   18 +++++++++---------
 4 files changed, 26 insertions(+), 26 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -36,8 +36,8 @@ struct msi_desc;
 enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_IOAPIC = 1,
 	X86_IRQ_ALLOC_TYPE_HPET,
-	X86_IRQ_ALLOC_TYPE_MSI,
-	X86_IRQ_ALLOC_TYPE_MSIX,
+	X86_IRQ_ALLOC_TYPE_PCI_MSI,
+	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
 };
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -188,7 +188,7 @@ int native_setup_msi_irqs(struct pci_dev
 	struct irq_alloc_info info;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_MSI;
+	info.type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 	info.msi_dev = dev;
 
 	domain = irq_remapping_get_irq_domain(&info);
@@ -220,9 +220,9 @@ int pci_msi_prepare(struct irq_domain *d
 	init_irq_alloc_info(arg, NULL);
 	arg->msi_dev = pdev;
 	if (desc->msi_attrib.is_msix) {
-		arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
-		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 	}
 
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3514,8 +3514,8 @@ static int get_devid(struct irq_alloc_in
 	case X86_IRQ_ALLOC_TYPE_HPET:
 		devid     = get_hpet_devid(info->hpet_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		devid = get_device_id(&info->msi_dev->dev);
 		break;
 	default:
@@ -3553,8 +3553,8 @@ static struct irq_domain *get_irq_domain
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		devid = get_device_id(&info->msi_dev->dev);
 		if (devid < 0)
 			return NULL;
@@ -3615,8 +3615,8 @@ static void irq_remapping_prepare_irte(s
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		msg->address_hi = MSI_ADDR_BASE_HI;
 		msg->address_lo = MSI_ADDR_BASE_LO;
 		msg->data = irte_info->index;
@@ -3660,15 +3660,15 @@ static int irq_remapping_alloc(struct ir
 
 	if (!info)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
+	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
 	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
 	devid = get_devid(info);
@@ -3700,9 +3700,9 @@ static int irq_remapping_alloc(struct ir
 		} else {
 			index = -ENOMEM;
 		}
-	} else if (info->type == X86_IRQ_ALLOC_TYPE_MSI ||
-		   info->type == X86_IRQ_ALLOC_TYPE_MSIX) {
-		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
+	} else if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI ||
+		   info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX) {
+		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
 		index = alloc_irq_index(devid, nr_irqs, align, info->msi_dev);
 	} else {
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1115,8 +1115,8 @@ static struct irq_domain *intel_get_ir_i
 	case X86_IRQ_ALLOC_TYPE_HPET:
 		iommu = map_hpet_to_ir(info->hpet_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		iommu = map_dev_to_ir(info->msi_dev);
 		break;
 	default:
@@ -1135,8 +1135,8 @@ static struct irq_domain *intel_get_irq_
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		iommu = map_dev_to_ir(info->msi_dev);
 		if (iommu)
 			return iommu->ir_msi_domain;
@@ -1306,8 +1306,8 @@ static void intel_irq_remapping_prepare_
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
 			set_hpet_sid(irte, info->hpet_id);
 		else
@@ -1362,15 +1362,15 @@ static int intel_irq_remapping_alloc(str
 
 	if (!info || !iommu)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
+	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
 	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
