Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528433B97F;
	Mon, 27 Apr 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270224; cv=none; b=PpM6Woqhhe1d82H3FbRdyVFlFvUQUNAbxbIVKvANBliuhzH7SoQGxpyH9pIyi0TVerJErWNzxL4cXG7pIcU84JOB/IR/lGgfrtNK+VnzidVaE4VfL2VS2I73Llw1l3xDLJrL2SgohKruf5xSNhHzpEIKTlkifFso8NGlvq/kl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270224; c=relaxed/simple;
	bh=FXNseaUyPlkvsiojsWtx3KsUI8A3dSz/hWt+/LNARW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8CSdPFZL/NK/J6nW6NCR+1VNvFqVYSOHqtvgKGS2ZYsTA1iHpf0rqa3PhVfZtir731lTtSSNE6kMrIZn9W0NTRP3A/CDbUmguyxN/pL4lAyq+aFLl/N8KQLVKKfvFNBidFyLrnmz093c35khTkC2OHvh8c5Ek5iTQqFTqCkcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np/fJ/Ld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np/fJ/Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA62C19425;
	Mon, 27 Apr 2026 06:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270224;
	bh=FXNseaUyPlkvsiojsWtx3KsUI8A3dSz/hWt+/LNARW4=;
	h=From:To:Cc:Subject:Date:From;
	b=Np/fJ/Ld8KknmcuTyDZSt4YryM3X+4gbXd53P72vx5f445xArwgyHL4dp23zKRvnh
	 0Ss+eoQknDzxVnEHgj+n1BGXQDExt1l8vGFVYGzPE+Fxx5xrSt7pOLUQyDfNkohLL8
	 F7/3fUf2j+bSPgTfmqyp9liLHfRiDmFnBjLnvS3TVlC9GGugJqC8nqoalw2CCD21eC
	 tKD/73pJ9i/sssx9iWPd6D2Golfv39hpljJnjt2jXLEvCkkj4QPyvrDy5x6kz8MbUj
	 xyNZznOSubPKcoyk7UGIhCASRyE2I2a1LQoddp/gtKYzpDKD3NTO/rzdEajl9puGme
	 aJ7jTpw/nO+dA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4 0/4] Add iommufd ioctls to support TSM operations
Date: Mon, 27 Apr 2026 11:40:01 +0530
Message-ID: <20260427061005.901854-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds iommufd ioctl support for TSM-related operations.
These ioctls allow VMMs to perform TSM management tasks such as bind and
unbind operations, and to handle guest requests.

Changes from v2:
https://lore.kernel.org/all/20260309111704.2330479-1-aneesh.kumar@kernel.org
* Bump the series revision to v4 to keep it in sync with the dependent CCA DA
  patchsets. There was no v3 posting.
* Drop [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd with a
  vIOMMU
* Add two new patches to associate a struct kvm * with iommufd objects:
  iommufd/device: Associate a kvm pointer to iommufd_device
  iommufd/viommu: Associate a kvm pointer to iommufd_viommu
* Address review feedback

Changes from v1:
https://lore.kernel.org/all/20250728135216.48084-8-aneesh.kumar@kernel.org
* Rebase onto the latest kernel
* Address review feedback
* Drop the TSM map ioctl; the KVM prefault patch will be used instead to
  ensure that private memory is preallocated

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Aneesh Kumar K.V (Arm) (2):
  iommufd/tsm: add vdevice TSM bind/unbind ioctl
  iommufd/vdevice: add TSM guest request ioctl

Nicolin Chen (1):
  iommufd/viommu: Associate a kvm pointer to iommufd_viommu

Shameer Kolothum (1):
  iommufd/device: Associate a kvm pointer to iommufd_device

 drivers/iommu/iommufd/Makefile          |   2 +
 drivers/iommu/iommufd/device.c          |   5 +-
 drivers/iommu/iommufd/iommufd_private.h |  17 ++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/selftest.c        |   2 +-
 drivers/iommu/iommufd/tsm.c             | 109 ++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  24 +++++-
 drivers/vfio/iommufd.c                  |   2 +-
 drivers/virt/coco/tsm-core.c            |  30 +++++++
 include/linux/iommu.h                   |   1 +
 include/linux/iommufd.h                 |   5 +-
 include/linux/tsm.h                     |  42 +++++++++
 include/uapi/linux/iommufd.h            |  67 +++++++++++++++
 13 files changed, 305 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/iommufd/tsm.c

-- 
2.43.0

