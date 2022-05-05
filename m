Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D0C4332F
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85E7583DEF;
	Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0KhLS4pUZ4H; Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4328983DF3;
	Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A6CC0032;
	Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4908BC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 289F5401D5
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IhYa64HPEFN for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C82B4010C
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795067; x=1683331067;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=zlyJMMAdck3m7Lj6IAc06Z99mVZqGJ1kJoeEJPS6nAw=;
 b=LBxqIaTW/leSRqLkSrVGHeVILprjxPQANXNQ5N6/LmSSmQYZVBxRLF8J
 dIda/WG3zLFdW8Vhl7QyWthYxLt/ZV/vh9lS/z6zGK5l1FhwzMqLWOrsv
 pb8J0nuRLwlcd6FG1exap14SyKLvxyFVGt9p+iBacYtrShJxAXfIjCxbK
 xkEsOqT/UvP5THg+MbiexVnorhdqBT/G+yMIqVNF4ZD/I7CQzhpyxd3rD
 2JkWUdoAKMnE7u4SGlt38X9zqZAF0OAKX8KQj212kIfmvw6yQOynaYzew
 BXQNa4/tAYNROWLSkyB8b/kYwzvMEGRvPo4Mx3+1FD1EMGnUxCJZNYl9F Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836877"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914325"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
Date: Thu,  5 May 2022 16:59:41 -0700
Message-Id: <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Currently, the delivery mode of all interrupts is set to the mode of the
APIC driver in use. There are no restrictions in hardware to configure the
delivery mode of each interrupt individually. Also, certain IRQs need to be
configured with a specific delivery mode (e.g., NMI).

Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
will update every irq_domain to set the delivery mode of each IRQ to that
specified in its irq_cfg data.

To keep the current behavior, when allocating an IRQ in the root domain
(i.e., the x86_vector_domain), set the delivery mode of the IRQ as that of
the APIC driver.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Updated indentation of the existing members of struct irq_cfg.
 * Reworded the commit message.

Changes since v4:
 * Rebased to use new enumeration apic_delivery_modes.

Changes since v3:
 * None

Changes since v2:
 * Reduced scope to only add the interrupt delivery mode in
   struct irq_alloc_info.

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hw_irq.h | 5 +++--
 arch/x86/kernel/apic/vector.c | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..5ac5e6c603ee 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -88,8 +88,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int			dest_apicid;
+	unsigned int			vector;
+	enum apic_delivery_modes	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b448f6a..838e220e8860 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
 		/*
 		 * Prevent that any of these interrupts is invoked in
 		 * non interrupt context via e.g. generic_handle_irq()
@@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		/* Don't invoke affinity setter on deactivated interrupts */
 		irqd_set_affinity_on_activate(irqd);
 
+		/*
+		 * Initialize the delivery mode of this irq to match the
+		 * default delivery mode of the APIC. Children irq domains
+		 * may take the delivery mode from the individual irq
+		 * configuration rather than from the APIC driver.
+		 */
+		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
