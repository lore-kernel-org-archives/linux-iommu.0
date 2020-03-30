Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D950C18E5B
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6106320757
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6106320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 207AB2034D;
	Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qv0esjCUxjp; Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 917FD22B7A;
	Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FB86C1D7E;
	Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A768AC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96ECE22B7A
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bl9Ta0ED6ADd for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 20:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id EBB182034D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:37:59 +0000 (UTC)
IronPort-SDR: v9p1nFQAoMVi3UJEpnW8TBvjjgjPFPNefV7xASyII5HgJHr+p36MrOMu97uag/vFOYxuOOAHqE
 dMBvo+ZPsjbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 13:37:58 -0700
IronPort-SDR: CJQdaqrUSQQgilclDju/LPXmoVK/jl0KfY1ywgIPdbpVbsU8pb5eXwYaR08Z9wBUjW1FauLcmv
 zW/pMYgTXpbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="242143821"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:37:57 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 0/7] x86: tag application address space for devices
Date: Mon, 30 Mar 2020 12:33:01 -0700
Message-Id: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Typical hardware devices require a driver stack to translate application
buffers to hardware addresses, and a kernel-user transition to notify the
hardware of new work. What if both the translation and transition overhead
could be eliminated? This is what Shared Virtual Address (SVA) and ENQCMD
enabled hardware like Data Streaming Accelerator (DSA) aims to achieve.
Applications map portals in their local-address-space and directly submit
work to them using a new instruction.

This series implements management of a new MSR (MSR_IA32_PASID). This new
MSR allows an application address space to be associated with what the PCIe
spec calls a Process Address Space ID (PASID). This PASID tag is carried
along with all requests between applications and devices and allows devices
to interact with the process address space.

SVA and ENQCMD enabled device drivers will use this series in the future.
For example, it will be used by the phase 2 DSA driver which will be
released with SVA and ENQCMD support as explained in:
https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator

This series only provides simple and basic support for the MSR as follows:
1. Explain different various technical terms used in the series (patch 1).
2. Enumerate support for ENQCMD in the processor (patch 2).
3. Handle FPU PASID state and the MSR during context switch (patches 3-4).
4. Allocate and free PASID for a process (patch 5).
5. Fix up the PASID MSR in #GP handler when one thread in a process
   executes ENQCMD for the first time (patches 6).
6. Clear PASID state for forked and cloned thread (patch 7).

And this patch series needs support from supervisor states patch set:
https://lore.kernel.org/lkml/20200328164307.17497-1-yu-cheng.yu@intel.com/

The v3 supervisor states series, this patch series, and DSA phase 2 series
(to be released shortly in idxd driver) can be cloned from:
https://github.com/intel/idxd-driver.git     idxd-stage2

References:
1. Detailed information on the ENQCMD/ENQCMDS instructions and the
IA32_PASID MSR can be found in Intel Architecture Instruction Set
Extensions and Future Features Programming Reference:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

2. Detailed information on DSA can be found in DSA specification:
https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

Ashok Raj (1):
  docs: x86: Add a documentation for ENQCMD

Fenghua Yu (5):
  x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
  x86/msr-index: Define IA32_PASID MSR
  x86/mmu: Allocate/free PASID
  x86/traps: Fix up invalid PASID
  x86/process: Clear PASID state for a newly forked/cloned thread

Yu-cheng Yu (1):
  x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature

 Documentation/x86/enqcmd.rst       | 185 +++++++++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/fpu/types.h   |  10 ++
 arch/x86/include/asm/fpu/xstate.h  |   2 +-
 arch/x86/include/asm/iommu.h       |   3 +
 arch/x86/include/asm/mmu.h         |   4 +
 arch/x86/include/asm/mmu_context.h |  14 +++
 arch/x86/include/asm/msr-index.h   |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c   |   1 +
 arch/x86/kernel/fpu/xstate.c       |   4 +
 arch/x86/kernel/process.c          |  13 ++
 arch/x86/kernel/traps.c            |  17 +++
 drivers/iommu/intel-svm.c          | 119 +++++++++++++++++--
 13 files changed, 367 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/x86/enqcmd.rst

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
