Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FDCC2D0A3
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA722226B
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dhk9piWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA722226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5690586E07;
	Sat, 24 Oct 2020 21:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yg5gS9zVDTHr; Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1685986DF2;
	Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDBD2C1AD9;
	Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E64FC0051
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D1428749A
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQ2d0PSABB4m for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 51E6487353
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2JkDAu+vSiSLfTGnxct94wTATgbmXr+ywebpMNCsh14=; b=dhk9piWOyuBysV0UwXx38nfUr2
 CQyBNE7yCisQMdfZIFGQJcVIgO5KLVmo+yZQqDhFLtoQSO6rbIKIMCol+R4YZihz6WCxczCRik3c7
 UzhuFqeikh2kB/ZF+rCLhxNHCYrCb1IJJO9F8IpCpMYhN3gw2rk2TEJGGidDlUMOTazN1Dy/GsfHf
 AIK7Dw1P1+vm6ObrUR+BFSqamjinUNRLzBDifO4z99QTimTEBNV/nEQiQ45ujtHIxefekX6wyrd95
 9CBgHlDPYfXd2XQSVZS5tLxSG4MfQmbFnocMFKrKBWzvjZI6tYMtZFT6SFraTbXH5zBP1JXcEvh+H
 LoHlQgxw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCS-0008BU-RO; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rO9-QO; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 09/35] x86/apic: Always provide irq_compose_msi_msg()
 method for vector domain
Date: Sat, 24 Oct 2020 22:35:09 +0100
Message-Id: <20201024213535.443185-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

This shouldn't be dependent on PCI_MSI. HPET and I/O-APIC can deliver
interrupts through MSI without having any PCI in the system at all.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h   |  8 +++-----
 arch/x86/kernel/apic/apic.c   | 32 ++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/msi.c    | 37 -----------------------------------
 arch/x86/kernel/apic/vector.c |  6 ++++++
 4 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 652f62252349..b489bb9894ae 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -520,12 +520,10 @@ static inline void apic_smt_update(void) { }
 #endif
 
 struct msi_msg;
+struct irq_cfg;
 
-#ifdef CONFIG_PCI_MSI
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
-#else
-# define x86_vector_msi_compose_msg NULL
-#endif
+extern void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+				  bool dmar);
 
 extern void ioapic_zap_locks(void);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 54f04355aaa2..4c15bf29ea2c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -50,6 +50,7 @@
 #include <asm/io_apic.h>
 #include <asm/desc.h>
 #include <asm/hpet.h>
+#include <asm/msidef.h>
 #include <asm/mtrr.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -2480,6 +2481,37 @@ int hard_smp_processor_id(void)
 	return read_apic_id();
 }
 
+void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+			   bool dmar)
+{
+	msg->address_hi = MSI_ADDR_BASE_HI;
+
+	msg->address_lo =
+		MSI_ADDR_BASE_LO |
+		(apic->dest_mode_logical ?
+			MSI_ADDR_DEST_MODE_LOGICAL :
+			MSI_ADDR_DEST_MODE_PHYSICAL) |
+		MSI_ADDR_REDIRECTION_CPU |
+		MSI_ADDR_DEST_ID(cfg->dest_apicid);
+
+	msg->data =
+		MSI_DATA_TRIGGER_EDGE |
+		MSI_DATA_LEVEL_ASSERT |
+		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_VECTOR(cfg->vector);
+
+	/*
+	 * Only the IOMMU itself can use the trick of putting destination
+	 * APIC ID into the high bits of the address. Anything else would
+	 * just be writing to memory if it tried that, and needs IR to
+	 * address higher APIC IDs.
+	 */
+	if (dmar)
+		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
+	else
+		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
+}
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 46ffd41a4238..4eda617eda1e 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -15,7 +15,6 @@
 #include <linux/hpet.h>
 #include <linux/msi.h>
 #include <asm/irqdomain.h>
-#include <asm/msidef.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
@@ -23,42 +22,6 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
-static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
-				  bool dmar)
-{
-	msg->address_hi = MSI_ADDR_BASE_HI;
-
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		(apic->dest_mode_logical ?
-			MSI_ADDR_DEST_MODE_LOGICAL :
-			MSI_ADDR_DEST_MODE_PHYSICAL) |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(cfg->dest_apicid);
-
-	msg->data =
-		MSI_DATA_TRIGGER_EDGE |
-		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
-		MSI_DATA_VECTOR(cfg->vector);
-
-	/*
-	 * Only the IOMMU itself can use the trick of putting destination
-	 * APIC ID into the high bits of the address. Anything else would
-	 * just be writing to memory if it tried that, and needs IR to
-	 * address higher APIC IDs.
-	 */
-	if (dmar)
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-	else
-		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
-}
-
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	__irq_msi_compose_msg(irqd_cfg(data), msg, false);
-}
-
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
 	struct msi_msg msg[2] = { [1] = { }, };
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1eac53632786..bb2e2a2488a5 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -818,6 +818,12 @@ void apic_ack_edge(struct irq_data *irqd)
 	apic_ack_irq(irqd);
 }
 
+static void x86_vector_msi_compose_msg(struct irq_data *data,
+				       struct msi_msg *msg)
+{
+       __irq_msi_compose_msg(irqd_cfg(data), msg, false);
+}
+
 static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
