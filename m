Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8BC433FE
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAAC285531;
	Fri, 10 Dec 2021 22:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1P6AGvZzivNS; Fri, 10 Dec 2021 22:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6B0385622;
	Fri, 10 Dec 2021 22:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81447C001E;
	Fri, 10 Dec 2021 22:19:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAAD9C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6B2B418E8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="M1tVjk6y";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="zq6e6vgO"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jxo8y8vHqEwV for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:19:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B629A418E9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:19 +0000 (UTC)
Message-ID: <20211210221814.540704224@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=cN4mOxuY7Okg1M+dlth8hthNIkx8L2iGPoOR+S+w+us=;
 b=M1tVjk6yFiMKXjz8z9rtje5UmZy1dz0aDWkX81TwRD2eOEBGMMOd4HQQbrePJuaH6+UMRX
 J8wzTS/tTtQdxXfph9XF969YPmB4Y9GtozG9J4einOdMXxZg3dQjYwxFmbcAJrBgo1kHEs
 PbCl/WQUGX4eNaP010LwWx1i2cL5DMz8+7ISg/FfzlYFm65Wyqm9T6dyF1sj5FioiD3VX+
 3iHK8Lyh2m73JkSmCPZRxgV4hdZQVdwIcMAKKbwxgrB6ifMNHS/T+pXh+isLvhLB4AByf+
 ekRKlayeNgYLRRrhODOIIyqUXowDIwjE4RArqa+pNuDaWoQqOOLWRwNBHeCs1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=cN4mOxuY7Okg1M+dlth8hthNIkx8L2iGPoOR+S+w+us=;
 b=zq6e6vgOvTOBpv83YKIBY7AfdQR37XhK0GNGPBYF4MooJaZ9kRON5kPCk5FJ8SFotmH1vC
 0TG1lB8qM5PsBWAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 22/35] soc: ti: ti_sci_inta_msi: Use msi_desc::msi_index
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:19:17 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-ti-sci-inta.c |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c  |    6 +++---
 include/linux/msi.h               |   16 ++--------------
 3 files changed, 6 insertions(+), 18 deletions(-)

--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -595,7 +595,7 @@ static void ti_sci_inta_msi_set_desc(msi
 	struct platform_device *pdev = to_platform_device(desc->dev);
 
 	arg->desc = desc;
-	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
+	arg->hwirq = TO_HWIRQ(pdev->id, desc->msi_index);
 }
 
 static struct msi_domain_ops ti_sci_inta_msi_ops = {
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -84,7 +84,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start + i;
+			msi_desc->msi_index = res->desc[set].start + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -96,7 +96,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 				return -ENOMEM;
 			}
 
-			msi_desc->inta.dev_index = res->desc[set].start_sec + i;
+			msi_desc->msi_index = res->desc[set].start_sec + i;
 			INIT_LIST_HEAD(&msi_desc->list);
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
@@ -154,7 +154,7 @@ unsigned int ti_sci_inta_msi_get_virq(st
 	struct msi_desc *desc;
 
 	for_each_msi_entry(desc, dev)
-		if (desc->inta.dev_index == dev_index)
+		if (desc->msi_index == dev_index)
 			return desc->irq;
 
 	return -ENODEV;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,14 +107,6 @@ struct pci_msi_desc {
 };
 
 /**
- * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
- * @dev_index: TISCI device index
- */
-struct ti_sci_inta_msi_desc {
-	u16	dev_index;
-};
-
-/**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
  * @irq:	The base interrupt number
@@ -128,8 +120,7 @@ struct ti_sci_inta_msi_desc {
  * @write_msi_msg_data:	Data parameter for the callback.
  *
  * @msi_index:	Index of the msi descriptor
- * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
+ * @pci:	PCI specific msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -147,10 +138,7 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	union {
-		struct pci_msi_desc		pci;
-		struct ti_sci_inta_msi_desc	inta;
-	};
+	struct pci_msi_desc		pci;
 };
 
 /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
