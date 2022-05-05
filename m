Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818B3C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5024160AD7;
	Thu,  5 May 2022 23:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTB6PN-0D9tf; Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F4BD60C07;
	Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06DE7C007B;
	Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 471C3C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31D5B60D94
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orfZrUe-4RNv for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A2FD60BE7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795071; x=1683331071;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=yu43tYTm3rL820NWGTlU5e3BSTdrJeh1cVn1o9Y1twQ=;
 b=JQnplOTaDirudAeFWy/OXDsyUAUCscy1y1o3D1XewIESJN4hn1IY723q
 y6BCAEBdWLVMUIv9ZV2GyeukgmXyDpG5f/pxJBqWqtad5eLyTM3PaXHpT
 nOGDJDPDIV+BUk4FIaK02NKTbTJEC0sBoVeDTnxu6+rwxh3BicH3k9Iw/
 F06RQDqzJkH80aGWyUHEjnTwFNo6sdgudCnX00dgMVgpebobX78damJAO
 TMfW+gxYyAYe7XHAKe7eBvjupVFgAsIUCai+/9bN1qpfsn8ZOB5o4q8t5
 C3vfciymqVXLDSsl+nafbPxvnmjCV3wwXzHnGWL5CW2Vy0I60cArauQEW A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496337"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914383"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 16/29] x86/hpet: Prepare IRQ assignments to use the
 X86_ALLOC_AS_NMI flag
Date: Thu,  5 May 2022 16:59:55 -0700
Message-Id: <20220506000008.30892-17-ricardo.neri-calderon@linux.intel.com>
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

The flag X86_ALLOC_AS_NMI indicates that the IRQs to be allocated in an
IRQ domain need to be configured as NMIs.  Add an as_nmi argument to
hpet_assign_irq(). Even though the HPET clock events do not need NMI
IRQs, the HPET hardlockup detector does. A subsequent changeset will
implement the reservation of a channel for it.

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
 arch/x86/kernel/hpet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 2c6713b40921..02d25e00e93f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -618,7 +618,7 @@ static inline int hpet_dev_id(struct irq_domain *domain)
 }
 
 static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-			   int dev_num)
+			   int dev_num, bool as_nmi)
 {
 	struct irq_alloc_info info;
 
@@ -627,6 +627,8 @@ static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 	info.data = hc;
 	info.devid = hpet_dev_id(domain);
 	info.hwirq = dev_num;
+	if (as_nmi)
+		info.flags |= X86_IRQ_ALLOC_AS_NMI;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
@@ -755,7 +757,7 @@ static void __init hpet_select_clockevents(void)
 
 		sprintf(hc->name, "hpet%d", i);
 
-		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num, false);
 		if (irq <= 0)
 			continue;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
