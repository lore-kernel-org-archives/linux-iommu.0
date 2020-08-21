Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043BC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F4C207BB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hduGjMZb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="54vZUbSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F4C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CD64D88693;
	Fri, 21 Aug 2020 02:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UW4cflKaZlTM; Fri, 21 Aug 2020 02:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14EE68869C;
	Fri, 21 Aug 2020 02:16:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED797C0895;
	Fri, 21 Aug 2020 02:16:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04BE5C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E84F686CD4
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtUii8IaX-TY for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FAE486CC1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:45 +0000 (UTC)
Message-Id: <20200821002945.695825784@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=n+9JzjgCW829xt57cBjdIpc/3IF3JudgknsVK2IiGtk=;
 b=hduGjMZbM0/qwLquCj86fWVEcSBPc0Iv1xA1asxyvWI+3WaJk/FZv3obiS9pdKi2N4Xi55
 g2B24e5RBCG7WKFAQnorS3FWxwuVXn4z6S30wQ9GCVD8rtp+77IWCQCGVnhsf3znLjLhSM
 aQmZw2lG8elAmC//IGUjNVWAb+xaLL0KKz9IZ14ZS5Czuz7wC08nu5Y+pBKinVQ49JiyCU
 CXbMGhzaoeBIvlaaHMr23nvutvRUEOUuFrM649Lo5JGWcrMEOw972tIYLaoecwN/uLHyl2
 R6g+Wh1VCvbaQYIhXKJhJnK8aiSLIDvD0enema4nF0KLI5Yj7n1BELeKwzCgbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=n+9JzjgCW829xt57cBjdIpc/3IF3JudgknsVK2IiGtk=;
 b=54vZUbSCVLbmLl/kEHzdwLB30JzHXmmLwe5GfkEeAMeKUbcsXnsiboZQzVlzf/vQeQ28JW
 WkKbSmHVLKTXoHDw==
Date: Fri, 21 Aug 2020 02:24:28 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 04/38] x86/irq: Add allocation type for parent domain
 retrieval
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-irq--Add-allocation-flag-for-domain-retrieval.patch"
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

irq_remapping_ir_irq_domain() is used to retrieve the remapping parent
domain for an allocation type. irq_remapping_irq_domain() is for retrieving
the actual device domain for allocating interrupts for a device.

The two functions are similar and can be unified by using explicit modes
for parent irq domain retrieval.

Add X86_IRQ_ALLOC_TYPE_IOAPIC/HPET_GET_PARENT and use it in the iommu
implementations. Drop the parent domain retrieval for PCI_MSI/X as that is
unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h       |    2 ++
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 arch/x86/kernel/apic/msi.c          |    2 +-
 drivers/iommu/amd/iommu.c           |    8 ++++++++
 drivers/iommu/hyperv-iommu.c        |    2 +-
 drivers/iommu/intel/irq_remapping.c |    8 ++------
 6 files changed, 15 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -40,6 +40,8 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
+	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
 struct irq_alloc_info {
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2296,7 +2296,7 @@ static int mp_irqdomain_create(int ioapi
 		return 0;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC;
+	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (!parent)
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -476,7 +476,7 @@ struct irq_domain *hpet_create_irq_domai
 	domain_info->data = (void *)(long)hpet_id;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (parent == NULL)
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3534,6 +3534,14 @@ static struct irq_domain *get_ir_irq_dom
 	if (!info)
 		return NULL;
 
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		break;
+	default:
+		return NULL;
+	}
+
 	devid = get_devid(info);
 	if (devid >= 0) {
 		iommu = amd_iommu_rlookup_table[devid];
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -184,7 +184,7 @@ static int __init hyperv_enable_irq_rema
 
 static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
 {
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
 	else
 		return NULL;
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1109,16 +1109,12 @@ static struct irq_domain *intel_get_ir_i
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC:
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		iommu = map_ioapic_to_ir(info->ioapic_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_HPET:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		iommu = map_hpet_to_ir(info->hpet_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		break;
 	default:
 		BUG_ON(1);
 		break;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
