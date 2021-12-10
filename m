Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F3C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 364D7418E2;
	Fri, 10 Dec 2021 22:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2ZIYko1W1VO; Fri, 10 Dec 2021 22:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D56C2418E4;
	Fri, 10 Dec 2021 22:18:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C8A8C0073;
	Fri, 10 Dec 2021 22:18:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAA0C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 878C885348
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="pE4rQ2ru";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="4a4+C7Wh"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ykLLarx3bo6Y for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E15C78515F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:51 +0000 (UTC)
Message-ID: <20211210221813.434156196@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=VrU+cUwVNt/tRlW4lw+bzWjrRhpWxr0n5kAnta20rq4=;
 b=pE4rQ2ru1rC+MOxwgCFck9hIsKI0LjZICNGNwEw8ze9/meweY1qANt4dgwIHKfQOPC1beg
 yPBns7caG7PjSlQkEoMvTCi/DDid/5ijo+pcU/3ZLIE1LS+qQRJIeuxZj2Mi/GYsUgFxDG
 UfE4buF12pfMJCkH4E7kXOGXF3Tdxoadhmimlb4Oqaa6At4sxsqGTcRd4XwvSUVolW7xT/
 BZ6l4WzdOdHBFzRU8fuHCGeKVTvU3fpMB68bg/XbArySIyUaHyjLg/eiywsouAZhDcRfnk
 7ETqReSwtzm9CpcynGCRQWFvda5xRxitOgtngCsHnX2u5kMmZ6hOfaZO1ylegg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=VrU+cUwVNt/tRlW4lw+bzWjrRhpWxr0n5kAnta20rq4=;
 b=4a4+C7WhuYdeuyTtWKdNyTdvLDhhfziSubOZ+5mUXlzgk+OuqIM6rjcLPfL3/GtWFOnIFc
 gcXKQZiyuUQutAAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 04/35] genirq/msi: Use PCI device property
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:18:49 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

From: Thomas Gleixner <tglx@linutronix.de>

to determine whether this is MSI or MSIX instead of consulting MSI
descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use PCI device property - Jason
---
 kernel/irq/msi.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -77,21 +77,8 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct msi_desc *entry;
-	bool is_msix = false;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	if (dev_is_pci(dev))
-		is_msix = entry->pci.msi_attrib.is_msix;
+	/* MSI vs. MSIX is per device not per interrupt */
+	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
 
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
