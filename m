Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D01E7C3E
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067487; cv=none; b=j2UN5SorEJq0nuKFuaIj/ZtOXu8rAZnGTQbzxLIxpA3pb+jMkfn6E82X1UMkB8Ws2uwdiYAZ4kfTSfZUMljkYbPkEnF4WCRavTWFobrKemDYyZiMQNwwOCKPtMBCepIUme37lMJ/CBip/4f0nODb2WW2driwxHPFD6ovo0Tx/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067487; c=relaxed/simple;
	bh=2s1wQPEzFpmggA2jawJvQiccvDr/ayphBD/48j9DeAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PK5obpvnGw06KlclavoFPzBzhaRm15jWwQT+KA5jPrRYWQ6Qc0N2ZGzmTDOgRfbv3WmsaXeYGAnrKH/HAEgskqpTaqlTrbAHRmXCSZPlnvn8sZOjX/sEGBnoRaCVmG/w1BqwgGTvQPYQ4J91qbeoik9AiZrjCRlLnR/8FJQrgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MubENC/l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MubENC/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067486; x=1762603486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2s1wQPEzFpmggA2jawJvQiccvDr/ayphBD/48j9DeAE=;
  b=MubENC/lllq42Te6S1voIcijcgRl01msL1B5T+LX5zpY71ABsorFL0Go
   7xzaWIncT9BZKooSgi0Sj8rb5JFkM8kNLWYGJUMbQ9LCv++psWmPEjBlg
   Wbgmgyedv4Y9xI2LzhcvujHi64D79KR6b+NBT6oqL61e6y+y8vEFEECfA
   5GE767IUtLQHQR9KgIorg/Ful4pcBWIU1e21s6Tknu0wftJY9gSclpfLD
   +5zRznqWAN4ZJuu50wFFBENLlVWFA8TlRpJOvUAPaMHJybG+y0qIi3TJ6
   Emtg5j9iO19ydPXNEuVRPNMQXpsKC7Scrxe3cuBAg2pt4oSMCJMFmWEU8
   Q==;
X-CSE-ConnectionGUID: N0FtkN3wRoS8PhOXnLx0LA==
X-CSE-MsgGUID: xa1hIuYtTz6ezMIDa5X/Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116456"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116456"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:35 -0800
X-CSE-ConnectionGUID: x/xJPLzuR/OL30nH6Ryz0g==
X-CSE-MsgGUID: LFS4smFFRXO+0Ncx01WDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679056"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:34 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v4 7/7] iommu: Remove the remove_dev_pasid op
Date: Fri,  8 Nov 2024 04:04:27 -0800
Message-Id: <20241108120427.13562-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108120427.13562-1-yi.l.liu@intel.com>
References: <20241108120427.13562-1-yi.l.liu@intel.com>
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
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 17 ++++-------------
 include/linux/iommu.h |  5 -----
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6fd4b904f270..e970893168d8 100644
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
@@ -3371,9 +3363,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	int ret;
 
 	if (!domain->ops->set_dev_pasid ||
-	    (!ops->remove_dev_pasid &&
-	     (!ops->blocked_domain ||
-	      !ops->blocked_domain->ops->set_dev_pasid)))
+	    !ops->blocked_domain ||
+	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
 	if (!group)
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

