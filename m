Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A1BD24
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 05:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674194280; x=1705730280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qO3loxrpApHeUs48FOJbFjVd9MSUnUWsGfno0aAx/oc=;
  b=Ijfd72YJxb9Jqfhkr+yzD8sF78nxpHdJJeZxootPH1snGxlHXQc00v8l
   h4av0oa5hhconZYoPRZl3VRMqO8xLchiX8QQqyzhHqyMhB/X/joQygXNC
   wboO1zxfquYUS3sdJUE6NnprqR3T8unJ4kIKHtK5UU+C81ABjMG513XiN
   8w1xD2DoiHIWxI5ALL/Xj9QnjQ5RaAosKZsKzq857sOV2JnoQmD6g4qoh
   gJll5QUZLFPPhx+2ikZajIK+rpd4N5svUtAOZNEs4TzcgjH+y2vkL0cJ3
   Id60ByN01bbIuAivtNMTtsDLQLX+9gUK5gvL/smDHroo9X9Mx885UjAMe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324194803"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="324194803"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 21:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905854744"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="905854744"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2023 21:57:59 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com
Cc: yi.l.liu@intel.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH] iommufd: Add two missing structures in ucmd_buffer
Date: Thu, 19 Jan 2023 21:57:57 -0800
Message-Id: <20230120055757.67879-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct iommu_option and struct iommu_vfio_ioas are missed in ucmd_buffer.
Although they are smaller than the size of ucmd_buffer, it is safer to
list them in ucmd_buffer explicitly.

Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 083e6fcbe10a..1fbfda4b53bf 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -255,6 +255,8 @@ union ucmd_buffer {
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
+	struct iommu_option option;
+	struct iommu_vfio_ioas vfio_ioas;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
-- 
2.34.1

