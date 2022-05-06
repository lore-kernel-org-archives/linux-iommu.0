Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66994C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03FF4419E4;
	Thu,  5 May 2022 23:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bukxPd6SWvzR; Thu,  5 May 2022 23:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC15E419E2;
	Thu,  5 May 2022 23:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 825C1C0032;
	Thu,  5 May 2022 23:58:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13920C007B
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DE6F610A7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLMQq0CvqjdV for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7016660C07
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795077; x=1683331077;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=OMAzr1b+gR0ghYqlTvIkOvlFxefky6ROYu4/AGgKvYI=;
 b=YfFarRGVX9YnmNqsciff8PD8fJfMvQnvl98Qh1kYA1YnOD0m20s+j16+
 ce0HHY6ekJLyuiHXvDt0gg1uiR44kv5j4DOQZd55U8kdsiEuzfL4UbQ3u
 WjjaF6CcPYwqusE1ID7/zzHbX3HzJGXfXMvfUM21wMB8OP9jJn3qo0ifD
 7MzhwzCQ3CBwndTctgJyymzkT88BGwYKgxsiAIBSxao2NQSGq2V6O0d9a
 rzZhuNxCnOAdolnPQjNR9+1UdVOLsf8oZ3ELzfhBtwXgyYbac75PQyMYc
 3IQpbw/GxDe8G8yaQzgelwccN9jrmvvIsY0iOIe3Lk/82W+zShO08+B/g g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496380"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914455"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:56 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining tsc_khz
Date: Thu,  5 May 2022 17:00:07 -0700
Message-Id: <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
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

The HPET hardlockup detector relies on tsc_khz to estimate the value of
that the TSC will have when its HPET channel fires. A refined tsc_khz
helps to estimate better the expected TSC value.

Using the early value of tsc_khz may lead to a large error in the expected
TSC value. Restarting the NMI watchdog detector has the effect of kicking
its HPET channel and make use of the refined tsc_khz.

When the HPET hardlockup is not in use, restarting the NMI watchdog is
a noop.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4
 * N/A

Changes since v3
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/tsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..cc1843044d88 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	/* Inform the TSC deadline clockevent devices about the recalibration */
 	lapic_update_tsc_freq();
 
+	/*
+	 * If in use, the HPET hardlockup detector relies on tsc_khz.
+	 * Reconfigure it to make use of the refined tsc_khz.
+	 */
+	lockup_detector_reconfigure();
+
 	/* Update the sched_clock() rate to match the clocksource one */
 	for_each_possible_cpu(cpu)
 		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
