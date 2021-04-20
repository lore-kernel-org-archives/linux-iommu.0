Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF3CC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 00:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF02D6113C
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 00:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF02D6113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59483403EC;
	Tue, 20 Apr 2021 00:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6m4gHO3XBNTb; Tue, 20 Apr 2021 00:31:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 430AC403F8;
	Tue, 20 Apr 2021 00:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07D67C000E;
	Tue, 20 Apr 2021 00:31:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83BB9C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 00:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D9DF82BE7
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 00:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o8iQkcguIKTw for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 00:30:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E31F82A26
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 00:30:54 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 s8-20020a5b04480000b029049fb35700b9so9570876ybp.5
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=bNgXJhmUMNU0+evBI0pwLRswhxIcDKwkEWyVTZBRyWM=;
 b=YMyx6nlQLOvFFAbDgx6YNaCaDDXI4bKsmSCOuAGO0YsJJJ59yBJF2nf3HETWFTNjn5
 BDX8iScXDXYTUnWky3x1kXAfYeMLKvBE0YioWYxQGrGa/5UaufNnBWvMq6fTt1h6CQgA
 RhCk3N9uDqyNr/SP43GyVK1rhtZglXDeI8U5CKiZsQBZAh9QBf1SaS9xL4XOX5wV6ECc
 2lGmJLgypOjwWc5ARVrQQeVPGSo32TiWyu7nQKIQxU7IkHVGg7gFusZeYEVGMs+diHcj
 xCd8VWtYTLr+2/fpdiwXbEMRE2Gj9Ax/NuxY6Hle6iO85ghyMZC7W7yUH7yZEdY0ZwPm
 y1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=bNgXJhmUMNU0+evBI0pwLRswhxIcDKwkEWyVTZBRyWM=;
 b=ZicI7+YT1EZMoeLcTdoaGdEIjAjObImrYPnLvfatvBQ3O9R9DUnydytFA1AVafrRUf
 hkKbluhaXXA5aolf28uEoOD0h6+5zeJjc68QA8BGhdTWnpwFWSvIhFC9m3Hy31+5of52
 MASikHuDsIteuSvSteHYs0N+bJMJp+W14XB1cU3iwg+LjSkn04WQCvADVIZyvoehPGfB
 mx/OqQq9GrOkds9bBv7Y4iWgcfIVrZKhtsmC2Z/y/S2EEcKZqw0fubUpwULWbCSfLkmJ
 BL7yvuuLZHrwKsvtHQeT+BjT8xF5Ca1EHZxcsZnqMRbyKKIslNVE8Ouwg9KWqJTa0+yu
 s5fA==
X-Gm-Message-State: AOAM532J763YTlxIPokSYGfBaiYJbU+fI1OkfUo0YfOW70YobKEPUCQK
 jz6bvosRWLiv0J76/d17O5cfaM6ER40m
X-Google-Smtp-Source: ABdhPJzYECDDmH5bXKjr9Mc2Uw3fMf3epk4bPJCmrRAN7UOb1sYVsXXlsZMAhBN08iQSSyEeHiOTuRJlOFYn
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:6933:e454:f68:b2b4])
 (user=rajatja job=sendgmr) by 2002:a25:bb41:: with SMTP id
 b1mr20366575ybk.249.1618878653410; Mon, 19 Apr 2021 17:30:53 -0700 (PDT)
Date: Mon, 19 Apr 2021 17:30:49 -0700
Message-Id: <20210420003049.1635027-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] pci: Rename pci_dev->untrusted to pci_dev->external
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
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

The current flag name "untrusted" is not correct as it is populated
using the firmware property "external-facing" for the parent ports. In
other words, the firmware only says which ports are external facing, so
the field really identifies the devices as external (vs internal).

Only field renaming. No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/iommu/dma-iommu.c   |  2 +-
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 12 ++++++------
 drivers/pci/quirks.c        |  2 +-
 include/linux/pci.h         |  9 +--------
 8 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..14769c213f30 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -313,7 +313,7 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 
 static bool dev_is_untrusted(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->external;
 }
 
 /**
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..965cc78e0dde 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5511,7 +5511,7 @@ intel_iommu_domain_get_attr(struct iommu_domain *domain,
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->external) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..abdedc98f3c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1482,7 +1482,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->external)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0d3719407b8b..0d17fb4a15bf 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->external == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..ec98892389d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -886,7 +886,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices */
-	if (dev->external_facing || dev->untrusted)
+	if (dev->external_facing || dev->external)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..ae4800e82914 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1562,17 +1562,17 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 	}
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void set_pcie_external(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
 	/*
-	 * If the upstream bridge is untrusted we treat this device
-	 * untrusted as well.
+	 * If the upstream bridge is external we mark this device
+	 * external as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->external || parent->external_facing))
+		dev->external = true;
 }
 
 /**
@@ -1814,7 +1814,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	set_pcie_external(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..1054b7d9ee89 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4942,7 +4942,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (dev->external_facing || dev->untrusted)
+	if (dev->external_facing || dev->external)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..a535e2c2b690 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -431,14 +431,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-	/*
-	 * Devices marked being untrusted are the ones that can potentially
-	 * execute DMA attacks and similar. They are typically connected
-	 * through external ports such as Thunderbolt but not limited to
-	 * that. When an IOMMU is enabled they should be getting full
-	 * mappings to make sure they cannot access arbitrary memory.
-	 */
-	unsigned int	untrusted:1;
+	unsigned int	external:1;             /* Device sits on an external PCI bus */
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.31.1.368.gbe11c130af-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
