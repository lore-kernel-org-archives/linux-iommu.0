Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B460C433F5
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3077B4035C;
	Sat, 27 Nov 2021 01:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMDaz7VBrOCQ; Sat, 27 Nov 2021 01:20:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C999040399;
	Sat, 27 Nov 2021 01:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A36F9C001C;
	Sat, 27 Nov 2021 01:20:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CDDC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 363958100D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="YIryAC4L";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="55nX1man"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXdVnltQJwTL for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EF6380F40
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:12 +0000 (UTC)
Message-ID: <20211126230524.045836616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6M1tvQVxDKTLunwyY5ENMp/fgv1O4+f2pv6jOyEcyuQ=;
 b=YIryAC4L4I1Af3XL1vUUSJE61qVH2AguHzm/Ld5iXG1xUKbISfFXjbkwdlzXWEuDYkPiXG
 Dfgp77Wy/1LBi6u/Xv4EcGbJ06ckptO2WbYjTpug10iLz3RRg351f4uJKJo024UZO13AzF
 FtC47tnXWMBlU9MohdTfMwaKC8ZRhyCBDh0JZGQ7iBXItqDxfB+jP7XCVhVF6JEnWHN9C8
 lDv6WkdQQ+B7eLtk9GAOZKUrcfKJtKrAJG9u4SBbh+mrj+DG+Oy6Vnbmk9ZaUxLdH9qRbf
 0JUgIsJIk6t2s5t9rD2/PAmWE9RuOxWq2b7m/X3mJY8O0tGmCuZpSRopkhwF0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6M1tvQVxDKTLunwyY5ENMp/fgv1O4+f2pv6jOyEcyuQ=;
 b=55nX1man+kpE+9l/RSMhAYpCJdsnYsFBBLV92Ozscq0/IQTjQpfArLDxN6QJuBxUrBzLXy
 7GxQpxJjJ/zL68BA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 02/37] device: Add device::msi_data pointer and struct
 msi_device_data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:09 +0100 (CET)
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

Create struct msi_device_data and add a pointer of that type to struct
dev_msi_info, which is part of struct device. Provide an allocator function
which can be invoked from the MSI interrupt allocation code pathes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/device.h |    5 +++++
 include/linux/msi.h    |   12 +++++++++++-
 kernel/irq/msi.c       |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -45,6 +45,7 @@ struct iommu_ops;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
+struct msi_device_data;
 
 /**
  * struct subsys_interface - interfaces to device functions
@@ -374,11 +375,15 @@ struct dev_links_info {
 /**
  * struct dev_msi_info - Device data related to MSI
  * @domain:	The MSI interrupt domain associated to the device
+ * @data:	Pointer to MSI device data
  */
 struct dev_msi_info {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 	struct irq_domain	*domain;
 #endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct msi_device_data	*data;
+#endif
 };
 
 /**
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,6 +2,7 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
+#include <linux/spinlock.h>
 #include <linux/list.h>
 #include <asm/msi.h>
 
@@ -170,6 +171,16 @@ struct msi_desc {
 	};
 };
 
+/**
+ * msi_device_data - MSI per device data
+ * @lock:		Spinlock to protect register access
+ */
+struct msi_device_data {
+	raw_spinlock_t		lock;
+};
+
+int msi_setup_device_data(struct device *dev);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
@@ -185,7 +196,6 @@ struct msi_desc {
 			for (__irq = (desc)->irq;			\
 			     __irq < ((desc)->irq + (desc)->nvec_used);	\
 			     __irq++)
-
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
 {
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -73,6 +73,39 @@ void get_cached_msi_msg(unsigned int irq
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+static void msi_device_data_release(struct device *dev, void *res)
+{
+	WARN_ON_ONCE(!list_empty(&dev->msi_list));
+	dev->msi.data = NULL;
+}
+
+/**
+ * msi_setup_device_data - Setup MSI device data
+ * @dev:	Device for which MSI device data should be set up
+ *
+ * Return: 0 on success, appropriate error code otherwise
+ *
+ * This can be called more than once for @dev. If the MSI device data is
+ * already allocated the call succeeds. The allocated memory is
+ * automatically released when the device is destroyed.
+ */
+int msi_setup_device_data(struct device *dev)
+{
+	struct msi_device_data *md;
+
+	if (dev->msi.data)
+		return 0;
+
+	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&md->lock);
+	dev->msi.data = md;
+	devres_add(dev, md);
+	return 0;
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
