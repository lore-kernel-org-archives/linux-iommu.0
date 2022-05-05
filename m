Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD9BC4321E
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9678F41811;
	Thu,  5 May 2022 23:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmPeE27X0_3G; Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AF8A41755;
	Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33EE3C0032;
	Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50847C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1DFB60BCA
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51BVBmEC0cD0 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E86D760ADE
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795067; x=1683331067;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=eY8ASsd7/aj+9aYNbmEq9GanUaeYVEui2oMFa5HCVds=;
 b=YMXxjxb13scJhai/c9kcuT3e1y9qaoy8f8nlPRARxffbHqPCprnB4xfO
 hXwBos4I70Mr0AyRixDeh0aN79ZtIDaIG1Dz8PuAeI+PvSgy8G8bpns7S
 cxeaF1gkEOeTa+Fx4vLn+VMg4qS7lHeWQd0g987MT5o2HktG/NKS+w+Sm
 bhqDCKkDSeA+aROvxoKiHyhVomN3jeiXj8uFyD4cz01pGe7b6on/BNeAu
 R7fjAvc1VUbT9L0kftyrHRrs9H2YY2tZabw9xYbnOtugI/6zp3kkuUdOd
 ZdEun7Ym253F4N6UesRlY0S74D2prZjSJBNM4rOBQ4824LeMQ6MBAr7Yt Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836895"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914342"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:46 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 06/29] x86/apic/vector: Implement support for NMI delivery
 mode
Date: Thu,  5 May 2022 16:59:45 -0700
Message-Id: <20220506000008.30892-7-ricardo.neri-calderon@linux.intel.com>
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

The flag X86_IRQ_ALLOC_AS_NMI indicates to the interrupt controller that
it should configure the delivery mode of an IRQ as NMI. Implement such
request. This causes irq_domain children in the hierarchy to configure
their irq_chips accordingly. When no specific delivery mode is requested,
continue using the delivery mode of the APIC driver in use.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/apic/vector.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 11f881f45cec..df4d7b9f6e27 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -570,6 +570,10 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
+	/* Only one IRQ per NMI */
+	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
+		return -EINVAL;
+
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
@@ -610,7 +614,15 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		 * default delivery mode of the APIC. Children irq domains
 		 * may take the delivery mode from the individual irq
 		 * configuration rather than from the APIC driver.
+		 *
+		 * Vectors are meaningless if the delivery mode is NMI. Since
+		 * nr_irqs is 1, we can return.
 		 */
+		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+			apicd->hw_irq_cfg.delivery_mode = APIC_DELIVERY_MODE_NMI;
+			return 0;
+		}
+
 		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
 
 		/*
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
