Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0A7F
	for <iommu@lists.linux.dev>; Mon,  1 Aug 2022 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372473; x=1690908473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLP49io1pzmQUn9VHWWPHuXHd9od2/sjs2BB4xjqYf8=;
  b=C73FTC8YRk/hkMpiGBaUUVKfqkGmexCGRTYCx8o2dFiFA6XWnfbTBN07
   nazQXQLbKee3DQvEIpnC6j/pvXSE1yJvXrlN+qODy2ftC8jXZwZk7HoNZ
   ZNOE/ehY6adzGqBOYtRMzS9pixmAIXhuTHdbtQx3d6sVydfA2ZiNorklm
   HyV2sV7fIPlZ5knqC/TaZGbWmWJRiYj6BG8A2SJ60ecrET7lK40Wt8y5m
   vOVQqvlgM1laSgklL/6H54/nctzLKKESZcqQYeuHq2NGXo/HPaEjwWFTp
   9v5dVLVm/efgNrhKhw+a8dcFedPSFm+px1VemeR2KPdOEBSgCtAu9PjBs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="287948630"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="287948630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="661226677"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 09:47:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 783B4F7; Mon,  1 Aug 2022 19:48:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Date: Mon,  1 Aug 2022 19:47:58 +0300
Message-Id: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific dev_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..31b5f4ceb2e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -173,7 +173,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	iommu->ops = ops;
 	if (hwdev)
-		iommu->fwnode = hwdev->fwnode;
+		iommu->fwnode = dev_fwnode(hwdev);
 
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-- 
2.35.1

