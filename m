Return-Path: <SRS0=fDzP=OK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758FDC433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3A261205
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F3A261205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1705D81A34;
	Mon, 20 Sep 2021 20:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVfcx1Kht5Q8; Mon, 20 Sep 2021 20:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF4D082AED;
	Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0199C0026;
	Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA75C002A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 163B5401D5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1UGsiM1KIFEr for <iommu@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 20:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CB644036F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="220033651"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="220033651"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2021 13:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="473779509"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:16 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Dave Hansen" <dave.hansen@intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 8/8] docs: x86: Change documentation for SVA (Shared Virtual
 Addressing)
Date: Mon, 20 Sep 2021 19:23:49 +0000
Message-Id: <20210920192349.2602141-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
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

Since allocating, freeing and fixing up PASID are changed, the
documentation is updated to reflect the changes.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/sva.rst | 81 +++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd51ef1f..868ed4b25002 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -106,16 +106,83 @@ process share the same page tables, thus the same MSR value.
 
 PASID is cleared when a process is created. The PASID allocation and MSR
 programming may occur long after a process and its threads have been created.
-One thread must call iommu_sva_bind_device() to allocate the PASID for the
-process. If a thread uses ENQCMD without the MSR first being populated, a #GP
-will be raised. The kernel will update the PASID MSR with the PASID for all
-threads in the process. A single process PASID can be used simultaneously
+One thread must call iommu_sva_bind(_device) to allocate the PASID for the process.
+If a thread uses ENQCMD without the MSR first being populated, it will cause #GP.
+The kernel will fix up the #GP by writing the process-wide PASID into the
+thread that took the #GP. A single process PASID can be used simultaneously
 with multiple devices since they all share the same address space.
 
-One thread can call iommu_sva_unbind_device() to free the allocated PASID.
-The kernel will clear the PASID MSR for all threads belonging to the process.
+The PASID MSR value is cleared at thread creation and is never inherited from a
+parent. This ensures consistent child behavior no matter whether the thread is
+created first or the PASID is allocated (and the MSR written).
 
-New threads inherit the MSR value from the parent.
+
+PASID Lifecycle Management
+==========================
+
+Only processes that access SVA-capable devices need to have a PASID
+allocated. This allocation happens when a process opens/binds an SVA-capable
+device but finds no PASID for this process. Subsequent binds of the same, or
+other devices will share the same PASID.
+
+Although the PASID is allocated to the process by opening a device,
+it is not active in any of the threads of that process. It's loaded to the
+IA32_PASID MSR lazily when a thread tries to submit a work descriptor
+to a device using the ENQCMD.
+
+That first access will trigger a #GP fault because the IA32_PASID MSR
+has not been initialized with the PASID value assigned to the process
+when the device was opened. The Linux #GP handler notes that a PASID has
+been allocated for the process, and so initializes the IA32_PASID MSR, takes
+a reference to the PASID and returns so that the ENQCMD instruction is
+re-executed.
+
+On fork(2) or exec(2) the PASID is removed from the process as it no
+longer has the same address space that it had when the device was opened.
+
+On clone(2) the new task shares the same address space, so will be
+able to use the PASID allocated to the process. The IA32_PASID is not
+preemptively initialized as the PASID value might not be allocated yet or
+the kernel does not know whether this thread is going to access the device
+and the cleared IA32_PASID MSR reduces context switch overhead by xstate
+init optimization. Since #GP faults have to be handled on any threads that
+were created before the PASID was assigned to the mm of the process, newly
+created threads might as well be treated in a consistent way.
+
+Due to complexity of freeing the PASID and clearing all IA32_PASID MSRs in
+all threads in unbind, free the PASID lazily when there is no PASID user.
+Track the PASID's reference count in the following way:
+
+- Track device usage of the PASID: The PASID's reference count is initialized
+  as 1 when the PASID is allocated in the first bind. Bind takes a reference
+  and unbind drops the reference.
+- Track task usage of the PASID: Fixing up the IA32_PASID MSR in #GP takes
+  reference and exit(2) drops the reference. Once the MSR is fixed up, the
+  PASID value stays in the MSR stays for the rest life of the task.
+
+The PASID is freed lazily in exit(2) or unbind when there is no reference
+to the PASID. After freed, the PASID can be allocated to any process.
+
+ENQCMD needs at least two requirements: a valid IA32_PASID MSR with the
+PASID value of the process and a valid PASID table entry for the PASID.
+To execute ENQCMD, the user must ensure the device is bound to the
+process so that the kernel can guarantee to meet the above two requirements.
+
+Lazy PASID free may cause the task still has the PASID value in IA32_PASID
+while there is no PASID table entry for the PASID. The workqueue submitted
+by ENQCMD in this scenario cannot find the PASID table entry and generates
+a DMAR fault. Currently DMAR fault handler just prints a fault reason.
+Future DMAR fault handler might notify the user the workqueue failure.
+Here are two detailed cases:
+
+- Unbind removes the PASID table entry but the process still owns the PASID
+  and the task's IA32_PASID MSR still keeps the PASID value. The workqueue
+  submitted by ENQCMD in this task will generate a DMAR fault.
+- Unbind removes the PASID table entry but the process still owns the PASID
+  because some task took one reference during fix up. ENQCMD executed in a
+  task that doesn't fix up the IA32_PASID MSR will generate #GP first to get
+  its IA32_PASID MSR fixed up and then the submitted workqueue will generate
+  a DMAR fault.
 
 Relationships
 =============
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
