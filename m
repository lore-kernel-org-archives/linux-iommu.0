Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C90C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF0A20838
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Xqx86E3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfxmzM35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF0A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F1FA1228DB;
	Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GT4mqFX2k6wo; Wed, 26 Aug 2020 12:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BFE0228DC;
	Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09CE7C0051;
	Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC5CFC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D7EB386AF2
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CwrIafQY-+l3 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8827886BC4
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:20 +0000 (UTC)
Message-Id: <20200826112332.564274859@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=i8DAYBEwyev5Sb9kBzuYKhZP/VSkuBj1GjlCA99AJoU=;
 b=1Xqx86E3q2b2ZixfziDqUULh/NKjOj9iSwzOxek01OxyvIOgg8cUw3scQFIUzhIik+ULyn
 eYFFOzQaAtAetJ50JADbspwYOvRf4DuZsIZmaC2YhkoUJhcr8Aw+N6rO1uVGgC7/3shr1d
 OLBVnD9q8QM5PVW3FFw8KiTObe68Q+oWSoYrp0u3NbRzILlSdX1zl6PFApXfxKlDu7mgcY
 VM+FjD84hB1Ylny24sp4NpcF0El5FTnNFvQ/lQe1ts3dGeGXohTL9r/sSDLTTc8KMOCHR9
 EFTxeabk4c1fokQ9HBmZl2X1/37ciY0jgRDlOoW6Jicw2OjZ+uXg/oIDQCh3Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=i8DAYBEwyev5Sb9kBzuYKhZP/VSkuBj1GjlCA99AJoU=;
 b=SfxmzM35p6LRaIAQ/4CDORuaZiaqNGlLQeEksCh9t6iTSH1SdW+K2Nr2PXf5/KBUbLnT8s
 4r2ubQSnF63IJVDg==
Date: Wed, 26 Aug 2020 13:16:47 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 19/46] x86/msi: Use generic MSI domain ops
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

pci_msi_get_hwirq() and pci_msi_set_desc are not longer special. Enable the
generic MSI domain ops in the core and PCI MSI code unconditionally and get
rid of the x86 specific implementations in the X86 MSI code and in the
hyperv PCI driver.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/msi.h          |    2 --
 arch/x86/kernel/apic/msi.c          |   15 ---------------
 drivers/pci/controller/pci-hyperv.c |    8 --------
 drivers/pci/msi.c                   |    4 ----
 kernel/irq/msi.c                    |    6 ------
 5 files changed, 35 deletions(-)

--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -9,6 +9,4 @@ typedef struct irq_alloc_info msi_alloc_
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
-
 #endif /* _ASM_X86_MSI_H */
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -204,12 +204,6 @@ void native_teardown_msi_irq(unsigned in
 	irq_domain_free_irqs(irq, 1);
 }
 
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
-					 msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
@@ -228,17 +222,8 @@ int pci_msi_prepare(struct irq_domain *d
 }
 EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
-{
-	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
-}
-EXPORT_SYMBOL_GPL(pci_msi_set_desc);
-
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.get_hwirq	= pci_msi_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1531,16 +1531,8 @@ static struct irq_chip hv_msi_irq_chip =
 	.irq_unmask		= hv_irq_unmask,
 };
 
-static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
-						   msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 static struct msi_domain_ops hv_msi_ops = {
-	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 	.msi_free	= hv_msi_free,
 };
 
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1401,16 +1401,12 @@ static int pci_msi_domain_handle_error(s
 	return error;
 }
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
-#else
-#define pci_msi_domain_set_desc		NULL
-#endif
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
 	.set_desc	= pci_msi_domain_set_desc,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -187,7 +187,6 @@ static const struct irq_domain_ops msi_d
 	.deactivate	= msi_domain_deactivate,
 };
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
 						msi_alloc_info_t *arg)
 {
@@ -206,11 +205,6 @@ static void msi_domain_ops_set_desc(msi_
 {
 	arg->desc = desc;
 }
-#else
-#define msi_domain_ops_get_hwirq	NULL
-#define msi_domain_ops_prepare		NULL
-#define msi_domain_ops_set_desc		NULL
-#endif /* !GENERIC_MSI_DOMAIN_OPS */
 
 static int msi_domain_ops_init(struct irq_domain *domain,
 			       struct msi_domain_info *info,


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
