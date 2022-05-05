Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C061C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D079F60BE7;
	Thu,  5 May 2022 23:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Skh8n-qmcnna; Thu,  5 May 2022 23:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB0D960AD7;
	Thu,  5 May 2022 23:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D556BC0032;
	Thu,  5 May 2022 23:58:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10708C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38E2F60BE7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YK2yXGVO-6RY for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CEA5610A7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795073; x=1683331073;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=Nult8sm5xsB/xmikf6OohjRwLwTEdiOtEi3jvHsqyXk=;
 b=eRzjj2VYdg+sQNRXu1QyUAA++G5NW9mg6JeC+2MdzKlXDLp5KqYAeV/S
 FfDWr+xUcp/ZVAN6qIS88vN9rXxQrd/nTFEo/sI2WXVzXk7+CONzIv7SR
 5zKTwKq5uhqGUmy0NPRQg6lurEUqJNSyTD8uQc9ifXvQ/A2z8Fq6y23LW
 ZVuuK97y/vZ7BH8MjCPZdw+kAWl4ITNF7apadoQebAWDIIJbMcL18cbT6
 o9LnutIVVhYhI7RD6CbqBfH2bpc1+9ybEcV9BTjAqP0p9Caev5vmx6ohe
 i6lbZsBqOWCWzmwipj7auIcvBYp/171s3mV0W2jHfJVxiibGvNlgFzZV3 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496347"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496347"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914415"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:52 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
Date: Thu,  5 May 2022 16:59:59 -0700
Message-Id: <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
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

Certain implementations of the hardlockup detector require support for
Inter-Processor Interrupt shorthands. On x86, support for these can only
be determined after all the possible CPUs have booted once (in
smp_init()). Other architectures may not need such check.

lockup_detector_init() only performs the initializations of data
structures of the lockup detector. Hence, there are no dependencies on
smp_init().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
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
 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..62c52c9e4c2b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1600,9 +1600,11 @@ static noinline void __init kernel_init_freeable(void)
 
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
-	lockup_detector_init();
 
 	smp_init();
+
+	lockup_detector_init();
+
 	sched_init_smp();
 
 	padata_init();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
