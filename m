Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BC5C433F5
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4858161C36;
	Sat, 27 Nov 2021 01:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3g7MGkagKTM; Sat, 27 Nov 2021 01:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37B0C61C15;
	Sat, 27 Nov 2021 01:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0834EC001C;
	Sat, 27 Nov 2021 01:22:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3FAC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2959E40598
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="p/NPVHkY";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="myakaVvh"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jUu8YrN9ChuJ for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47D6640593
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:04 +0000 (UTC)
Message-ID: <20211126230525.603398433@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
 b=p/NPVHkYkWacp959EAGV63t+QF44M4nmwyJpkmxhobzHMy0oLeXCml4Dr7nGtmPNC0j+WY
 B7A+XOX+bUiQGGnqmMeYDCi6nuPATIptOhpsfS6cXI93itu1a39nmOe3EbTIHJPYHxHJl/
 XJKPi6FmSn54C8eYngXdjjlg5nTuN6a/ZboSRqT6YWuNUK9jSxbqg8/oAYI5jlkVYTdMCt
 H1C6eAWCV+Ct3UnEO7kwgd8AlvWgSHDYcClguXlcmdH6z2n0jDEfUP11605adYmJ3lTsWt
 0veZehPwbKT+6+xkp5lhiaNBDoo35OX5lr/p1bk3ueG0H0O/j/Dbx0Y1nbMU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
 b=myakaVvhQTfIHvDEKNp6aQzHpJx42UzrH2h+7Ogy2xKClVuLIsMQRKwjYYVfx3QxA0yElw
 jWtiyr7lcC5BO3BQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 28/37] genirq/msi: Provide interface to retrieve Linux
 interrupt number
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:22:01 +0100 (CET)
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
Message-ID: <20211127012201.g_Www55sV7_F04GU79r5XhD1IF8vJnCynXXK-ThsnyM@z>

This allows drivers to retrieve the Linux interrupt number instead of
fiddling with MSI descriptors.

msi_get_virq() returns the Linux interrupt number or 0, __msi_get_virq()
has more detailed return codes so pci_irq_vector() can use it as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   16 ++++++++++++++++
 kernel/irq/msi.c    |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -169,6 +169,22 @@ static inline bool msi_device_has_proper
 }
 #endif
 
+int __msi_get_virq(struct device *dev, unsigned int index);
+
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	int ret = __msi_get_virq(dev, index);
+
+	return ret < 0 ? 0 : ret;
+}
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,6 +120,44 @@ int msi_setup_device_data(struct device
 	return 0;
 }
 
+/**
+ * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0)
+ *	   -ENODEV when the device is not using MSI
+ *	   -ENOENT if no such entry exists
+ */
+int __msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return -ENODEV;
+
+	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
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
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(__msi_get_virq);
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
