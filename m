Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2A6C4332F
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66F9241C53;
	Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sb8ZUhR3HWCO; Mon,  6 Dec 2021 22:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50BEC41C59;
	Mon,  6 Dec 2021 22:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2095EC0030;
	Mon,  6 Dec 2021 22:39:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D094C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 771BE60E46
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="nFlB/ZfA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="kZidNZ0r"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8iy6590WdP0 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF31060E30
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:27 +0000 (UTC)
Message-ID: <20211206210438.634566968@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=22kiva9JQ6H45N/BOYxKJH09o/YfXdpwUv48in1Qe9g=;
 b=nFlB/ZfAFV290eYeaq7YAleaoxlr5J/DYFZ2Nq0+kVCGwKiCDKsS0JHzsD3GRMLXU+qV7j
 fra1pXggf1FZlOZCNMPIxkiO3JccQ5fVaiEY4+wxZ8vfIfEPgFxqSqOEDhxvLBTtU1gzKY
 qsFpt6Tnx+hQcBuljGc2PBclIz+d+ynQZYG+ACQWiOyQUmhPmvu6dr2LKWPRaEB1D1qXsF
 2A0umNkHhXupulP3JfDQWZ0OTfW1qVObZkyPWFJX6TXvls5XDLaIdBIVLG1YsfbYg5gpU0
 8IofU2+b58NPrtDCOWVDCJmuc6BYOXMLrVmDAZ5XjTrebsqoMme+mHo5LfCXtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=22kiva9JQ6H45N/BOYxKJH09o/YfXdpwUv48in1Qe9g=;
 b=kZidNZ0rKz6u6g4sF+G5QgHXRDluyP5cIqQcaPX0b7qjkPXhcQchyCEpOUgYZQx5OduRon
 leuupQ2MYvos0eAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 18/36] genirq/msi: Add msi_device_data::properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:25 +0100 (CET)
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

Add a properties field which allows core code to store information for easy
retrieval in order to replace MSI descriptor fiddling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Add a setter function to prepare for future changes
---
 include/linux/msi.h |   17 +++++++++++++++++
 kernel/irq/msi.c    |   24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,6 +4,7 @@
 
 #include <linux/cpumask.h>
 #include <linux/list.h>
+#include <linux/bits.h>
 #include <asm/msi.h>
 
 /* Dummy shadow structures if an architecture does not define them */
@@ -153,6 +154,22 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
+/* MSI device properties */
+#define MSI_PROP_PCI_MSI		BIT(0)
+#define MSI_PROP_PCI_MSIX		BIT(1)
+#define MSI_PROP_64BIT			BIT(2)
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+bool msi_device_has_property(struct device *dev, unsigned long prop);
+void msi_device_set_properties(struct device *dev, unsigned long prop);
+#else
+static inline bool msi_device_has_property(struct device *dev, unsigned long prop)
+{
+	return false;
+}
+static inline void msi_device_set_properties(struct device *dev, unsigned long prop) { }
+#endif
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -60,6 +60,30 @@ void free_msi_entry(struct msi_desc *ent
 	kfree(entry);
 }
 
+/**
+ * msi_device_set_properties - Set device specific MSI properties
+ * @dev:	Pointer to the device which is queried
+ * @prop:	Properties to set
+ */
+void msi_device_set_properties(struct device *dev, unsigned long prop)
+{
+	if (WARN_ON_ONCE(!dev->msi.data))
+		return ;
+	dev->msi.data->properties = 0;
+}
+
+/**
+ * msi_device_has_property - Check whether a device has a specific MSI property
+ * @dev:	Pointer to the device which is queried
+ * @prop:	Property to check for
+ */
+bool msi_device_has_property(struct device *dev, unsigned long prop)
+{
+	if (!dev->msi.data)
+		return false;
+	return !!(dev->msi.data->properties & prop);
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
