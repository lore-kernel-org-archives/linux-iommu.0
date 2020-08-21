Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B432C433F4
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4796F2075E
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfuhL/7f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vm7OTzxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4796F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 24C1E22F05;
	Fri, 21 Aug 2020 02:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nY8JJhUQzuAb; Fri, 21 Aug 2020 02:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C991C22D0D;
	Fri, 21 Aug 2020 02:17:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4081C0889;
	Fri, 21 Aug 2020 02:17:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAEE2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C7646886B3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V4-rnLws4eJP for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1E352886AA
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:25 +0000 (UTC)
Message-Id: <20200821002948.864315814@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=t2NP7pVQXQ51g4UiBc17WkLPgfxzXUgtml1iOCs60Co=;
 b=hfuhL/7fph6qJyz7le4PFdDuEV6MgavC4eL9tY98pIvs0YVze1YpWy0KRD91j37VO5xh00
 tTfHk67g95+hQUTKU8KKSJA9eo2nfkCdUr6TNnpfLcGvt2wuEY9nmzSH6VO99xeXV0+A4+
 3UjDpnDV9ZJztKDU7K04c6z+Rh36p1B0DxMcS/s4gAC3meHhAazcpz19IpHsV1rKXTUXlh
 F48/seVKLFST8w9pwF9LxUe+fNZV2bhNMA1EJOOHcS0s4CTtWwFjNzrfnnkfJhn0NvlpGT
 seVvAX6gLDDs+OR8IS0+3pMgXtOebMT5uXucoYewe42TFsA9VJ16SSbZ+2wV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=t2NP7pVQXQ51g4UiBc17WkLPgfxzXUgtml1iOCs60Co=;
 b=vm7OTzxc+ZgBvpRZzpZI8vCsQAhHhTud1cF5+49Ul2OutYT4sEg30INjxq8N+0un9/anLJ
 iwhMU1saq0+BRDAw==
Date: Fri, 21 Aug 2020 02:25:00 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 36/38] platform-msi: Add device MSI infrastructure
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="platform-msi--Add-device-MSI-infrastructure.patch"
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>
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

Add device specific MSI domain infrastructure for devices which have their
own resource management and interrupt chip. These devices are not related
to PCI and contrary to platform MSI they do not share a common resource and
interrupt chip. They provide their own domain specific resource management
and interrupt chip.

This utilizes the new alloc/free override in a non evil way which avoids
having yet another set of specialized alloc/free functions. Just using
msi_domain_alloc/free_irqs() is sufficient

While initially it was suggested and tried to piggyback device MSI on
platform MSI, the better variant is to reimplement platform MSI on top of
device MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/platform-msi.c |  129 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/irqdomain.h   |    1 
 include/linux/msi.h         |   24 ++++++++
 kernel/irq/Kconfig          |    4 +
 4 files changed, 158 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -412,3 +412,132 @@ int platform_msi_domain_alloc(struct irq
 
 	return err;
 }
