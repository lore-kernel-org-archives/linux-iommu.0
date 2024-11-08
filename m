Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752F1E6DD4
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067479; cv=none; b=EK1nJo3adFm8yRytnxb6xmPXOA22yH+GG5VUCyuaAkPmMGoph0xYm6xpsDaRc9NFoycT15bLeOa9rCF60xog1j1UKSAKTPlX2uorjPfG3CCgqvcllON5BIfET89qZ7evOEnkCkjql1GcL+zvweFMtPtd8UQiyThOh21C79bCbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067479; c=relaxed/simple;
	bh=hga76UsnkngRS0zS8f0+ZljIoWVttNerXYCKXD9K8aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DywmjKlO2fmknibxumYwmJmyGEyEUw5OKVbFDHI1wmx3wpjLVQmsoSLL9FB5rUA4PnvZwhwKV+5eRryBxzke6B5XWXqqYu2l84GXcQEblLfN7PDiWIs46yWNfh1vHeoKPA0UWWsCHLDPL5X9JKWntRwmW9LDmjVm2AfFdeXbt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMAzOH1i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMAzOH1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067479; x=1762603479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hga76UsnkngRS0zS8f0+ZljIoWVttNerXYCKXD9K8aE=;
  b=nMAzOH1inO5kdCNEOC2JpowWcyKqRe2llxifISxA9XeeALbTywVizOyU
   r72rKOgu25m4rFKPAN0OfW9+9x047PIwEIvdLRP7CVFBUJwKY+N+J8yFa
   u2PcfFzTJzKJE9HpPrOtL1sXDjaBCKsg1Y5b3mqw5jC0VjstsyLkLEUYo
   K5+x0NFnBdbbU8POkoxBWo3KfOhFK3xJjUb3J4c+XhZf9rG6jQu4Nvm0r
   E9l0qcgVmEO5GkNAWrMypX1yyV/8Pl1WeTGyDefqYx3Qp5NDgp+2+2YP1
   NHXipemE/x6n/aiUuOLLDrXLuBuzSFqVb3XWP52YZsrH8ozpAvPei4g0u
   w==;
X-CSE-ConnectionGUID: kd8f/9F2R8a04mS+ZFYHbA==
X-CSE-MsgGUID: yeMwGo/wTJ++1N9f8l7/Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116407"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116407"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:31 -0800
X-CSE-ConnectionGUID: EoOSmgAcR12+xNQz5v1n/A==
X-CSE-MsgGUID: GzrpdAunSya6SwNaKweqFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679020"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:29 -0800
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
Subject: [PATCH v4 1/7] iommu: Prevent pasid attach if no ops->remove_dev_pasid
Date: Fri,  8 Nov 2024 04:04:21 -0800
Message-Id: <20241108120427.13562-2-yi.l.liu@intel.com>
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

driver should implement both set_dev_pasid and remove_dev_pasid op, otherwise
it is a problem how to detach pasid. In reality, it is impossible that an
iommu driver implements set_dev_pasid() but no remove_dev_pasid() op. However,
it is better to check it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13fcd9d8f2df..1c689e57928e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3352,17 +3352,19 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct iommu_attach_handle *handle)
 {
 	/* Caller must be a probed driver on dev */
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	int ret;
 
-	if (!domain->ops->set_dev_pasid)
+	if (!domain->ops->set_dev_pasid ||
+	    !ops->remove_dev_pasid)
 		return -EOPNOTSUPP;
 
 	if (!group)
 		return -ENODEV;
 
-	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
+	if (!dev_has_iommu(dev) || ops != domain->owner ||
 	    pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
-- 
2.34.1

