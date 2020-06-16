Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF5C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7ED20768
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cY5+g1xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7ED20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A5E687D6B;
	Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kzcl02f2sAr3; Tue, 16 Jun 2020 01:17:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F268987D51;
	Tue, 16 Jun 2020 01:17:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF179C0890;
	Tue, 16 Jun 2020 01:17:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1BCC016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1AF3887D51
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPyXxBug8FY7 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 01:17:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E64C87D6B
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:51 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id y2so14435764qvp.1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=w48/vZpRpHgwBvOvRR4dLXxoxTIWLJ/Tbv3NQjwroMA=;
 b=cY5+g1xIvZJv6zrortzaOeWv8O0xGNvfzNtSs5QO9rdIHlGVT63x/y8HsaA7Ib48Di
 +zk6NkCUybBACqHinSCBe5fb681ZFWv7+SScnvQki/3J6tzCTkIcqCWzdk8i7ExNyt50
 EEv3I0+v4Fz9g52dxJaxX8X425L7dd0CZB9zzvO7vdTTmwn3+XLNJskqQDiZWaCsF5xQ
 59sc88DqoHxtpcAU/f2NRM1qX9hahvquMvjcGOWIR/tg6rVcSUfdF2J7zhQun5kLBJC8
 qeRgb18EhgUZ4eNJLdyZmo8JGYMxGTgLHsgMdGy1FgS/10j2IUj4BbI9hZMUi1uTGqRP
 vJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=w48/vZpRpHgwBvOvRR4dLXxoxTIWLJ/Tbv3NQjwroMA=;
 b=t2AN3DrdyR4cLtzCWXH9IREpf6FzAmo2UGuePaej2ebyg3GOO5KZYtzdmGU17OfY5u
 MJ75Q0SdioPQEAamgDeDvmysYsgMwskAii7uzMYHH5TDvYK5gb16/vQeDepgW6xpBjhg
 JlcBr6CaJIMXQbxCaJJTRXRHWIhqgB9ywdzX0FLhIE9hExLF8yRTXjDxXAJ1YZS+HDHd
 pOedrinIHXvVrErH7fDVi7mrnuZIgQFWBCW1w2mcsnXA+su+faEc/9Vqht8Vcl1TshFb
 wUGajYZlWKxz9eDUorpHxvFiRprtyRQNjaREqeMwW6xFHMT7vUPGyelxQ9Q74G2r+MEv
 IOMQ==
X-Gm-Message-State: AOAM530KymrEMk3IZHyGEUiF+wAXuHoiLvCpyO3pa5efkjMzPNYUvI9m
 EjZ32taMCflsSIxeI1Odkwwp5s3n+/8E
X-Google-Smtp-Source: ABdhPJwZZbFOZsLZEoNiGS8uCk3JSEs+IYRXiB58zA0V9PGwAgSl+E0UZUh/CeZFnX4u8WZSP/gPN0YL5jNf
X-Received: by 2002:a05:6214:b30:: with SMTP id w16mr6887qvj.28.1592270269984; 
 Mon, 15 Jun 2020 18:17:49 -0700 (PDT)
Date: Mon, 15 Jun 2020 18:17:40 -0700
In-Reply-To: <20200616011742.138975-1-rajatja@google.com>
Message-Id: <20200616011742.138975-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 2/4] pci: set "untrusted" flag for truly external devices only
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com
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

The "ExternalFacing" devices (root ports) are still internal devices
that sit on the internal system fabric and thus trusted. Currently they
were being marked untrusted - likely as an unintended border case.

This patch uses the platform flag to identify the external facing devices
and then use it to mark any downstream devices as "untrusted". The
external-facing devices themselves are left as "trusted". This was
discussed here: https://lkml.org/lkml/2020/6/10/1049

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 13 +++++++------
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9129663a7406b..1256ca89fb519 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4735,7 +4735,7 @@ static inline bool has_untrusted_dev(void)
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
2.27.0.290.gba653c62da-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
