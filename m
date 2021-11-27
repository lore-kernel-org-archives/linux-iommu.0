Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA1C4321E
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15FE261C09;
	Sat, 27 Nov 2021 01:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKpDB_SiAIH5; Sat, 27 Nov 2021 01:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3BE261C08;
	Sat, 27 Nov 2021 01:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8203BC001C;
	Sat, 27 Nov 2021 01:20:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DAB7C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1821940579
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="aQ1pSGzf";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="+khAQI9u"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UNuyup1hrzfQ for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A7AF40577
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:52 +0000 (UTC)
Message-ID: <20211126230525.548258086@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=wJMUpNJgyC/5WRXAWU3ClvJ2/7JlSux0SjtaYWx+PkY=;
 b=aQ1pSGzf1xljCMjV+A0HzBdj533zrI8Sn8/x78I5JLlzyaGEt2oaQIsa1H+VK1HinYpueS
 +3myORcpC+LyitSb3vMrxPMq0DdPSeOmr+hwbfxW2AzPhxwb5L2zDvpDENXii3Eq3fARgs
 moKEGxluXefb305ZDtRjnMujpBvPT5xFMXT0JTPNbH3aMGBKzkStBUqVjhor692Rl+IOBE
 xCmjzF0+vA/27cY8FjGJpCndjmidTZiuHmk0dsQDSB89lO5FRMUDZPKROlJ/JjU+NGZTPd
 kT+u92mqPp823zt8fgiXmt8+iJowIP8MdiBGyRV6mE2PiuLN6I3OdDf/9GaWZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=wJMUpNJgyC/5WRXAWU3ClvJ2/7JlSux0SjtaYWx+PkY=;
 b=+khAQI9uNx8/zRgnV5rYXfaV6JyxSqTfzihC0RwrUHqKrPuQ+rUqH7qGte4yfUVdbfquwh
 jJs8fClZojrNxQDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 27/37] powerpc/pseries/msi: Let core code check for contiguous
 entries
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:50 +0100 (CET)
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

Set the domain info flag and remove the check.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c |   32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -321,27 +321,6 @@ static int msi_quota_for_device(struct p
 	return request;
 }
 
-static int check_msix_entries(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-	int expected;
-
-	/* There's no way for us to express to firmware that we want
-	 * a discontiguous, or non-zero based, range of MSI-X entries.
-	 * So we must reject such requests. */
-
-	expected = 0;
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_index != expected) {
-			pr_debug("rtas_msi: bad MSI-X entries.\n");
-			return -EINVAL;
-		}
-		expected++;
-	}
-
-	return 0;
-}
-
 static void rtas_hack_32bit_msi_gen2(struct pci_dev *pdev)
 {
 	u32 addr_hi, addr_lo;
@@ -380,7 +359,7 @@ static int rtas_prepare_msi_irqs(struct
 	if (quota && quota < nvec)
 		return quota;
 
-	if (type == PCI_CAP_ID_MSIX && check_msix_entries(pdev))
+	if (type == PCI_CAP_ID_MSIX)
 		return -EINVAL;
 
 	/*
@@ -530,9 +509,16 @@ static struct irq_chip pseries_pci_msi_i
 	.irq_write_msi_msg	= pseries_msi_write_msg,
 };
 
+
+/*
+ * Set MSI_FLAG_MSIX_CONTIGUOUS as there is no way to express to
+ * firmware to request a discontiguous or non-zero based range of
+ * MSI-X entries. Core code will reject such setup attempts.
+ */
 static struct msi_domain_info pseries_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
+		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MSIX_CONTIGUOUS),
 	.ops   = &pseries_pci_msi_domain_ops,
 	.chip  = &pseries_pci_msi_irq_chip,
 };

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
