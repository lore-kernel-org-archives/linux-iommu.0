Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBBEC433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83689417D9;
	Thu,  5 May 2022 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSTXjK9k4s4b; Thu,  5 May 2022 23:57:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2268D41817;
	Thu,  5 May 2022 23:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B231C0082;
	Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 151A9C0032
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF390402F7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ic3fNzAV_mz for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B58EC401D5
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795067; x=1683331067;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=Jz5/GbztoMpO5f33w54Dy1VgumudmsMpWQzH5+E5s4I=;
 b=XlZwEYI6/M/Oti/oKGwvzBgRy98haQGOy0pNl1ocMfxAxNWuh77VXoX8
 mfn6j2B80IABNcm2f1O78T7HrFLtCiJjKHo2hMNbw33/X8Dk8y0kdMWqC
 fGxZUMJgnuGpV9lnIBA2YtHsP6CCcbNoT5mwYUJ6VnlikYVSe3tqS9whK
 m9aetlD8Dq2cnW1PFOzKRx4vf+D5jdptOJLtEXxoVv9mMX80y2xpfGVkZ
 KP7dGaAydb0qbZhBi8RzIxrREpIw/4dKxnXCCs4oaDFPX5YI5CArhld5c
 xKH4yHo0pWLiBnxXl+l//kY9iRCajNzs1b+Cc/OKRDspSQxpa1V1+6FF8 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836887"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836887"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914335"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 04/29] x86/apic: Add the X86_IRQ_ALLOC_AS_NMI irq
 allocation flag
Date: Thu,  5 May 2022 16:59:43 -0700
Message-Id: <20220506000008.30892-5-ricardo.neri-calderon@linux.intel.com>
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

There are cases in which it is necessary to set the delivery mode of an
interrupt as NMI. Add a new flag that callers can specify when allocating
an IRQ.

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
 arch/x86/include/asm/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index 125c23b7bad3..de1cf2e80443 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -10,6 +10,7 @@ enum {
 	/* Allocate contiguous CPU vectors */
 	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		= 0x1,
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
+	X86_IRQ_ALLOC_AS_NMI				= 0x4,
 };
 
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
