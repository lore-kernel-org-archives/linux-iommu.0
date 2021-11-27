Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B86C433F5
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 191CE40562;
	Sat, 27 Nov 2021 01:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-U4IwjntAjz; Sat, 27 Nov 2021 01:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05CEB4095D;
	Sat, 27 Nov 2021 01:20:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2292C001C;
	Sat, 27 Nov 2021 01:20:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1289FC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AEA140576
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="UggVVv3f";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="KjHrEnrG"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DoHNib4nu5oq for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C5AF40574
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:41 +0000 (UTC)
Message-ID: <20211126230525.137299282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
 b=UggVVv3f7QCjME5pjLx9J0hsxvfwEK88RAs5+In+TDQQ49/kKJE/4UBeSm9ZmjOA3ObLqP
 RsQuoCiENoW9YWD6uVKBIaFEfiXZtiUA08HDqEG1GpZjdIXrtx2v7bjgs5y6sTpxr2DQVA
 /dKkq3qcWWn1VZjG9liURMDeIHNbl/xUG3O/brsKYly5bzbVoe+4DfLAT2w+cOXQs188b9
 U3cNtwx6+wWxxHiA4/bh4AnrsFJmkU3lZlUxoJ+pijTSavjP+DhwwYBqOLB/XscIqzEUw0
 Ovy3cNm8ATuXUVs96hhg2BgomxXlWEh+swP3glYt48WR6vFYpyUno12lQdyhAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
 b=KjHrEnrG0fpDzTmWoCzq7Si7jPR+/lr5hq4rxoNYcQ2Ul/fX9e3zQDEhrh98Csz5sTQmgO
 gbeMniPwqgDOT0Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 20/37] PCI/MSI: Store properties in device::msi::data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:39 +0100 (CET)
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

Store the properties which are interesting for various places so the MSI
descriptor fiddling can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;
 	}
+
+	dev->dev.msi.data->properties = 0;
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -372,6 +374,9 @@ msi_setup_entry(struct pci_dev *dev, int
 	if (entry->pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
+	dev->dev.msi.data->properties = MSI_PROP_PCI_MSI;
+	if (entry->pci.msi_attrib.is_64)
+		dev->dev.msi.data->properties |= MSI_PROP_64BIT;
 out:
 	kfree(masks);
 	return entry;
@@ -514,6 +519,7 @@ static int msix_setup_entries(struct pci
 		if (masks)
 			curmsk++;
 	}
+	dev->dev.msi.data->properties = MSI_PROP_PCI_MSIX | MSI_PROP_64BIT;
 	ret = 0;
 out:
 	kfree(masks);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
