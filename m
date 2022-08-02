Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0D7F
	for <iommu@lists.linux.dev>; Tue,  2 Aug 2022 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659469125; x=1691005125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nh6oqzOP4zkEC2BfS8mKs5YxKTaE500IwLAFVtKjfWc=;
  b=d54l9mfGMoREcI/2mYslrm1AX5EfZCiX+Q9zt/QoVQgnVkOCFabbzeFg
   VlmNfBb6hldDVLVQDf1lg4JRdAauaDPDt6lBOa7TTc93FJqXhjwyXbXiD
   Y5AWIUpet5BuWYWRZGtWUBeZienuB7fVLVUmbJYwgg07drl8a9f8/vMUn
   Z/xhctbFjFXQxQvyRCIOVFBV3kD/Mv5s8uU37xr4NxML5dqUOLViNJVfz
   Gz+MUGppJDcv65z+THTdT7IVgvOJ5qGA0SxfzqX79KtqcXqvfX0tSuTgh
   lom64vJLF4/p638CkUSkiHKi2x0rJ2qan7xvyMTv1sFQ0SWQGBuYRlMze
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351216609"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="351216609"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 12:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="848320304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2022 12:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0ABD7F7; Tue,  2 Aug 2022 22:35:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eric Auger <eric.auger@redhat.com>,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct device
Date: Tue,  2 Aug 2022 22:35:03 +0300
Message-Id: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
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
Instead, use the specific dev_fwnode() and device_match_fwnode()
APIs for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/viot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 647f11cf165d..6132092dab2a 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
 		return -ENODEV;
 	}
 
-	fwnode = pdev->dev.fwnode;
+	fwnode = dev_fwnode(&pdev->dev);
 	if (!fwnode) {
 		/*
 		 * PCI devices aren't necessarily described by ACPI. Create a
@@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
 		}
 		set_primary_fwnode(&pdev->dev, fwnode);
 	}
-	viommu->fwnode = pdev->dev.fwnode;
+	viommu->fwnode = dev_fwnode(&pdev->dev);
 	pci_dev_put(pdev);
 	return 0;
 }
@@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 		return -ENODEV;
 
 	/* We're not translating ourself */
-	if (viommu->fwnode == dev->fwnode)
+	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
 	ops = iommu_ops_from_fwnode(viommu->fwnode);
-- 
2.35.1

