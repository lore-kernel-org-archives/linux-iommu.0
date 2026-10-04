Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFA39B947
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131282; cv=none; b=TOHu2gw2Hj8K4k1IftnaKJQ/2R1TOP8aQWmSfhlmyHohKzJCUA9/4KqU+LjawyNP4AqzB+3Fjt/I4iAl8yd9jj7bnHgIb6ZSz2Qwr33CuvHAqTrv5ac4YNj4pppuwEugZwuRrxynhwMIoL8uoW38la+puz0s2pAY5FsruiR933o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131282; c=relaxed/simple;
	bh=w9r81eCoveL47+gCXyxD7BCzW5wFdS99rIgSVsnMRZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj+dGoJXqUt9Io4EyK9tbJ7fykO2/muEE26MFbVclVP/IJIYeL2tm8rmXZhUJQW/t8ce6RDbuHIVZ14AgyLgxKhJdXrJfMo+PNfaKgVWklp8VW6HDwv30xo0NVtbOyN1Dz/yV+QcM1+NJCik81Z+ijx/cNWaP4J7JJ0WkPU3w2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BGuBn5gN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BGuBn5gN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791131277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rdb9mwYU+CLQG44ZORqhDvuNBy6pepzRB8jbksXuEJI=;
	b=BGuBn5gNp4fqFvpcGwx3OPvtfhMQQj9DlFSvuNEbBPtdMT+gfMLx2Zo5WPB0JFnIBL/8OMJqJblWofJ2pqGLU6f1DsqjVbc94p7kqGY8kFdCM9WuM6INCHCfulwt2s8785haKbVdX+VObxOPUVUyGyKIV/6bDiIzZcrIAs7AGJM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XC2de7O_1791130933;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XC2de7O_1791130933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 05 Oct 2026 00:22:37 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v3 0/2] iommu/iommufd: Expose PCI host bridge MMIO windows for opt-in IOVA avoidance
Date: Mon,  5 Oct 2026 00:22:11 +0800
Message-ID: <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260921115513.GK11599@ziepe.ca>
References: <20260921115513.GK11599@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device sits behind a PCIe switch and ACS Upstream Forwarding is
not fully enabled, DMA TLPs whose IOVA happens to fall within a host
bridge MMIO window may be routed peer-to-peer to another downstream
device instead of upstream to the root complex for IOMMU translation.
This can lead to faults, data corruption, or silent misrouting.

The DMA IOVA layer already avoids this via iova_reserve_pci_windows().
However, passthrough paths that let userspace pick IOVAs (VFIO type1,
iommufd) had no mechanism to learn about these ranges.  Commit
cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into
dma specific path.") intentionally keeps this information out of the
IOMMU reserved-region API to avoid pessimistically restricting
userspace.

Following Jason Gunthorpe's suggestion [1], this series takes an opt-in
approach: the kernel reports the information, userspace decides whether
to avoid it.

  Patch 1 adds iommu_get_pci_resv_windows(), a shared helper that
  enumerates a device's host bridge MMIO windows as sorted, merged
  IOMMU_RESV_RESERVED regions.

  Patch 2 adds the IOMMU_GET_PCI_MMIO_WINDOWS ioctl to iommufd, a
  per-device query that returns these windows to userspace without
  reserving or enforcing them.

[1] https://lore.kernel.org/all/20260921115513.GK11599@ziepe.ca/

v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v2:
- Complete redesign per Robin Murphy's and Jason Gunthorpe's review.
  v2 forced PCI window reservation through iommu_get_group_resv_regions()
  which was explicitly rejected (this was tried before and reverted by
  cd2c9fcf5c66).  v3 instead provides an opt-in query interface.
- Patch 1: add iommu_get_pci_resv_windows() as a standalone helper.
  No longer touches dma-iommu.c (the existing direct enumeration in
  iova_reserve_pci_windows() is simpler and allocation-free; refactoring
  it to use the helper would add unnecessary overhead for no functional
  benefit).
- Patch 2: new IOMMU_GET_PCI_MMIO_WINDOWS ioctl replaces the v2
  iommufd enforce-path change.  Reports windows to userspace without
  reserving them.
- io_pagetable.c and dma-iommu.c are unchanged from base.

Changes since v1:
- (Superseded by v2->v3 changes above.)

Guanghui Feng (2):
  iommu: Add iommu_get_pci_resv_windows() helper
  iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl

 drivers/iommu/iommu-priv.h              | 12 +++++
 drivers/iommu/iommu.c                   | 57 ++++++++++++++++++++++
 drivers/iommu/iommufd/device.c          | 64 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 55 +++++++++++++++++++++
 6 files changed, 192 insertions(+)

-- 
2.43.7

