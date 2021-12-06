Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA63C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9A6841C60;
	Mon,  6 Dec 2021 22:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9q5gsc5ktGIz; Mon,  6 Dec 2021 22:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A482640469;
	Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7E4C001E;
	Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C6DFC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B9DE41C5D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wfxntnwFOIx for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1A0441C59
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:28 +0000 (UTC)
Message-ID: <20211206210438.688216619@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=rDy+I3ErSIwPbhu7X1CCkhe4PGVkrX5FRQ61OeZYbi0=;
 b=rdxELXqqCUvF6w5maDZkJ1DUVcE8xtOFQuqB//kVE8LutIsp9x7oY88xYjjcJZGehvl20I
 R+i6TJmT/vTW79Nv4ctZJYRheEWHSoWoguFGJMgyW+Y78A4gZheDTRjB7MKWo1i1SNciQv
 MAkGYA8bGBoVVnZcIEV3q2C/xmLuWz4pSytUusJpxR9xdD6KElclS1+2OYVVTkq2CTV5v0
 K7Qk55Cr9KK7t23ybVmifYXu8ldnDmpJ27OX5lTB0ymWjBlgUMjTEseTLZ8Qod83UjgC9D
 tbU/slR0lNW5luPAEZ2uA0pSeOSKTDgFQBd2KUoEvNi5EWLt9sMAqB45SFUrIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=rDy+I3ErSIwPbhu7X1CCkhe4PGVkrX5FRQ61OeZYbi0=;
 b=tGgA6BqJjARLsTeCWAn17BXxaUG282LmcuxVJy035n8FdUpejfTN0J30/E3k5C2sIwZD1h
 pHsGs8TzGh+VOpBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:26 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

Store the properties which are interesting for various places so the MSI
descriptor fiddling can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use the setter function
---
 drivers/pci/msi/msi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;
 	}
+
+	msi_device_set_properties(&dev->dev, 0);
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -341,6 +343,7 @@ msi_setup_entry(struct pci_dev *dev, int
 {
 	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
+	unsigned long prop;
 	u16 control;
 
 	if (affd)
@@ -372,6 +375,10 @@ msi_setup_entry(struct pci_dev *dev, int
 	if (entry->pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
+	prop = MSI_PROP_PCI_MSI;
+	if (entry->pci.msi_attrib.is_64)
+		prop |= MSI_PROP_64BIT;
+	msi_device_set_properties(&dev->dev, prop);
 out:
 	kfree(masks);
 	return entry;
@@ -514,6 +521,7 @@ static int msix_setup_entries(struct pci
 		if (masks)
 			curmsk++;
 	}
+	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
 	ret = 0;
 out:
 	kfree(masks);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
