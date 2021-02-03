Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F7C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B088864FAD
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B088864FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A18286239;
	Wed,  3 Feb 2021 20:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7uaOpdgaN4XE; Wed,  3 Feb 2021 20:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5038F86234;
	Wed,  3 Feb 2021 20:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E092C1E74;
	Wed,  3 Feb 2021 20:57:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61DBCC013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 49C9187164
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L5Zfieq0LEoZ for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 20:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0FC09871A8
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:29 +0000 (UTC)
IronPort-SDR: rjTBGKekQv95A7uGXBs2Xcn5tkTHfJ0nDZ5hCAuIGzhVHEzBeFOH0rDzTfxwmmRV4tuCDz3MWx
 F3s1oct0zcAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160875291"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="160875291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 12:57:28 -0800
IronPort-SDR: VhbifczPcXhDwHkb/ZHA/S9Oq+urvMYrbvav4fHs8Grqtb1TY7uqLIePZwzijvKOn62Hn9xw9k
 TuLfQiddyJ2Q==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="372510548"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 03 Feb 2021 12:57:28 -0800
From: Megha Dey <megha.dey@intel.com>
To: tglx@linutronix.de
Subject: [PATCH 02/12] x86/msi: Rename and rework pci_msi_prepare() to cover
 non-PCI MSI
Date: Wed,  3 Feb 2021 12:56:35 -0800
Message-Id: <1612385805-3412-3-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

Rename it to x86_msi_prepare() and handle the allocation type setup
depending on the device type.

Add a new arch_msi_prepare define which will be utilized by the upcoming
device MSI support. Define it to NULL if not provided by an architecture
in the generic MSI header.

One arch specific function for MSI support is truly enough.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 arch/x86/include/asm/msi.h          |  4 +++-
 arch/x86/kernel/apic/msi.c          | 27 ++++++++++++++++++++-------
 drivers/pci/controller/pci-hyperv.c |  2 +-
 include/linux/msi.h                 |  4 ++++
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index b85147d..9bd214e 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -6,9 +6,11 @@
 
 typedef struct irq_alloc_info msi_alloc_info_t;
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
+#define arch_msi_prepare		x86_msi_prepare
+
 /* Structs and defines for the X86 specific MSI message format */
 
 typedef struct x86_msi_data {
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 44ebe25..84b16c7 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -153,26 +153,39 @@ static struct irq_chip pci_msi_controller = {
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+static void pci_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
+	struct msi_desc *desc = first_msi_entry(dev);
 
-	init_irq_alloc_info(arg, NULL);
 	if (desc->msi_attrib.is_msix) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 	}
+}
+
+static void dev_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
+{
+	arg->type = X86_IRQ_ALLOC_TYPE_DEV_MSI;
+}
+
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	init_irq_alloc_info(arg, NULL);
+
+	if (dev_is_pci(dev))
+		pci_msi_prepare(dev, arg);
+	else
+		dev_msi_prepare(dev, arg);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
+EXPORT_SYMBOL_GPL(x86_msi_prepare);
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= x86_msi_prepare,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6db8d96..bfb47c2 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1546,7 +1546,7 @@ static struct irq_chip hv_msi_irq_chip = {
 };
 
 static struct msi_domain_ops hv_msi_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= arch_msi_prepare,
 	.msi_free	= hv_msi_free,
 };
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 360a0a7..89acc76 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -467,4 +467,8 @@ static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
+#ifndef arch_msi_prepare
+# define arch_msi_prepare	NULL
+#endif
+
 #endif /* LINUX_MSI_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
