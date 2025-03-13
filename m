Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F98266F18
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869353; cv=none; b=lWczYVEQUUudv/tzLwE6Wn0JWjlfni0EVFTf+P4+C0dVsA1iFrEI3s9bnDpAn4CfB9SY1B8jVgdPsk8mlGU0whtI6c23icUxUN6WFa/1U9BN0yE+0Ey9S70iy3bPjhhECs8+TEMLBiHlsbuKm8HHRM9mSday8nmvynyLKaaMwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869353; c=relaxed/simple;
	bh=d0YMSBHqf0IotLe1G1QsMi6p7SNyaQvzyy5hqayzsZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmzUlT6uW3OwhaEeXZOHuKgVcyjiZC7AgZRtaMvgPU0HI7J8rfepaqtoyCzdukBS9L4SYbSH/Z3oyUA/s60TJGVr5QRlyzVeD5lp+ta4/K304GfLCzHkKdjusMOA1/Ot649ZzDWgNlOmW8J+/T9C0afhA/TuQTzCrxU1d3lMacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3xVQaSh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3xVQaSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869352; x=1773405352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0YMSBHqf0IotLe1G1QsMi6p7SNyaQvzyy5hqayzsZQ=;
  b=P3xVQaShdufuM43qPDn3SgYYCbhYtoVYLKtCD1MhteYcOe3MqfxqBb4Y
   yXHwP0pRDgrW4MoDiQeb3CDEheQZPF/nZ1U120wdSE/fbOD8BnEjqgsSG
   10IYtvN9zf063zelLSwgT37TPVaXv3FC9C/CwDOdZAhnRwpK0b+szKPJg
   gP3z//7tUPoYlrf6fOhIaJC6Uce8Tt3uUd9lx63toQxbYsN+efUyhamoM
   IRXeIpMyDJ6agjBm8rPt7zouK+tcnWGTKS8LHuMh9e5Tl7ILtEDvkUMRz
   BlX9saS+JDBTnNs0dWPk5cN1SUZf6FHhvUjB+t0PaAp6APeDhjWV9gEgq
   w==;
X-CSE-ConnectionGUID: cwoQ+jLJS0O0DYsmUon2oA==
X-CSE-MsgGUID: SW+5tJ6+RGio92D8JzCPnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863955"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863955"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:38 -0700
X-CSE-ConnectionGUID: 4xksmSsnSHmwocP3/gd2CA==
X-CSE-MsgGUID: ObhNsK+7TNecrIBUvMKv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005512"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:38 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 07/21] iommufd/device: Check !igroup->hwpt in iommufd_device_attach_reserved_iova()
Date: Thu, 13 Mar 2025 05:35:18 -0700
Message-Id: <20250313123532.103522-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_device_attach_reserved_iova() needs to handle the sw_msi when
the first device of the group is attaching to the domain. Currently,
it checks the igroup->device_list empty. However, !igroup->hwpt has the
same effect. Use it can help to further transit the igroup->hwpt to
iommufd_attach_handle. Hence prepare to add PASID support.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ac54d734b819..a63d90ab3154 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -459,7 +459,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
-	if (list_empty(&igroup->device_list)) {
+	if (!igroup->hwpt) {
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
-- 
2.34.1

