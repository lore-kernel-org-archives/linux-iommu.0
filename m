Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E622AE8E
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649968; cv=none; b=b89fpEaUMq7Ls9Rt+TN2bH/X/v009glvolU3TYadcrbrJCCent4McZu//0iD1z098y7WS4lUe5aobBWFnZ22iq496c55F3xpcFWhYOw886ld7CKQDFF/BvGEE3D9YUW3KIOY/0TqfB9tGov3+cv3qgwuerVnCkxGy5tteCUxR64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649968; c=relaxed/simple;
	bh=CsxQqXTtX64Ksavxo4Aj3iPKCc2CvcTVo51rF2K2wO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eswts4SAUfY0RVwZcn/3eJc/tV15wvyAOvslm097q9NJLCAmhjpLxv81w01VqxPV+gyag/kD5wOGkl+Y8H1Nlu0TgivrJVHjVq8rrLrsUyEPxPLozoZb1iL7uIPGIZTVQVEYg46RTXhpaKvXyUnzsYbN+qVHX6KMQNveFfmE2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T65K579R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T65K579R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649967; x=1784185967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsxQqXTtX64Ksavxo4Aj3iPKCc2CvcTVo51rF2K2wO0=;
  b=T65K579Ravq6o+AEMfx1Eq/jyn+8Ax5Y3rFaPEzqlULnDs40bPHrKh04
   Fm892cTuEzJLgFbFtkm8Gwkpgprr0Cf0qalkgIw8AhD+HwjlFSzg+ijgx
   rwcju3y3KNQt8Q3mnlm/BStRShgo0dxUAx3wvVHT5ZYdTwJ1HGB5MJGr8
   gLeRYUB/hXIVjg2+xVnL7I1xCEVvy5hMpSIMc1C9YRowZfhkiwOPJMd/K
   87DAglJR+OzuwY+W8obQAZ5NbD/e9wxyIhixtrGqWF37VeIxC7DWs8Ogm
   6ZNLXXx9tvjLjzUVeKGCEE1G2260ITjN9SYTPmSXdKobTB2VuDkAo8cwS
   w==;
X-CSE-ConnectionGUID: iplX5cFLTOW1Ewtr7wlIiA==
X-CSE-MsgGUID: aOZfmwMJTFK3pOINfiWh/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540785"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:33 -0700
X-CSE-ConnectionGUID: yuUVXbKtQ9+UQNdIp/TIVg==
X-CSE-MsgGUID: 6bmKm5ngTAuzwWCcnfiL1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453621"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:30 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v6 1/8] iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
Date: Wed, 16 Jul 2025 15:03:42 +0800
Message-Id: <20250716070349.1807226-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To solve the vdevice lifecycle issue, future patches make the vdevice
allocation protected by lock. That will make
_iommufd_object_alloc_ucmd() not applicable for vdevice. Roll back to
use _iommufd_object_alloc() for preparation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/viommu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 91339f799916..dcf8a85b9f6e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -167,8 +167,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		vdev_size = viommu->ops->vdevice_size;
 	}
 
-	vdev = (struct iommufd_vdevice *)_iommufd_object_alloc_ucmd(
-		ucmd, vdev_size, IOMMUFD_OBJ_VDEVICE);
+	vdev = (struct iommufd_vdevice *)_iommufd_object_alloc(
+		ucmd->ictx, vdev_size, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -183,18 +183,24 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
 		rc = xa_err(curr) ?: -EEXIST;
-		goto out_put_idev;
+		goto out_abort;
 	}
 
 	if (viommu->ops && viommu->ops->vdevice_init) {
 		rc = viommu->ops->vdevice_init(vdev);
 		if (rc)
-			goto out_put_idev;
+			goto out_abort;
 	}
 
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_put_idev;
 
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
-- 
2.25.1

