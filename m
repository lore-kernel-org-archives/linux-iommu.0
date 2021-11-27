Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199EDC001B6
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0C2182BF5;
	Sat, 27 Nov 2021 01:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEsbsskgD9tI; Sat, 27 Nov 2021 01:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE9D982C18;
	Sat, 27 Nov 2021 01:20:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9945C001C;
	Sat, 27 Nov 2021 01:20:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F07BC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66F0582B94
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IMC8CsfsAPYL for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B23DE82BF5
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:39 +0000 (UTC)
Message-ID: <20211126230525.076279841@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=gZLgk03W9BPqX4Y47drAtN3rUO/Oc3l0uTHU4EywtJI=;
 b=haWzMt4KR9DWFpGWdGE1l1s2+vs+6A08HfUC3wCsW3ct8bY8hzzw5Zksb1QAtSqqKXiTLV
 90HL8F+IY3f388igePB9oG82ZtrhY+pUqOOsbCmR2UT/4VVzeLQMGXQ7XBpjTJVwJYV4gI
 WYrto37nJcH9GJjyMqoKYfnwaCKd3a9/AJtrxjeb2TiAS5tmTf34lQJzwzHb8XlIXVJWOr
 i65Z3V0NA6W4UMX3WRllvGzZNGYs2fwg6buB6N3fX2WBKGLJIFIaq0bn5EZ88rtrKujv++
 Pb6chN5PsN34skBdrvROx5hCigMHTKQgd0gRtXaVoWnySgsBCrEuicXBelakSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=gZLgk03W9BPqX4Y47drAtN3rUO/Oc3l0uTHU4EywtJI=;
 b=pmIRurktZCqaSiTjEwau1BH/cen1Z4IWsZYOdf1qJ4Pt16qpjmgbTpo368LzRvhdZG1dgu
 sjE9naEhMlft7uAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 19/37] genirq/msi: Add msi_device_data::properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:37 +0100 (CET)
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

Add a properties field which allows core code to store information for easy
retrieval in order to replace MSI descriptor fiddling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   17 +++++++++++++++++
 kernel/irq/msi.c    |   12 ++++++++++++
 2 files changed, 29 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/bits.h>
 #include <asm/msi.h>
 
 /* Dummy shadow structures if an architecture does not define them */
@@ -141,17 +142,33 @@ struct msi_desc {
 /**
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
+ * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
+	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 };
 
 int msi_setup_device_data(struct device *dev);
 
+/* MSI device properties */
+#define MSI_PROP_PCI_MSI		BIT(0)
+#define MSI_PROP_PCI_MSIX		BIT(1)
+#define MSI_PROP_64BIT			BIT(2)
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+bool msi_device_has_property(struct device *dev, unsigned long prop);
+#else
+static inline bool msi_device_has_property(struct device *dev, unsigned long prop)
+{
+	return false;
+}
+#endif
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -60,6 +60,18 @@ void free_msi_entry(struct msi_desc *ent
 	kfree(entry);
 }
 
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
