Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC0C433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E5BE4058C;
	Sat, 27 Nov 2021 01:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxiBbAvMC0Bg; Sat, 27 Nov 2021 01:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D85A340589;
	Sat, 27 Nov 2021 01:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC177C001C;
	Sat, 27 Nov 2021 01:21:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71277C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6014A40994
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="F4ZLl3LV";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="o8kiWdx9"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVzsgn7GTxXs for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5D5A40962
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:54 +0000 (UTC)
Message-ID: <20211126230525.256653991@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W0h8cFkpSlrjWKkacc77gmgmQ9hJjfO/HefW6QQlYnQ=;
 b=F4ZLl3LVIalGx1nr8zVLN4qZ/kerGBNQpqO5YwHiasRWJghsRIfbflMcthfqI+iCXCq8eI
 wZYeWFPYfrYDaTYz29UJEA68CReYY3ynGXGguRFPy+j2mgbKeUJS/nr9XRM022ZojRHgp2
 A024LiuABId6ikwybGCYm9PsFirU9ihvOON2CQPzQ9oNItc9+ZBh4rYbZoiVrYsfe6KFiG
 LzV8LY02rVe9jY8nR6yZNVpOa6fRKsZtEruEPzXYhe57Rmxht7yefXapbt9VAAZpay7hYh
 9R4/vPx6fqzj0ZWXyFxBliQFsTeS4Ns3cRFBBgAej/AwkxiwAFpRHFozvL4mvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W0h8cFkpSlrjWKkacc77gmgmQ9hJjfO/HefW6QQlYnQ=;
 b=o8kiWdx9jl5zPCSu4DW+wVgTHdK1AewHKh1zlz9tmI0YsrxRcKBO33H2yCj/pCYcOyBha5
 mO1A4J6EQOpzSPAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 22/37] x86/apic/msi: Use device MSI properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:52 +0100 (CET)
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
Message-ID: <20211127012152.9fP7NBXiBDjb0pjruUFpjkZ5DZyAM_tO0bFhtPMVecY@z>

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -160,11 +160,8 @@ static struct irq_chip pci_msi_controlle
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-
 	init_irq_alloc_info(arg, NULL);
-	if (desc->pci.msi_attrib.is_msix) {
+	if (msi_device_has_property(dev, MSI_PROP_PCI_MSIX)) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
