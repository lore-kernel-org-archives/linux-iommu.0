Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96113AA35
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010003; cv=none; b=Q7DarH8E1gsMfMIO9iQmKCNOCxLiSEXQMNqTkHJmCr0AoTvfidmY/xgjtVdVkBayHx3kj9EjL1umGcOwrZYpmkVHgCabCyDdg4YHd4kWeCquNnH1RZus1IW4zEKhJ6+fe5VPY+p39rhnWq52855gTxab/sUHGfe/26lniiywscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010003; c=relaxed/simple;
	bh=wZSuoOsJ9R3MpkLrN5YRfrHjzrkwvK0M+Y3osdd4hrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvkSA0GCtRv2Ij8hGE716WIS+Xxx8vvX4gI8gMcz+xwAtKX/SsKjv7vSLDcbe98fnBHXni0RuOCH5gvVee2vUXkpnZ8KlZ/B8n0pu6a3/a9s0BL6XvL88uIB49Sv8+5aKLM0CkcNsl0SIGc2TWJCzdR0LfRGNRU0edHtqq4spqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6Ykq3eH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6Ykq3eH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718010001; x=1749546001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZSuoOsJ9R3MpkLrN5YRfrHjzrkwvK0M+Y3osdd4hrI=;
  b=j6Ykq3eHqWLfRFXMh1h0NdwpHI8EdOGnpwCMzm84bNFJmFGaIHH3KKoe
   /DXGEmwn6Wig8ke0GYAx1tfdW9xZBOZJ5sPFyNm+vRW7ZyIcNBNhI/qoZ
   nWvmk+CcUb0DT1peLDziwtI6WaTDUEJax9Gerl/yOuY2wOqR9tjaXekmX
   K+jB2c9TYQnyGkBr8u3CGWBIRpY+ixC4zMoHvKOZHq49boVzx/znjcOSt
   MZFIEhknWtVoIxh5pue/U5YzW0YiTI5juum1YheQFUa6q8BwIR4+iZwNu
   Db3M3/yHNReu13rTQI50F+VzMkuEpbPFedDAkVAgZicnifOADoR0ZLyf8
   A==;
X-CSE-ConnectionGUID: 9/86607fSKyfw/r1E2J5VQ==
X-CSE-MsgGUID: xCnlbPbLQzuSitjDCVV0pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17582005"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17582005"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:00:01 -0700
X-CSE-ConnectionGUID: UkJOBireQRy0iFWBh3TABg==
X-CSE-MsgGUID: GPssOU7ITwWVQqYExEAGUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43433176"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 20/21] iommu: Remove iommu_present()
Date: Mon, 10 Jun 2024 16:55:54 +0800
Message-Id: <20240610085555.88197-21-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_present() interface is no longer used in the tree anymore.
Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ------
 drivers/iommu/iommu.c | 25 -------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46f1348f1f0a..ba0b27afc256 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -776,7 +776,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 }
 
 extern int bus_iommu_probe(const struct bus_type *bus);
-extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
@@ -1072,11 +1071,6 @@ struct iommu_iotlb_gather {};
 struct iommu_dirty_bitmap {};
 struct iommu_dirty_ops {};
 
-static inline bool iommu_present(const struct bus_type *bus)
-{
-	return false;
-}
-
 static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return false;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e03c71a34347..c7ebdf96e4bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1846,31 +1846,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
-/**
- * iommu_present() - make platform-specific assumptions about an IOMMU
- * @bus: bus to check
- *
- * Do not use this function. You want device_iommu_mapped() instead.
- *
- * Return: true if some IOMMU is present and aware of devices on the given bus;
- * in general it may not be the only IOMMU, and it may not have anything to do
- * with whatever device you are ultimately interested in.
- */
-bool iommu_present(const struct bus_type *bus)
-{
-	bool ret = false;
-
-	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
-		if (iommu_buses[i] == bus) {
-			spin_lock(&iommu_device_lock);
-			ret = !list_empty(&iommu_device_list);
-			spin_unlock(&iommu_device_lock);
-		}
-	}
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_present);
-
 /**
  * device_iommu_capable() - check for a general IOMMU capability
  * @dev: device to which the capability would be relevant, if available
-- 
2.34.1

