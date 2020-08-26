Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032DC433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17D120838
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snoRszRW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkWzhAcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17D120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 93F4586BB7;
	Wed, 26 Aug 2020 12:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWdnq5StvXGJ; Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E67E986AFE;
	Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC783C0893;
	Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1B0AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AAC9A82476
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x64IXVR4FdYa for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8FF5B87EC4
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:10 +0000 (UTC)
Message-Id: <20200826112331.741909337@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=AgqtG7FWGG/aGAFBHu5WBpbnYbeqKy2fMcz2CwAcWys=;
 b=snoRszRWXNTq8lUaP7yhojk4htjebRsW3YGR8fE9Gmfx4qVobtdoAr26AWBP7qIQpliA4f
 7aFa2pBnsl9Ctw0m0pZ90ko8gj7NLGRIag9IPsjt0vCG9SfV5xYQm3iIZ3b4A+jj2KBP2r
 n7m7Z9h3VKo1mzE01T7/oJC/cA9cuTMdCMXitRoW+N/uLvRYqvOjNNtE0EnvBT57sOseIJ
 +ep5495Xm6M1vtZxqZoNXtIwPNaDD5YFbygXw/S7p52zaTUO8FgXMs/HT8CDB7PoJgBrCS
 PgBUXOPf4RweIoJl/JgGjSw0p2TonbjlkDh+/e7Po0YSgcxwAe3CB5qUgecnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=AgqtG7FWGG/aGAFBHu5WBpbnYbeqKy2fMcz2CwAcWys=;
 b=nkWzhAcYABzUIpHke7RusnFIf+hrjRwwhuLGcmAEoC2SxHQAjUUdw1Le9FKphWcTohRd6/
 mLASKAi/R6fSbOCA==
Date: Wed, 26 Aug 2020 13:16:39 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 11/46] iommu/irq_remapping: Consolidate irq domain lookup
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

Now that the iommu implementations handle the X86_*_GET_PARENT_DOMAIN
types, consolidate the two getter functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/irq_remapping.h |    8 --------
 arch/x86/kernel/apic/io_apic.c       |    2 +-
 arch/x86/kernel/apic/msi.c           |    2 +-
 drivers/iommu/amd/iommu.c            |    1 -
 drivers/iommu/hyperv-iommu.c         |    4 ++--
 drivers/iommu/intel/irq_remapping.c  |    1 -
 drivers/iommu/irq_remapping.c        |   23 +----------------------
 drivers/iommu/irq_remapping.h        |    5 +----
 8 files changed, 6 insertions(+), 40 deletions(-)

--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,8 +45,6 @@ extern int irq_remap_enable_fault_handli
 extern void panic_if_irq_remap(const char *msg);
 
 extern struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info);
-extern struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info);
 
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
@@ -74,12 +72,6 @@ static inline void panic_if_irq_remap(co
 }
 
 static inline struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
-static inline struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	return NULL;
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2298,7 +2298,7 @@ static int mp_irqdomain_create(int ioapi
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (!parent)
 		parent = x86_vector_domain;
 	else
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -478,7 +478,7 @@ struct irq_domain *hpet_create_irq_domai
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
 	else
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3561,7 +3561,6 @@ struct irq_remap_ops amd_iommu_irq_ops =
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -182,7 +182,7 @@ static int __init hyperv_enable_irq_rema
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
@@ -193,7 +193,7 @@ static struct irq_domain *hyperv_get_ir_
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
+	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1131,7 +1131,6 @@ struct irq_remap_ops intel_irq_remap_ops
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_ir_irq_domain	= intel_get_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
 
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -160,33 +160,12 @@ void panic_if_irq_remap(const char *msg)
 }
 
 /**
- * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
- *				     device serving request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * It's used to get parent irqdomain for HPET and IOAPIC irqdomains.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_ir_irq_domain)
-		return NULL;
-
-	return remap_ops->get_ir_irq_domain(info);
-}
-
-/**
  * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
  * @info: interrupt allocation information, used to identify the IOMMU device
  *
- * There will be one PCI MSI/MSIX irqdomain associated with each interrupt
- * remapping device, so this interface is used to retrieve the PCI MSI/MSIX
- * irqdomain serving request @info.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (!remap_ops || !remap_ops->get_irq_domain)
 		return NULL;
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -43,10 +43,7 @@ struct irq_remap_ops {
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
 
-	/* Get the irqdomain associated the IOMMU device */
-	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
-
-	/* Get the MSI irqdomain associated with the IOMMU device */
+	/* Get the irqdomain associated to IOMMU device */
 	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
