Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52F5C433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9558B61C33;
	Sat, 27 Nov 2021 01:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGzQwbahG1Wf; Sat, 27 Nov 2021 01:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A9B061C2C;
	Sat, 27 Nov 2021 01:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B162C0039;
	Sat, 27 Nov 2021 01:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64157C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DE7F61C27
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44rezg9ZAu-f for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C31B561C19
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:59 +0000 (UTC)
Message-ID: <20211126230525.432148049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=R5e0O3/cPtKTz28swaAQpwxXJzIJ0KDZCypBX7NJJUs=;
 b=hpzto8xhzukk8u1nkwN7EwRdyUWjhTaFiWPVDlIDyIm9oYdJqJFHG/jfbCvpcm0oxZpg+5
 eWxQ4GVS0y5UGVPpgpEgLMcGXJ5aBcdV5Ujwk7RB/lD/HJ0KaAhmoTgPDIWsH9XA3D7+UM
 I6Ppx4+amHWSzHx+RyAalrR8QWto+sufEwyh6BsVc1a1U8dHMSDnCScjdvUnDP8QDBJ+ht
 hNa0NfxG8ICKcn4KdwTO6hVcDzXlNw50STzwPA7NPed+n7lfC2vtA3k4nDowG0lj3fQDIs
 DEs5L5IGI7lwvRaC7yzep9kjveMBRwJ6d3XqnBkAjAAK4QsxOVxRdYbi6gJ2JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=R5e0O3/cPtKTz28swaAQpwxXJzIJ0KDZCypBX7NJJUs=;
 b=gxRmusEFoJeTCxrfFUtXFJtogB8UJhbO1ZUCrqk8bW1piXnXCa6Xeg36Y3VSuB83/DJc2o
 XcTUN9Z1ds2TyuAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 25/37] powerpc/pseries/msi: Use MSI device properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:57 +0100 (CET)
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
Message-ID: <20211127012157.vUz1hoLpEY42HvllkHrt6iSDC8rqcQfqegvljMmRlUk@z>

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,9 +447,9 @@ static int rtas_prepare_msi_irqs(struct
 static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev,
 				   int nvec, msi_alloc_info_t *arg)
 {
+	bool is_msix = msi_device_has_property(dev, MSI_PROP_PCI_MSIX);
+	int type = is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-	int type = desc->pci.msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
