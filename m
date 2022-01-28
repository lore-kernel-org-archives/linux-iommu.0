Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A26C4332F
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 20:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C78B405C2;
	Fri, 28 Jan 2022 20:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxFo2w0_ZYK6; Fri, 28 Jan 2022 20:29:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E16F5405D0;
	Fri, 28 Jan 2022 20:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73C5FC0070;
	Fri, 28 Jan 2022 20:29:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 157B7C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00FB18282C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOB5YGdOfH1H for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 20:29:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2149F827A5
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643401763; x=1674937763;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v7Qgm78mQ7173GgCb2BV6zkS0u7NYuuELpPc4hyi3zk=;
 b=f1JZXDwUYzHq5Uvb2BIRl3XpIpNZ81A9mnJGAR0Nw8LUjjs9HKiur664
 ggAVHOb+mV59bNl8IvwcBJuQhf+MXe8biJ+s0b9qAVOBT0h+xK5JLGBnN
 Pxvj4d2ROBQYSVPAfxlomlGRXUuUxZAumOZ2fwrm9L9Y4U9lI3YGReEKz
 liSti8xLhPj+ysWtSXshFcSP6KuFImGtt95OoPYvYc0zuuJgok3M50t4R
 X7ctONhYN1Lwl/hVqGSVmcCDPk9dfaed4N3jWNY5eJ1fs5AVGbxnb60Lt
 iLiCdijiHCqqpR7ZyzTdhQBljiqFZd67r+HqnYUku8zJnIpVfnR9a2nCi w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227862431"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="227862431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 12:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="618827686"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:20 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 00/11] Re-enable ENQCMD and PASID MSR
Date: Fri, 28 Jan 2022 12:28:54 -0800
Message-Id: <20220128202905.2274672-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
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

Problems in the old code to manage SVM (Shared Virtual Memory) devices
and the PASID (Process Address Space ID) led to that code being
disabled.

Subsequent discussions resulted in a far simpler approach:

1) PASID life cycle is from first allocation by a process until that
   process exits.
2) All tasks begin with PASID disabled
3) The #GP fault handler tries to fix faulting ENQCMD instructions very
   early (thus avoiding complexities of the XSAVE infrastructure)

Change Log:
v3:
- Rename mm_pasid_get() to mm_pasid_set() in patch #5 (Thomas).
- Remove ioasid_get() because it's not used any more when the IOASID
  is freed on mm exit in patch #5 (Thomas).
- Remove PASID's refcount exercise in ioasid_put() and rename
  ioasid_put() to ioasid_free() in patch #5 and #11 (Thomas).
- Add Acked-by: Josh Poimboeuf <jpoimboe@redhat.com> in patch #10.

v2 can be found at https://lore.kernel.org/lkml/20211217220136.2762116-1-fenghua.yu@intel.com/

v2:
- Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
  PeterZ)
- Directly write IA32_PASID MSR in fixup while local IRQ is still disabled
  (Thomas)
- Simplify handling ENQCMD in objtool (PeterZ and Josh)
- Define mm_pasid_get(), mm_pasid_drop(), and mm_pasid_init() in mm and
  call the functions from IOMMU (Dave Hansen).
- A few changes in the #GP fixup function (Dave Hansen, Tony Luck).
- Initial PASID value is changed to INVALID_PASID (Ashok Raj and
  Jacob Pan).
- Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
  So the mm's PASID operations are generic for both X86 and ARM
  (Dave Hansen).
- Rename CONFIG_IOMMU_SVA_LIB to more useful and accurate
  CONFIG_IOMMU_SVA
- Use CONFIG_IOMMU_SVA for PASID processing condition (Jacob)
- The patch that cleans up old update_pasid() function is in upstream
  now (commit: 00ecd5401349 "iommu/vt-d: Clean up unused PASID updating
  functions") and therefore it's removed from this version.

v1 can be found at https://lore.kernel.org/lkml/20210920192349.2602141-1-fenghua.yu@intel.com/T/#md6d542091da1d1159eda0a44a16e57d0c0dfb209

Fenghua Yu (10):
  iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to CONFIG_IOMMU_SVA
  mm: Change CONFIG option for mm->pasid field
  iommu/ioasid: Introduce a helper to check for valid PASIDs
  kernel/fork: Initialize mm's PASID
  iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm
    exit
  x86/fpu: Clear PASID when copying fpstate
  x86/traps: Demand-populate PASID MSR via #GP
  x86/cpufeatures: Re-enable ENQCMD
  tools/objtool: Check for use of the ENQCMD instruction in the kernel
  docs: x86: Change documentation for SVA (Shared Virtual Addressing)

Peter Zijlstra (1):
  sched: Define and initialize a flag to identify valid PASID in the
    task

 Documentation/x86/sva.rst                     | 53 ++++++++++++++----
 arch/x86/include/asm/disabled-features.h      |  7 ++-
 arch/x86/kernel/fpu/core.c                    |  7 +++
 arch/x86/kernel/traps.c                       | 55 +++++++++++++++++++
 drivers/iommu/Kconfig                         |  6 +-
 drivers/iommu/Makefile                        |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +-
 drivers/iommu/intel/Kconfig                   |  2 +-
 drivers/iommu/intel/iommu.c                   |  4 +-
 drivers/iommu/intel/svm.c                     |  9 ---
 drivers/iommu/ioasid.c                        | 38 ++-----------
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++---------
 drivers/iommu/iommu-sva-lib.h                 |  7 +--
 include/linux/ioasid.h                        | 21 +++----
 include/linux/mm_types.h                      |  2 +-
 include/linux/sched.h                         |  3 +
 include/linux/sched/mm.h                      | 26 +++++++++
 kernel/fork.c                                 | 15 +++--
 mm/init-mm.c                                  |  4 ++
 tools/objtool/arch/x86/decode.c               | 11 +++-
 20 files changed, 197 insertions(+), 119 deletions(-)

-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
