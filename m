Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20D1FAF
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiuE+TVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841494; x=1728377494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oSl+8ABY4vMSX9OU2YlTePC4xhTypHD8FVbeS8l5Dc=;
  b=hiuE+TVMaW6cQ5jEDIo5i3Rvld4MKyB1ZJCk4i04+YqCPHnWR/SJJPUV
   DwRZXAcq+UJ0HS+bXAbkbKmbsIw5BEmYsKIHF6zo1K25FC8OwEOQbZFZG
   iYNyyR/k356e4oc6pZatvPGPO6ZEXotG1lBQWO1RyYfPH6zLwkLPgVCyP
   6KEWzt0e/kJ1Kew2wNLqg/wvIzGNu2d+NT+Rujjlk+iZs/yMoV6VK1522
   gmluYLrOBezzbQ3KRKcvwRIESqUOK8C+GzdMlQ6DDsvss2xsu1w89icrv
   l0pPYcC1Xd1OJLiDLikmuwO2BvOYfr2QYBBU/7PgnnAC+onD2mst82V3h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390813"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781686"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781686"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:33 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [RFC 4/7] iommufd: Support attach/replace for SIOV virtual device {dev, pasid}
Date: Mon,  9 Oct 2023 01:51:20 -0700
Message-Id: <20231009085123.463179-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

SIOV devices allows driver to tag different PASIDs for the virtual devices
within it. Such driver should call iommufd_device_bind_pasid() to connect
the pasid of the device to iommufd, and then driver is able to attach the
virtual device to IOAS/HWPT with the iommufd_device_attach() API.

Unlike physical devices, for SIOV virtual devices, iommufd_device_attach()
eventually uses the idev->default_pasid when the virtual device is attached
to an IOAS/HWPT. Also, there is no need to do immediate_attach per iommu
domain allocation in the attach/replace path if any iommu domain allocation
happens since the attach/replace is eventually pasid attach/replace.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 35c1419ee96b..4882e3106b2e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -841,7 +841,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		.pasid = IOMMU_PASID_INVALID
 	};
 
-	rc = iommufd_device_change_pt(idev, pt_id, &data);
+	if (idev->igroup)
+		rc = iommufd_device_change_pt(idev, pt_id, &data);
+	else
+		/* SIOV device follows generic pasid attach flow */
+		rc = iommufd_device_pasid_attach(idev, idev->default_pasid, pt_id);
 	if (rc)
 		return rc;
 
@@ -876,7 +880,12 @@ int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 		.pasid = IOMMU_PASID_INVALID
 	};
 
-	return iommufd_device_change_pt(idev, pt_id, &data);
+	if (idev->igroup) {
+		return iommufd_device_change_pt(idev, pt_id, &data);
+	} else {
+		/* SIOV device follows generic pasid replace flow */
+		return iommufd_device_pasid_replace(idev, idev->default_pasid, pt_id);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
 
@@ -891,8 +900,12 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
-	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+	if (idev->igroup) {
+		hwpt = iommufd_hw_pagetable_detach(idev);
+		iommufd_hw_pagetable_put(idev->ictx, hwpt);
+	} else {
+		iommufd_device_pasid_detach(idev, idev->default_pasid);
+	}
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
-- 
2.34.1

