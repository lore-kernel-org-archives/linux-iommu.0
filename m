Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D030E0EE
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442924; cv=none; b=pFwmc5vuiIGeLx2VzYke8AgVc4NZvnIK0TdAq7gRwtRWVnKB26fwEBIj30kyBlDO75VweLjUdpT8FfnF/R3jJvPD7X1H36S+f64BbI9t804aZuDQzMt123CySt1qFcJEFfQ+TXkJgs6s3XfGty2AWp6+3yuSrtyG2tyiYEMI/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442924; c=relaxed/simple;
	bh=aX+gHik0/HF4QyGg5XxxddTBSHHt/SiD3jXKyO2buzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iCLyTjeRwJIdsLvJyDDHZN7GCuQujQ+9Tl9goKM3b5EOAcd9h/qS+yMJDeKfmwe0S6nx2CXP3LEHgBYqcltAKxlhSa/HwSfKqosllpywmm0+ShNN6/0VBsgzrQVmFdDr7VyZHCb0Bt09nphXzLIw/za7+CqweBqUadGIatsDMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uBqucqUf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uBqucqUf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789442914; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=KEnYjPH9sIY7wU+k5WAIIK2/axmvXp5XB0Al/sd5JkQ=;
	b=uBqucqUfoCZ9+to+1cYA9D0lTooPD4TCqg3QaU4xiom5sgdQDWgj4KGYxj8L2b+gdbtnRPHR8DK6UE1zLsc7+ABRKwnOqD4SI+GNeH4gxFe6fTg8MAjaWJCB9Qc1k/8R4mWR+EGs9rnoRpV01MCtxVsPCWwmD7e2xqnJifExURg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0XB.uvMv_1789442910;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XB.uvMv_1789442910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 11:28:32 +0800
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
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v4 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Tue, 15 Sep 2026 11:28:19 +0800
Message-Id: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
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

---
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
  iommu/riscv: Add IOTINVAL.GVMA after updating DDT/PDT entries

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
 drivers/iommu/riscv/iommu.c                  | 224 +++++++++++++++----
 include/linux/generic_pt/common.h            |   4 +
 include/linux/generic_pt/iommu.h             |  11 +
 7 files changed, 336 insertions(+), 72 deletions(-)

-- 
2.50.1

