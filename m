Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC3C433FE
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C71D82B94;
	Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCBpf6CLMufi; Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2341E82B97;
	Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3B45C003C;
	Sat, 27 Nov 2021 01:20:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05C93C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0250A607DB
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="qS9f2NkK";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="vhD3cmRC"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7F2FsI8g-2jZ for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B9C061BFA
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:27 +0000 (UTC)
Message-ID: <20211126230524.600490756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=rnKORZE/4q0+dcWq5txOsnvSH8CsBB5Zw8/HocPRCso=;
 b=qS9f2NkK0r+z0LvL1ffdUS9y1b2C+JINxyh5UP9JUaDeY6E/gk5QARggKP8tASyvh7WAHK
 uKSx3IcQ4w62lyDAQU3WN7DKuXRvkAbRyJf515EEY96JIGudC49MgE4d1SLOlNiyNiI3cO
 /bx/sKu0dSlHMq7xqRFfFCc8FL4jAZMiCiTsnXuzFfc2lRvFJv26Wd+iK8hnckUseuxmsA
 DXLWJXAswomGH2z4c+rOvxNUwfFyD1TUJTQx1Myv9pLADZe4p42k4xxO+xTck+RUuxBUhc
 I3zdepkeBMxJil8A3xeFSEVuXowhQPmbvAuw9szDYTp9oAIm0t4ltlyagMr4zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=rnKORZE/4q0+dcWq5txOsnvSH8CsBB5Zw8/HocPRCso=;
 b=vhD3cmRCZH91LKAGRQEzR87rH9zcB4J0sfS6Lph75ZQBWWwci6udi8uV2PwOTRPb9ByuxQ
 gJmbrXCJzc5CZYAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 11/37] genirq/msi: Remove the original sysfs interfaces
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:24 +0100 (CET)
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

No more users. Refactor the core code accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   12 -----------
 kernel/irq/msi.c    |   53 +++++++++++++++++++---------------------------------
 2 files changed, 20 insertions(+), 45 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -246,21 +246,9 @@ void pci_msi_unmask_irq(struct irq_data
 #ifdef CONFIG_SYSFS
 int msi_device_populate_sysfs(struct device *dev);
 void msi_device_destroy_sysfs(struct device *dev);
-
-const struct attribute_group **msi_populate_sysfs(struct device *dev);
-void msi_destroy_sysfs(struct device *dev,
-		       const struct attribute_group **msi_irq_groups);
 #else
 static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
 static inline void msi_device_destroy_sysfs(struct device *dev) { }
-
-static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
-{
-	return NULL;
-}
-static inline void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-}
 #endif
 
 /*
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -132,12 +132,8 @@ static ssize_t msi_mode_show(struct devi
 /**
  * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
  * @dev:	The device(PCI, platform etc) who will get sysfs entries
- *
- * Return attribute_group ** so that specific bus MSI can save it to
- * somewhere during initilizing msi irqs. If devices has no MSI irq,
- * return NULL; if it fails to populate sysfs, return ERR_PTR
  */
-const struct attribute_group **msi_populate_sysfs(struct device *dev)
+static const struct attribute_group **msi_populate_sysfs(struct device *dev)
 {
 	const struct attribute_group **msi_irq_groups;
 	struct attribute **msi_attrs, *msi_attr;
@@ -228,41 +224,32 @@ int msi_device_populate_sysfs(struct dev
 }
 
 /**
- * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
- * @dev:		The device(PCI, platform etc) who will remove sysfs entries
- * @msi_irq_groups:	attribute_group for device msi_irqs entries
- */
-void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count = 0;
-
-	if (msi_irq_groups) {
-		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-		msi_attrs = msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr = container_of(msi_attrs[count],
-					struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(msi_irq_groups[0]);
-		kfree(msi_irq_groups);
-	}
-}
-
-/**
  * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
  * @dev:		The device(PCI, platform etc) for which to remove
  *			sysfs entries
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
+	struct device_attribute *dev_attr;
+	struct attribute **msi_attrs;
+	int count = 0;
+
 	dev->msi.data->attrs = NULL;
+	if (!msi_irq_groups)
+		return;
+
+	sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+	msi_attrs = msi_irq_groups[0]->attrs;
+	while (msi_attrs[count]) {
+		dev_attr = container_of(msi_attrs[count], struct device_attribute, attr);
+		kfree(dev_attr->attr.name);
+		kfree(dev_attr);
+		++count;
+	}
+	kfree(msi_attrs);
+	kfree(msi_irq_groups[0]);
+	kfree(msi_irq_groups);
 }
 #endif
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
