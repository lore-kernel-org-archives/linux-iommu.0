Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE2C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176DC2064C
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pXZcXhxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176DC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2D4B89413;
	Tue,  7 Jul 2020 22:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6+5LGCSGLwY; Tue,  7 Jul 2020 22:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF06B89410;
	Tue,  7 Jul 2020 22:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3E6AC0893;
	Tue,  7 Jul 2020 22:46:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32131C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2080F89411
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeflUlFWrBqj for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 22:46:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 36DB889410
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 22:46:12 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id y36so27980769qvf.21
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=+Rqxcc67bWamHPT9UuHLq9P/O36CYZQMOcdNpnmmIao=;
 b=pXZcXhxz7mxW6RS7gJAv+NztP6PWIdXUddf5RV8kHRHOgSQsBTRWQ1kS6KDZwaXyYH
 yoGbwYV+lo5tqx0FRClBaQgvoKziBo4h6Z7fY1r8opn1GwexWSqz0HsRK5lgFzCx7Hto
 oJF9FQRenEaECQh4qFBYY48A456Srf7zC3wEtpl4CRGFVns2fUaYYgnA3QLbCwBlEBGe
 r2o2LBmx6Z1RS0/swh8B4gpLLRumQtdkajRNwjGtDHeKjMr7XzLJ7xp7rZtaSPPwl75U
 lK06Fba7oS0Ta8x3kR5Y+4Elrw6RS0PJg+Obk1PPaGMj5vur2Pd782/vmR1grIYi8RhN
 VFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=+Rqxcc67bWamHPT9UuHLq9P/O36CYZQMOcdNpnmmIao=;
 b=JSbd1KPvIp0rEeIbYQrZdsvDDohC5+MwlAumpDOGHjPZ/av3ieKVcUfftRkFuVPfZR
 G1oN6cFieTmvbxKgCOonnqn+VBEHjL+zg8aBSsLo0opEbNack1FWpCZtB8Yg2Hr5XtQb
 IvqJxtlCxYpdq4Lyi/YadMpK2XMLxlib0U55ledo3tpudWRycW/Bbm5GCIMhFXuz25il
 NeN9antTn2ya0vwrqW2pdlM2hPLRM+3BwUZVH4UO6aKwdNBqBiBJEzKzlXn5z+f6HsLZ
 GwOBdGvRDi5w3rlAHwxbMlyfEHf3l59TBUlhSYdrDMM3+WQ5ofaqBUJ3p2PUhQknLPw2
 T9xQ==
X-Gm-Message-State: AOAM531tPYw3sSVKrYzITYiPiArpj4vkOLU3jPpl96u4woLzADeRlMif
 tHpix9SKf5VOXoGFDIk7kFWqKtKs+fe7
X-Google-Smtp-Source: ABdhPJxnH+92NoVCcK7NZHV4Ls6bngx8p8nimLUooSLS2gVZpS5/6IxaAi2WM9zBZzRgEB7nYKaxRQqv7qfK
X-Received: by 2002:a05:6214:18f2:: with SMTP id
 ep18mr41966212qvb.96.1594161971125; 
 Tue, 07 Jul 2020 15:46:11 -0700 (PDT)
Date: Tue,  7 Jul 2020 15:46:03 -0700
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Message-Id: <20200707224604.3737893-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200707224604.3737893-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4 3/4] PCI: Treat "external-facing" devices as internal
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

The "ExternalFacingPort" devices (root ports) are internal devices that
sit on the internal system fabric. Ref:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

Currently they were treated (marked as untrusted) at par with other
external devices downstream those external facing rootports.

Use the platform flag to identify the external facing devices and then
treat them at par with internal devices (don't mark them untrusted).
Any devices downstream continue to be marked as "untrusted". This was
discussed here:
https://lore.kernel.org/linux-pci/20200610230906.GA1528594@bjorn-Precision-5520/

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: No change
v3: * fix commit log and minor code comment
    * Don't check for "ExternalFacingPort" on PCI_EXP_TYPE_DOWNSTREAM
    * Check only for pdev->external_facing in iommu.c
v2: cosmetic changes in commit log

 drivers/iommu/intel/iommu.c |  6 +++---
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 10 +++++-----
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e982..4f0f6ee2d4aaa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4738,12 +4738,12 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static inline bool has_untrusted_dev(void)
+static inline bool has_external_pci(void)
 {
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->untrusted)
+		if (pdev->external_facing)
 			return true;
 
 	return false;
@@ -4751,7 +4751,7 @@ static inline bool has_untrusted_dev(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_untrusted_dev())
+	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
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
index 7224b1e5f2a83..43a5158b2b662 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,7 +1213,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_set_untrusted(struct pci_dev *dev)
+static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
 
@@ -1223,12 +1223,12 @@ static void pci_acpi_set_untrusted(struct pci_dev *dev)
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
@@ -1240,7 +1240,7 @@ static void pci_acpi_setup(struct device *dev)
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
index 0ca39042507ce..281be857d2430 100644
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
+	 * device enumerated downstream an external-facing device, is marked
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
