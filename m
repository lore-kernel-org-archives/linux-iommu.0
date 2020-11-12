Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3DC5519F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 19:15:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D112223F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ht3hNrDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Az6qw/Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D112223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 604BC203DD;
	Thu, 12 Nov 2020 19:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ekiddSuOhnmP; Thu, 12 Nov 2020 19:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AE1F12033E;
	Thu, 12 Nov 2020 19:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDDEC088B;
	Thu, 12 Nov 2020 19:15:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D2B3C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8B6CA856B8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkFYi383YNNj for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 19:15:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C94C984F76
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:15:06 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605208502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VT0wgNNnYfg403e5d0pAs+2XCLbbkpVLyNxvOBCDBuE=;
 b=ht3hNrDRCVGymMncVEg5pjAcDv08tWywC6nLFZ8yD77PdLFXCLO0Ue46Y1S68o/VtPYazI
 Xmw6baNY48Jphh6gQVv9vgE9TnmXAKVbv1WXuWF15pzAwMHmYiy5o99xh6OH6bHDXqJrRW
 Si3X+wwQUbexkqsUdkQPQruWfFCf7QsZcISN5ORskkgtGXEeh9lS2Tn5ub+GvZM0s7FhAB
 5WQwYNqTWgh1xWwB6amImhyDfWZe2+NerCuq1n7RpJtn1AFHz0MVnXLWbfEzqvlbQ73/Ko
 PEa8f6IIiyv00ZloSWluRID8KzI5Ao1lH2HdcNX/Nv8XcwK5ayWi8Bh83JwNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605208502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VT0wgNNnYfg403e5d0pAs+2XCLbbkpVLyNxvOBCDBuE=;
 b=Az6qw/Q+kOFcEDQj8L6u+EJlRh4aQzhE/iNGjllYzvg/z9F90alZL2d95mOZbTNLrzOOjh
 Ka4aBVfxaajGxqAg==
To: Jason Gunthorpe <jgg@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 Itay Aveksis <itayav@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
Date: Thu, 12 Nov 2020 20:15:02 +0100
Message-ID: <87d00imlop.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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

The recent changes to store the MSI irqdomain pointer in struct device
missed that Intel DMAR does not register virtual function devices.  Due to
that a VF device gets the plain PCI-MSI domain assigned and then issues
compat MSI messages which get caught by the interrupt remapping unit.

Cure that by inheriting the irq domain from the physical function
device.

That's a temporary workaround. The correct fix is to inherit the irq domain
from the bus, but that's a larger effort which needs quite some other
changes to the way how x86 manages PCI and MSI domains.

Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
 	dmar_iommu_notify_scope_dev(info);
 }
 
+static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
+{
+	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+}
+
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct
 	/* Only care about add/remove events for physical functions.
 	 * For VFs we actually do the lookup based on the corresponding
 	 * PF in device_to_iommu() anyway. */
-	if (pdev->is_virtfn)
+	if (pdev->is_virtfn) {
+		/*
+		 * Note: This is a horrible hack and needs to be cleaned
+		 * up by assigning the domain to the bus, but that's too
+		 * big of a change for post rc3.
+		 *
+		 * Ensure that the VF device inherits the irq domain of the
+		 * PF device:
+		 */
+		if (action == BUS_NOTIFY_ADD_DEVICE)
+			vf_inherit_msi_domain(pdev);
 		return NOTIFY_DONE;
+	}
+
 	if (action != BUS_NOTIFY_ADD_DEVICE &&
 	    action != BUS_NOTIFY_REMOVED_DEVICE)
 		return NOTIFY_DONE;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
