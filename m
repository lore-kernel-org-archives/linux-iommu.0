Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2401A76C3
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146420; cv=none; b=DghecOHyT7Y/0maQ+emz5PHt753Jgzno7II2XNUC4Cak6j1Rer2CUWgTDv7oBXfIxDPSYhKkf9fS+bfNwID0slk688fKh9Lo6L6GmzBfFG7MwDlMybvi2a4tfEv0ZzyHDJsPLJQlzUz4GLERhBEZ4kbPr0pMOT9EthJz9YRWGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146420; c=relaxed/simple;
	bh=BudDgrzpUi9w3UHcUcy5uREfcPNidqfvUxKeTlW+hzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9K4T5p4gGvMWMRE4jlvVUc+55OtkbpWyakyTAFqDCWif6MhHyLojUXhvcrKwsr83TpyxNZwL7pvTKobpIC07IKqwcfDBIiHDlsOlKkPB1ALJYZhj96Ix4LRxRKHwUt1U6l9kOwIRL9A3FHgvy5ArtC1c/sNNDwEKmGeGLbnDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGvCM84t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGvCM84t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146419; x=1757682419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BudDgrzpUi9w3UHcUcy5uREfcPNidqfvUxKeTlW+hzw=;
  b=dGvCM84tfUlDLUJFpuhGEthSw8JtFugUQeXckbBDl/E0/pQAgqBB80gf
   7hgKmVYJ33Y8wqXVH/q/VkrGzzM1AVslzLoDOq3FXfKwq34XfuuhVGzcV
   Dg6Bpo7ABvNrKgaCVP8/m0zuNBzZz9A+X75nCpDaR+EPVypVTbNEy7rHT
   hQp+kp0yt6LmAgOAUm5UioSZVFYK+Jt7v3X1rIJ2VtRVY+ACFwG18DZ7M
   lD48N04ZOsMroXBcjB2DZC7dYloVMKg9LigpDEf9oZI1fB7bYIjz4L8CF
   VR+qItlkMafhR68lyQNBLWbmNi33wq3LKJbPR5Qb7AvcjXR8eiVS1gD4m
   Q==;
X-CSE-ConnectionGUID: XfSWGxsWRt2Pn6+HRrBahw==
X-CSE-MsgGUID: w1lm1+F6Q5eDcvAd//7Ifw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35585703"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35585703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:06:58 -0700
X-CSE-ConnectionGUID: +qFEQsy/Q62xL0ZzVpQLrQ==
X-CSE-MsgGUID: iACBXHYfRfiRuUVQ2bXtJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68211628"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2024 06:06:58 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH 3/3] iommu: Add a wrapper for remove_dev_pasid
Date: Thu, 12 Sep 2024 06:06:53 -0700
Message-Id: <20240912130653.11028-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130653.11028-1-yi.l.liu@intel.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers are on the way to drop the remove_dev_pasid op by
extending the blocked_domain to support PASID. However, this cannot be
done in one shot. So far, the Intel iommu and the ARM SMMUv3 driver have
supported it, while the AMD iommu driver has not yet. During this
transition, the IOMMU core needs to support both ways to destroy the
attachment of device/PASID and domain.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f3f81c04b8fb..b6b44b184004 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3324,6 +3324,28 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+/*
+ * This is only needed in the transition of dropping remove_dev_pasid op
+ * by adding set_dev_pasid op for the blocked domains.
+ */
+static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *blocked_domain = ops->blocked_domain;
+	int ret = 1;
+
+	if (blocked_domain->ops->set_dev_pasid) {
+		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
+							 dev, pasid, domain);
+	} else if (ops->remove_dev_pasid) {
+		ops->remove_dev_pasid(dev, pasid, domain);
+		ret = 0;
+	}
+
+	WARN_ON(ret);
+}
+
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
@@ -3342,11 +3364,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 err_revert:
 	last_gdev = device;
 	for_each_group_device(group, device) {
-		const struct iommu_ops *ops = dev_iommu_ops(device->dev);
-
 		if (device == last_gdev)
 			break;
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3356,11 +3376,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 				       struct iommu_domain *domain)
 {
 	struct group_device *device;
-	const struct iommu_ops *ops;
 
 	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 }
 
-- 
2.34.1

