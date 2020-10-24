Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAEEC56202
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:37:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE0B2469C
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEBxw75U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE0B2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 770B387357;
	Sat, 24 Oct 2020 21:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0TOSIlPt4yA; Sat, 24 Oct 2020 21:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 57264874D8;
	Sat, 24 Oct 2020 21:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442F7C0893;
	Sat, 24 Oct 2020 21:36:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6B79C1AD7
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A1B0486A77
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22CIHMboRNlY for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 21FCA86A4E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ikWKCAbNgSYSTx8CvKcfSVES3+bcE6fz2fZBIvPenfg=; b=OEBxw75UKpTz1DSj/h+VRA9m9i
 409KF6sANlugKgYGjc2TXPQ40UOPTZff6v1Enb7uu0ZzxA51LHBc5fHJHG0Pcym665zQaW27sdfY+
 EGOzyASyWiSXOZfarnQhNpvZjLEBBBVrmZSCg6w9Kmwj33OrhP7Pdq28P8hp++xCitgCqE8eKUcuJ
 TM7IJf3FEHMhSSzzwddADjz1YJDufu8p6rt8JR9fjytoM/xUaX8UQuGlajr19H9at6NNM9m64GnOX
 GdhiQa7opU09LFOR0+bZZhF/U9tzfV4NwgrtezzYJiRqoD73oe0Aey6Xc6d06/r1MuAIp4z4WFgNc
 ZR/Ys0Og==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCS-0008BV-ST; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rOD-RF; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 10/35] x86/hpet: Move MSI support into hpet.c
Date: Sat, 24 Oct 2020 22:35:10 +0100
Message-Id: <20201024213535.443185-11-dwmw2@infradead.org>
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

This isn't really dependent on PCI MSI; it's just generic MSI which is now
supported by the generic x86_vector_domain. Move the HPET MSI support back
into hpet.c with the rest of the HPET support.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hpet.h |  11 ----
 arch/x86/kernel/apic/msi.c  | 111 ---------------------------------
 arch/x86/kernel/hpet.c      | 118 ++++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 128 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6352dee37cda..ab9f3dd87c80 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,17 +74,6 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void force_hpet_resume(void);
 
-struct irq_data;
-struct hpet_channel;
-struct irq_domain;
-
-extern void hpet_msi_unmask(struct irq_data *data);
-extern void hpet_msi_mask(struct irq_data *data);
-extern void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg);
-extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
-extern int hpet_assign_irq(struct irq_domain *domain,
-			   struct hpet_channel *hc, int dev_num);
-
 #ifdef CONFIG_HPET_EMULATE_RTC
 
 #include <linux/interrupt.h>
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 4eda617eda1e..44ebe25e7703 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -340,114 +340,3 @@ void dmar_free_hwirq(int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 #endif
-
-/*
- * MSI message composition
- */
-#ifdef CONFIG_HPET_TIMER
-static inline int hpet_dev_id(struct irq_domain *domain)
-{
-	struct msi_domain_info *info = msi_get_domain_info(domain);
-
-	return (int)(long)info->data;
-}
-
-static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
-}
-
-static struct irq_chip hpet_msi_controller __ro_after_init = {
-	.name = "HPET-MSI",
-	.irq_unmask = hpet_msi_unmask,
-	.irq_mask = hpet_msi_mask,
-	.irq_ack = irq_chip_ack_parent,
-	.irq_set_affinity = msi_domain_set_affinity,
-	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
-};
-
-static int hpet_msi_init(struct irq_domain *domain,
-			 struct msi_domain_info *info, unsigned int virq,
-			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
-{
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
-			    handle_edge_irq, arg->data, "edge");
-
-	return 0;
-}
-
-static void hpet_msi_free(struct irq_domain *domain,
-			  struct msi_domain_info *info, unsigned int virq)
-{
-	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
-}
-
-static struct msi_domain_ops hpet_msi_domain_ops = {
-	.msi_init	= hpet_msi_init,
-	.msi_free	= hpet_msi_free,
-};
-
-static struct msi_domain_info hpet_msi_domain_info = {
-	.ops		= &hpet_msi_domain_ops,
-	.chip		= &hpet_msi_controller,
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
-};
-
-struct irq_domain *hpet_create_irq_domain(int hpet_id)
-{
-	struct msi_domain_info *domain_info;
-	struct irq_domain *parent, *d;
-	struct irq_alloc_info info;
-	struct fwnode_handle *fn;
-
-	if (x86_vector_domain == NULL)
-		return NULL;
-
-	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
-	if (!domain_info)
-		return NULL;
-
-	*domain_info = hpet_msi_domain_info;
-	domain_info->data = (void *)(long)hpet_id;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.devid = hpet_id;
-	parent = irq_remapping_get_irq_domain(&info);
-	if (parent == NULL)
-		parent = x86_vector_domain;
-	else
-		hpet_msi_controller.name = "IR-HPET-MSI";
-
-	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
-					      hpet_id);
-	if (!fn) {
-		kfree(domain_info);
-		return NULL;
-	}
-
-	d = msi_create_irq_domain(fn, domain_info, parent);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		kfree(domain_info);
-	}
-	return d;
-}
-
-int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-		    int dev_num)
-{
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.data = hc;
-	info.devid = hpet_dev_id(domain);
-	info.hwirq = dev_num;
-
-	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
-}
-#endif
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7a50f0b62a70..3b8b12769f3b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 
@@ -50,7 +51,7 @@ unsigned long				hpet_address;
 u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
 
