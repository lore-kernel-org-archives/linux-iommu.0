Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1EFCCA483
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACE6F6143B;
	Fri,  1 Jul 2022 20:10:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACE6F6143B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=bdIu56u5;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IIGVa/3L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uKwzt6tJW-54; Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F0EE561032;
	Fri,  1 Jul 2022 20:10:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0EE561032
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC2B8C007B;
	Fri,  1 Jul 2022 20:10:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5423CC0035
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 230B241765
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 230B241765
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=sholland.org
 header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=bdIu56u5; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=IIGVa/3L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zN6NABwrgsBl for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC74C41727
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC74C41727
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:48 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id B24605802E7;
 Fri,  1 Jul 2022 16:01:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 01 Jul 2022 16:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1656705682; x=1656712882; bh=1g
 Yq3VbEkPVty/pd1tEYQnVO1uU7x5LYLlMSe3zbDrE=; b=bdIu56u5NUcFW5hvaK
 2/laTWzN8GTHoYTAZXrQlwuGxUO/51vWxcPMTA2kgfltyNMsvcq9NazmXFT1M9hf
 Yy7nInyHLoEyitpTjDbv3GYoUVgLpWSo40ttAnfTRma7mvNYsPbG1mejs2Qgcb3t
 LbFItmmgx0ui1jMDv36Wq3t0B7zszJ1O7HYnTX+/01o0+2PoRscDY1WPAVAiDqzA
 lL8KiMkDxHJI+62Lumh+214ubp82KV2hgQ6WmN9StyO1UxZc5Jrl4uDo5CIcMf+v
 w3d+EflqLt3LJ6h3D97ccfd/v3Oe7fE6Pop4QYptsoopZcfNSmaoapHf/0dyMeat
 KJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1656705682; x=1656712882; bh=1gYq3VbEkPVty
 /pd1tEYQnVO1uU7x5LYLlMSe3zbDrE=; b=IIGVa/3L4rIIDkpm5x9kJF4p4zPgE
 bekRQi2xgDfEmYrxPVdTUgxGIsZGgD0mmbIIymHEeJR6lUkDl7AgH4weEwbRvI39
 z+3v4BNWVNKOg4Y3UKxsTxHjzdvdNIGGn03gzsHuwPtkq11popiSb4aRYBnIvyaL
 L3pj53Cf9IJhHuC3KtMRhkQ9lEVDTzotxVI7nK9L+t1iY2zY5ZlKJF5XkZlzy1kW
 qRxbxA7qUT5pUcyoRZWtPspZfkyMkSc2u3lh/Z1BI0SuCIzlQIrm1Ogt1M9ktsDh
 yae+YwhKLB+1GibJY4Yhz0XeYPpHVyQA4KoXzDl26EyU2QNQe5gKGx26w==
X-ME-Sender: <xms:iFK_YvH3FMyAZsKRZV3A0GprYtQC7s68B_MPFguwTi0KU6kqxq0xRQ>
 <xme:iFK_YsUz0pMrVbXNSrGo0uGc-HB3zbb4nrlZSFsuHkdbMUP1sdU3HElrNL2KF-oGh
 b34XdWEa03EJqcOog>
X-ME-Received: <xmr:iFK_YhJh_1EQiu0zTxxgTBMM1Zw1nveGQHWRXFwuPPHyhoxhahmD-kB5FtEfBUWeLd1zUD8TKcYVLdTH_AwtDSrjfUIvksQpn43lCZI1ulvIDzhZY9rSagRLZXsv73Fdp0MsGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
 gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:iFK_YtHsbbj2iuY_FeCxakuRenry44VSu2B-fzKnQnYneTvRe9spSw>
 <xmx:iFK_YlVfgRQNrxDo7Ai87dgvpBDjHa2HPao95ZSvgWSmF7Y8euI5pA>
 <xmx:iFK_YoOR_g9PNyYJVLJ7TkcK34rcKMKV3h6pUl542yueucyJ1Rv_Gw>
 <xmx:klK_Yuc4LCTmGZISjXfSPMcDk1VujGGWEKmzte1mSHk4yVLCHyf3JA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:10 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 1/8] irqchip/mips-gic: Only register IPI domain when SMP is
 enabled
