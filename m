Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0937C4167E
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86D1940556;
	Sat, 27 Nov 2021 01:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BTkwwhekLeqR; Sat, 27 Nov 2021 01:21:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 519B340570;
	Sat, 27 Nov 2021 01:21:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3E9C001C;
	Sat, 27 Nov 2021 01:21:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCABCC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF4B580E1E
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="itabOq2/";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="p5ubsedS"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ydQQHUrs7sEg for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E4D78247F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:04 +0000 (UTC)
Message-ID: <20211126230525.942768779@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=p/qcF7fn4OxVhWuReK+wMgikFJMOqHr6o9RPZFmkX94=;
 b=itabOq2/goNmVeWHFB5h7LUlNokKCJwhxIqr2TNaqXG3rE+msDvgxF3R8d+lDMQdpFLFMB
 2rvVZrnGq081hsY5QdIU8qQUR+To3tHna4hN0zbgKDRe26TS0apCiD1wKBPybv2NLvQ1a/
 jA0wq+xDF/7BTVvOy7SzFYqYzOVwwz4O59fL4fmQfvywkIdw6RdHxwDugA0I2P+ohTzCH/
 DszOAxkAAjMZ/U0A9nyPD2gEp8K6D3Z+7NgnuGuS9kvWeuiUZua5kcgjgMzJuSNbAQEkTu
 B1FubAjMmOJK1BcNvleDd2vf7jIIYRBftQir9TNTQwPabnrpSIpj7WCZOws6wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=p/qcF7fn4OxVhWuReK+wMgikFJMOqHr6o9RPZFmkX94=;
 b=p5ubsedSnSr6AcduksWDB4MJEZscofhI5yEISG/LcUOqL4vr2FI2SDc+JOX/1dXjavNAQK
 l3vnrVRpfKqxIqCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 34/37] mailbox: bcm-flexrm-mailbox: Rework MSI interrupt
 handling
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:01 +0100 (CET)
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

No point in retrieving the MSI descriptors. Just query the Linux interrupt
number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/mailbox/bcm-flexrm-mailbox.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1497,7 +1497,6 @@ static int flexrm_mbox_probe(struct plat
 	int index, ret = 0;
 	void __iomem *regs;
 	void __iomem *regs_end;
-	struct msi_desc *desc;
 	struct resource *iomem;
 	struct flexrm_ring *ring;
 	struct flexrm_mbox *mbox;
@@ -1608,10 +1607,8 @@ static int flexrm_mbox_probe(struct plat
 		goto fail_destroy_cmpl_pool;
 
 	/* Save alloced IRQ numbers for each ring */
-	for_each_msi_entry(desc, dev) {
-		ring = &mbox->rings[desc->msi_index];
-		ring->irq = desc->irq;
-	}
+	for (index = 0; index < mbox->num_rings; index++)
+		mbox->rings[index].irq = msi_get_virq(dev, index);
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
