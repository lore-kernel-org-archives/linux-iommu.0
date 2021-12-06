Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A864C433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C75984BFE;
	Mon,  6 Dec 2021 22:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WkDhYENExJT; Mon,  6 Dec 2021 22:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B3FD84BF6;
	Mon,  6 Dec 2021 22:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA73C001E;
	Mon,  6 Dec 2021 22:39:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA08C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 498D640469
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="qT4xZpBB";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="pP/dPC6P"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0M2xix2eb0_k for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A942541C57
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:38 +0000 (UTC)
Message-ID: <20211206210439.021277807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=OQ0f5KjFgbSgmAVP4hnPtoqFO6q3+Ey9wT8c/Y+fgX8=;
 b=qT4xZpBBQ0W0WAPiWf1zJJDYqrWw+ae2Lg455lzO/6P3dumvTkmmO4OyNNpV7Ehjg/w2fl
 manHJleIsU6+wlUO34qbZ1k6P6+fjxe8BUkOz6OIEK3o0dKzrtvUgPypQwoUUUNIuZDXWM
 jnT7oY4poA/FbJovF4S/oz4eehalct4S0HCuDJJLpJBmvaR5HibVjBTc7GIHDoqZivOfX3
 iNd/9PdHT8ILfKUVyXiifKPtOz1VtZWGnO4Nr1SM+0tOgRkRXdJgokjEVSeB/BR9gvjNQB
 gsA5BgMNnlWPVbKtzFcSx9515yBP8sGdsrFziNqK9jyPrTDomPQd0ggxKPGeng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=OQ0f5KjFgbSgmAVP4hnPtoqFO6q3+Ey9wT8c/Y+fgX8=;
 b=pP/dPC6PWwsNwzwAXjslgxnuRXxlApMSk05YyUr2uPuStX/4iB4GmcP+0fnXmnf907i7Do
 3vW65Ey/2ZjD8lDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 25/36] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:36 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

Provide a domain info flag which makes the core code check for a contiguous
MSI-X index on allocation. That's simpler than checking it at some other
domain callback in architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/msi/irqdomain.c |   16 ++++++++++++++--
 include/linux/msi.h         |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -89,9 +89,21 @@ static int pci_msi_domain_check_cap(stru
 	if (pci_msi_desc_is_multi_msi(desc) &&
 	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
 		return 1;
-	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
-		return -ENOTSUPP;
 
+	if (desc->pci.msi_attrib.is_msix) {
+		if (!(info->flags & MSI_FLAG_PCI_MSIX))
+			return -ENOTSUPP;
+
+		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
+			unsigned int idx = 0;
+
+			/* Check for gaps in the entry indices */
+			for_each_msi_entry(desc, dev) {
+				if (desc->msi_index != idx++)
+					return -ENOTSUPP;
+			}
+		}
+	}
 	return 0;
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -376,6 +376,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 	/* Populate sysfs on alloc() and destroy it on free() */
 	MSI_FLAG_DEV_SYSFS		= (1 << 7),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
