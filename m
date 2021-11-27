Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D9C2BB1D
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B955D82D0F;
	Sat, 27 Nov 2021 01:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6_qLJWyA0jdt; Sat, 27 Nov 2021 01:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA3F082D49;
	Sat, 27 Nov 2021 01:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4873CC003E;
	Sat, 27 Nov 2021 01:21:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 503EFC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4770B4058C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="hy97HFE6";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="DfYv5Qo1"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJJ3sdWOy0w5 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82D3D40579
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:51 +0000 (UTC)
Message-ID: <20211126230525.137299282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
 b=hy97HFE6I814pV4rx+xUrwuUAhL4IUA798mts+smaySzKuUadOTBalyUe9VTE3Hx8vG+TZ
 hIuTfOk36OH3vQYQZefI5I3Rw3EAi8HCjA/3s6icu+vdv2PFRY7dWD3CUk+dgwwntHLSFg
 YyNTHMOWkiuKCIWIb0zFBNJpiz69LHC5rMFKk3ShYcanbbVttRGLGrJZCnI6+Ecd/BlckC
 OEvsof342hr0uLMAcDan61lIqCeE6/Kee5YFN6JIGUB30gTy4531wLcwnPea6KcxvzCp4M
 gjKx6hMBTQKuf2Ls44rtIPD7505IuqKnel6KsjHMq+66g5dCaastAkR/IPEcWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=ZWaHMo5/cxTSb8aCm3CN77ES3jPYHd9BeCyQKbhAf1Q=;
 b=DfYv5Qo1fNDyy/u2FnjloE8DeN/fnIR0Tl+Jv4cf71yMysYcKARkCZEL1g1Y02rzlDPgNE
 w4pJ5/U3r3YQu1Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 20/37] PCI/MSI: Store properties in device::msi::data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:49 +0100 (CET)
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
Message-ID: <20211127012149.uUgwCSr03GpomIN406kFMDARrLI-5ScwoD_CQtRFzlE@z>

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
