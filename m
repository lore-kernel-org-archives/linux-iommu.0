Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF2C433FE
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1075A61C3C;
	Sat, 27 Nov 2021 01:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uH-t4C2cEmDk; Sat, 27 Nov 2021 01:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1775D61C36;
	Sat, 27 Nov 2021 01:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7ED5C001C;
	Sat, 27 Nov 2021 01:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88A7CC001C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62BA5409B9
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="MpO6BJG2";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="Wt8UMoxw"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hh2XEW3RLnVg for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD78409B7
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:22:11 +0000 (UTC)
Message-ID: <20211126230525.885757679@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=95o7iVE7rds7rlpuNcpuaJBc/5SOakXF5BxxMijrxrA=;
 b=MpO6BJG26x5UCFGq7vdr31dASeSXLlraHWcnBGwjhGhlbDJRkbhVPMytL/Q8lFOebQ/UGw
 MCnX5WUzDbQr3JqTUn6CB/W7GIIoqZmV8Vos1bqTRsX7zvCukPx/nstYyj1VV499Ndj6o8
 rHCqvlu+9amo2GKRp3mFBbdwhSajNBB1GOc3X224mGFIK+EdCiSuL3gOtjt8dyYT9TV2qN
 oef49n6a0pXFitEppgkpH1cXMKOotQn5GQP0XHE1n5aHcKTENe/nGDGArRd4z/sqS38HyW
 s5z8WVevwMctLoUSBtV0ciYVnZOl0NXrrwH2GuaEcSrFbk5x02V9HpbSL+nsFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=95o7iVE7rds7rlpuNcpuaJBc/5SOakXF5BxxMijrxrA=;
 b=Wt8UMoxwJlB+v9F443IqyDfIB8UWmxIDqdrhKGMKuTlpdePbnWWtZNluQFgrwpR3vcPIVI
 e6UMeuDyMqaTWqAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:22:09 +0100 (CET)
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
Message-ID: <20211127012209.P-xoTYDJ_elBzEZd0NhQtvHZ6yLo-VtlcGvYPkRbc-o@z>

Let the core code fiddle with the MSI descriptor retrieval.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
 
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	struct msi_desc *desc;
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
 	struct device *dev = smmu->dev;
 
@@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
 		return;
 	}
 
-	for_each_msi_entry(desc, dev) {
-		switch (desc->msi_index) {
-		case EVTQ_MSI_INDEX:
-			smmu->evtq.q.irq = desc->irq;
-			break;
-		case GERROR_MSI_INDEX:
-			smmu->gerr_irq = desc->irq;
-			break;
-		case PRIQ_MSI_INDEX:
-			smmu->priq.q.irq = desc->irq;
-			break;
-		default:	/* Unknown */
-			continue;
-		}
-	}
+	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
+	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, arm_smmu_free_msis, dev);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
