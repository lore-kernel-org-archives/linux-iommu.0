Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FDEC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DEA361B53;
	Fri, 10 Dec 2021 22:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SobH-W_kOOil; Fri, 10 Dec 2021 22:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82FF561B4F;
	Fri, 10 Dec 2021 22:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E53DC001E;
	Fri, 10 Dec 2021 22:19:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13630C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D05D61B5D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oQEBGi68We6B for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:19:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFB4761B4F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:25 +0000 (UTC)
Message-ID: <20211210221814.780824745@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZEIc+hYHtGZ+R8Y42PTVzHWVlXMSBVtNMJGsH152424=;
 b=ZnOdjYsyWWWPA45DX/sEP1Hz7/N21g6u4UZdn8c1qyQRQwctj1a4i6BAp20kDLoVrj6D2s
 MbD+ZTo1q9CByKhQo2XRoN4WdhbqsWP8IhvQmO5n4QjDLb4bQeMj+tjt/r7iv7ulqjYgof
 F4ISSFlfQwvH4mj7rI3COb7fhYfIaOuZZwt6hdi7/i1KgHhxe1miuwBC9ALPHJWSgBGtAq
 Hm9GThVygPLyQUzGEUG99ih95uj7Ifn3w+/L6+ojF2urlcLuEKAYpMauAHf1+Mdai5rTl4
 6N8IRoupzCe+vvFuCq6MovD0Voro2Z7OmtZqPzl66KvGCxnWY1NqHMI0nV1/OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZEIc+hYHtGZ+R8Y42PTVzHWVlXMSBVtNMJGsH152424=;
 b=IxahGrtxRlopXsWUYNpTNdhCUtnqonpOEodZ3IuQBz/DFc/KxGCheju7XzPFrWnx3hqpKg
 Kcg6g5cSFSWCRQCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 26/35] genirq/msi: Provide interface to retrieve Linux
 interrupt number
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:19:23 +0100 (CET)
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

This allows drivers to retrieve the Linux interrupt number instead of
fiddling with MSI descriptors.

msi_get_virq() returns the Linux interrupt number or 0 in case that there
is no entry for the given MSI index.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
V2: Simplify the implementation and let PCI deal with the PCI specialities - Marc
---
 include/linux/msi.h |    2 ++
 kernel/irq/msi.c    |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -153,6 +153,8 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -105,6 +105,42 @@ int msi_setup_device_data(struct device
 	return 0;
 }
 
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return 0;
+
+	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+
+	for_each_msi_entry(desc, dev) {
+		/* PCI-MSI has only one descriptor for multiple interrupts. */
+		if (pcimsi) {
+			if (desc->irq && index < desc->nvec_used)
+				return desc->irq + index;
+			break;
+		}
+
+		/*
+		 * PCI-MSIX and platform MSI use a descriptor per
+		 * interrupt.
+		 */
+		if (desc->msi_index == index)
+			return desc->irq;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(msi_get_virq);
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
