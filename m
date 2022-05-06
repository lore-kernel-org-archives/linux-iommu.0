Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D137FC433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9377340C22;
	Thu,  5 May 2022 23:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_0KNlxsNBGO; Thu,  5 May 2022 23:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65A6240C12;
	Thu,  5 May 2022 23:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04F2AC0082;
	Thu,  5 May 2022 23:58:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0335DC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4EBA60B74
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejiSJ-bqbwMM for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3683260AD8
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795074; x=1683331074;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=L3Ao7/ADM/27W4au5Ct5JCZDRw2G77dHHek57JRUTvg=;
 b=Tbsm5h+K+HZ5e963QP3vTdJ0zywmcaL4rdHGA+PhQEZw4oZ3cEiKEuxt
 BMHJEvq+QmxUb/kFjJbiXA2A1F/bbUBfO/pKh7GXnlb7w80wYZGRVSVne
 KEa2kPtIs1cKGXdRvXikN3MaKmyBwaFytSU24gyUep54IaFkn+KlsKM1S
 /DpEjloWdKLu8woVq2kbaLKxO4mwHuwdROQ2Y3sAj/WUOgo8cPkINk/op
 c9J20DJpJqXLlLuSSk+bNquFSpxXI98peAF6jtRs7yyqbcU0lx/cbWMtW
 YM27Dgnqr5NkPP3FZM5R0kDmrJkQD88ZWEVdzEaG7Yy9VQfT7FzULG1QB g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496351"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496351"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914422"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:53 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler category
Date: Thu,  5 May 2022 17:00:00 -0700
Message-Id: <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
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

Add a NMI_WATCHDOG as a new category of NMI handler. This new category
is to be used with the HPET-based hardlockup detector. This detector
does not have a direct way of checking if the HPET timer is the source of
the NMI. Instead, it indirectly estimates it using the time-stamp counter.

Therefore, we may have false-positives in case another NMI occurs within
the estimated time window. For this reason, we want the handler of the
detector to be called after all the NMI_LOCAL handlers. A simple way
of achieving this with a new NMI handler category.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Updated to call instrumentation_end() as per f051f6979550 ("x86/nmi:
   Protect NMI entry against instrumentation")

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/nmi.h |  1 +
 arch/x86/kernel/nmi.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 1cb9c17a4cb4..4a0d5b562c91 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -28,6 +28,7 @@ enum {
 	NMI_UNKNOWN,
 	NMI_SERR,
 	NMI_IO_CHECK,
+	NMI_WATCHDOG,
 	NMI_MAX
 };
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e73f7df362f5..fde387e0812a 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -61,6 +61,10 @@ static struct nmi_desc nmi_desc[NMI_MAX] =
 		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[3].lock),
 		.head = LIST_HEAD_INIT(nmi_desc[3].head),
 	},
+	{
+		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[4].lock),
+		.head = LIST_HEAD_INIT(nmi_desc[4].head),
+	},
 
 };
 
@@ -168,6 +172,8 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	 */
 	WARN_ON_ONCE(type == NMI_SERR && !list_empty(&desc->head));
 	WARN_ON_ONCE(type == NMI_IO_CHECK && !list_empty(&desc->head));
+	WARN_ON_ONCE(type == NMI_WATCHDOG && !list_empty(&desc->head));
+
 
 	/*
 	 * some handlers need to be executed first otherwise a fake
@@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
+	handled = nmi_handle(NMI_WATCHDOG, regs);
+	if (handled == NMI_HANDLED)
+		goto out;
+
 	/*
 	 * Only one NMI can be latched at a time.  To handle
 	 * this we may process multiple nmi handlers at once to
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
