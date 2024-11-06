Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A32071F9
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907977; cv=none; b=UWLBbuIMg7Yp71H6++OTkESquywdcVDdrFnd3jIE/Mxpha5QIRUHmeB2qvJjJlYxathmQDwfsa0L6DDIYUVtwtyuRZOTygWd62eOkCfg6jE05C2DN2GLiFiov4IgOdKFCBNvKz5IuHZwsI6HOn1eS4JXX9+LBh9XBHkJVv4ZthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907977; c=relaxed/simple;
	bh=StPLIHdHMILZf4wA2ehuHqX9QaXNphD0GtF6wSM9b0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ybg0mox15vVyNSnraaVG9ZMwIDLTucQasD1M++zOnIkWGFu3BiKwLsAL4/rJK6wlFVCUO1TyAUhauRfk423+/kuZUIWN73lquSkGJdq95mIwWoHRsjfVAeDCOM/y0CrAOkXFzxNs1AE+XEErALfmdamNohYDFmedIB4BLnCPoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmilHevX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmilHevX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907975; x=1762443975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StPLIHdHMILZf4wA2ehuHqX9QaXNphD0GtF6wSM9b0E=;
  b=EmilHevXJji0senIlaTxsa5qqSQSKUDBejpI/4ENV+k6Qyjwi+XPnHo5
   vJWco5vr1jmGCWUBRPE3PDgZBB5xnERW+QUkzfM5KdaaWbauYNU2P0w8s
   /f0P1g60csm2k0jG6hRBmMYHICVFQtMSnZXIdSK52KbTB5O1uG59fPh/T
   Y+STv2ihnMQ81c1llhI3qWmtnhzHDLLzFzDhV+nT3ye6p+F1pelWrpYsX
   rnomGJ1EpE2hX3kmzlWJQ+pogz+E6PkoIUqJ7cLuITePXjSqt+PG4OiNQ
   gYge3mopzlxvIKBejW5gLvG69sN3++5zNDgE5ufAcbvWtB1B3YJPtg6Tf
   w==;
X-CSE-ConnectionGUID: nvZeQjZAQRWUYA5DXNrgbQ==
X-CSE-MsgGUID: t5sjNEstTFa/GLmEO0CTpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174270"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:11 -0800
X-CSE-ConnectionGUID: Ijf6F0wPQGCEY0G8aT+wlw==
X-CSE-MsgGUID: iuTUwI+QQuy2tECElwfFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468240"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:11 -0800
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
Subject: [PATCH v5 08/13] iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
Date: Wed,  6 Nov 2024 07:46:01 -0800
Message-Id: <20241106154606.9564-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106154606.9564-1-yi.l.liu@intel.com>
References: <20241106154606.9564-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_iommu_set_dev_pasid() is only supposed to be used by paging domain,
so limit it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6b7f48119502..3c1b92fa5877 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4156,6 +4156,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dev_pasid_info *dev_pasid;
 	int ret;
 
+	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
@@ -4184,8 +4187,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
-		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
+	intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
 
-- 
2.34.1

