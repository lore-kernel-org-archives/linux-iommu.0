Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB438D40C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666395; cv=none; b=DPBuMvx7IWs3CzGNovrz7hl2h2ESCVK6O0WCTDvgwDXALKzeGl/k5WTohBrJ92XL6cU/fb4ide9uvN1K/GMafVmcERXnkMf/j5yuzM2RvUEHEPmw13VStWpSUKSptAkaGVD7Mwg2EcTVAvr88212DakUdIeWX7fFBNfV0mjh1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666395; c=relaxed/simple;
	bh=XN2L7fZ4uJ0WfAuh+cusDAbs3iAuT+OUMY2ssNV6vLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rAxy1NFfAHCnAUCOMn9XXMyz87YWiQdqymbVobgWs4X5kL4WjhUCMMRdmmQwXHUkapvrmYq9JbD0oCbhARlJ/UTTwoEE3LHu6YsxfnXb01EyLMB2DYPzrfd5cWjOB5YfGOckG77Ofe3RHd4O8Ov2zXjuy83iZRxom/GTlbnM2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cre7bC9/; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cre7bC9/"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc79125e4b8so2016804a12.2
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666393; x=1791271193; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0QkpnEIdbuhsyhHvyTGjlw2S9g9xsutWV9HU9W/cLGk=;
        b=cre7bC9/9G2v117EQqrlMnF7wCY0NMcVZscIKzwheTcgsdptj2n0fxOX8CVlBlTzZE
         GWMV6Jl1wBKhziKDLKI6qbxycsRQvgYZzTcFrfScjFaxbVLzKF/zyq6xXUFQMziZPfCM
         A61PXcOcojxFm9H8zgjPI+eOTPN7JOl41RUxIm5g2nj+OVkpBjarHUkkaASqvk2k+XUt
         +mv3jSgG0TGD/e/y5kGNKi3sMsqR4MAcxkvdpnkm/08LQ1vqSyawgAPVr+JPaKCG2PRt
         P1DzWjlME86ZPbCqjNwx0Gp3ztCWQI56DngmL+xVbdBsuOEX1Y48mr1q4JnA5GU1Nw6Z
         nl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666393; x=1791271193;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QkpnEIdbuhsyhHvyTGjlw2S9g9xsutWV9HU9W/cLGk=;
        b=xG0PXHR2/O9CpdU97CEH3OOEKcfz3h73s7CYrFSjzDkX9bJuIfKDhCAsk72vK0FBB7
         Q4dKvWtTf+nBwTD0drKSxX1eOSfC6kQZzb8+f77xefNxCgPX6kpKs9dbiJY9o4RJPT9G
         Eds0VnB7+MA9ay01FoEWPMraIm5j+hWoarPPfiKvda/VjRzxibS8g4Krjl+oyWbalwMH
         tM5Nq71uOXQXkXHe9Kde4mvXDpu2aym59c/lbOnUg4Bdf5lh32Epe+70SPM8zLkW73u3
         x0qE6M6lj+YWj9yLgMjdcw/OGmTTYcs9uXlbPytJs4qk318fuQ59WrAoj3hbKo8n+xN7
         LsKA==
X-Gm-Message-State: AFuF++lIARchhApWITPQmFfZPDnTAbAQG+cmYHBhjZxbJao9goCN6DtM
	4ZhoCg03UBDnrr1GNZPT0ZsTAiunxj/TRC4dl63cGk4XQzJ8aum1KOQSPr4H8biXyAQddKr6TqD
	8JoxcG5m4bgK6Lyd/bZPSwgt53aw08NftV9UGWRB5h+ucGaEO2P7hOkew9SVPSpWRuOMR2vsYIf
	JFekY5IPpX39NWZBG/9FPbE9ghdqcf1w==
