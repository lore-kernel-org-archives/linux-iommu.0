Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA035435514
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987192; cv=none; b=V05/j4vqrFisXrL2ZSe3aeg5bSDkPWSgkv0A6QiyANBuMEyxRs9MPJqZinbi7xcsmg8ZBIlCfdr4nxtWxAK01VGzGNTg7MG79H+0S2+jakYqS6mhEPpSr5dAAbYbT7vhWXE88HrHUFTvcr51EfL8upP/ZMNBSAM1dI+sSMEON0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987192; c=relaxed/simple;
	bh=cQKe33CkmGv2kL9EoHanYMLGJBVwaWAB6423BuYQQ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUnZrFaGF1lbR9JWJW0/L7MXchL6th5UD6CogfhIXmuqCKHGUT9M6ywcsSPc6sWsLKqKprjTOfcJki62Df1BX1li1j/b7M7EAbTNvvE7+TUEs1YkzsIP20Av4YQO8Vjvv0KJRiIsfEkMBCjY+a+9Lf47VwZezSBDgFuc8gujoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LcvMQhNf; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LcvMQhNf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789987178; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mzlY+7WKmWC1qIp/3zzQwEE6yf9TuN03YHdJStM2WvA=;
	b=LcvMQhNf3BeAOCwuRy3PNQfRWTE9wVEZ+S4ayOdSR/OVqH68u+1PL07yPlQ4vUAr8n4V8NQNjVYBma0HWtHAad3ZPHoHUKYysCp9JaoywtxI02GoBlv0bG6TxysQAVCxPYG14xtBlpw/n49xPwS21fdfeIEKoQ6/ogwuCJO2d6o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBMvKat_1789987163;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XBMvKat_1789987163 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 18:39:37 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	alex@shazbot.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iommu: Reserve PCI host bridge MMIO windows for IOVA
Date: Mon, 21 Sep 2026 18:39:20 +0800
Message-ID: <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA IOVA layer reserves PCI host bridge MMIO windows via
iova_reserve_pci_windows() to keep IOVA allocations from overlapping
those address ranges.  As commit fade1ec055dc ("iommu/dma: Avoid PCI
host bridge windows") explains, a host bridge may interpret addresses
falling within its MMIO windows as peer-to-peer DMA, leading to
faults, data corruption, or DMA transactions being misrouted to the
wrong PCIe device.  This is especially dangerous when a device sits
behind a PCIe switch and ACS Upstream Forwarding is not fully enabled.

Passthrough paths that let userspace pick IOVAs did not honour these
windows: VFIO type1 and iommufd only excluded IOMMU driver-level
reserved regions (RMRR, unity maps, MSI), not PCI host bridge MMIO
windows.

This series closes that gap:

  Patch 1 adds a common helper, iommu_get_pci_resv_windows(), and
  reserves PCI host bridge MMIO windows in
  iommu_get_group_resv_regions() so all group-level consumers (VFIO
  type1, sysfs reserved_regions) avoid them; iova_reserve_pci_windows()
  is refactored to reuse the helper.

  Patch 2 switches iommufd's iopt_table_enforce_dev_resv_regions() to
  iommu_get_group_resv_regions() so IOMMU_IOAS_IOVA_RANGES also avoids
  PCI host bridge MMIO windows, aligning iommufd with VFIO type1.

v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v1:
- v1 was a single patch; v2 is a two-patch series.
- Patch 1: build the reservations with iommu_insert_resv_region()
  instead of list_add_tail(), so the group reserved list stays sorted
  by start address and overlapping same-type regions are merged.  The
  helper now frees its partial list itself on error and leaves the
  caller's list untouched.
- Patch 2 (new): reserve PCI host bridge MMIO windows for the iommufd
  IOAS as well, so IOMMU_IOAS_IOVA_RANGES no longer reports IOVAs that
  overlap PCI MMIO windows.

Notes on earlier automated review feedback:
- The size_t length of each window matches struct iommu_resv_region's
  existing field type; no new truncation is introduced on 64-bit.
- An IOMMU group cannot span multiple PCI host bridges:
  pci_device_group() only groups devices within a single host bridge
  hierarchy, so scanning the first PCI device of the group is enough.

Guanghui Feng (2):
  iommu: Reserve PCI host bridge MMIO windows in group reserved regions
  iommufd: Reserve PCI host bridge MMIO windows in IOAS reserved regions

 drivers/iommu/dma-iommu.c            | 17 ++++--
 drivers/iommu/iommu-priv.h           | 11 ++++
 drivers/iommu/iommu.c                | 85 ++++++++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c | 15 ++++-
 4 files changed, 121 insertions(+), 7 deletions(-)

-- 
2.43.7

