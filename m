Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E81C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C2E221E2
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yBa1jZyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+rqdbCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C2E221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E3D9822843;
	Wed, 26 Aug 2020 12:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7RUCobGacGZ; Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BB2702279B;
	Wed, 26 Aug 2020 12:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A67EEC07FF;
	Wed, 26 Aug 2020 12:01:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6BE4C0891
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE08C87C11
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8nRE49cfZGO for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 017A886D2D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
Message-Id: <20200826112331.157603198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=6S+VPwjCO4/0/sg5O/D8yGF7mUxRzB6iCmAEo7WLFeY=;
 b=yBa1jZyq19hlxKFJk3xxqm7DyS+GDm5bb0xsGOflfAgTKxIfxMWsOquHJO8oAmDg57DS2O
 lOd5gVhWE33CpyLZ98lEY6XLD8VUMPfnergrf924inK2Y0VoOUDpqLwrNon8BZkDdz3+RZ
 yX47Hb4PiDkN+/QsBNEh9UPVPiX3u0mN3awXLTF4/59iOyWlV4bQiBwP1s4Iy1rkRwPWcl
 0sRWk8UdH9fpJKD4wOajIaX4OIEMEwGSfYibyYvgtipQmWu1nChRU0L9O3ofQCESFnO2r0
 /O1UWsUyXWAh1MgcFvs4LyhV7tN+dM6a3oK2zVsEshW1p5maB74zT8l4pFyB8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=6S+VPwjCO4/0/sg5O/D8yGF7mUxRzB6iCmAEo7WLFeY=;
 b=X+rqdbCzEwcm50ULD6Yd1kuRe0Xhd7Md4D5DV2hlhjFcxaDeRH1iXqy0ovLxzi9/fl9LUK
 RmgSqOyBQ/HmJiAQ==
Date: Wed, 26 Aug 2020 13:16:33 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 05/46] x86/msi: Move compose message callback where it
 belongs
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

Composing the MSI message at the MSI chip level is wrong because the
underlying parent domain is the one which knows how the message should be
composed for the direct vector delivery or the interrupt remapping table
entry.

The interrupt remapping aware PCI/MSI chip does that already. Make the
direct delivery chip do the same and move the composition of the direct
delivery MSI message to the vector domain irq chip.

This prepares for the upcoming device MSI support to avoid having
architecture specific knowledge in the device MSI domain irq chips.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/apic.h   |    8 ++++++++
 arch/x86/kernel/apic/msi.c    |   12 +++---------
 arch/x86/kernel/apic/vector.c |    1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -519,6 +519,14 @@ static inline bool apic_id_is_primary_th
 static inline void apic_smt_update(void) { }
 #endif
 
+struct msi_msg;
+
+#ifdef CONFIG_PCI_MSI
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
+#else
+# define x86_vector_msi_compose_msg NULL
+#endif
+
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,7 @@ static void __irq_msi_compose_msg(struct
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	__irq_msi_compose_msg(irqd_cfg(data), msg);
 }
@@ -177,7 +177,6 @@ static struct irq_chip pci_msi_controlle
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -321,7 +320,6 @@ static struct irq_chip dmar_msi_controll
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -419,7 +417,6 @@ static struct irq_chip hpet_msi_controll
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg = irq_msi_compose_msg,
 	.irq_write_msi_msg = hpet_msi_write_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
@@ -479,13 +476,10 @@ struct irq_domain *hpet_create_irq_domai
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL) {
+	if (parent == NULL)
 		parent = x86_vector_domain;
-	} else {
+	else
 		hpet_msi_controller.name = "IR-HPET-MSI";
-		/* Temporary fix: Will go away */
-		hpet_msi_controller.irq_compose_msi_msg = NULL;
-	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -823,6 +823,7 @@ static struct irq_chip lapic_controller
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
 	.irq_set_affinity	= apic_set_affinity,
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
 	.irq_retrigger		= apic_retrigger_irq,
 };
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
