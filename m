Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745DC55179
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B9D24696
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LbicCFso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B9D24696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4408986E28;
	Sat, 24 Oct 2020 21:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1QbapDpQKAJ; Sat, 24 Oct 2020 21:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C82586E7A;
	Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2660EC0893;
	Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF27C1AD8
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6844886AD7
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8nqLm9rkdMc for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2162586A51
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=QKv+CnHFIIRktMa1BeG6QVG/pUWoIFk8HhQM9MlGvdQ=; b=LbicCFsoHA0GA9eqP0yPlGOiQa
 P3S6n6ygsmuS0MX2RoZA7KBotfj4G8Hfbo9r0Bc2t8WEOSmzQ6KZc3IlvHnUlUI2siJtpiPrhve9F
 UKBSKhFAr/gS7qmUPoPTtZrnnsUVHkqQiumBL93Yi9K7n+Zu2HHRAnQkSgb0cdH9UYipsEjTv+gmM
 252auLaNt1LcUpDVCsEuKzpemNPk7fzxwRp1PmdPom10w15Af3MDod3z6dFkvqpGzPXJ+HyGCIu/A
 svpgDHEjJatE/TGReDC1B89G3u0i7Q7ouQP481z9X6wylEYCmK772TyH0Q45p1dHOdxYTih+DgOyq
 5l0g4bPw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCO-0008B3-Gg; Sat, 24 Oct 2020 21:35:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rNg-KF; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 02/35] x86/msi: Only use high bits of MSI address for DMAR
 unit
Date: Sat, 24 Oct 2020 22:35:02 +0100
Message-Id: <20201024213535.443185-3-dwmw2@infradead.org>
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

The Intel IOMMU has an MSI-like configuration for its interrupt, but it
isn't really MSI. So it gets to abuse the high 32 bits of the address, and
puts the high 24 bits of the extended APIC ID there.

This isn't something that can be used in the general case for real MSIs,
since external devices using the high bits of the address would be
performing writes to actual memory space above 4GiB, not targeted at the
APIC.

Factor the hack out and allow it only to be used when appropriate, adding a
WARN_ON_ONCE() if other MSIs are targeted at an unreachable APIC ID. That
should never happen since the compatibility MSI messages are not used when
Interrupt Remapping is enabled.

The x2apic_enabled() check isn't needed because Linux won't bring up CPUs
with higher APIC IDs unless IR and x2apic are enabled anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6313f0a05db7..516df47bde73 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -23,13 +23,11 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
-static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
+static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+				  bool dmar)
 {
 	msg->address_hi = MSI_ADDR_BASE_HI;
 
-	if (x2apic_enabled())
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-
 	msg->address_lo =
 		MSI_ADDR_BASE_LO |
 		((apic->irq_dest_mode == 0) ?
@@ -43,18 +41,29 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 		MSI_DATA_LEVEL_ASSERT |
 		MSI_DATA_DELIVERY_FIXED |
 		MSI_DATA_VECTOR(cfg->vector);
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
 }
 
 void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	__irq_msi_compose_msg(irqd_cfg(data), msg);
+	__irq_msi_compose_msg(irqd_cfg(data), msg, false);
 }
 
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
 	struct msi_msg msg[2] = { [1] = { }, };
 
-	__irq_msi_compose_msg(cfg, msg);
+	__irq_msi_compose_msg(cfg, msg, false);
 	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
 }
 
@@ -276,6 +285,17 @@ struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
 #endif
 
 #ifdef CONFIG_DMAR_TABLE
+/*
+ * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
+ * high bits of the destination APIC ID. This can't be done in the general
+ * case for MSIs as it would be targeting real memory above 4GiB not the
+ * APIC.
+ */
+static void dmar_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	__irq_msi_compose_msg(irqd_cfg(data), msg, true);
+}
+
 static void dmar_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	dmar_msi_write(data->irq, msg);
@@ -288,6 +308,7 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
