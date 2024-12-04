Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807C1B87E3
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315375; cv=none; b=nEmi5mdrNWUk+3TJ6jXWaHeVlq+A5BeKp7w11hp7ADt5rbuBOqpLCiKtj7rEazDZ3na2Xk1gimT/ScnmHRUAjEpMhjnLzpObrv9DRcBfNXIKUn98UqgQAxOnCuYtU+bIwVmIoBQnFs/xN7TPfl34CSW8+L6cgF12KFkxfWSbicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315375; c=relaxed/simple;
	bh=YOo7EVh87rnwHYdcmhCtZ2+qKHDekfy1krTEhcj6ymo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4vKAFZn56p8JoBhfqQr5TBH8W/ZyYBPgLxZQpgVX7/RnAl8/sq0oaLVs4gMEvMEr+q41W482+shk//m8C6HSqELIL9Tyh2SykedYeaD/SShXzuf5WZkUf/E6KmYLHn5bnWJY2e2M+B4NUtfRnRomBxnCMzCSKENTppfBlmE97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqL2Vf0/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqL2Vf0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315374; x=1764851374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOo7EVh87rnwHYdcmhCtZ2+qKHDekfy1krTEhcj6ymo=;
  b=hqL2Vf0/lmktYJcB/ePhEcnHyRiLFwfuAKdz/XpK5nRazKd6D9JrIGBP
   Q2CB7jGuphTUUtkjRYqGHYENVOv7N003XawI13t4xS+3v6pJXB11M/v8L
   lnVKTtpYezVSQa0SIWXLOS77yWmgZL1W9kMA+UyvIo9KoqA56j3Foipmt
   Jjm5dYqQh9izZYvA6Joeg+UDB9FHFsQJSjCugTMmHCUqGtBhe0MqvC5Q1
   Z/Di/gk0L16/nqdG6dkmyg1p+9M4hS0EmOsgUOxJNm5ibof5jUp7vUXht
   /UsbzVfd+ZWdm2Id26HWZ+MGIjMdUClWSgxWxBXqTdL/spPeZf44m4TRW
   A==;
X-CSE-ConnectionGUID: ie1cFkWfS8O9VZy/M0ULBg==
X-CSE-MsgGUID: BvIKxetZRM6hyuw2zmfYPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32937887"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32937887"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:29:32 -0800
X-CSE-ConnectionGUID: 6rvywbw8QpKNNUz2UuyNig==
X-CSE-MsgGUID: JvbBeR9USxGvupboqeabxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93599069"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 04:29:32 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 2/7] iommu: Consolidate the ops->remove_dev_pasid usage into a helper
Date: Wed,  4 Dec 2024 04:29:23 -0800
Message-Id: <20241204122928.11987-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204122928.11987-1-yi.l.liu@intel.com>
References: <20241204122928.11987-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for the ops->remove_dev_pasid, this consolidates the iommu_ops
fetching and callback invoking. It is also a preparation for starting the
transition from using remove_dev_pasid op to detach pasid to the way using
blocked_domain to detach pasid.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 38c3f67e441f..0331dc30eb64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3312,6 +3312,14 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	ops->remove_dev_pasid(dev, pasid, domain);
+}
+
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
@@ -3330,11 +3338,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3344,12 +3350,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 				       struct iommu_domain *domain)
 {
 	struct group_device *device;
-	const struct iommu_ops *ops;
 
-	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
-	}
+	for_each_group_device(group, device)
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 }
 
 /*
-- 
2.34.1

