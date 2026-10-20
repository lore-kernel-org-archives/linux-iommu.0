Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489280;
	b=bynJD4yzKaEqakllgR07OYPZTw3Ye3fUftIUUs/ZQ4a/5ytWhRphZrUsAAPLqlrWb+8d
	 hYTmRSC/wbXrshOss1GBHHxPmFeQ5mXo4/5K38aD++3KSdfi4zQvT65c0B8nbrLmuZFg/
	 uXWNlSKN4OmX9tNJEzLWF+iEo/cTOR6euePTRY3wOE8paO+iPRBHSMDVAX/OZR6BFdsvn
	 viriY8bJ6T5anDbzLhTOkCa52ljmQl9rFzco8zYOrOvjGDfYgo6nFhAK4Wml3a1VAake2
	 dFA9IOiJAlxmwmv8lU1FXcQQHDe+X2Rx5lqk8NZ2bYY6mJFyZASAk1aLuofUuKVYt9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489280;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kcaNBbiUMzKXzNSISjdYUCG67KZVrDK5XLEKTAvzTD8=;
	b=Im6UJiQ8G+F+ZATX6ZJIIJZTSgK6/Cepbz0svuaJHmCUXWUguyc6x59hpmSvGeY4G+8g
	 nES3wDgiaMJ+dyQn+qOaHat68dXzxq4NmPs4rnzbIBJVaCkhR1Rh8cpbhh4yvnWPGLr8D
	 o31Uar2i0PXAEzpnz/iDawKS/lE7TvMbxQHyrak2Ii7vHj67Ym28rvj21K7vJYsnR9fTo
	 zuQDYArsI5G9Ulc3Pwv5mIzGWdpEPk5Vn+RjILRsmocWF2VJFY+fe8QcPV+an2Z+aG/by
	 mLbi4EWbaYY5rgHhpjfMhUQuHL3eUcjQK/OTCZs8V4k97p5Dp1zno8uEnt8PieMJBsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oOrn0Mel;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDD606A31C
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oOrn0Mel
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792489275; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=kcaNBbiUMzKXzNSISjdYUCG67KZVrDK5XLEKTAvzTD8=;
	b=oOrn0MellT+LylF9SfCLBr2TKQo1lm3UOX+pEOgSkAxLn3LLfG7oMi2Dtml2H987gSw8ERputZM1elyz3UW+/A9lM7/6dTq/1bi13sqZNymQ4W035xk33PRnhHqZ0lHy4sf/rEFIJb0DixQmNEPWeS4wdmDvUH0FbrhF9VTr+Ss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDCspNU_1792489269;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDCspNU_1792489269 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:41:12 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v5 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Tue, 20 Oct 2026 17:40:56 +0800
Message-Id: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
autonomously sets D on the first write to a page mapped by an iohgatp
domain.  This series wires that capability up to the iommufd dirty-tracking
interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
reports IOMMU_CAP_DIRTY_TRACKING.

Design notes
------------

* The feature is scoped to second-stage (iohgatp) domains only; these are
  the domains created for KVM / VFIO device pass-through when userspace
  allocates an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT or
  IOMMU_HWPT_ALLOC_DIRTY_TRACKING.  First-stage (iosatp) domains are not
  touched by this series.

* The page-table side plugs into the existing generic_pt dirty hook
  framework (amdv1 / vtdss style).  RISC-V adds the three required PTE
  ops – is_write_dirty / make_write_clean / make_write_dirty.

Testing
-------

* Test on QEMU RISC-V, a nvme and an e1000e device was passed through
  to an L2 guest via vfio-pci + iommufd.

* generic_pt KUnit: the existing test_dirty case now runs and passes for
  the RISC-V 64-bit format.

Follow-up work
--------------
* Build a dedicated end-to-end test case that drives the full flow
  (HWPT_ALLOC with DIRTY_TRACKING -> attach -> IOAS_MAP -> generate real
  DMA -> SET_DIRTY_TRACKING -> GET_DIRTY_BITMAP -> verify bitmap against
  expected IOVA footprint) so that the behaviour can be regression-tested
  beyond the KUnit PTE-level coverage.

* If possible, rebase and retest on top of the updated "iommu irqbypass"
  patchset.

