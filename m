Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042CBC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A68C040A8B;
	Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6sjqRaQs-VP; Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0C0C408D5;
	Thu,  5 May 2022 23:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C81F2C0086;
	Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20F9EC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DA3F60BC6
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6gS0p-_lpD87 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B5A960B6A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795068; x=1683331068;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=s6kx2WD+U+gm4lQdJ9AXtLnfiPC2EdKdrJZetgovSOw=;
 b=LAQSZFRt0VfLpAxWTIJ93sXM7+vniu54efLdIofxKBwFoy9j7jF3poZ5
 YtcyHPYKJORJ67r9K34BiOafHzmMr7xizSFXrQIahVDwbd382b2M4r+2J
 z7gCod/C8XrRSfOc4a0D4yuhlhXRUIKdp5pZkZ3jJk+PxhZZXYMyrnl1D
 hE6bs1vl5j7gXoamhTPtbXo0Jq3bPAr2Ko5mSaZWHh4GoH0sFHCeBtiy7
 VlIRq063rDeI1TUYi4Vd21NNwkMz/Eqi+Pr24XryCbfr0G2z/YRHn59em
 3jT8t3/W+CgWaBuiSLhbCg8loti/KQDXj8LmcsLKgDvvSFuSiDVmEOwvB A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496313"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914346"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:46 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 07/29] iommu/vt-d: Clear the redirection hint when the
 destination mode is physical
Date: Thu,  5 May 2022 16:59:46 -0700
Message-Id: <20220506000008.30892-8-ricardo.neri-calderon@linux.intel.com>
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

When the destination mode of an interrupt is physical APICID, the interrupt
is delivered only to the single CPU of which the physical APICID is
specified in the destination ID field. Therefore, the redirection hint is
meaningless.

Furthermore, on certain processors, the IOMMU does not deliver the
interrupt when the delivery mode is NMI, the redirection hint is set, and
the destination mode is physical. Clearing the redirection hint ensures
that the NMI is delivered.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/irq_remapping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a67319597884..d2764a71f91a 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1128,7 +1128,17 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
-	irte->redir_hint = 1;
+
+	/*
+	 * When using the destination mode of physical APICID, only the
+	 * processor specified in @dest receives the interrupt. Thus, the
+	 * redirection hint is meaningless.
+	 *
+	 * Furthermore, on some processors, NMIs with physical delivery mode
+	 * and the redirection hint set are delivered as regular interrupts
+	 * or not delivered at all.
+	 */
+	irte->redir_hint = apic->dest_mode_logical;
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
