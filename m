Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2C370D79
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318888; cv=none; b=dzyoPTljJ10lpM2Qq/Q01Gh4B61+GhEONb8WJR654uZs8L2GkmvCX/meCC3ihHHPLYK6ADgfnZwloK2xXRFMh+4DOv3PQww5MNCstS19eT7CIkDs37UZQMHaHJaM9sVFxgS+x2HpUmjKoGUw8L0ZTuIRvYT9yMDZ20HcTra8dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318888; c=relaxed/simple;
	bh=21XZ9BXWcC5puKkNvdTtXB+wuqY9w5/tpYCQJOExbBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NOBrZqft0qO30+Z9RX9lZkCYfMoHMzA3x6h7J3GLn4FSR9EYUhwymzbR4PSHRCZW2UZkK1xK4cdhS4C4b+W4Yb1STieo5BwlV4dIi/vdPlbUJSP4zPe8QwUwkVqXR86PMqN++hZM/27aud9vABts5XkhvB8a866NpPphTuJzk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I3ub4AEZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I3ub4AEZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787318877; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=FQZVISIu+7OErW0PwVSS24Fbga2XewF6EwSwZSSnvvM=;
	b=I3ub4AEZx/F4F1VMJuJX2oJFhvXUBshXDb64ZGPWXv64OinW8dOgfg4xI0hMBHyyIUOAnspTM6Yc/DEmAISleIjLsJssBzZdNEJcKN5b5U/PbRP++V3YgkV2A2Yj1X+3brQ0y+rleixQjJFhyvdqnd09l/3O0H/wt8n8J1zsRbw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9MSFFA_1787318872;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9MSFFA_1787318872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 21:27:54 +0800
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
	vasant.hegde@amd.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Fri, 21 Aug 2026 21:27:40 +0800
Message-Id: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
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
 drivers/iommu/generic_pt/fmt/riscv.h         | 120 +++++++++-
 drivers/iommu/riscv/iommu-bits.h             |   7 +
 drivers/iommu/riscv/iommu.c                  | 224 +++++++++++++++----
 include/linux/generic_pt/common.h            |   4 +
 include/linux/generic_pt/iommu.h             |  17 +-
 7 files changed, 317 insertions(+), 59 deletions(-)

-- 
2.50.1