X-Received: from pgbgf2.prod.google.com ([2002:a05:6a02:2cc2:b0:cc1:cba6:484c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7352:b0:3da:5eda:d167
 with SMTP id adf61e73a8af0-3de0e7136efmr15088339637.5.1790666393084; Tue, 29
 Sep 2026 00:19:53 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-1-praan@google.com>
Subject: [RFC PATCH v1 0/9] iommu/arm-smmu-v3: Implement Live Update support
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The IOMMU Live Update framework [1] preserves the IOMMU hardware state and
the translation (HWPTs) of devices assigned to userspace via iommufd/VFIO
across a kexec based Live Update, using KHO and the DMA allocation
preservation API [2]. This series implements the arm-smmu-v3 side of it,
allowing an SMMUv3 to keep translating the DMA of preserved devices,
without any disruption, while the kernel underneath is replaced.

We have an alignment session planned on IOMMU Live Update at LPC 2026 [3].

Design
======
The arm-smmu-v3 operates almost entirely out of in-memory data structures
(Stream Table, CD tables, page tables) that the HW registers point to.
Hence, a Live Update boils down to preserving these structures, keeping
the SMMU enabled across the kexec and having the incoming kernel take
them over without ever reprogramming anything that the HW is walking.

1. Preservation (outgoing kernel)
  a. .preserve (per SMMU): Serializes the SMMU identity (the MMIO base is
     used as the token, similar to VT-d), STRTAB_BASE_CFG and the Stream
     Table. A linear Stream Table is preserved as a whole, for a 2-level
     table the L1 table is preserved, along with an array of L2 tokens
     indexed by the L1 index.
  b. .preserve_device (per master): Preserves the L2 Stream Tables holding
     the STEs of the master, since .preserve only runs for the first
     preserved device. For an S1 domain, the CD table of the master
     (linear, or L1 + active L2 tables) is preserved too. SVA domains and
     masters with active PASIDs are rejected, matching the granularity of
     the core. The ASID/VMID tagging the translation is recorded in the
     attachment_id of the device state.
  c. For S2 and nested domains only the STE is needed. The page tables
     come from the preserved domain, and a guest-owned (nested) CD table
     lives in guest RAM, which is preserved with the guest memory anyway.
  d. The Event queue memory is preserved as well, as it stays enabled
     across the kexec. Only its preservation token is serialized; its
     base, size, PROD and CONS are left in the EVTQ registers.
  e. .unpreserve_device and .unpreserve undo the above. An L2 Stream
     Table is unpreserved once no preserved master uses it.

2. Shutdown (outgoing kernel)
Instead of clearing SMMUEN, .shutdown:
  a. Masks the SMMU interrupts and waits for a running EVTQ handler.
  b. Installs abort STEs for all the unpreserved masters and clears the L1
     descriptors of L2 tables that have no preserved stream.
  c. Issues CFGI_ALL + TLBI_{EL2,NSNH}_ALL.
  d. Disables the CMDQ and the PRIQ, leaving SMMUEN and EVTQEN set for the
     preserved devices.
If any of this fails, it falls back to the regular full disable.

3. Restoration (incoming kernel)
  a. arm_smmu_init_strtab() takes over the preserved Stream Table instead
     of allocating a new one. The layout read back from STRTAB_BASE{,_CFG}
     is validated with the common kexec helpers from the kdump series [4]
     and the in-use ASIDs/VMIDs are reserved, such that new domains can
     never alias the preserved ones.
  b. arm_smmu_alloc_cd_tables() takes over the CD table of a restored
     master, validated with arm_smmu_kexec_check_ste_cdtab().
  c. arm_smmu_init_queues() adopts the preserved EVTQ, resuming from the
     live EVTQ_BASE/PROD/CONS, so any event recorded across the Live
     Update is left pending for the EVTQ handler of the incoming kernel.
  d. The stream tables and the EVTQ are restored with the managed (dmam_*)
     variants of [2] as they're devres allocations tied to the SMMU, while
     CD tables use the unmanaged (dma_*) variants, as their lifetime
     follows the master.

4. Hitless reset
When there's incoming preserved state for the SMMU (a failed restoration
fails the probe, so this implies a restored Stream Table),
arm_smmu_device_reset() shares the kdump adoption path, which already
solves the problem of a live Stream Table:
  a. SMMUEN and ATSCHK are retained, CR1/CR2/STRTAB_BASE are left alone,
     as updating them with SMMUEN=1 is CONSTRAINED UNPREDICTABLE.
  b. The CMDQ and the PRIQ (already disabled by the outgoing kernel) are
     reset as usual, while EVTQEN and the EVTQ registers are left alone
     for the adopted EVTQ.
  c. Any GERROR latched across the kexec is acked before the CMDQ is
     re-enabled.
  d. The interrupts are re-wired to the incoming kernel. The IRQs are
     masked, hence IRQ_CFGn can be reprogrammed with SMMUEN=1. The EVTQ
     thread is then woken up to handle the events already pending.
  e. CFGI_ALL and TLBI_NSNH_ALL/TLBI_EL2_ALL flush everything cached for
     the previous kernel. The preserved devices merely re-walk the
     preserved tables.

5. Hitless re-attach
The IOMMU core restores a preserved domain by allocating a new paging
domain around the preserved page table and attaching it to the restored
device [1]. A new domain comes with a new ASID/VMID though, while the
device is still doing DMA through the preserved CD/STE.

Similar to the Intel driver reclaiming the preserved Domain ID, the
restored domain inherits the ASID/VMID of the live CD/STE on its first
attach (the ID was reserved in 3.a, so it's just handed over). The stage,
the page table root and the ID recorded in 1.b are cross-checked against
the live CD/STE, failing the attach if the restored domain isn't what the
HW is walking. With this, the CD/STE computed for the restored domain are
identical to the live ones and the re-attach is a no-op for the HW.

Relation to the kdump adoption series
=====================================
Nicolin's kdump series [4] factored the parsing and validation of the
previous kernel's SMMU tables into arm-smmu-v3-kexec.c with Live Update
in mind. This series builds on it: ARM_SMMU_V3_KEXEC is also enabled by
IOMMU_LIVEUPDATE, the restore paths use those helpers, the kdump reset
path is shared via arm_smmu_strtab_is_live(), and a small
arm_smmu_kexec_check_cdtab_l1_desc() helper is factored out of the ASID
scan to be shared with the CD table restoration.

Open issues and discussion points
=================================
1. Stage of the restored domain: The core restores a domain with
   iommu_paging_domain_alloc(), i.e. flags == 0, which gives an S1 domain
   on SMMUs supporting S1. This covers VFIO/iommufd paging HWPTs, but a
   preserved S2 (NEST_PARENT) domain can't be restored as such. The core
   has to preserve the allocation flags. For now, such a mismatch fails
   the attach instead of switching the device to a different translation.

2. Hitless domain replace: A restored domain is immutable (no map/unmap),
   so the VMM has to replace it with a new HWPT after the Live Update.
   With S1, the ASID and TTB0 live in different CD qwords, making the
   replace non-hitless today; [11] addresses it with a temporary ASID.
   S2 has the same problem with the VMID and S2TTB and needs a temporary
   VMID.

3. Queue drain: The shutdown doesn't drain the CMDQ before disabling it,
   as the final invalidations are synced, there are no other submitters
   left at shutdown and the incoming kernel invalidates everything again.
   However, the CMDQV VCMDQs assigned to guests may need to be quiesced,
   which is future work along with the ATS and PASID support.

4. RMR SIDs: The outgoing kernel parks the unpreserved RMR streams in
   abort, and the incoming kernel skips installing the RMR bypass STEs, as
   it does for kdump, since they're written assuming a Stream Table that
   isn't live yet.

5. A failed restoration fails the SMMU probe instead of falling back to a
   full reset (which would at least keep the system usable). Also, a
   partially restored CD table isn't unwound on failure yet.

6. PASID granularity, PRI and ATS state of the preserved PCI devices are
   not handled yet (e.g. arm_smmu_enable_pasid() at probe for a device
   that still has ATS enabled).

7. The kdump [4] and invalidation [5] series both define ARM_SMMU_OPT
   bit 5; this tree moves ARM_SMMU_OPT_KDUMP_ADOPT to bit 6.

Dependencies
============
This series depends on the following series, applied in this order on
top of v7.3-rc5:
 1. iommu/arm-smmu-v3: Invalidation rework (v7), by Jason [5]
 2. iommupt: Generic IOMMU page table for SMMUv3 (v2), by Jason [6]
 3. iommu/arm-smmu-v3: kdump Stream Table adoption (v10), by Nicolin [4]
 4. dma: DMA allocation preservation (RFC v2), by Samiullah [2]
 5. vfio/pci: Live Update preservation of VFIO cdev (v5), by Vipin [8]
 6. iommu: IOMMU Live Update state preservation (v5), by Samiullah [1]

The luo_file internal APIs [10] and the PCI Live Update series [7] are
already merged in linux-next.

The VFIO series is taken as carried in [9], along with a small build
fixup for the stack.

A tree with everything applied is available at:
https://github.com/pran005/linux/tree/arm-smmu-v3-liveupdate-rfc

[1] https://lore.kernel.org/all/20260921004834.2601285-1-skhawaja@google.com/
[2] https://lore.kernel.org/all/20260708234854.4044652-1-skhawaja@google.com/
[3] https://lpc.events/event/20/contributions/2612/
[4] https://lore.kernel.org/all/cover.1788130528.git.nicolinc@nvidia.com/
[5] https://lore.kernel.org/all/0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com/
[6] https://lore.kernel.org/all/0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
[7] https://lore.kernel.org/all/20260918200640.887030-1-dmatlack@google.com/
[8] https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
[9] https://github.com/samikhawaja/linux/tree/iommu/phase1-v5
[10] https://patch.msgid.link/20260723202912.1467112-2-skhawaja@google.com
[11] https://lore.kernel.org/all/20260925011308.3381953-1-skhawaja@google.com/

Pranjal Shrivastava (9):
  iommu/kho: Extend IOMMU KHO ABI for ARM SMMUv3
  iommu/arm-smmu-v3: Implement KHO preservation for STEs
  iommu/arm-smmu-v3: Implement CD Table preservation
  iommu/arm-smmu-v3: Implement Live Update Stream Table restoration
  iommu/arm-smmu-v3: Implement Live Update CD Table restoration
  iommu/arm-smmu-v3: Implement Live Update shutdown
  iommu/arm-smmu-v3: Retain SMMUEN across a Live Update restore
  iommu/arm-smmu-v3: Inherit the ASID/VMID of restored domains
  iommu/arm-smmu-v3: Adopt the Event queue across a Live Update

 drivers/iommu/arm/Kconfig                     |   2 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c |  44 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 997 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 119 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  56 +
 include/linux/kho/abi/iommu.h                 |  38 +
 7 files changed, 1220 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

