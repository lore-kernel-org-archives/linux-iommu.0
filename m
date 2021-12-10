Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7607C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 714424284C;
	Fri, 10 Dec 2021 22:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZB-jXknrqff; Fri, 10 Dec 2021 22:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E0E042855;
	Fri, 10 Dec 2021 22:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01DEFC0072;
	Fri, 10 Dec 2021 22:19:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F57C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F5608560B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="3uRJBXLz";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="jVULDfzU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Llb87ZjJGr3M for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CBE185535
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:30 +0000 (UTC)
Message-ID: <20211210221814.970099984@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=zF6xwEDBnJqDiuzvbqLmsexoc+W+jGd9VwXdVq5BEMI=;
 b=3uRJBXLzDA2NYHvGXAjPESXwPtY4wndvLVMfkxhow+rp/kDN16U4X0C98PwLB5MMnD4tYn
 ZOEGSM2ye4hhzzHTXNKc+wG0/ppoUdhswTzSBop3HHGnldcxLhjnLtQjD+xMmCwf22EUFE
 Q/zKOvjGyNcbqIgKQIsGXYGvefv5FHydeVKH232ubirlNA6T15859yhIKJ3jJ/7StDjYf2
 Oo9QLHN7iSJxzUqL6+fXtAzM9h9rqxwBGkEmlO1cFEBEwCIOcIJDJlbaSJFihp8W7eJp79
 8OeTtwQoaG0Z1HU6FBoYv5812za0uLavtriysEdHJ3Xheg5DIbiHdaTlV7ZxlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=zF6xwEDBnJqDiuzvbqLmsexoc+W+jGd9VwXdVq5BEMI=;
 b=jVULDfzUnOD2T8hCESYAAk+sAcevMjadKqHQJ3kXJ4DqJvj5V3VSRLrJFQ9AuMxcORx3I7
 XP2F++Om2JcSHtCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 29/35] dmaengine: mv_xor_v2: Get rid of msi_desc abuse
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:19:28 +0100 (CET)
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

Storing a pointer to the MSI descriptor just to keep track of the Linux
interrupt number is daft. Use msi_get_virq() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/mv_xor_v2.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -149,7 +149,7 @@ struct mv_xor_v2_descriptor {
  * @desc_size: HW descriptor size
  * @npendings: number of pending descriptors (for which tx_submit has
  * @hw_queue_idx: HW queue index
- * @msi_desc: local interrupt descriptor information
+ * @irq: The Linux interrupt number
  * been called, but not yet issue_pending)
  */
 struct mv_xor_v2_device {
@@ -168,7 +168,7 @@ struct mv_xor_v2_device {
 	int desc_size;
 	unsigned int npendings;
 	unsigned int hw_queue_idx;
-	struct msi_desc *msi_desc;
+	unsigned int irq;
 };
 
 /**
@@ -718,7 +718,6 @@ static int mv_xor_v2_probe(struct platfo
 	int i, ret = 0;
 	struct dma_device *dma_dev;
 	struct mv_xor_v2_sw_desc *sw_desc;
-	struct msi_desc *msi_desc;
 
 	BUILD_BUG_ON(sizeof(struct mv_xor_v2_descriptor) !=
 		     MV_XOR_V2_EXT_DESC_SIZE);
@@ -770,14 +769,9 @@ static int mv_xor_v2_probe(struct platfo
 	if (ret)
 		goto disable_clk;
 
-	msi_desc = first_msi_entry(&pdev->dev);
-	if (!msi_desc) {
-		ret = -ENODEV;
-		goto free_msi_irqs;
-	}
-	xor_dev->msi_desc = msi_desc;
+	xor_dev->irq = msi_get_virq(&pdev->dev, 0);
 
-	ret = devm_request_irq(&pdev->dev, msi_desc->irq,
+	ret = devm_request_irq(&pdev->dev, xor_dev->irq,
 			       mv_xor_v2_interrupt_handler, 0,
 			       dev_name(&pdev->dev), xor_dev);
 	if (ret)
@@ -892,7 +886,7 @@ static int mv_xor_v2_remove(struct platf
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 
-	devm_free_irq(&pdev->dev, xor_dev->msi_desc->irq, xor_dev);
+	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
 
 	platform_msi_domain_free_irqs(&pdev->dev);
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
