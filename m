Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF88C433F5
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C243D4091A;
	Sat, 27 Nov 2021 01:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id baNB3zJvfh3r; Sat, 27 Nov 2021 01:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80A7040562;
	Sat, 27 Nov 2021 01:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68FFDC001C;
	Sat, 27 Nov 2021 01:20:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B468C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AAE040562
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Shz48VeF9ah for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64DB4408DB
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
Message-ID: <20211126230524.720574009@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=AKZi5uNn4XVDZLoHv4Jql/2maJ3KbTWq3QeKTKNmToU=;
 b=tQVdRbr8D6QOJfSIL8hZc7D5jXtRi+sY2QGiJD8gR42VHfMeEqDEapCs/fw/GTwnDQINbv
 zmmukl2GtKQHqATBHyMgD/6/2dD88XZO3ahEUZclvxVnBWsDW3uUc4FC2Nj557AcFJIpQT
 MuBv5WqltOx1wX2ySEqJTC+ZEoF7SdT3DBaSzqLh4mab4k3SycwC66EhJ5lCoT2o8IZY0s
 iTNkYe96JQP86SeKQNml0k29YzeEH91Cz2hc7UXYq55jYwD65/mmljwUA/oMjimkLSC9yf
 3Xp3rTSpB4spMaUdCw0TRdxgFxrswx4ggfR/QtWlQJMSvk1r1BwgNolCYoripQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=AKZi5uNn4XVDZLoHv4Jql/2maJ3KbTWq3QeKTKNmToU=;
 b=+rNYfW2aRjdFV180ENWsip3NhnsSxMlLC7uqJRcxqbePjtqvf1Rb3Arh4z/ia+5zCnztsJ
 LYl8MG+mhSXFAyDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 13/37] platform-msi: Store platform private data pointer in
 msi_device_data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:27 +0100 (CET)
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

Storing the platform private data in a MSI descriptor is sloppy at
best. The data belongs to the device and not to the descriptor.
Add a pointer to struct msi_device_data and store the pointer there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |   79 +++++++++++++++++---------------------------
 include/linux/msi.h         |    5 +-
 2 files changed, 35 insertions(+), 49 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -38,9 +38,7 @@ static DEFINE_IDA(platform_msi_devid_ida
  */
 static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
-	u32 devid;
-
-	devid = desc->platform.msi_priv_data->devid;
+	u32 devid = desc->dev->msi.data->platform_data->devid;
 
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
 }
@@ -85,11 +83,8 @@ static void platform_msi_update_dom_ops(
 static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
-	struct platform_msi_priv_data *priv_data;
-
-	priv_data = desc->platform.msi_priv_data;
 
-	priv_data->write_msg(desc, msg);
+	desc->dev->msi.data->platform_data->write_msg(desc, msg);
 }
 
 static void platform_msi_update_chip_ops(struct msi_domain_info *info)
@@ -126,9 +121,7 @@ static void platform_msi_free_descs(stru
 }
 
 static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec,
-					     struct platform_msi_priv_data *data)
-
+					     int nvec)
 {
 	struct msi_desc *desc;
 	int i, base = 0;
@@ -144,7 +137,6 @@ static int platform_msi_alloc_descs_with
 		if (!desc)
 			break;
 
-		desc->platform.msi_priv_data = data;
 		desc->platform.msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
@@ -161,11 +153,9 @@ static int platform_msi_alloc_descs_with
 	return 0;
 }
 
-static int platform_msi_alloc_descs(struct device *dev, int nvec,
-				    struct platform_msi_priv_data *data)
-
+static int platform_msi_alloc_descs(struct device *dev, int nvec)
 {
-	return platform_msi_alloc_descs_with_irq(dev, 0, nvec, data);
+	return platform_msi_alloc_descs_with_irq(dev, 0, nvec);
 }
 
 /**
@@ -199,9 +189,8 @@ struct irq_domain *platform_msi_create_i
 	return domain;
 }
 
-static struct platform_msi_priv_data *
-platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-			     irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
+					irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
 	int err;
@@ -213,41 +202,44 @@ platform_msi_alloc_priv_data(struct devi
 	 * capable devices).
 	 */
 	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (dev->msi.domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
 		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	err = msi_setup_device_data(dev);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	/* Already had a helping of MSI? Greed... */
-	if (!list_empty(dev_to_msi_list(dev)))
-		return ERR_PTR(-EBUSY);
+	/* Already initialized? */
+	if (dev->msi.data->platform_data)
+		return -EBUSY;
 
 	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
 	if (!datap)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
 		err = datap->devid;
 		kfree(datap);
-		return ERR_PTR(err);
+		return err;
 	}
 
 	datap->write_msg = write_msi_msg;
 	datap->dev = dev;
-
-	return datap;
+	dev->msi.data->platform_data = datap;
+	return 0;
 }
 
-static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
+static void platform_msi_free_priv_data(struct device *dev)
 {
+	struct platform_msi_priv_data *data = dev->msi.data->platform_data;
+
+	dev->msi.data->platform_data = NULL;
 	ida_simple_remove(&platform_msi_devid_ida, data->devid);
 	kfree(data);
 }
@@ -264,14 +256,13 @@ static void platform_msi_free_priv_data(
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg)
 {
-	struct platform_msi_priv_data *priv_data;
 	int err;
 
-	priv_data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(priv_data))
-		return PTR_ERR(priv_data);
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
+		return err;
 
-	err = platform_msi_alloc_descs(dev, nvec, priv_data);
+	err = platform_msi_alloc_descs(dev, nvec);
 	if (err)
 		goto out_free_priv_data;
 
@@ -284,8 +275,7 @@ int platform_msi_domain_alloc_irqs(struc
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
-	platform_msi_free_priv_data(priv_data);
-
+	platform_msi_free_priv_data(dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
@@ -296,15 +286,9 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_al
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	if (!list_empty(dev_to_msi_list(dev))) {
-		struct msi_desc *desc;
-
-		desc = first_msi_entry(dev);
-		platform_msi_free_priv_data(desc->platform.msi_priv_data);
-	}
-
 	msi_domain_free_irqs(dev->msi.domain, dev);
 	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
+	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
 
@@ -351,10 +335,11 @@ struct irq_domain *
 	struct irq_domain *domain;
 	int err;
 
-	data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(data))
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
 		return NULL;
 
+	data = dev->msi.data->platform_data;
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
 					     is_tree ? 0 : nvec,
@@ -372,7 +357,7 @@ struct irq_domain *
 free_domain:
 	irq_domain_remove(domain);
 free_priv:
-	platform_msi_free_priv_data(data);
+	platform_msi_free_priv_data(dev);
 	return NULL;
 }
 
@@ -420,7 +405,7 @@ int platform_msi_device_domain_alloc(str
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
 
-	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs, data);
+	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs);
 	if (err)
 		return err;
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,7 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -106,11 +107,9 @@ struct pci_msi_desc {
 
 /**
  * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_priv_data:	Pointer to platform private data
  * @msi_index:		The index of the MSI descriptor for multi MSI
  */
 struct platform_msi_desc {
-	struct platform_msi_priv_data	*msi_priv_data;
 	u16				msi_index;
 };
 
@@ -175,10 +174,12 @@ struct msi_desc {
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
  * @attrs:		Pointer to the sysfs attribute group
+ * @platform_data:	Platform-MSI specific data
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
 	const struct attribute_group    **attrs;
+	struct platform_msi_priv_data	*platform_data;
 };
 
 int msi_setup_device_data(struct device *dev);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
