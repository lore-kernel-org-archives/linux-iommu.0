Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125FFC433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB62F20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYeOk83p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19p1170o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB62F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62EBB86AF2;
	Wed, 26 Aug 2020 12:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3Bk3MUC7dP4; Wed, 26 Aug 2020 12:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD0B686B19;
	Wed, 26 Aug 2020 12:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95AA4C0891;
	Wed, 26 Aug 2020 12:08:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 580C7C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3908D84FDD
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XZf571T-Wuw for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EA2DE84F2E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Message-Id: <20200826112334.698236296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=T7GI6+per3yw7C/RYhxMMvPmri10khmLfeX2/IGCf+c=;
 b=rYeOk83pkEJnp46ajEK6NUiZaIQWhcYQOD7ARwQ4vU+RFzqloQ63JN2nVYehUzJCZ3LhEM
 nSvRtOTy2UEio1ys8RRtDU/QayBvKZkSuMuvMgk+a9H5ILcig8cpK/553ZabvDI8df5lKS
 okR053zhIrINePDGUZi1mOpY/lBtAW5f6ZunqQOcOmm/Sm2oNDC+w9GwUD6L0lAJTkCSNt
 voLf39dTRK8wXWcqnk8nqZa7+ytxZXByWN4UpDIwm6TP4r34cMxnX/n8ogGmo5ibrOp+nq
 jMMBNare5DRQuC71qjLfmswliL61Gs8OgznCWDk/2DJZm1QTEOADZCXvc8ODGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=T7GI6+per3yw7C/RYhxMMvPmri10khmLfeX2/IGCf+c=;
 b=19p1170oqCuoZJTSY37jpDQNACEfJLfBQIGgKA6yb2yN5TF7Hyw1gvihiQWU9wKDv1m7Ky
 q5LnSO3wTOR3faCA==
Date: Wed, 26 Aug 2020 13:17:09 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 41/46] platform-msi: Provide default irq_chip:: Ack
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

For the upcoming device MSI support it's required to have a default
irq_chip::ack implementation (irq_chip_ack_parent) so the drivers do not
need to care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/base/platform-msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,6 +95,8 @@ static void platform_msi_update_chip_ops
 		chip->irq_mask = irq_chip_mask_parent;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
 	if (!chip->irq_set_affinity)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
