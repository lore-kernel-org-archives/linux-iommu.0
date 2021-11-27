Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8521C4332F
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78FE161C1E;
	Sat, 27 Nov 2021 01:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MI9xAY93XG76; Sat, 27 Nov 2021 01:21:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68E2461C08;
	Sat, 27 Nov 2021 01:21:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D84DC001C;
	Sat, 27 Nov 2021 01:21:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E34CAC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5DFE82BA1
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="mnofpq5q";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="EVRr4dtW"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ast7ufyVEezn for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 296E782C98
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:29 +0000 (UTC)
Message-ID: <20211126230524.295122054@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=Oh8EM+g3S/QfSPoDjrJmTy+Z80Zsw+m+X3NUsXacOTE=;
 b=mnofpq5qHTa73EYKnX+gSUS66qA0qV9CISVRKLfy6CK+WHHapL7/SxJScP3TewGTsdaH0N
 zAvnNBw/ghsjSAPlWoxiAo332Y+PYhTukKuDEZj9V1VYhrr+P5cVirRxCX1oxdgSHHKb0H
 WjNbIuJvv3jXXH7mx4heiKx32Kw4D9PfsByyk16Elpvdu1570LvxkxGLKXRp6OjKe3TlpP
 Xe1MS5Hg5BphaQ2gVhuYOHWnihn7qsyWN1mKTT5Jwb6C+9zbFdAoXxMJC98vzYLZQNrb+l
 qFu1ZcsCjD2RhhQDyTBUL8woeasGlKhpmU6BJOCFm5U+I1V9643SxCalB7arcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=Oh8EM+g3S/QfSPoDjrJmTy+Z80Zsw+m+X3NUsXacOTE=;
 b=EVRr4dtWw855mql4RX0lKIdYekacrmXSlpmN+9wTz4Ck3BslRlqjv8mdIuNN/fgD+8rRyc
 vBIv57L/ZOklsqCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 06/37] bus: fsl-mc-msi: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:26 +0100 (CET)
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
Message-ID: <20211127012126.KoI7H1aiYRUzX5Yl7X9gKwEDCA-XexYtjiXETxT3ses@z>

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -253,6 +253,14 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	struct irq_domain *msi_domain;
 	int error;
 
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	error = msi_setup_device_data(dev);
+	if (error)
+		return error;
+
 	if (!list_empty(dev_to_msi_list(dev)))
 		return -EINVAL;
 
@@ -260,12 +268,6 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	if (error < 0)
 		return error;
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain) {
-		error = -EINVAL;
-		goto cleanup_msi_descs;
-	}
-
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
