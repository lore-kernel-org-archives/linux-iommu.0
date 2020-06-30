Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC62C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 23:45:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8E42083B
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 23:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8E42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CECBB2408D;
	Tue, 30 Jun 2020 23:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsQBEUEDi18E; Tue, 30 Jun 2020 23:45:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AD02A23BE7;
	Tue, 30 Jun 2020 23:45:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F7FC0865;
	Tue, 30 Jun 2020 23:45:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8816C0865
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B001288A38
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2sHW6fbgVICS for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 23:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A7C40889C3
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:45:19 +0000 (UTC)
IronPort-SDR: jhu3bSiAscJrO4EgqgenT4/++7TGpL+I40kHAaRZ8wuomC0R2b3j1kmJgn8bTnRgc2eesGQgN1
 owfY2SFoAGrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134710055"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="134710055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 16:45:18 -0700
IronPort-SDR: 1d2w0g0oEXr+THsF3l1K+zbXI6+lgr1NNg3NQvkVRc/72TZojcLGwV26rsQ6HxqeqK42B7FlDP
 Wthx4SVb1UZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="386842551"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 16:44:51 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Felix Kuehling" <Felix.Kuehling@amd.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradead.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v5 00/12] x86: tag application address space for devices
Date: Tue, 30 Jun 2020 16:44:30 -0700
Message-Id: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
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

This series enables ENQCMD and associated management of the new MSR
(MSR_IA32_PASID). This new MSR allows an application address space to be
associated with what the PCIe spec calls a Process Address Space ID (PASID).
This PASID tag is carried along with all requests between applications and
devices and allows devices to interact with the process address space.

SVA and ENQCMD enabled device drivers need this series. The phase 2 DSA
patches with SVA and ENQCMD support was released on the top of this series:
https://lore.kernel.org/patchwork/cover/1244060/

This series only provides simple and basic support for ENQCMD and the MSR:
1. Clean up type definitions (patch 1-2). These patches can be in a
   separate series.
   - Define "pasid" as "u32" consistently
   - Define "flags" as "unsigned int"
2. Explain different various technical terms used in the series (patch 3).
3. Enumerate support for ENQCMD in the processor (patch 4).
4. Handle FPU PASID state and the MSR during context switch (patches 5-6).
5. Define "pasid" in mm_struct (patch 7).
5. Clear PASID state for new mm and forked and cloned thread (patch 8-9).
6. Allocate and free PASID for a process (patch 10).
7. Fix up the PASID MSR in #GP handler when one thread in a process
   executes ENQCMD for the first time (patches 11-12).

This patch series and the DSA phase 2 series are in
https://github.com/intel/idxd-driver/tree/idxd-stage2

References:
1. Detailed information on the ENQCMD/ENQCMDS instructions and the
IA32_PASID MSR can be found in Intel Architecture Instruction Set
Extensions and Future Features Programming Reference:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

2. Detailed information on DSA can be found in DSA specification:
https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

Chang log:
v5:
- Mark ENQCMD disabled when configured out and use cpu_feature_enabled()
  to simplify the feature checking code in patch 10 and 12 (PeterZ and
  Dave Hansen)
- Add Reviewed-by: Lu Baolu to patch 1, 2, 10, and 12.

v4:
- Define PASID as "u32" instead of "unsigned int" in patch 1, 7, 10, 12.
  (Christoph)
- Drop v3 patch 2 which changes PASID type in ocxl because it's not related
  to x86 and was rejected by ocxl maintainer Frederic Barrat
- A split patch which changes PASID type to u32 in crypto/hisilicon/qm.c
  was released separately to linux-crypto mailing list because it's not
  related to x86 and is a standalone patch:

v3:
- Change names of bind_mm() and unbind_mm() to match to new APIs in
  patch 4 (Baolu)
- Change CONFIG_PCI_PASID to CONFIG_IOMMU_SUPPORT because non-PCI device
  can have PASID in ARM in patch 8 (Jean)
- Add a few sanity checks in __free_pasid() and alloc_pasid() in
  patch 11 (Baolu)
- Add patch 12 to define a new flag "has_valid_pasid" for a task and
  use the flag to identify if the task has a valid PASID MSR (PeterZ)
- Add fpu__pasid_write() to update the MSR in fixup() in patch 13
- Check if mm->pasid can be found in fixup() in patch 13

v2:
- Add patches 1-3 to define "pasid" and "flags" as "unsigned int"
  consistently (Thomas)
  (these 3 patches could be in a separate patch set)
- Add patch 8 to move "pasid" to generic mm_struct (Christoph).
  Jean-Philippe Brucker released a virtually same patch. Upstream only
  needs one of the two.
- Add patch 9 to initialize PASID in a new mm.
- Plus other changes described in each patch (Thomas)

Ashok Raj (1):
  docs: x86: Add documentation for SVA (Shared Virtual Addressing)

Fenghua Yu (9):
  iommu: Change type of pasid to u32
  iommu/vt-d: Change flags type to unsigned int in binding mm
  x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
  x86/msr-index: Define IA32_PASID MSR
  mm: Define pasid in mm
  fork: Clear PASID for new mm
  x86/process: Clear PASID state for a newly forked/cloned thread
  x86/mmu: Allocate/free PASID
  x86/traps: Fix up invalid PASID

Peter Zijlstra (1):
  sched: Define and initialize a flag to identify valid PASID in the
    task

Yu-cheng Yu (1):
  x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature

 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/sva.rst                     | 287 ++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/disabled-features.h      |   9 +-
 arch/x86/include/asm/fpu/types.h              |  10 +
 arch/x86/include/asm/fpu/xstate.h             |   2 +-
 arch/x86/include/asm/iommu.h                  |   3 +
 arch/x86/include/asm/mmu_context.h            |  11 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/fpu/xstate.c                  |   4 +
 arch/x86/kernel/process.c                     |  18 ++
 arch/x86/kernel/traps.c                       |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h       |   2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   2 +-
 drivers/iommu/amd/amd_iommu.h                 |  10 +-
 drivers/iommu/amd/iommu.c                     |  31 +-
 drivers/iommu/amd/iommu_v2.c                  |  20 +-
 drivers/iommu/intel/dmar.c                    |   7 +-
 drivers/iommu/intel/intel-pasid.h             |  24 +-
 drivers/iommu/intel/iommu.c                   |   4 +-
 drivers/iommu/intel/pasid.c                   |  31 +-
 drivers/iommu/intel/svm.c                     | 225 ++++++++++++--
 drivers/iommu/iommu.c                         |   2 +-
 drivers/misc/uacce/uacce.c                    |   2 +-
 include/linux/amd-iommu.h                     |   8 +-
 include/linux/intel-iommu.h                   |  14 +-
 include/linux/intel-svm.h                     |   2 +-
 include/linux/iommu.h                         |  10 +-
 include/linux/mm_types.h                      |   6 +
 include/linux/sched.h                         |   3 +
 include/linux/uacce.h                         |   2 +-
 kernel/fork.c                                 |  12 +
 54 files changed, 719 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/x86/sva.rst

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
