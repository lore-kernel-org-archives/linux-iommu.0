Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5801A5B9E
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987192; cv=none; b=ICFLOPko67yCWNZzL0C4Ha5jbQuzljqwmCXZ+orWDGsbX2M8r/MyVAGBp4nbc0QjUtky49P9AGt6488Xg6ZsPJfrEcI9+7etXsY+tbsaf/ekXmMk/uBX4JoVdBACf9Xv5vSzDTBNUEVKJJPpdPd12eIutzWoo/V7YqG66Dxknf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987192; c=relaxed/simple;
	bh=UkhjINtAq6pVvDlyfn99Lk1sC5bm0tv9oHYzkNv9AMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkg1rOEEBHOZ6CJ6G5KHJ5ISe4lmqqB3LVgtlBCb+iFa27gkOFbNg4hZR1vueGrnS149Pd89s+WKvkZihsuGSm/LSAzyuJb1RezjQNdgraawrewTB0zFpL3WKFzpgvlwPVGW/gg5dzpsf7d3nQ09BvxrKb7aFTbBPCFHDDeIsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a4C2S6rl; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a4C2S6rl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789987179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5ZcZPnDGodXH/T9B5tDU4vKRkCmpolgJS5NkZsXR4g0=;
	b=a4C2S6rl7h3Gbe1sMKRxj/BISdolrBcTVo5Xuxcl3rqW6y71tqI7ZGJ4fjYJzW9tUxee4bQi+QLCX7k6wIBGHCDFcbm4e+KH2kQ7e3IQHRglXLSoo6wnJcllFDd9wRYdagd09E3r88Cle/cMO0g7ldOfNyB3bBlt6x7RxspKf2w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBMvKgm_1789987178;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XBMvKgm_1789987178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 18:39:38 +0800
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
Subject: [PATCH v2 2/2] iommufd: Reserve PCI host bridge MMIO windows in IOAS reserved regions
Date: Mon, 21 Sep 2026 18:39:22 +0800
Message-ID: <20260921103922.1113752-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd builds the reserved IOVA ranges of an IOAS in
iopt_table_enforce_dev_resv_regions() by calling the per-device
iommu_get_resv_regions(), which only returns IOMMU driver-level
reserved regions (RMRR, unity maps, MSI windows, etc.) and does
not include PCI host bridge MMIO windows.  As a result, the ranges
reported to userspace by IOMMU_IOAS_IOVA_RANGES may overlap with a
host bridge's MMIO windows, allowing userspace to map IOVAs that a
PCIe switch might misinterpret as peer-to-peer DMA and misroute to
the wrong device.

VFIO type1 avoids this because it collects reserved regions through
iommu_get_group_resv_regions(), which already reserves PCI host
bridge MMIO windows.

Switch iommufd to iommu_get_group_resv_regions() as well so that
the IOAS reserved set includes PCI host bridge MMIO windows and
IOMMU_IOAS_IOVA_RANGES no longer hands out IOVAs overlapping them,
aligning iommufd behaviour with VFIO type1.  The per-device @dev is
kept as the reservation owner so that per-device detach cleanup via
__iopt_remove_reserved_iova() continues to work unchanged.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6..7198deba378e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1582,6 +1582,7 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					phys_addr_t *sw_msi_start)
 {
 	struct iommu_resv_region *resv;
+	struct iommu_group *group;
 	LIST_HEAD(resv_regions);
 	unsigned int num_hw_msi = 0;
 	unsigned int num_sw_msi = 0;
@@ -1591,8 +1592,16 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 		return -EINVAL;
 
 	down_write(&iopt->iova_rwsem);
-	/* FIXME: drivers allocate memory but there is no failure propagated */
-	iommu_get_resv_regions(dev, &resv_regions);
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		rc = -ENODEV;
+		goto out_unlock;
+	}
+
+	rc = iommu_get_group_resv_regions(group, &resv_regions);
+	if (rc)
+		goto out_free_resv;
 
 	list_for_each_entry(resv, &resv_regions, list) {
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
@@ -1624,6 +1633,8 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	__iopt_remove_reserved_iova(iopt, dev);
 out_free_resv:
 	iommu_put_resv_regions(dev, &resv_regions);
+	iommu_group_put(group);
+out_unlock:
 	up_write(&iopt->iova_rwsem);
 	return rc;
 }
-- 
2.43.7

