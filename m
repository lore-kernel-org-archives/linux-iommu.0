Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037443DCDA0
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153842; cv=none; b=fs22ItU388e0S1vQsIutGv00qsCLoqqyZJuCzFPSEj2h/S0U0PhLXVPRMq6PabXx7PtvNYBqKqUloK/91u11B7M1tWSaHn9V1fmMrccwpAmspa5N9JWOGBMzYMpcS8B80e3YGLK3CgjPEuHBI/z695qnN/hQZxJpHqE0jMU2a2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153842; c=relaxed/simple;
	bh=iIi6DSq19U1rg+snr2YDWknmdZdPmbYIuqjKBUUWwUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n/4qWWeptJEDDkYAZG6OzQkrBI683ZbB3YaZxBOTsRHg12v1mPj3s4tW5rgVhyi6vci4Kk1wpsSIsXsXKUaurUFhD3Kpz2lICYXO4W2imHxsHOGUl9KdB0PWs3OzrLj5P/QOSrgOKiktPMIEKKD+QCML7IEGY8WRueviUUkMkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KXZZXWia; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KXZZXWia"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778153833; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=pYPOjk5vRxc6PyCVSBrJamgrCDH5JWFpBbo0/9xzAQk=;
	b=KXZZXWiaOQKzOewqOOWD7lY0Y9uN7GuhUrQB9zIQYcFIB1Nn2bdoEHIKW5HN+mE2YvTOZDqy7D/7MoEoV43yC1HqXS0dZ//xIS+8o5zBDGg5ofAqqjyscjT5+ymvOkMwkVTUEMndwpsC/625i9PK4QujKgzSgqT0xBMGghiSqkM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2UVEza_1778153829;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2UVEza_1778153829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 19:37:11 +0800
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
	andrew.jones@oss.qualcomm.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH v2 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Thu,  7 May 2026 19:36:56 +0800
Message-Id: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
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

---
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

 arch/riscv/kvm/Kconfig               |   2 +
 drivers/iommu/generic_pt/fmt/riscv.h | 104 ++++++++++++++-
 drivers/iommu/riscv/iommu-bits.h     |   7 +
 drivers/iommu/riscv/iommu.c          | 190 +++++++++++++++++++++------
 include/linux/generic_pt/common.h    |   5 +-
 include/linux/generic_pt/iommu.h     |  17 ++-
 6 files changed, 277 insertions(+), 48 deletions(-)

-- 
2.50.1