Date: Fri,  1 Jul 2022 15:00:49 -0500
Message-Id: <20220701200056.46555-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701200056.46555-1-samuel@sholland.org>
References: <20220701200056.46555-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 linux-hyperv@vger.kernel.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <jbeulich@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, kernel test robot <lkp@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Samuel Holland <samuel@sholland.org>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 Wei Xu <xuwei5@hisilicon.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-xtensa@linux-xtensa.org,
 Kees Cook <keescook@chromium.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Maximilian Heyne <mheyne@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Juergen Gross <jgross@suse.com>, Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Colin Ian King <colin.king@intel.com>,
 Helge Deller <deller@gmx.de>
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

The MIPS GIC irqchip driver may be selected in a uniprocessor
configuration, but it unconditionally registers an IPI domain.

Limit the part of the driver dealing with IPIs to only be compiled when
GENERIC_IRQ_IPI is enabled, which corresponds to an SMP configuration.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - New patch to fix build errors in uniprocessor MIPS configs

 drivers/irqchip/Kconfig        |  3 +-
 drivers/irqchip/irq-mips-gic.c | 80 +++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6be7d88..d26a4ff7c99f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -322,7 +322,8 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
-	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_IPI if SMP
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..8a9efb6ae587 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -52,13 +52,15 @@ static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
-static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+
+#ifdef CONFIG_GENERIC_IRQ_IPI
 static DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 static DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
+#endif /* CONFIG_GENERIC_IRQ_IPI */
 
 static struct gic_all_vpes_chip_data {
 	u32	map;
@@ -472,9 +474,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	u32 map;
 
 	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
+#ifdef CONFIG_GENERIC_IRQ_IPI
 		/* verify that shared irqs don't conflict with an IPI irq */
 		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
 			return -EBUSY;
+#endif /* CONFIG_GENERIC_IRQ_IPI */
 
 		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
 						    &gic_level_irq_controller,
@@ -567,6 +571,8 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 };
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 				const u32 *intspec, unsigned int intsize,
 				irq_hw_number_t *out_hwirq,
@@ -670,6 +676,48 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
+static int gic_register_ipi_domain(struct device_node *node)
+{
+	struct irq_domain *gic_ipi_domain;
+	unsigned int v[2], num_ipis;
+
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
+						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain) {
+		pr_err("Failed to add IPI domain");
+		return -ENXIO;
+	}
+
+	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
+
+	if (node &&
+	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
+		bitmap_set(ipi_resrv, v[0], v[1]);
+	} else {
+		/*
+		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
+		 * meeting the requirements of arch/mips SMP.
+		 */
+		num_ipis = 2 * num_possible_cpus();
+		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
+	}
+
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+
+	return 0;
+}
+
+#else /* !CONFIG_GENERIC_IRQ_IPI */
+
+static inline int gic_register_ipi_domain(struct device_node *node)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_GENERIC_IRQ_IPI */
+
 static int gic_cpu_startup(unsigned int cpu)
 {
 	/* Enable or disable EIC */
@@ -688,11 +736,12 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
+	unsigned int cpu_vec, i, gicconfig;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
 	size_t gic_len;
+	int ret;
 
 	/* Find the first available CPU vector. */
 	i = 0;
@@ -780,30 +829,9 @@ static int __init gic_of_init(struct device_node *node,
 		return -ENXIO;
 	}
 
-	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
-						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
-						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-						  node, &gic_ipi_domain_ops, NULL);
-	if (!gic_ipi_domain) {
-		pr_err("Failed to add IPI domain");
-		return -ENXIO;
-	}
-
-	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
-
-	if (node &&
-	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
-		bitmap_set(ipi_resrv, v[0], v[1]);
-	} else {
-		/*
-		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
-		 * meeting the requirements of arch/mips SMP.
-		 */
-		num_ipis = 2 * num_possible_cpus();
-		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
-	}
-
-	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+	ret = gic_register_ipi_domain(node);
+	if (ret)
+		return ret;
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
