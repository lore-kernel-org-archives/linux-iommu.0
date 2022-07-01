Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2697CCA485
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F53860FB2;
	Fri,  1 Jul 2022 20:10:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F53860FB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=QpxRZ/Qq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bZV6JNZN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Lh-se7GxiGY; Fri,  1 Jul 2022 20:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD68C607D1;
	Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD68C607D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B07C007B;
	Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11C0EC0071
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4C9184145
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4C9184145
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=sholland.org
 header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=QpxRZ/Qq; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=bZV6JNZN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDQxWC38ZS2i for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D07CA84143
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D07CA84143
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id C3753580314;
 Fri,  1 Jul 2022 16:01:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 01 Jul 2022 16:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1656705710; x=1656712910; bh=GP
 TgF7ArqFMLRWCMzAXk/iblC7hZOhNlz+8yGyXcVmI=; b=QpxRZ/QqCKAaTufwyd
 lUjoM1KJpo2vAxdEuEjb/waTg16dZR9eragrRhhtwxuPLt0ECneX3zy6CNzBBx5c
 Ygb4PPzfUzDV5VvtfKPQBAj8iCK8i+A3N0IvHHfLXEkCFny82EoJbTgg4N7U1bwk
 TgxvTxE3rNtOE/fFih1K1eJ8kHseL1OspFJFfo5CJ04JSj1DGPwQ6FHwv0IhNoq4
 EGKiBH64+38GGFPCSypyrkvUHdkYQuk9s/BixzzRoak4pO7Ob+kyqg83h69D4GAa
 h3rUBxATwnOMT09jx3nmAk3wW/b1biR06qzg7OZv2+rzhWJ7Rr/DFMBhHTnlVHau
 I+8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1656705710; x=1656712910; bh=GPTgF7ArqFMLR
 WCMzAXk/iblC7hZOhNlz+8yGyXcVmI=; b=bZV6JNZNCNgrHjWghrR9O98nWKlYN
 DX/X53ob25+i0NwhRNBQiBLDVz6UVV3he1PXha4QFwp5yMwGnxpB7lu/UEE8Xi3o
 OpXqvhbTbTBs7KDOhb4KUllG3Pk9Aa1vRSyBe3BCvgnGtLlZf/oqGEk+Jnl3BG85
 OJ3xW7PAvFO/MhjF/+sAERp5XAdEzU4Ff5xnJ4prZbZoQYpU1kHRmjt2+C7DkY3Y
 SuzrsxXUNapv8zup6IGTgy0/s8A+vKX+TshcO/FgHArWEelqqro6tFdd578sYzkL
 51oiHdOk0YWBV5old0Q464FJ20N+qIDsdwwqcQx1JwG+SPenzYypJolkw==
X-ME-Sender: <xms:rVK_YrvJiSYONF7CEdjhjFiA7NVNIz848Y6UWL1UvoW5Kk98rD32MA>
 <xme:rVK_YscCQ56tn6Jbi-UrgbUXziNYammdhZwj9d_fRqjwZfFsyibvxpzulvyGyPE3l
 nIcbwFWIb1gQ1IWRw>
X-ME-Received: <xmr:rVK_YuxQ26_MlFVPAYRm9LQSezj1uAnQq_5KXA4VYKTypOMiEuKARbcRhSJ8ThL01GY8yOnOdaKMCYVbNpHMpQiFOxVUfyBzPfQ56dNPyDvXSxcf1rys5qct4CVmOEgcSJMg5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
 gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:rVK_YqPoiHG8AjDOChBFnFX08lnDDslPf8goJgdd_vLYsZ_FLe8BOw>
 <xmx:rVK_Yr9D1WRuiQZL_UjTJVrGcywERxW5RhRT9Z-Yaao614z_XXjogg>
 <xmx:rVK_YqUOpiANhp9VfUV7TJzOYKVezuEGDZevF5jxI4UHjJPlI9xzWA>
 <xmx:rlK_Ylc6c0A6OatdG6ociNhXHzzYk5zr5HpOQTe8ZbFc30Ca9vzr-Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:47 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 6/8] genirq: Add and use an irq_data_update_affinity helper
Date: Fri,  1 Jul 2022 15:00:54 -0500
Message-Id: <20220701200056.46555-7-samuel@sholland.org>
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
 Stephen Hemminger <sthemmin@microsoft.com>,
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

Some architectures and irqchip drivers modify the cpumask returned by
irq_data_get_affinity_mask, usually by copying in to it. This is
problematic for uniprocessor configurations, where the affinity mask
should be constant, as it is known at compile time.

