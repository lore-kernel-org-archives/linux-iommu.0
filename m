Return-Path: <SRS0=fDzP=OK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7AAC43219
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709BC61352
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 709BC61352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D935404D6;
	Mon, 20 Sep 2021 20:02:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dUatl1eNB35; Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90438404CC;
	Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A091C0027;
	Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1361CC0020
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7729660AE5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqxYAXgbjDUT for <iommu@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 20:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E01E060AC6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="220033628"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="220033628"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2021 13:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="473779464"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:12 -0700
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
Subject: [PATCH 0/8] Re-enable ENQCMD and PASID MSR
Date: Mon, 20 Sep 2021 19:23:41 +0000
Message-Id: <20210920192349.2602141-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
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

Since updating PASID (Process Address Space ID) MSR through IPI has a few
issues that are beyond repair, Thomas disables ENQCMD [1].

Please check Documentation/x86/sva.rst for various concepts and terms
related to PASID, ENQCMD, SVM (Shared Virtual Memory), etc.

This series re-enables ENQCMD and IA32_PASID MSR by using a #GP fix up
method previously published in [2]. A PASID is allocated to a mm once
a SVM is bound to the mm via intel_svm_bind() API. The #GP fix up method
updates the PASID MSR from the mm's PASID in #GP handler when one thread
in a process executes ENQCMD for the first time and one reference is taken
to the PASID. Once the MSR is uploaded, the thread keeps and can use it
for the rest life time of the thread. In exit(2) or unbind, the PASID's
reference is dropped and the PASID is freed if there is no reference.

References:
1. ENQCMD was disabled in upstream due to serious issues:
https://lore.kernel.org/linux-iommu/87mtsd6gr9.ffs@nanos.tec.linutronix.de/

2. #GP fix up PASID MSR:
https://lore.kernel.org/linux-iommu/1594684087-61184-1-git-send-email-fenghua.yu@intel.com/

Fenghua Yu (7):
  iommu/vt-d: Clean up unused PASID updating functions
  x86/process: Clear PASID state for a newly forked/cloned thread
  x86/traps: Demand-populate PASID MSR via #GP
  x86/mmu: Add mm-based PASID refcounting
  x86/cpufeatures: Re-enable ENQCMD
  tools/objtool: Check for use of the ENQCMD instruction in the kernel
  docs: x86: Change documentation for SVA (Shared Virtual Addressing)

Peter Zijlstra (1):
  sched: Define and initialize a flag to identify valid PASID in the
    task

 Documentation/x86/sva.rst                | 81 ++++++++++++++++++--
 arch/x86/include/asm/disabled-features.h |  7 +-
 arch/x86/include/asm/fpu/api.h           |  6 +-
 arch/x86/include/asm/iommu.h             |  8 ++
 arch/x86/include/asm/mmu_context.h       |  2 +
 arch/x86/kernel/fpu/xstate.c             | 59 +++++++++++++++
 arch/x86/kernel/process.c                |  8 ++
 arch/x86/kernel/traps.c                  | 12 +++
 drivers/iommu/intel/svm.c                | 95 ++++++++++++++++++------
 include/linux/sched.h                    |  4 +
 kernel/fork.c                            |  4 +
 tools/objtool/arch/x86/decode.c          | 10 ++-
 tools/objtool/check.c                    | 20 +++++
 tools/objtool/include/objtool/arch.h     |  1 +
 14 files changed, 283 insertions(+), 34 deletions(-)

-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