+
+#ifdef CONFIG_DEVICE_MSI
+/*
+ * Device specific MSI domain infrastructure for devices which have their
+ * own resource management and interrupt chip. These devices are not
+ * related to PCI and contrary to platform MSI they do not share a common
+ * resource and interrupt chip. They provide their own domain specific
+ * resource management and interrupt chip.
+ */
+
+static void device_msi_free_msi_entries(struct device *dev)
+{
+	struct list_head *msi_list = dev_to_msi_list(dev);
+	struct msi_desc *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, msi_list, list) {
+		list_del(&entry->list);
+		free_msi_entry(entry);
+	}
+}
+
+/**
+ * device_msi_free_irqs - Free MSI interrupts assigned to  a device
+ * @dev:	Pointer to the device
+ *
+ * Frees the interrupt and the MSI descriptors.
+ */
+static void device_msi_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	__msi_domain_free_irqs(domain, dev);
+	device_msi_free_msi_entries(dev);
+}
+
+/**
+ * device_msi_alloc_irqs - Allocate MSI interrupts for a device
+ * @dev:	Pointer to the device
+ * @nvec:	Number of vectors
+ *
+ * Allocates the required number of MSI descriptors and the corresponding
+ * interrupt descriptors.
+ */
+static int device_msi_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
+{
+	int i, ret = -ENOMEM;
+
+	for (i = 0; i < nvec; i++) {
+		struct msi_desc *entry = alloc_msi_entry(dev, 1, NULL);
+
+		if (!entry)
+			goto fail;
+		list_add_tail(&entry->list, dev_to_msi_list(dev));
+	}
+
+	ret = __msi_domain_alloc_irqs(domain, dev, nvec);
+	if (!ret)
+		return 0;
+fail:
+	device_msi_free_msi_entries(dev);
+	return ret;
+}
+
+static void device_msi_update_dom_ops(struct msi_domain_info *info)
+{
+	if (!info->ops->domain_alloc_irqs)
+		info->ops->domain_alloc_irqs = device_msi_alloc_irqs;
+	if (!info->ops->domain_free_irqs)
+		info->ops->domain_free_irqs = device_msi_free_irqs;
+	if (!info->ops->msi_prepare)
+		info->ops->msi_prepare = arch_msi_prepare;
+}
+
+/**
+ * device_msi_create_msi_irq_domain - Create an irq domain for devices
+ * @fwnode:	Firmware node of the interrupt controller
+ * @info:	MSI domain info to configure the new domain
+ * @parent:	Parent domain
+ */
+struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
+						struct msi_domain_info *info,
+						struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		platform_msi_update_chip_ops(info);
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		device_msi_update_dom_ops(info);
+
+	domain = msi_create_irq_domain(fn, info, parent);
+	if (domain)
+		irq_domain_update_bus_token(domain, DOMAIN_BUS_DEVICE_MSI);
+	return domain;
+}
+
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+
+/**
+ * pci_subdevice_msi_create_irq_domain - Create an irq domain for subdevices
+ * @pdev:	Pointer to PCI device for which the subdevice domain is created
+ * @info:	MSI domain info to configure the new domain
+ */
+struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
+						       struct msi_domain_info *info)
+{
+	struct irq_domain *domain, *pdev_msi;
+	struct fwnode_handle *fn;
+
+	/*
+	 * Retrieve the parent domain of the underlying PCI device's MSI
+	 * domain. This is going to be the parent of the new subdevice
+	 * domain as well.
+	 */
+	pdev_msi = dev_get_msi_domain(&pdev->dev);
+	if (!pdev_msi)
+		return NULL;
+
+	fn = irq_domain_alloc_named_fwnode(dev_name(&pdev->dev));
+	if (!fn)
+		return NULL;
+	domain = device_msi_create_irq_domain(fn, info, pdev_msi->parent);
+	if (!domain)
+		irq_domain_free_fwnode(fn);
+	return domain;
+}
+EXPORT_SYMBOL_GPL(pci_subdevice_msi_create_irq_domain);
+#endif /* CONFIG_PCI */
+#endif /* CONFIG_DEVICE_MSI */
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -85,6 +85,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
 	DOMAIN_BUS_VMD_MSI,
+	DOMAIN_BUS_DEVICE_MSI,
 };
 
 /**
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,18 @@ struct ti_sci_inta_msi_desc {
 };
 
 /**
+ * device_msi_desc - Device MSI specific MSI descriptor data
+ * @priv:		Pointer to device specific private data
+ * @priv_iomem:		Pointer to device specific private io memory
+ * @hwirq:		The hardware irq number in the device domain
+ */
+struct device_msi_desc {
+	void		*priv;
+	void __iomem	*priv_iomem;
+	u16		hwirq;
+};
+
+/**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
  * @irq:	The base interrupt number
@@ -127,6 +139,7 @@ struct msi_desc {
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
 		struct ti_sci_inta_msi_desc inta;
+		struct device_msi_desc device_msi;
 	};
 };
 
@@ -412,6 +425,17 @@ void platform_msi_domain_free(struct irq
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
+#ifdef CONFIG_DEVICE_MSI
+struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
+						struct msi_domain_info *info,
+						struct irq_domain *parent);
+
+# ifdef CONFIG_PCI
+struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
+						       struct msi_domain_info *info);
+# endif
+#endif /* CONFIG_DEVICE_MSI */
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -93,6 +93,10 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config DEVICE_MSI
+	bool
+	select GENERIC_MSI_IRQ_DOMAIN
+
 config IRQ_MSI_IOMMU
 	bool
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
