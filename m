Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA70CC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA75207DE
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CRPY34ws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1mwLj/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA75207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A9DE87C41;
	Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzCAtHqK8M+2; Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03591875D8;
	Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3DB5C0889;
	Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C72C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 33FA287B8A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PX5Lp-A7nbdI for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 64EF8875D8
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:51 +0000 (UTC)
Message-Id: <20200821002946.199183502@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=LD6OVvQs2U2JxX8J9pridpcS80uuUDIg27lgsrj0jJs=;
 b=CRPY34wsllTNZMQTzfHmC/bLHmFNZXjHc+0vQh0jeY9ITWlQkym0opheyN3NRcJzqcHOHJ
 CHYIqTYZnqVkKhqquuh188LHjPQFzKMfNrO+snIxPPWKQHiLK+ffsxMsoZeHe/B7v7XYe1
 cuX+NpQi1A5/Fn9vaxG6S4sQEy2wWp/f0oSqiYk8YMYh4elYHLer7qbYCPC3rl0B22A3VR
 IBhB65J+18B/Q+XGqIP+UGfvuxgjrDZI3JTqMOLBOAyMqwHK6lpU6ycapbGUGOhUJ344mt
 mOddcRhnigyA+N6yWvrsLa/OfC2BK/FfFxuYvQ3K4jmg3nZpKhQi+wwt8N0wTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=LD6OVvQs2U2JxX8J9pridpcS80uuUDIg27lgsrj0jJs=;
 b=Z1mwLj/mwBnb8I7ynjxugLR+zpH4uYwTS4gNXm22EbrWp72HpLuVIP3cf5+ahajpToHJme
 X3mObWebjp/vVZDA==
Date: Fri, 21 Aug 2020 02:24:33 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 09/38] x86/msi: Consolidate HPET allocation
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-msi--Consolidate-HPET-allocation.patch"
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

None of the magic HPET fields are required in any way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h       |    7 -------
 arch/x86/kernel/apic/msi.c          |   14 +++++++-------
 drivers/iommu/amd/iommu.c           |    2 +-
 drivers/iommu/intel/irq_remapping.c |    4 ++--
 4 files changed, 10 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -65,13 +65,6 @@ struct irq_alloc_info {
 
 	union {
 		int		unused;
-#ifdef	CONFIG_HPET_TIMER
-		struct {
-			int		hpet_id;
-			int		hpet_index;
-			void		*hpet_data;
-		};
-#endif
 #ifdef	CONFIG_PCI_MSI
 		struct {
 			struct pci_dev	*msi_dev;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -427,7 +427,7 @@ static struct irq_chip hpet_msi_controll
 static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->hpet_index;
+	return arg->hwirq;
 }
 
 static int hpet_msi_init(struct irq_domain *domain,
@@ -435,8 +435,8 @@ static int hpet_msi_init(struct irq_doma
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
 	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hpet_index, info->chip, NULL,
-			    handle_edge_irq, arg->hpet_data, "edge");
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -477,7 +477,7 @@ struct irq_domain *hpet_create_irq_domai
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.hpet_id = hpet_id;
+	info.devid = hpet_id;
 	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
@@ -506,9 +506,9 @@ int hpet_assign_irq(struct irq_domain *d
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_data = hc;
-	info.hpet_id = hpet_dev_id(domain);
-	info.hpet_index = dev_num;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3511,7 +3511,7 @@ static int get_devid(struct irq_alloc_in
 		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return get_hpet_devid(info->hpet_id);
+		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return get_device_id(&info->msi_dev->dev);
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1115,7 +1115,7 @@ static struct irq_domain *intel_get_irq_
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		return map_ioapic_to_ir(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return map_hpet_to_ir(info->hpet_id);
+		return map_hpet_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return map_dev_to_ir(info->msi_dev);
@@ -1285,7 +1285,7 @@ static void intel_irq_remapping_prepare_
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->hpet_id);
+			set_hpet_sid(irte, info->devid);
 		else
 			set_msi_sid(irte, info->msi_dev);
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
