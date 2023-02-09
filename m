Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E63A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917138; x=1707453138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBFJ6TbDlAcW3TvlfZUDDjiRVo3eS7ALVE66cynI8FM=;
  b=Yf+L47K4/88sslXysxMrYX/ldM7+b/Ivl272avFHpO/xGu5Cbo8XcZ09
   IMqrmKTeKc8N10Utlk0GDJyxY6bUkuQBp21i3JW2rygH0sdCgsbl/LlV2
   9/XbtKDchJndk3WLvFXfU6MdfyKA7SQTnsjJtUUr92HqpR/oX/TMnoAc3
   leVS0IP0D78F3GAhG0AV6oAAsFgZBQjTl27VYhNpcJA+yO6DwIu5HrAEb
   Se1ooJMc0OkjN9MzG4CrEK9lLoNSjwo2Q96k46eRmcn9wPJLq0mnfNfHY
   k2elE2faWSjgCZCSCuhPeS3NAG5JkYOs76C0dx1Ew9M8VlWFoH1NnWqUT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298781"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298781"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447573"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447573"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:16 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 10/17] iommufd/device: Move IOAS attaching and detaching operations into helpers
Date: Wed,  8 Feb 2023 20:31:46 -0800
Message-Id: <20230209043153.14964-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

When using a 2-stage nested hw_pagetable (hwpt) setup, the IOVA mappings
or SW MSI are at the stage-2 hwpt, while the device will be attached to
a stage-1 hwpt. And then the current do_attach() flow will fail to set up
MSI, since it always uses the attaching hwpt pointer (i.e. stage-1 in such
case).

As a preparatory change for the following nesting support patch, move all
related operations into a pair of separate functions, so we only need to
redirect the hwpt pointer to its stage-2 hwpt, when using a nested setup.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 40 +++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dd7943ff02e4..cdc4ab36f52d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -294,6 +294,36 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
+static int iommufd_device_attach_ioas(struct iommufd_device *idev,
+				      struct iommufd_hw_pagetable *hwpt)
+{
+	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
+	struct io_pagetable *iopt;
+	int rc;
+
+	iopt = &hwpt->ioas->iopt;
+
+	rc = iopt_table_enforce_group_resv_regions(iopt, idev->dev,
+						   idev->group, &sw_msi_start);
+	if (rc)
+		return rc;
+
+	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+	if (rc)
+		goto out_iova;
+
+	return 0;
+out_iova:
+	iopt_remove_reserved_iova(iopt, idev->group);
+	return rc;
+}
+
+static void iommufd_device_detach_ioas(struct iommufd_device *idev,
+				       struct iommufd_hw_pagetable *hwpt)
+{
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+}
+
 /**
  * __iommmufd_device_detach - Detach a device from idev->hwpt to new_hwpt
  * @idev: device to detach
@@ -323,7 +353,7 @@ static void __iommmufd_device_detach(struct iommufd_device *idev,
 
 	if (hwpt->ioas != new_ioas) {
 		mutex_lock(&hwpt->ioas->mutex);
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iommufd_device_detach_ioas(idev, hwpt);
 		mutex_unlock(&hwpt->ioas->mutex);
 	}
 	mutex_unlock(&hwpt->devices_lock);
@@ -342,7 +372,6 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hw_pagetable *cur_hwpt = idev->hwpt;
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&hwpt->ioas->mutex);
@@ -367,15 +396,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+	rc = iommufd_device_attach_ioas(idev, hwpt);
 	if (rc)
 		goto out_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto out_iova;
-
 	/*
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
 	 * the group once for the first device that is in the group.
-- 
2.34.1

