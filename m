Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E125C433E4
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26A0207D0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gm5cJgnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26A0207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 80E38204C5;
	Tue, 30 Jun 2020 04:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NWOooiOHKxI; Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 05381203A0;
	Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5389C0865;
	Tue, 30 Jun 2020 04:49:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95872C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7DE90203A0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1+F2qBtEHJvk for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by silver.osuosl.org (Postfix) with ESMTPS id 783BA20385
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 186so20978677yby.19
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=p5jMb0OYXUjKEO09icbDu9vKB8mUnjKS7ldJrGg6Yyk=;
 b=Gm5cJgnNdA4j8KoD0JqCp92eh1dOmKyWbRuaafAkp7j4Tiyi/4VrofOQLz3gqmH/1f
 vlpldBL1WmCe+59Bk7L3+Bu45rxpdaClWinZYlTrS4AghzmPY4sSK8SDAvo4ZHE4nVF8
 dD1LOwsfjMTY6dYL4PT5+7wRAPaZZTfGFryosjGQCzjr3GjbXbC0q8rP7WwUrkKK+129
 6iRr7B/3o9dNgxc+2YqyrOnydhVzjrhZ3STLNNjon1ze+cF/JTDek3hPTlrAhpXvbTf/
 RbztkalEnybqiFRfvvrtExkKkmnoIKChXrimpwJ7RbEd0qnfPPsRFLzGD/3RV9k79OtQ
 wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=p5jMb0OYXUjKEO09icbDu9vKB8mUnjKS7ldJrGg6Yyk=;
 b=EXnwRC2i70VEqKYLlzpZxNcWja3s0SMm6QhkfTaC6KVIHMp8zWrVrakMnWVaN1M0+t
 W8HwqWuPhGzR6fqHbpG3f8SQt863gpzMTAtoE3u0i1JIuZTPnrmR2p8qomD+bUYbYXXO
 dvBuTR6dzeQnmVTUpcEDhg7ZTwbRttge/BDRiG14Jkmsogiizc27uaz3JWK1GVPEI8DW
 bBuy6gTC5xyIzB5zEnCFS4U3Ra6eoqh5d8StAWbjUdCr9zD3AdNDWw4pLV8D5pvOsfdN
 tUt5iWB2GQr20ql2bAfbh/KvtZY7KdtI7T0ZliftJqH3G9YD89wHY58osRkXZmTEabSZ
 yCJg==
X-Gm-Message-State: AOAM5320QUFu+gK1gDBCxUk23/rhZJjetOeuILZfCRBSHAFKUdWx3TJi
 o/aXlh6BNPp5GVbBXA/djNJDmXe/yoZz
X-Google-Smtp-Source: ABdhPJzQYV+XpQGsCmrvbSL0LKYgWoNAocwQcR3CYTfyKumjchyuds/0xjCWulL4XB9xL8VDCCUqLfTZnHHz
X-Received: by 2002:a25:dfd2:: with SMTP id
 w201mr25555433ybg.230.1593492591375; 
 Mon, 29 Jun 2020 21:49:51 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:38 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external devices
 only
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>
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

The "ExternalFacing" devices (root ports) are still internal devices that
sit on the internal system fabric and thus trusted. Currently they were
being marked untrusted.

This patch uses the platform flag to identify the external facing devices
and then use it to mark any downstream devices as "untrusted". The
external-facing devices themselves are left as "trusted". This was
discussed here: https://lkml.org/lkml/2020/6/10/1049

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: cosmetic changes in commit log

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 13 +++++++------
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e982..1ccb224f82496 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->untrusted)
+		if (pdev->untrusted || pdev->external_facing)
 			return true;
 
 	return false;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 27839cd2459f6..22727fc9558df 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
 		if (node && of_property_read_bool(node, "external-facing"))
-			bus->self->untrusted = true;
+			bus->self->external_facing = true;
 	}
 
 	bus->dev.of_node = node;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a83..492c07805caf8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_set_untrusted(struct pci_dev *dev)
+static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
 
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
 		return;
 	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
 		return;
 
 	/*
-	 * These root ports expose PCIe (including DMA) outside of the
-	 * system so make sure we treat them and everything behind as
+	 * These root/down ports expose PCIe (including DMA) outside of the
+	 * system so make sure we treat everything behind them as
 	 * untrusted.
 	 */
 	if (val)
-		dev->untrusted = 1;
+		dev->external_facing = 1;
 }
 
 static void pci_acpi_setup(struct device *dev)
@@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
 		return;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
-	pci_acpi_set_untrusted(pci_dev);
+	pci_acpi_set_external_facing(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d87066a5ecc5..8c40c00413e74 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && parent->untrusted)
+	if (parent && (parent->untrusted || parent->external_facing))
 		dev->untrusted = true;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a26be5332bba6..fe1bc603fda40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -432,6 +432,14 @@ struct pci_dev {
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
 	unsigned int	untrusted:1;
+	/*
+	 * Devices are marked as external-facing using info from platform
+	 * (ACPI / devicetree). An external-facing device is still an internal
+	 * trusted device, but it faces external untrusted devices. Thus any
+	 * devices enumerated downstream an external-facing device is marked
+	 * as untrusted.
+	 */
+	unsigned int	external_facing:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
