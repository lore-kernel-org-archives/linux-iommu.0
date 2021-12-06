Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBF1C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FB8C41C67;
	Mon,  6 Dec 2021 22:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O0OoeoYS3DHs; Mon,  6 Dec 2021 22:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3EFAE41C60;
	Mon,  6 Dec 2021 22:39:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12880C001E;
	Mon,  6 Dec 2021 22:39:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2806C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FC774052D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="CWfcJ/iB";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="wbBVA5z+"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZR_HfEWF7GN for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4D074052F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:46 +0000 (UTC)
Message-ID: <20211206210439.289194020@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=jjYpKlfviGkOs8GJ86qqUCf8iCclgx/MvIgVwsbGrI8=;
 b=CWfcJ/iBUYjrpon8kS2pojeizMcv7c60QxvaLAU5LI7KfIMvLSxmIM/m6bfUaFi/gGyxAb
 PdqO0v+VPjjzILOgrIY49OVkafA0iReKzvL8PY9tzXeT2OhfpAJ4GW6YLu65K/Ld7nLIG0
 dbzZwwZ742NgY9QLmrAZqlDg1SC6c+Vxj66hiQWNzv4d8TaTEE4oqgYxP5G8UX+MQMw73e
 +b6nz9F4GAlHfDc5dR9qnGxMEdL//gXdSMYdGOcVIGZyzLatX6atJs5gbWAUqCzw+Ld7RN
 hETb0rVdGgYiZNsPAYhQE+wSINXC0JxDMrNyubVTne/6jVvmGPHY/Mo/UsX8LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=jjYpKlfviGkOs8GJ86qqUCf8iCclgx/MvIgVwsbGrI8=;
 b=wbBVA5z+1RlpKAaa5w62yohCfb98XisYXj6A57jf4CV6E6TSRwWAqsQRcXyzzVkM5x3Dtz
 DSeIPQrauDdTp2AA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 30/36] dmaengine: mv_xor_v2: Get rid of msi_desc abuse
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:44 +0100 (CET)
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

Storing a pointer to the MSI descriptor just to keep track of the Linux
interrupt number is daft. Use msi_get_virq() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
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
