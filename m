Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B7C4332B
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D5764F36
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5764F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75BE64F0A9;
	Fri, 26 Feb 2021 20:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LtBNUbJVr49B; Fri, 26 Feb 2021 20:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 353D94F0C4;
	Fri, 26 Feb 2021 20:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7D1C0013;
	Fri, 26 Feb 2021 20:11:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43C0BC001B
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E5D24F0AA
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmb3S4w-UI78 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 20:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1796C4F092
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:16 +0000 (UTC)
IronPort-SDR: GTLkPUhnd71Hs8aFvbwJA5FSt6GF9o3iUaeV1URjZy0k/HTneJG8VurbVrU5eBumErRFrZtjZ9
 DGoKipMSOWfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="186039466"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="186039466"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 12:11:15 -0800
IronPort-SDR: nb0fcvfHHm0m8Hdy1+xls3a8hEnYNqDlXOEEWSI1luFshB5X1P5oXgEgsXgT8eoI0Qn46ShK9E
 yLC1P6ZemW2g==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="405109464"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 26 Feb 2021 12:11:15 -0800
From: Megha Dey <megha.dey@intel.com>
To: tglx@linutronix.de
Subject: [Patch V2 13/13] genirq/msi: Provide helpers to return Linux
 IRQ/dev_msi hw IRQ number
Date: Fri, 26 Feb 2021 12:11:17 -0800
Message-Id: <1614370277-23235-14-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, megha.dey@intel.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, dwmw@amazon.co.uk
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Dave Jiang <dave.jiang@intel.com>

Add new helpers to get the Linux IRQ number and device specific index
for given device-relative vector so that the drivers don't need to
allocate their own arrays to keep track of the vectors and hwirq for
the multi vector device MSI case.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 24abec0..d60a6ba 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -451,6 +451,8 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg);
 void platform_msi_domain_free_irqs(struct device *dev);
+int msi_irq_vector(struct device *dev, unsigned int nr);
+int dev_msi_hwirq(struct device *dev, unsigned int nr);
 
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 047b59d..f2a8f55 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -581,4 +581,48 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
 	return (struct msi_domain_info *)domain->host_data;
 }
 
+/**
+ * msi_irq_vector - Get the Linux IRQ number of a device vector
+ * @dev: device to operate on
+ * @nr: device-relative interrupt vector index (0-based).
+ *
+ * Returns the Linux IRQ number of a device vector.
+ */
+int msi_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct msi_desc *entry;
+	int i = 0;
+
+	for_each_msi_entry(entry, dev) {
+		if (i == nr)
+			return entry->irq;
+		i++;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(msi_irq_vector);
+
+/**
+ * dev_msi_hwirq - Get the device MSI hw IRQ number of a device vector
+ * @dev: device to operate on
+ * @nr: device-relative interrupt vector index (0-based).
+ *
+ * Return the dev_msi hw IRQ number of a device vector.
+ */
+int dev_msi_hwirq(struct device *dev, unsigned int nr)
+{
+	struct msi_desc *entry;
+	int i = 0;
+
+	for_each_msi_entry(entry, dev) {
+		if (i == nr)
+			return entry->device_msi.hwirq;
+		i++;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(dev_msi_hwirq);
+
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
