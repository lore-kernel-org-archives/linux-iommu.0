Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D26C4332F
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C52AE4052D;
	Mon,  6 Dec 2021 22:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUNj8pWHJAZF; Mon,  6 Dec 2021 22:39:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8064A40534;
	Mon,  6 Dec 2021 22:39:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5279EC001E;
	Mon,  6 Dec 2021 22:39:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1310AC0030
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F21E240529
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XK6-ARGXd-t8 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E65D4053A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:48 +0000 (UTC)
Message-ID: <20211206210439.343885841@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=b+nZ88WC2vD5W5n7RNFx/r8UkB+MFzrqoW9QgVGfhmI=;
 b=iwrgnjkZBMa2IKJv9GR2TqvukXqu2pkFrxVjyoHHECtn4Rc9LgNQQNExFqlLTV68Uz6Uft
 rYPKPMZf2YrALowU0yX92pDkp2jtIINx3wHfcb8bZ+UojtO69Zdu/Im3WAsWvXwGD+ZHu4
 qDASgqvtA67NHfTjtLEz1g6pO7eTFk7owK2I9iBDKOOGOcssFBcvzRkjgZzmyXb5qMTBPv
 /9hacvluJ9Ktt0ExrIUqTyL9ldBv8dy6d9aSw7RMxr+mObk5LqYd35pCb8fqtIxmAz38sL
 HU6D7envfFV+DRskiNV0bGxVZeWLt8SRFz6J6jjRDSR96CoViUYZ64Erl8yMpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=b+nZ88WC2vD5W5n7RNFx/r8UkB+MFzrqoW9QgVGfhmI=;
 b=/cbCkUOyxJbsNJMXB3K5nPxHxtl6ty6WuSd175VsB9cZHdXcERW1MvVY/sZjbqrcAZYPTG
 4Qpef42t/or8mfAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 31/36] perf/smmuv3: Use msi_get_virq()
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:45 +0100 (CET)
Cc: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

Let the core code fiddle with the MSI descriptor retrieval.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/arm_smmuv3_pmu.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -684,7 +684,6 @@ static void smmu_pmu_write_msi_msg(struc
 
 static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 {
-	struct msi_desc *desc;
 	struct device *dev = pmu->dev;
 	int ret;
 
@@ -701,9 +700,7 @@ static void smmu_pmu_setup_msi(struct sm
 		return;
 	}
 
-	desc = first_msi_entry(dev);
-	if (desc)
-		pmu->irq = desc->irq;
+	pmu->irq = msi_get_virq(dev, 0);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, smmu_pmu_free_msis, dev);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
