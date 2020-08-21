Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB0C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C7C207DE
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VO5VGkAj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Juw/16bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C7C207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B9F5122F22;
	Fri, 21 Aug 2020 02:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TeqIk140pj1h; Fri, 21 Aug 2020 02:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA66522EE6;
	Fri, 21 Aug 2020 02:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96755C0889;
	Fri, 21 Aug 2020 02:16:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63A0EC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5266D877B3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWyjjNSPtKyL for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65EE0875D8
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:48 +0000 (UTC)
Message-Id: <20200821002945.992750750@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=08gHalbpGGDCN4mhRavSvWN/hPadHuFy3soEotqowwI=;
 b=VO5VGkAjH9r2ALe1X8UAQPlYGQOuDOVb0mHWVE3eldniJ7l1GIP82Fu9y2gk+1eUKLSSU/
 TfGlgz7KO+FuqyvNW7mF2trtvUfpad0jlDTS/tDY3OJLNa/Gzv2yomJb8bcCre/u1xQmhm
 fBQYXbF5BVHG6zLbNjyWtlULeEO9xrRdz7SK5n8oVe6B202tY7yzQv5+0GjDRXPgo706nH
 Y16WfHJgck7nS4gv3cRNGsuJ+vQB8uPqRulyrTT7sGINkuqikAuNEzMlBdCU/V+kSt8ifl
 S0knuL4TMs7CKpggEPDLrI2M0EH8eIwViE7vZ/QXg3ONJHx+b8dqtA4tN47McA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=08gHalbpGGDCN4mhRavSvWN/hPadHuFy3soEotqowwI=;
 b=Juw/16bMTphkE8b9E9cjCckz1/9ORrGofLrjGGkmOO/l+gCU7ULxTKjuA+hvWjQmIuTGTD
 JsqOwIvquOGzshAw==
Date: Fri, 21 Aug 2020 02:24:31 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 07/38] iommu/irq_remapping: Consolidate irq domain lookup
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="iommu-irq_remapping--Consolidate-irq-domain-lookup.patch"
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

Now that the iommu implementations handle the X86_*_GET_PARENT_DOMAIN
types, consolidate the two getter functions. 

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-hyperv@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
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
