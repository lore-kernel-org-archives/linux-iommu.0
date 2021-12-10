Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AE9C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DADA261B4E;
	Fri, 10 Dec 2021 22:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvGNxrw5TJIF; Fri, 10 Dec 2021 22:19:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC59661B61;
	Fri, 10 Dec 2021 22:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48DC4C0072;
	Fri, 10 Dec 2021 22:19:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 716D7C001E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B70E418DD
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="VY9AhPc6";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="nm4LR+v2"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDne8EpIurJY for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 201D7418E7
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:39 +0000 (UTC)
Message-ID: <20211210221815.269468319@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=vWoIYZmWx3H0h9pFUJiUBADTUR4l5NcbszlCZMu1Kwk=;
 b=VY9AhPc6Y86iy9XnKaKC022X5LX2E1Sin0mw6tqrZ3osyzhE+2W7SgnSBOgXimvkWKulED
 l4AuEUnopvI0lV/tgmo9e24Dfo6ML2fTsHk9X0iLcJ22dC2ADIYHepaTVbk5XFH3pO3wRH
 29E4/m4y7LIeWYmEDeaZq0LcdgImdDpC2mfPGC6zarCUVVtau23HzuA1JELcqLNznzIKv/
 EiD8V5EophlaHy5XIW5/kNy//V9j9uzcT0LENNV9cAgIYxQ/RjQU3v+6A+2zr9hQU7S1ZZ
 XsNiTChg6t09pw/yjxLmwIAqVQpTFeYErMOSAEzKecIm846Z0MDkmHqG1chyoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=vWoIYZmWx3H0h9pFUJiUBADTUR4l5NcbszlCZMu1Kwk=;
 b=nm4LR+v2Mbj1oO9KG+4c2hdaYxWpH8aXSxojWvNUkbO4swV7whxzoVJADykQyKGVACgArD
 5K9p/ZVSiPs35tCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 34/35] soc: ti: ti_sci_inta_msi: Get rid of
 ti_sci_inta_msi_get_virq()
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:19:35 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
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

Just use the core function msi_get_virq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/ti/k3-udma-private.c       |    6 ++----
 drivers/dma/ti/k3-udma.c               |   10 ++++------
 drivers/soc/ti/k3-ringacc.c            |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c       |   12 ------------
 include/linux/soc/ti/ti_sci_inta_msi.h |    1 -
 5 files changed, 7 insertions(+), 24 deletions(-)

--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -168,8 +168,7 @@ int xudma_pktdma_tflow_get_irq(struct ud
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_tflow_id +
-					oes->pktdma_tchan_flow);
+	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
@@ -177,7 +176,6 @@ int xudma_pktdma_rflow_get_irq(struct ud
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_rflow_id +
-					oes->pktdma_rchan_flow);
+	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_rflow_get_irq);
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2313,8 +2313,7 @@ static int udma_alloc_chan_resources(str
 
 	/* Event from UDMA (TR events) only needed for slave TR mode channels */
 	if (is_slave_direction(uc->config.dir) && !uc->config.pkt_mode) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2486,7 +2485,7 @@ static int bcdma_alloc_chan_resources(st
 		uc->psil_paired = true;
 	}
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
@@ -2503,8 +2502,7 @@ static int bcdma_alloc_chan_resources(st
 
 	/* Event from BCDMA (TR events) only needed for slave channels */
 	if (is_slave_direction(uc->config.dir)) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get bcdma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2672,7 +2670,7 @@ static int pktdma_alloc_chan_resources(s
 
 	uc->psil_paired = true;
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -647,7 +647,7 @@ int k3_ringacc_get_ring_irq_num(struct k
 	if (!ring)
 		return -EINVAL;
 
-	irq_num = ti_sci_inta_msi_get_virq(ring->parent->dev, ring->ring_id);
+	irq_num = msi_get_virq(ring->parent->dev, ring->ring_id);
 	if (irq_num <= 0)
 		irq_num = -EINVAL;
 	return irq_num;
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -148,15 +148,3 @@ void ti_sci_inta_msi_domain_free_irqs(st
 	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
-
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
-{
-	struct msi_desc *desc;
-
-	for_each_msi_entry(desc, dev)
-		if (desc->msi_index == dev_index)
-			return desc->irq;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,6 +18,5 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 index);
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
