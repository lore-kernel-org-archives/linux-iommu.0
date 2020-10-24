Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E0C55179
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC2F24692
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDezbMGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC2F24692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5429486DC0;
	Sat, 24 Oct 2020 21:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 705m2by-Gvps; Sat, 24 Oct 2020 21:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F32A086E71;
	Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9EDDC1AD9;
	Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CD97C1AD7
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A34A86DE4
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CWXl1Sk2RsS for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FA6D86DB0
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=JW78knbqw7EYlsJkBZcRrOydz/oXelrB7ardJZkkdqY=; b=PDezbMGPDWtFQXHB+z5YGGVwLN
 zhLBtlAB6feibtgg4eZNFkMHrHmcZq9SSnLxL6dz/yGWZaAxjGJfHl6v5ZgVCzPLx50aWH/3ms3nc
 GsLcLCVvoKVE1xH15H2z/U1dXe6rJI9ZtCFuTJk6N36otUqtnu+pvC4tfF+kZhrGdE8SGXCIVXpSH
 5LCoGCRTCSO+TrYjBEjAev+qpIJ/sbQhCMlkoj0k4FH2enFmpSKvxbfGqX89igqJPI02szLf56AJR
 FmlDK+SiUwPF4WfhqkIYeGokwj0XLGoqe4swfWKDqgeAv8e9/9jmMjrZJgljMaA0SNeH+XaB4+Lh3
 8BhwKgxQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCS-0006HD-Gm; Sat, 24 Oct 2020 21:35:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCN-001rOf-1P; Sat, 24 Oct 2020 22:35:39 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 17/35] x86/pci/xen: Use msi_msg shadow structs
Date: Sat, 24 Oct 2020 22:35:17 +0100
Message-Id: <20201024213535.443185-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

Use the msi_msg shadow structs and compose the message with named bitfields
instead of the unreadable macro maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/pci/xen.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index c552cd2d0632..3d41a09c2c14 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -152,7 +152,6 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 
 #if defined(CONFIG_PCI_MSI)
 #include <linux/msi.h>
-#include <asm/msidef.h>
 
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
@@ -210,23 +209,20 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return ret;
 }
 
-#define XEN_PIRQ_MSI_DATA  (MSI_DATA_TRIGGER_EDGE | \
-		MSI_DATA_LEVEL_ASSERT | (3 << 8) | MSI_DATA_VECTOR(0))
-
 static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 		struct msi_msg *msg)
 {
-	/* We set vector == 0 to tell the hypervisor we don't care about it,
-	 * but we want a pirq setup instead.
-	 * We use the dest_id field to pass the pirq that we want. */
-	msg->address_hi = MSI_ADDR_BASE_HI | MSI_ADDR_EXT_DEST_ID(pirq);
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		MSI_ADDR_DEST_MODE_PHYSICAL |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(pirq);
-
-	msg->data = XEN_PIRQ_MSI_DATA;
+	/*
+	 * We set vector == 0 to tell the hypervisor we don't care about
+	 * it, but we want a pirq setup instead.  We use the dest_id fields
+	 * to pass the pirq that we want.
+	 */
+	memset(msg, 0, sizeof(*msg));
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_hi.destid_8_31 = pirq >> 8;
+	msg->arch_addr_lo.destid_0_7 = pirq & 0xFF;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
 }
 
 static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