-#ifdef CONFIG_PCI_MSI
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
@@ -467,9 +468,8 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 /*
  * HPET MSI Support
  */
-#ifdef CONFIG_PCI_MSI
-
-void hpet_msi_unmask(struct irq_data *data)
+#ifdef CONFIG_GENERIC_MSI_IRQ
+static void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -479,7 +479,7 @@ void hpet_msi_unmask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_mask(struct irq_data *data)
+static void hpet_msi_mask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -489,12 +489,118 @@ void hpet_msi_mask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
+static void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 {
 	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
+static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
+}
+
+static struct irq_chip hpet_msi_controller __ro_after_init = {
+	.name = "HPET-MSI",
+	.irq_unmask = hpet_msi_unmask,
+	.irq_mask = hpet_msi_mask,
+	.irq_ack = irq_chip_ack_parent,
+	.irq_set_affinity = msi_domain_set_affinity,
+	.irq_retrigger = irq_chip_retrigger_hierarchy,
+	.irq_write_msi_msg = hpet_msi_write_msg,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int hpet_msi_init(struct irq_domain *domain,
+			 struct msi_domain_info *info, unsigned int virq,
+			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
+
+	return 0;
+}
+
+static void hpet_msi_free(struct irq_domain *domain,
+			  struct msi_domain_info *info, unsigned int virq)
+{
+	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
+}
+
+static struct msi_domain_ops hpet_msi_domain_ops = {
+	.msi_init	= hpet_msi_init,
+	.msi_free	= hpet_msi_free,
+};
+
+static struct msi_domain_info hpet_msi_domain_info = {
+	.ops		= &hpet_msi_domain_ops,
+	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
+};
+
+static struct irq_domain *hpet_create_irq_domain(int hpet_id)
+{
+	struct msi_domain_info *domain_info;
+	struct irq_domain *parent, *d;
+	struct irq_alloc_info info;
+	struct fwnode_handle *fn;
+
+	if (x86_vector_domain == NULL)
+		return NULL;
+
+	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
+	if (!domain_info)
+		return NULL;
+
+	*domain_info = hpet_msi_domain_info;
+	domain_info->data = (void *)(long)hpet_id;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
+	info.devid = hpet_id;
+	parent = irq_remapping_get_irq_domain(&info);
+	if (parent == NULL)
+		parent = x86_vector_domain;
+	else
+		hpet_msi_controller.name = "IR-HPET-MSI";
+
+	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
+					      hpet_id);
+	if (!fn) {
+		kfree(domain_info);
+		return NULL;
+	}
+
+	d = msi_create_irq_domain(fn, domain_info, parent);
+	if (!d) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+	}
+	return d;
+}
+
+static inline int hpet_dev_id(struct irq_domain *domain)
+{
+	struct msi_domain_info *info = msi_get_domain_info(domain);
+
+	return (int)(long)info->data;
+}
+
+static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
+			   int dev_num)
+{
+	struct irq_alloc_info info;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
+
+	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+}
+
 static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
 	struct hpet_channel *hc = clockevent_to_channel(evt);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
