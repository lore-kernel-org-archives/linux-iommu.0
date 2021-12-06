Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C54C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46A4984C06;
	Mon,  6 Dec 2021 22:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8sYHZvVf4_YU; Mon,  6 Dec 2021 22:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 288C282D40;
	Mon,  6 Dec 2021 22:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 149BAC001E;
	Mon,  6 Dec 2021 22:39:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3488DC0071
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89F0E41C6D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="fSODZTv6";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="ey27UtKM"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xpSeZtit0GCw for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7B7141C68
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:54 +0000 (UTC)
Message-ID: <20211206210439.563159167@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=jHyezEoA6dhB4ZSrBoZ23WpPCkveZt9yuxL9BvGVX8Y=;
 b=fSODZTv6AD7cSUnet1lA0cqP/4dL95Iu7D5l0WKszY8dggFQTtnEV3OUn3y9urhS5lmSRr
 bFPJzjBz3KIY5JStVk2zLspbNKsiDElGLLBtmMeic1y43ALqfA26qf9j9voFO6UYMBcyGo
 xANld6SPj5Tddo7FyTlAhz2h/RnlckwFpyglJv1Mm4P9x3xPdkLLUFYTmBGH0ndCDFXWmn
 +HwZpvPjvn9qzUm1kTQMlIWr5a5R0DwCYqn4UG81FQqEXp0/qvhQ7ci1MdMRGaMY/JzthP
 oh5Q61Ci98kFYJdOLoeMxVLrXNkS7mQiutBs2vw0mQuUoUWq2VaDx8FtqpYpNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=jHyezEoA6dhB4ZSrBoZ23WpPCkveZt9yuxL9BvGVX8Y=;
 b=ey27UtKMqiE+fXqJWfKK+X9EYyKnROGFcjxs9M1r6hk+PzmcSb+zFvcui9i4NN5/NwzEv9
 ug0Fq3tF+65z+tBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 35/36] soc: ti: ti_sci_inta_msi: Get rid of
 ti_sci_inta_msi_get_virq()
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:52 +0100 (CET)
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

Just use the core function msi_get_virq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