LLM-based coding assistants were used for code exploration, patch
review, test execution, and drafting/editing messages and this cover
letter. I reviewed and finalized all resulting code and text.

---
Changes in v5:
    - Propagate the GADE bit from the new device context into the hardware
      DC in riscv_iommu_iodir_update(), so the pre-enabled GADE actually
      reaches the hardware. (Per Gong Shuai)
    - Issue a global IOTINVAL.GVMA in riscv_iommu_iodir_set_mode(), so that
      second-stage translations cached before a DDTP mode change (e.g. by
      a previous kernel after kexec) are flushed as the specification
      requires. (Per Tan Chi)
    - Rebased on top of v7.3, with [1] and [2] applied.
    - Link to v4:
      https://lore.kernel.org/linux-riscv/20260915032828.11250-1-fangyu.yu@linux.alibaba.com/
Changes in v4 (Jason's suggestions):
    - Rebased the series on top of [1] and [2].
    - Drop the RISC-V-specific pt_num_items_lg2() top-level special case.
    - Validate page-table address widths by translation stage: accept only
      Sv39/Sv48/Sv57 widths for first-stage tables and only Sv39x4/Sv48x4/
      Sv57x4 widths for second-stage tables.
    - Replace the aliased first-stage/second-stage MODE union with
      independent FSC/IOSATP and IOHGATP MODE fields.
    - Add pt_dirty_supported() to restrict RISC-V generic_pt dirty tracking
      to second-stage tables.
    - Link to v3:
      https://lore.kernel.org/linux-riscv/20260821132749.82070-1-fangyu.yu@linux.alibaba.com/
Changes in v3 (Andrew Jones's suggestions):
    - Rebased the series on top of Andrew Jones' generic_pt RISC-V supported
      feature mask fix, which adds PT_FEAT_RISCV_SVPBMT to the supported feature
      set.
    - Added PT_FEAT_RISCV_S2 to the RISC-V generic_pt supported feature mask and
      KUnit feature matrix.
    - Kept PT_FEAT_SIGN_EXTEND only for first-stage RISC-V KUnit configs; second
      stage configs now use PT_FEAT_RISCV_S2 without sign-extension semantics.
    - Split RISC-V IOMMU capability checks into first-stage FSC and second-stage
      IOHGATP helpers.
    - Updated second-stage paging domain setup to use GPA widths 41/50/59 and to
      avoid PT_FEAT_SIGN_EXTEND.
    - Link to v2:
      https://lore.kernel.org/linux-riscv/20260507113706.11400-1-fangyu.yu@linux.alibaba.com/
Changes in v2 (Jason's suggestions):
    - Introduced a single PT_FEAT_RISCV_S2: second-stage selection is driven
      purely by this feature bit.
    - Switched from dynamic DC.tc.GADE toggling to static pre-enable.
    - domain_alloc_paging_flags: follow the switch/case design from other
      drivers.
    - Drop IOMMU_CAP_DEFERRED_FLUSH in riscv_iommu_capable.
    - Remove the .hw_info-related patch.
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260428131359.34872-1-fangyu.yu@linux.alibaba.com/

[1] https://lore.kernel.org/linux-iommu/1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/

Fangyu Yu (6):
  iommupt: Add RISC-V Second-stage (iohgatp) page table support
  iommupt: Add RISC-V dirty tracking PTE ops
  iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
  iommu/riscv: Pre-enable GADE for second-stage domains
  iommu/riscv: Add dirty tracking support for second-stage domains
  iommu/riscv: Add IOTINVAL.GVMA invalidations

Tomasz Jeznach (2):
  iommu/riscv: report iommu capabilities
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch

Zong Li (2):
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: support GSCID and GVMA invalidation command

 arch/riscv/kvm/Kconfig                       |   2 +
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c |   2 +-
 drivers/iommu/generic_pt/fmt/riscv.h         | 158 +++++++++++--
 drivers/iommu/riscv/iommu-bits.h             |   7 +
 drivers/iommu/riscv/iommu.c                  | 235 +++++++++++++++----
 include/linux/generic_pt/common.h            |   4 +
 include/linux/generic_pt/iommu.h             |   11 +
 7 files changed, 347 insertions(+), 72 deletions(-)

-- 
2.50.1

