Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61890C433F5
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 21:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFF87817BA;
	Sun, 28 Nov 2021 21:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxlqOPRGWfvJ; Sun, 28 Nov 2021 21:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F160C81751;
	Sun, 28 Nov 2021 21:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C81B1C0012;
	Sun, 28 Nov 2021 21:00:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B230EC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 21:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A08760689
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 21:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="ovQrQWgM";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="NUA/BtE1"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGGVdNaBFF3c for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 21:00:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A533160611
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 21:00:29 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638133227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVxt6RB3wq6HozhBc+E1hXItThUGltcJ9ju6gKUja04=;
 b=ovQrQWgMUuCiS2J0TbehvfgGdvNDScGgbL+6hWiymu/4hk9yeorrjvjwv2A9ri4fiF4TL3
 DSfT6C8e0bmVDuHDUQCzJRqttusZrTW5XX4wCU7Yj9sLULu1x4kK66+AlBBbjIUAjG9B8b
 64XqhOhWkg/ctdSQbKmE8BPcVfZbk2k2cR6inZtwbnSoC1F0IYB1MxGUeqWra/EysyM5Ez
 qxt0eKskFmSTQ/tAboszZk03QHU7P8ZOyTxd+7hAvKgMMi3vTl00SxM61TgYLUB2M3NMJS
 AYqARRb1pH+8qjed7HIPkZ/WNgRcJfB3t7oIWocwmnlKWlG53ZmKHDR/Q2zjcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638133227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVxt6RB3wq6HozhBc+E1hXItThUGltcJ9ju6gKUja04=;
 b=NUA/BtE19KWnZCRSqlc8MZDe4YbQjIYarpAE6lp/GjIsHlXDmVpRZHIvnhigXdHIcoaHek
 On6pzReK20LEQhBw==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [patch 29/37] PCI/MSI: Use __msi_get_virq() in pci_get_vector()
In-Reply-To: <871r30rrzq.wl-maz@kernel.org>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.660206325@linutronix.de> <871r30rrzq.wl-maz@kernel.org>
Date: Sun, 28 Nov 2021 22:00:26 +0100
Message-ID: <87tufwdmhh.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
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

On Sun, Nov 28 2021 at 19:37, Marc Zyngier wrote:
> On Sat, 27 Nov 2021 01:22:03 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I worked around it with the hack below, but I doubt this is the real
> thing. portdrv_core.c does complicated things, and I don't completely
> understand its logic.
>
> 	M.
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 1f72bc734226..b15278a5fb4b 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1092,8 +1092,9 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  	int irq = __msi_get_virq(&dev->dev, nr);
>  
>  	switch (irq) {
> -	case -ENODEV: return !nr ? dev->irq : -EINVAL;
> -	case -ENOENT: return -EINVAL;
> +	case -ENOENT:
> +	case -ENODEV:
> +		return !nr ? dev->irq : -EINVAL;

Hrm. ENODEV is returned when dev->msi.data == NULL, ENOENT when there is
no MSI entry. But yes, that goes south when the device tried to enable
MSI[X} and then ended up with INTx. It still has dev->msi.data, which
causes it to return -ENOENT, which makes the above go belly up.

Moo, what was I thinking?

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1032,13 +1032,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	int irq = __msi_get_virq(&dev->dev, nr);
+	unsigned int irq;
 
-	switch (irq) {
-	case -ENODEV: return !nr ? dev->irq : -EINVAL;
-	case -ENOENT: return -EINVAL;
-	}
-	return irq;
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
+
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -169,21 +169,7 @@ static inline bool msi_device_has_proper
 }
 #endif
 
-int __msi_get_virq(struct device *dev, unsigned int index);
-
-/**
- * msi_get_virq - Return Linux interrupt number of a MSI interrupt
- * @dev:	Device to operate on
- * @index:	MSI interrupt index to look for (0-based)
- *
- * Return: The Linux interrupt number on success (> 0), 0 if not found
- */
-static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
-{
-	int ret = __msi_get_virq(dev, index);
-
-	return ret < 0 ? 0 : ret;
-}
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -119,21 +119,19 @@ int msi_setup_device_data(struct device
 }
 
 /**
- * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on
  * @index:	MSI interrupt index to look for (0-based)
  *
- * Return: The Linux interrupt number on success (> 0)
- *	   -ENODEV when the device is not using MSI
- *	   -ENOENT if no such entry exists
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
  */
-int __msi_get_virq(struct device *dev, unsigned int index)
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
 	bool pcimsi;
 
 	if (!dev->msi.data)
-		return -ENODEV;
+		return 0;
 
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
@@ -152,9 +150,9 @@ int __msi_get_virq(struct device *dev, u
 		if (desc->msi_index == index)
 			return desc->irq;
 	}
-	return -ENOENT;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(__msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_get_virq);
 
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
