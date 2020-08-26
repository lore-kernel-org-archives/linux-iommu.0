Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146BC433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27BE20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcZtqL4l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K2Lxyzsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27BE20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEE0A8659E;
	Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id drSBou2mqRoB; Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44AA286511;
	Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30321C07FF;
	Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2C70C0893
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BAC5486AFE
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jsr+b2vMfpuN for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9F40F86A70
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:05 +0000 (UTC)
Message-Id: <20200826112331.343103175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=yUak3m0NwlqIqsF9vwdOVEDgjCYRdAN21F8d0mSMKGQ=;
 b=CcZtqL4lvptBr6O8tkmhEQLyN2lRF7B9yfOWJiZHdO44k0wdGsKpl6eWdq06TDejigd6ob
 JDCD52HZX+tsL5/rUPRGCwvIyqDA9zwUQ2VDiaoYgWK0cvpU2nAZUW+oVwywZr9FEINxUi
 VPGA2iy3zrIyWLUAGs4V3oB5DonOhA2FxuFQIi3d7LuHT+Gama3dCMZ8JahfFfHkRfxJm7
 D5UltiIvHeZ+/SpaNlhpYmHQ8lJWZdq24exfT4lKNQ2AeVtmjerFG05h04YY3WFDo4H3z5
 aBwORx/I0HI+GncAXRYaJ2j9Pv6KAcTg9Xj39PuKxCKBAvV3TCHZdRxCwy5kqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=yUak3m0NwlqIqsF9vwdOVEDgjCYRdAN21F8d0mSMKGQ=;
 b=K2Lxyzsd9n0HFLhQ7NLh5Km/SSUSbbyJ7SJ4NwtKLHNFB2UnCTgLYIOtfVN93n9DYdKBau
 Z3yoeEu2w5MuXuDg==
Date: Wed, 26 Aug 2020 13:16:35 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 07/46] x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect
 PCI dependency
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

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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
