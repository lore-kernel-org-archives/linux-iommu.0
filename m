Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA594C433DF
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 20:18:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9667B2084D
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 20:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9667B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 586E923724;
	Thu, 25 Jun 2020 20:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJSm+GtYA-hx; Thu, 25 Jun 2020 20:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B9535231A0;
	Thu, 25 Jun 2020 20:18:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1EEDC0893;
	Thu, 25 Jun 2020 20:18:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BFFCC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 685E3881BF
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w95SM7oTp6Aa for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 20:18:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 631ED881A6
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:36 +0000 (UTC)
IronPort-SDR: LIiFO0nsB+Bq8HJoRbKdW4gfg7Y76U4iD+sn8qCGr7JULl4e8IcZaGEHF2qLi6YxS9Phg8dRff
 xYjmYkHhUnDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146566722"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="146566722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 13:18:35 -0700
IronPort-SDR: yWQGN4+/oLTUQHbFUM6OSWd7QSpUxGCVE4UI5jVxe5EYzFYdBh8l0QNo5Fyvx/+50fRof7mfYg
 4LOBWknPLVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="453132202"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga005.jf.intel.com with ESMTP; 25 Jun 2020 13:18:34 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradeed.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v4 00/12] x86: tag application address space for devices
Date: Thu, 25 Jun 2020 13:17:10 -0700
Message-Id: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
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
 arch/x86/include/asm/fpu/types.h              |  10 +
 arch/x86/include/asm/fpu/xstate.h             |   2 +-
 arch/x86/include/asm/iommu.h                  |   3 +
 arch/x86/include/asm/mmu_context.h            |  14 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/fpu/xstate.c                  |   4 +
 arch/x86/kernel/process.c                     |  18 ++
 arch/x86/kernel/traps.c                       |  14 +
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
 53 files changed, 716 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/x86/sva.rst

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
