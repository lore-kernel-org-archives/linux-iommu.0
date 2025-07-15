Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A826D4E1
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561689; cv=none; b=NWpNcSHPmDRDhYpl5ZaXwkbCSvRxyaLNwqOSqRXB/+9OTR+BLC6tCvx8ZPJsO9/GEkmksZkBAlsw5fke+nOx2uaX+MxcZLQ94bMbYEfI4enlQBoh1YvtiWA+KmcQYQpSEZeaPnU4q3KqPSddBLes0lIrK9x2Na/tjRgQoxnYqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561689; c=relaxed/simple;
	bh=dW8N0hXsHJ0xZQ7gyU6p87aQVgeVycVBLBzar7O5u6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dyby9+H8Mr5COs6BBzAWmTQxQBhOEpUtYRw3lCEQGfIswiCGhUcQc1T66U93P+tQ4nxT6NQUlTznEkIiJl36KTMa9olvpOg9qjQ7s4v+3fRe38NJjt52LBokUcb77sbNW0jbmQzkKhzcSfJgVEtPCUEm5TuzyOQ7pfdoNz+y5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+aFmf42; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+aFmf42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561688; x=1784097688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dW8N0hXsHJ0xZQ7gyU6p87aQVgeVycVBLBzar7O5u6Y=;
  b=m+aFmf42ZjaiL9qMh9vIz9wKzX8W2mvnVZcfvXA9wUms10JhDvmyS9aD
   Ppz0u5CD+dcNMjpdC8KTzczE5hJcDhZ+u6fFyEZmM46/TNAtEZZy6UnsU
   loCqh/POZnVhdLwUXhl2WuOJmFJXRteiHCPKXYQ8OB7B9b2nKsE67LgFf
   CiJ2rKWiXMJpnYtNP4QqtF4ZdqnIi+u0PQ8V81VV3eJfAq/LHRr/la61k
   8etwdj+w0ndCS3BWWTBNJ93r6GJoDOxoQZ56iL6Dm8ByIas7WGiRtUMCp
   SQm+S+OMfyXBut9o2kUOqAdNtf8hfqZNddvo16+3QY1ljYg+uxAfuzplq
   A==;
X-CSE-ConnectionGUID: lmAmD8I+T9OxHeRMlFPIAw==
X-CSE-MsgGUID: 5Q5q3LxbRO6symeC7ECc0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880826"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880826"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:28 -0700
X-CSE-ConnectionGUID: TAZ3xvnWRuyK0ttEvH4aeg==
X-CSE-MsgGUID: Z+F9k3SbTg2SYuG/I878FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157648940"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:24 -0700
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
Subject: [PATCH v5 1/8] iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
Date: Tue, 15 Jul 2025 14:32:38 +0800
Message-Id: <20250715063245.1799534-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
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

