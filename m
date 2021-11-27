Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F82DC43219
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41CFE403F1;
	Sat, 27 Nov 2021 01:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i27QrO4yguna; Sat, 27 Nov 2021 01:21:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F26014056F;
	Sat, 27 Nov 2021 01:21:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE0DC001C;
	Sat, 27 Nov 2021 01:21:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE327C003C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBEA64040C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pl1Hj_A2pwg9 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6919403F1
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:33 +0000 (UTC)
Message-ID: <20211126230524.478418625@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6Kf8uoDdfqcgp3MpzFvCoiTWQV1YmFn3oOwS+G3NmiU=;
 b=uJny3d4U+UDfN2qwxXmPeWyCSXjP6bVnQ46hZWvBcTMJK6Lip2GAf9qC6X+mDHyPLP9eh3
 kfEvv+Fp6TBuNZe7er8nltm6G1RajiYiLR3r/ho767bbHV8Tlz2e04gnxcxMuVEHBJp1vJ
 cz3eshPWazplKVJSDpbyUOC7GIIG+Qo7QCuunBvHdBOsJ+TEsdvnp9fwAwYhmaCwftLcUt
 4pVvQ04CyQykv+ACnxfOCQDcITO3GnDRaw6cBZxGVcuACUjrOOqO6LFH1fG5fZFi4NepuY
 6HGjGosXrBvW98AkzR//PXisSwS8UB8KAQc2G7KqzKHZ55sBlYxT9qWnfPq/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6Kf8uoDdfqcgp3MpzFvCoiTWQV1YmFn3oOwS+G3NmiU=;
 b=wPvgGBVHSb0mX4FLV8Xk3XzijuG+iSGKVCJJ8M5I36QRerq9w7dd+4nPO6dHtx7gShH0GC
 w2Pci6jHjN1VBxBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 09/37] PCI/MSI: Let the irq code handle sysfs groups
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:31 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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
Message-ID: <20211127012131.Gxd78BcO0otIs98Ynt6xKEzeLyW0JJ0TdwWKxug4bvY@z>

Set the domain info flag which makes the core code handle sysfs groups and
put an explicit invocation into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    2 +-
 drivers/pci/msi/legacy.c    |    6 +++++-
 drivers/pci/msi/msi.c       |   23 -----------------------
 include/linux/pci.h         |    1 -
 4 files changed, 6 insertions(+), 26 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -159,7 +159,7 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -71,10 +71,14 @@ int pci_msi_legacy_setup_msi_irqs(struct
 {
 	int ret = arch_setup_msi_irqs(dev, nvec, type);
 
-	return pci_msi_setup_check_result(dev, type, ret);
+	ret = pci_msi_setup_check_result(dev, type, ret);
+	if (!ret)
+		ret = msi_device_populate_sysfs(&dev->dev);
+	return ret;
 }
 
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
 {
+	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -233,11 +233,6 @@ static void free_msi_irqs(struct pci_dev
 			for (i = 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
 
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups = NULL;
-	}
-
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
@@ -415,7 +410,6 @@ static int msi_verify_entries(struct pci
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	struct msi_desc *entry;
 	int ret;
 
@@ -439,14 +433,6 @@ static int msi_capability_init(struct pc
 	if (ret)
 		goto err;
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto err;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
@@ -574,7 +560,6 @@ static void msix_mask_all(void __iomem *
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -616,14 +601,6 @@ static int msix_capability_init(struct p
 
 	msix_update_entries(dev, entries);
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto out_free;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -474,7 +474,6 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
-	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
