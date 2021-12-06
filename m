Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC93C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F12ED4053F;
	Mon,  6 Dec 2021 22:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KEqyykWeHQEw; Mon,  6 Dec 2021 22:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 982C340515;
	Mon,  6 Dec 2021 22:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7678EC001E;
	Mon,  6 Dec 2021 22:39:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 194F9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 150F341C50
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="nfZZ3sBO";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="zIv8vjiK"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbG0JN3GiB5O for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4514C40469
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:35 +0000 (UTC)
Message-ID: <20211206210438.913603962@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=Ep5zFYMr2dpuKFMI1pf/izOHx/wmIORxQk2vil3OoJI=;
 b=nfZZ3sBOutSvGHqk1sS290DDgjFJGXEhzG9mKo8h3KNUTS21yvque0kvoe6kdy44X6ihqJ
 rlecPnSuBE8kWWqzbTh8ZfS2t/6i87b9mxuCdiQdAWfWgv/FXfDMxOB4hPcENaQevz8X1t
 sfoi2d3W+glPX+uizuVT258ABJFrCCoKMbU990PZvSPJbq47uN//h7RBBdikCbG4VbXTMa
 uzPGLlJ6oqG4Ba1T/Qi10UeHj0+DdaJ0BuryMFaEruZB4DB4ufEmaO0gHVQmA6rDjulOYP
 4odcYLKYN6S0ZLHgH8AU1siZXSl2RCWz6Zdbj85yUeDpTNP4mcveuhP4LXFExg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=Ep5zFYMr2dpuKFMI1pf/izOHx/wmIORxQk2vil3OoJI=;
 b=zIv8vjiKX+sZKy9gbTJ2X4+XfGOmD/O04fsKImX/MjjZGQEs9MDTD7XhFu7ricmc2LeLAj
 jEryKJg6XslL1KCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 23/36] powerpc/cell/axon_msi: Use MSI device properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:33 +0100 (CET)
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

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Invoke the function with the correct number of arguments - Andy
---
 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -199,7 +199,7 @@ static struct axon_msic *find_msi_transl
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
 	struct device_node *dn;
-	struct msi_desc *entry;
+	bool is_64bit;
 	int len;
 	const u32 *prop;
 
@@ -209,10 +209,10 @@ static int setup_msi_msg_address(struct
 		return -ENODEV;
 	}
 
-	entry = first_pci_msi_entry(dev);
+	is_64bit = msi_device_has_property(&dev->dev, MSI_PROP_64BIT);
 
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->pci.msi_attrib.is_64) {
+		if (is_64bit) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
