Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419D2C4332F
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFB0D40BE5;
	Thu,  5 May 2022 23:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhCnFdfFaeMU; Thu,  5 May 2022 23:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9136740C19;
	Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40F16C0032;
	Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02E4AC007B
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53C6960ADE
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynryDOcBGowv for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7573860AD7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795067; x=1683331067;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=H881t49gt9ruU/EtOx7+sxhRpxmGtS427Z13jRF3PD8=;
 b=U3k/HwjtI1RpT+f9U5hA5Pnky5VzdJD0D5edFJxnMChqEq6c25uJ1EL8
 cO1frK+72Ykotb0WtQvdJJTeDKt7MNlvbLjEQ3Bgs0kM/6byKkc7LbnB4
 /62XrVS3cNIiaONBPcDXvivn0i92rFqUJz6/wZnCaZegGJ7aPy7Grz91W
 eJ0bU+xNHWAGoEExxIShlAFl5yxH13nMM3GtV/g4tcZjGQx2a5POQmn/C
 HhX0QDelzeNIW7dI0DIooLZtPkV8GIiepcutN+j9aCjpRJqqIx+P8XYop
 K1TQ8kVOxurZATT7dbNZoSY3czZ1whHrgwxxUoVAEosc09nf8De5tftqV g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836881"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914332"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode individually for
 each IRQ
Date: Thu,  5 May 2022 16:59:42 -0700
Message-Id: <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
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

There are no restrictions in hardware to set  MSI messages with its
own delivery mode. Use the mode specified in the provided IRQ hardware
configuration data. Since most of the IRQs are configured to use the
delivery mode of the APIC driver in use (set in all of them to
APIC_DELIVERY_MODE_FIXED), the only functional changes are where
IRQs are configured to use a specific delivery mode.

Changing the utility function __irq_msi_compose_msg() takes care of
implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI
irq_chips.

The IO-APIC irq_chip configures the entries in the interrupt redirection
table using the delivery mode specified in the corresponding MSI message.
Since the MSI message is composed by a higher irq_chip in the hierarchy,
it does not need to be updated.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 189d3a5e471a..d1e12da1e9af 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2528,7 +2528,7 @@ void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
 	msg->arch_addr_lo.destid_0_7 = cfg->dest_apicid & 0xFF;
 
-	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	msg->arch_data.delivery_mode = cfg->delivery_mode;
 	msg->arch_data.vector = cfg->vector;
 
 	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