Add and use a setter for the affinity mask, following the pattern of
irq_data_update_effective_affinity. This allows the getter function to
return a const cpumask pointer.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - New patch to introduce irq_data_update_affinity

 arch/alpha/kernel/irq.c          | 2 +-
 arch/ia64/kernel/iosapic.c       | 2 +-
 arch/ia64/kernel/irq.c           | 4 ++--
 arch/ia64/kernel/msi_ia64.c      | 4 ++--
 arch/parisc/kernel/irq.c         | 2 +-
 drivers/irqchip/irq-bcm6345-l1.c | 4 ++--
 drivers/parisc/iosapic.c         | 2 +-
 drivers/sh/intc/chip.c           | 2 +-
 drivers/xen/events/events_base.c | 7 ++++---
 include/linux/irq.h              | 6 ++++++
 10 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index f6d2946edbd2..15f2effd6baf 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
 		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu = cpu;
 
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
+	irq_data_update_affinity(data, cpumask_of(cpu));
 	chip->irq_set_affinity(data, cpumask_of(cpu), false);
 	return 0;
 }
diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index 35adcf89035a..99300850abc1 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -834,7 +834,7 @@ iosapic_unregister_intr (unsigned int gsi)
 	if (iosapic_intr_info[irq].count == 0) {
 #ifdef CONFIG_SMP
 		/* Clear affinity */
-		cpumask_setall(irq_get_affinity_mask(irq));
+		irq_data_update_affinity(irq_get_irq_data(irq), cpu_all_mask);
 #endif
 		/* Clear the interrupt information */
 		iosapic_intr_info[irq].dest = 0;
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index ecef17c7c35b..275b9ea58c64 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -57,8 +57,8 @@ static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
 	if (irq < NR_IRQS) {
-		cpumask_copy(irq_get_affinity_mask(irq),
-			     cpumask_of(cpu_logical_id(hwid)));
+		irq_data_update_affinity(irq_get_irq_data(irq),
+					 cpumask_of(cpu_logical_id(hwid)));
 		irq_redir[irq] = (char) (redir & 0xff);
 	}
 }
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index df5c28f252e3..025e5133c860 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -37,7 +37,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 	msg.data = data;
 
 	pci_write_msi_msg(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
+	irq_data_update_affinity(idata, cpumask_of(cpu));
 
 	return 0;
 }
@@ -132,7 +132,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
 	msg.address_lo |= MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
 
 	dmar_msi_write(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(data), mask);
+	irq_data_update_affinity(data, mask);
 
 	return 0;
 }
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0fe2d79fb123..5ebb1771b4ab 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -315,7 +315,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
 	struct irq_data *d = irq_get_irq_data(irq);
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
+	irq_data_update_affinity(d, cpumask_of(cpu));
 #endif
 
 	return per_cpu(cpu_data, cpu).txn_addr;
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 142a7431745f..6899e37810a8 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -216,11 +216,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 		enabled = intc->cpus[old_cpu]->enable_cache[word] & mask;
 		if (enabled)
 			__bcm6345_l1_mask(d);
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 		if (enabled)
 			__bcm6345_l1_unmask(d);
 	} else {
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 	}
 	raw_spin_unlock_irqrestore(&intc->lock, flags);
 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..3a8c98615634 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -677,7 +677,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
 	if (dest_cpu < 0)
 		return -1;
 
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
+	irq_data_update_affinity(d, cpumask_of(dest_cpu));
 	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
 
 	spin_lock_irqsave(&iosapic_lock, flags);
diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index 358df7510186..828d81e02b37 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
 	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -1;
 
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
+	irq_data_update_affinity(data, cpumask);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 46d9295d9a6e..5e8321f43cbd 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -528,9 +528,10 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
 	BUG_ON(irq == -1);
 
 	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
-		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
-		cpumask_copy(irq_get_effective_affinity_mask(irq),
-			     cpumask_of(cpu));
+		struct irq_data *data = irq_get_irq_data(irq);
+
+		irq_data_update_affinity(data, cpumask_of(cpu));
+		irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	}
 
 	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 69ee4e2f36ce..adcfebceb777 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -884,6 +884,12 @@ static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 	return d->common->affinity;
 }
 
+static inline void irq_data_update_affinity(struct irq_data *d,
+					    const struct cpumask *m)
+{
+	cpumask_copy(d->common->affinity, m);
+}
+
 static inline struct cpumask *irq_get_affinity_mask(int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
