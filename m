Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E7C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC1D84CF5;
	Fri, 17 Dec 2021 22:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPns19SXIz-I; Fri, 17 Dec 2021 22:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1EF1F84CA9;
	Fri, 17 Dec 2021 22:02:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04E70C002F;
	Fri, 17 Dec 2021 22:02:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 245E1C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BF916118C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PP2YDrML81FO for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8AB16116E
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639778517; x=1671314517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uaN1ppSyx00sbK+6ZvuNPJeDvV+BViDU9aY3XKLPb00=;
 b=Tv8yzaWu1i78w80AYNZUa1wc1EaiGPvzRCPkptD7kzUsirmzjlyGdU2y
 KqMR8arHmITDv2ETeafrgEvDywSAy0dmFfH+4T8a+GJr6Pwcv9fSw5IZo
 xRlNLgXZiH2xD7LAy/s1/LedeZhpRFNI9UBfyUzdznFNMB70qDHo3Qtz7
 B/BcJB2PkTZK6H6xCx4ZrRMIVnLh1Lohd4+m5S207CEB5SQUCryPN6khN
 Vo6hy0CqgaZxU7Fbhjn3zm2dFXfkf1ETLxVz6Iw7K3kQpUzkB+6Bg3HSw
 BKDqWwpdAVH4AbcS56EC3yqr70bG18abrwkJYDMbZSNhrOgK96XJCi9Yn w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239793582"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="239793582"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 14:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="506928090"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:48 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v2 04/11] kernel/fork: Initialize mm's PASID
Date: Fri, 17 Dec 2021 22:01:29 +0000
Message-Id: <20211217220136.2762116-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

A new mm doesn't have a PASID yet when it's created. Initialize
the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob)

 include/linux/sched/mm.h | 10 ++++++++++
 kernel/fork.c            | 10 ++--------
 mm/init-mm.c             |  4 ++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aca874d33fe6..394c4359c4e1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -407,4 +408,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 }
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+#else
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+#endif
+
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index b33c52021d4e..4e799c9b13bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,6 +96,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/sched/mm.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1018,13 +1019,6 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
-static void mm_init_pasid(struct mm_struct *mm)
-{
-#ifdef CONFIG_IOMMU_SVA
-	mm->pasid = INIT_PASID;
-#endif
-}
-
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1053,7 +1047,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_init_pasid(mm);
+	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..fbe7844d0912 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -10,6 +10,7 @@
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
+#include <linux/ioasid.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -38,6 +39,9 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
+#ifdef CONFIG_IOMMU_SVA
+	.pasid		= INVALID_IOASID,
+#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
