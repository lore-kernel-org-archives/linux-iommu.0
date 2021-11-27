Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3829C433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BB444095D;
	Sat, 27 Nov 2021 01:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JaC57shcrQkW; Sat, 27 Nov 2021 01:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 740F940986;
	Sat, 27 Nov 2021 01:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5379FC001C;
	Sat, 27 Nov 2021 01:20:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15CF4C003F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC0F340962
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6A5Ac3JeG3R for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51BFF4095D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:44 +0000 (UTC)
Message-ID: <20211126230525.256653991@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W0h8cFkpSlrjWKkacc77gmgmQ9hJjfO/HefW6QQlYnQ=;
 b=r4eal6rIfDIoamvlWEISLX+P71N4hhZWD6sAKPeFo0r/w9+NdyQL8mH9WU9ard2q78GBGM
 puSfzbYsc/CLTm4wMoatWZX8JGm4zcDz4aypqFRJVzPwpahZK4bLGm8GmHxqVRFswULQN0
 vxOuVPmklXTu1Dt3I0tBOTNgRG0Sn42XfnNRTSfuGvZb5z0VAdT9OkLzq3IHXHIVqeB93p
 6gSP3m2B7KtG9jwXFYWdBmrxG0dhkXKDqJjtZ7VFkiA3Wet92nFLuAj2ktppNDpf85Evr9
 iBbS8mzN6/r/uRiEFpkV7cESINPLw2PRGvei1yfLXYzA9yftlrSnsJt6JFh6dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W0h8cFkpSlrjWKkacc77gmgmQ9hJjfO/HefW6QQlYnQ=;
 b=exDXzbWNyzm8lpC8blE93+qo6A6+cBUS2GiuAcExzXacXAdgjQYexIMIGb0pS8kwazFa+i
 WxdkIBqLR1OS8LDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 22/37] x86/apic/msi: Use device MSI properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:42 +0100 (CET)
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
