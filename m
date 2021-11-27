Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34099C4332F
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC86182D07;
	Sat, 27 Nov 2021 01:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nB5_9Zi2AlK5; Sat, 27 Nov 2021 01:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CB0582CFD;
	Sat, 27 Nov 2021 01:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71028C001C;
	Sat, 27 Nov 2021 01:21:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37630C0039
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23570409B3
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="k+/f0p97";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="lPqAA3ja"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0LcSq4HT8Ey for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F83F409B5
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:45 +0000 (UTC)
Message-ID: <20211126230524.897737278@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=bB22Fj84OnFrRIG/bs67IiQdK7QkbC0Kd4+++76cDFQ=;
 b=k+/f0p97ZNAYtITSfS6/UVgrXyGxOvI5W6304Xjkfl20zuGn9J3xTVteLBvIcMg6CdzCQn
 RGA7CyFa9DlSgRRU6aUVgFW2Mvf11uO5YWn5mdQwc15xnVbFXnDuavAus6YYKCKpLMzjqQ
 Mott9ICMD1G8P+Ba5BI7Hvhmtma3AjtYcJ1K09pLucoDEySbiuE2MZnwlxzM49XkE2akVX
 71sct5H60gz51CsnliFWlUL7Q2XI6O8Qo9XJU5OC4VQgO+uUXl5NUeBrwzWD+LRxKI1llN
 0oE/41ZNpmsJedVPx4sHwODRkH2oLnPmUyiMuQXek/ZJ9Tazk5w1NylVwSEv2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=bB22Fj84OnFrRIG/bs67IiQdK7QkbC0Kd4+++76cDFQ=;
 b=lPqAA3jad28ccma7nsS1toKj9pKptCajyGjOS6IC/OlDMgQZE/ovVcabO3D4EjXn/sop95
 jMBlQIzFQ2RyU9Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 16/37] bus: fsl-mc-msi: Use msi_desc::msi_index
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:43 +0100 (CET)
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
Message-ID: <20211127012143.xuKLKO6-PjlEBSIc3HDKw9rEA-RSQPgL7OvyoBtiSEY@z>

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c |    2 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c       |    6 +++---
 include/linux/msi.h                   |   10 ----------
 3 files changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -393,7 +393,7 @@ int fsl_mc_populate_irq_pool(struct fsl_
 	}
 
 	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->fsl_mc.msi_index];
+		mc_dev_irq = &irq_resources[msi_desc->msi_index];
 		mc_dev_irq->msi_desc = msi_desc;
 		mc_dev_irq->resource.id = msi_desc->irq;
 	}
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -29,7 +29,7 @@ static irq_hw_number_t fsl_mc_domain_cal
 	 * Make the base hwirq value for ICID*10000 so it is readable
 	 * as a decimal value in /proc/interrupts.
 	 */
-	return (irq_hw_number_t)(desc->fsl_mc.msi_index + (dev->icid * 10000));
+	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
 }
 
 static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
@@ -122,7 +122,7 @@ static void fsl_mc_msi_write_msg(struct
 	struct fsl_mc_device *mc_bus_dev = to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =
-		&mc_bus->irq_resources[msi_desc->fsl_mc.msi_index];
+		&mc_bus->irq_resources[msi_desc->msi_index];
 
 	msi_desc->msg = *msg;
 
@@ -235,7 +235,7 @@ static int fsl_mc_msi_alloc_descs(struct
 			goto cleanup_msi_descs;
 		}
 
-		msi_desc->fsl_mc.msi_index = i;
+		msi_desc->msi_index = i;
 		INIT_LIST_HEAD(&msi_desc->list);
 		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 	}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -106,14 +106,6 @@ struct pci_msi_desc {
 };
 
 /**
- * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor
- */
-struct fsl_mc_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
  * @dev_index: TISCI device index
  */
@@ -136,7 +128,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
 struct msi_desc {
@@ -157,7 +148,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};
 };

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
