Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D6BC433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 17:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F19C783E47;
	Tue, 26 Apr 2022 17:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2NWuD1i8qsQ; Tue, 26 Apr 2022 17:21:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94FFB83E4D;
	Tue, 26 Apr 2022 17:21:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 684BCC0039;
	Tue, 26 Apr 2022 17:21:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE89C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B772840B74
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5twHkH4TP6IW for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:21:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF17740499
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 17:21:12 +0000 (UTC)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2f7ee6bc6ddso53496537b3.1
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=PI6P4hVmL5VSlNStDa8yoRCKf8zCtm5J26ICwUjLazU=;
 b=nmszqekbq0eqmAOrxhoxhpOUtjONopanoK4BLzf6Y7SO0MdbDpxoPMN7TldeHuYxU1
 FAcxQslQWcISEhOLRyXucSQvrVGbNevk/n9eGT7cC0ffdZLPqDnqWVJIe+Li9DrIsc65
 Ip3Upkx2bX5Bn8uFUpWeoJklm9//BrntC9OYtGHiowTnSikOduUyBEq67k2Pdfdd3hrW
 +JSXGuRf1XPyXek3iJppsuE/1YIxw+L9FcPhOf6A9WZGIkG+vwrYyMyP5udv4FKGosh2
 d5Ve8EwwsNt7sA1X4j0zlzgBiI5lO1ZC4ydpfkbf8CtwIMqSFXtPfocTcYO4s4ezzpbW
 VlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=PI6P4hVmL5VSlNStDa8yoRCKf8zCtm5J26ICwUjLazU=;
 b=Wc4svdJHaSSmFpzjcqphteJwP8dmmSY2+j8rqA7WzSkN+P3mrJg9B7OLabs79emWaE
 6WTzB8C1GJQg8lsuDC0VI88srJX2rl0lsY6rkXANlciuOoumr7MYzDEWBDYV2X0nMSu3
 FFcqWCSOZU64kv7rSjfGKVMOEpblIdsLvC2Qv3QKBzgLdVAaoTM7sXYvJRQZnQl07OEu
 sv/IB7bHGHqXVTnJDISvaLbDV7E1DI0WklHtAspzG8blrnYfyUwd+vqfvM9lNbDVXDoQ
 XBPMG05u1i3SWBYMaPtKkS6WGIHmiUf+CYC9UskxlyWACZ/9727XOQL0Jrl8Hd4E8wYg
 ulzQ==
X-Gm-Message-State: AOAM531gHZtIX+yaUHbfCBus72ZDI2oS4hQLRME6FYc7GVL2mfopsz3y
 Nmqk+dJoHqg91UfcA602lHiIk3tXsEGi
X-Google-Smtp-Source: ABdhPJxATiLz5ywsTWoQ7JirGS+mZuGjN5/d7L930okabHwvzFCdATmA+VcGAs6znkMpr/Vyp7vGVBotprXt
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:ce74:273e:a60f:b750])
 (user=rajatja job=sendgmr) by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr11938019ywj.42.1650993671724; Tue, 26
 Apr 2022 10:21:11 -0700 (PDT)
Date: Tue, 26 Apr 2022 10:21:05 -0700
In-Reply-To: <20220426172105.3663170-1-rajatja@google.com>
Message-Id: <20220426172105.3663170-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220426172105.3663170-1-rajatja@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v7 2/2] PCI: Rename pci_dev->untrusted to
 pci_dev->untrusted_dma
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rajat Jain <rajatxjain@gmail.com>, 
 Dmitry Torokhov <dtor@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Pavel Machek <pavel@denx.de>,
 "Oliver O'Halloran" <oohall@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 iommu@lists.linux-foundation.org
Cc: Rajat Jain <rajatja@google.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Rename the field to make it more clear, that the device can execute DMA
attacks on the system, and thus the system may need protection from
such attacks from this device.

No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v7: Added Lu Baolu's "Reviewed by" tag.
v6: No change in this patch, rebased on top of changes in other patch.
v5: Use "untrusted_dma" as property name, based on feedback.
    Reorder the patches in the series.
v4: Initial version, created based on comments on other patch

 drivers/iommu/dma-iommu.c   | 6 +++---
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/iommu.c       | 2 +-
 drivers/pci/ats.c           | 2 +-
 drivers/pci/pci-acpi.c      | 2 +-
 drivers/pci/pci.c           | 2 +-
 drivers/pci/probe.c         | 8 ++++----
 drivers/pci/quirks.c        | 2 +-
 include/linux/pci.h         | 5 +++--
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..aeee4be7614d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_has_untrusted_dma(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
 }
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_has_untrusted_dma(dev);
 }
 
 /**
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..b88f47391140 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4843,7 +4843,7 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->untrusted_dma) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..d8d3133e2947 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1525,7 +1525,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..477c16ba9341 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->untrusted_dma == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 8cb4725d41fa..bf04e873c96a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1396,7 +1396,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->untrusted_dma |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..1fb0eb8646c8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..d2a9b26fcede 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_untrusted_dma(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
@@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->untrusted_dma || parent->external_facing))
+		dev->untrusted_dma = true;
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_untrusted_dma(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 41aeaa235132..583d35968413 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5135,7 +5135,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..2453a794bdb2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,13 +444,14 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-	 * Devices marked being untrusted are the ones that can potentially
+	 * Devices marked with untrusted_dma are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
 	 * through external ports such as Thunderbolt but not limited to
 	 * that. When an IOMMU is enabled they should be getting full
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
-	unsigned int	untrusted:1;
+	unsigned int	untrusted_dma:1;
+
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
