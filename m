Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625294657E5
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382075; cv=none; b=Mt/J3VjOTBfW/GmlTtP42ED5EU4Ls5BCJzFtaJEEe7PYJ/+jkPs9ZtRSdb0wRbr9OAd07W/UagxLuw+2IQH4J/rgkKIsbtjYRimuKKodRUf3Ww+d4NOkdyuI9V4kqSrsDr0wNxxM5ewL0zgNBS33g5zV4saCy3tnhHaLLKoHfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382075; c=relaxed/simple;
	bh=diDOzbpb0IUj8BkUuWGihkuhgsYOZsvMM26freJyXy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D4NohvMpy9+mzuu701A0gPK0uT1qigyvXqCuPwZ6P5DfHVICnuX2ekUlvhCDTyaYBg00ts2vyiBg8xf2r5huE4wmYyZ+bjy93Gh9HJ6HAWNCy1Sdb37q4gNGqVAT0RUh2BkeqXA1W63MMb0DRDHQAwQ0JCp0WN8uXHAUhh8skhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QySNcVVR; arc=none smtp.client-ip=47.90.199.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QySNcVVR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777382054; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=2eUnDZEfxgG5YZ/aUJ43Dh+182ud/Kd1EhVPQjTWqdA=;
	b=QySNcVVR+82dvR47NFjyB+wYRdu0qZSTQFsIPrzcIdam3z4uhlbK+jLvIYuvF2rktZCFk2tH5PGOC1AYQSdZDeb6/YUXrKj/Kk0AJpXQMilt2E/jB7WIs/AdAM8hIHaHJ9hShBXvlbpBlBW5In2WVKW9bcOrmWMThHzUrrTtC8g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1ubICp_1777382049;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1ubICp_1777382049 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 21:14:12 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 00/11] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Tue, 28 Apr 2026 21:13:48 +0800
Message-Id: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
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

* Test on QEMU RISC-V, a virtio-net and an e1000e device was passed through
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


Fangyu Yu (6):
  iommupt: Add RISC-V Second-stage (iohgatp) page table support
  iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
  iommupt: Don't preset D when RISC-V IOMMU dirty tracking on
  iommu/riscv: Add dirty tracking support for second-stage domains
  iommu/riscv: Add IOTINVAL.GVMA after updating DDT/PDT entries
  iommupt: Add RISC-V dirty tracking PTE ops

Tomasz Jeznach (2):
  iommu/riscv: report iommu capabilities
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch

Zong Li (3):
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: support GSCID and GVMA invalidation command
  iommu/riscv: support nested iommu for getting iommu hardware
    information

 arch/riscv/kvm/Kconfig               |   2 +
 drivers/iommu/generic_pt/fmt/riscv.h | 120 ++++++++++++-
 drivers/iommu/riscv/iommu-bits.h     |   7 +
 drivers/iommu/riscv/iommu.c          | 247 +++++++++++++++++++++++----
 include/linux/generic_pt/common.h    |  13 ++
 include/linux/generic_pt/iommu.h     |  17 +-
 include/uapi/linux/iommufd.h         |  18 ++
 7 files changed, 383 insertions(+), 41 deletions(-)

-- 
2.50.1

