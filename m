Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63552010F1
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505582; cv=none; b=CWt4cvDKkx5zTiJBBaeE7zol2dp/q9tGPezxg0nLQ0fIXXupDCATIC+T113ugLfjnI93kwDcdGUd7J9kcy49o7aL0koYNr74/WJitcbu36WLoQNCwJqErY/OCiey/4adZr96mUCJnMeQ6cNwPCn/iltOUj4uSG0EtCL7h6N+ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505582; c=relaxed/simple;
	bh=RSZiUmG12bOfUY9cuPpOaVCOvpSre8G8I7IPBw8s4VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6VnEpS0T6F7b6RjZfNaLHu4p+OOBIFgbmWvak6IP63N94IYbrW0dajYEWzzTwmEXXYNsgkYr/9enLWeE5FhkRfbmPQzQQ1DaeuTcrPVKub9iXcJmVRz9F5SXZvfE2l7TzPsvaTK9RPD+PeHdvqJzJYx5LytBmY+7LMju4Qb4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7kCLu/6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7kCLu/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731505581; x=1763041581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSZiUmG12bOfUY9cuPpOaVCOvpSre8G8I7IPBw8s4VA=;
  b=A7kCLu/630dGDoebwrkJ2jodUfK2T+JBAzm/JHoomXScrL42WWye2gr4
   VMxHNI/uPWdtdZGkc9zmOcyJ1JdbsgUkqZTMJ4UMu0rm5UAL4xeSByiBJ
   A0ZWvF3h8tFqzeBa45q4gOxzeDDNlf6R6NvNQsHPu3RTDOhHQ9sfc25qc
   9AoCUSE43nnORW+XSsksoVICJGw4USz/IwoF+JeDutFLQZjYz9wy8rZdP
   Mr6+/8JNvu9tIugQYuvJ0fugenh4BcgTavJOJ5/Fq/E+2OSOm0iI9K1Ua
   vnQhC/Abf95UQkLy6BgjkpbGynkUMqp5OeclXpHefVpzLRwLcL+59bfTu
   g==;
X-CSE-ConnectionGUID: 6QI+DsmLTGq9voHa/tnb7Q==
X-CSE-MsgGUID: 1gsQisKJTSusK4Zfyvilsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42025736"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42025736"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 05:46:18 -0800
X-CSE-ConnectionGUID: sZTYEZIRQ4GTyTm6J0Hwcg==
X-CSE-MsgGUID: QhaMjDBbSoGjOBH292t0cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87445611"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 05:46:17 -0800
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
Subject: [PATCH v5 7/7] iommu: Remove the remove_dev_pasid op
Date: Wed, 13 Nov 2024 05:46:13 -0800
Message-Id: <20241113134613.7173-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113134613.7173-1-yi.l.liu@intel.com>
References: <20241113134613.7173-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers that supports PASID have supported attaching pasid to the
blocked_domain, hence remove the remove_dev_pasid op from the iommu_ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 17 ++++-------------
 include/linux/iommu.h |  5 -----
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 25d170de76fe..8a3e3a753fd5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3303,17 +3303,9 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *blocked_domain = ops->blocked_domain;
-	int ret = 1;
 
-	if (blocked_domain && blocked_domain->ops->set_dev_pasid) {
-		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
-							 dev, pasid, domain);
-	} else {
-		ops->remove_dev_pasid(dev, pasid, domain);
-		ret = 0;
-	}
-
-	WARN_ON(ret);
+	WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
+						   dev, pasid, domain));
 }
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
@@ -3376,9 +3368,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	ops = dev_iommu_ops(dev);
 
 	if (!domain->ops->set_dev_pasid ||
-	    (!ops->remove_dev_pasid &&
-	     (!ops->blocked_domain ||
-	      !ops->blocked_domain->ops->set_dev_pasid)))
+	    !ops->blocked_domain ||
+	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
 	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0c3bfb66dc7c..1d033121bf00 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -537,9 +537,6 @@ static inline int __iommu_copy_struct_from_user_array(
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
  * @default_domain_ops: the default ops for domains
- * @remove_dev_pasid: Remove any translation configurations of a specific
- *                    pasid, so that any DMA transactions with this pasid
- *                    will be blocked by the hardware.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -586,8 +583,6 @@ struct iommu_ops {
 			      struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
-	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
-				 struct iommu_domain *domain);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
-- 
2.34.1

