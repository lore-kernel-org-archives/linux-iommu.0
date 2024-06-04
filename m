Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841D13DB96
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466086; cv=none; b=ZdNv5esKOY7yTVapq0/u4lIr+s4Tbc1P8n1iVPZXOmjOgFUwYcuKHtm0Za+UNbW4L9qbHT5y1i+YtgOYW9sPI25UCbotAQcOLbe2jtRlI87xLPdVJlk8mU2crvFXUdxZ03ri9BF57P/2oBqHik1FFL9ulXQrzLbDLE+/oeTlmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466086; c=relaxed/simple;
	bh=sQhpQrDpkr5d6QzI9UDmfi+nhpzVyW1CcaBVDpyFpuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6oXtgwhpTKK+PvBaLSX/nqQmckW+CsSyzuEMXS31UNsnsnRLVMoGX+d5Bc4s4qBkZ1/sGLwMChypqwaX+nhwGng2AkpZaPyAZ216LE9p3efdCW1Qc4QI+R02Bq7OGs9heZFBSB4Zf7ybyYgat7qFG+iwybfGA5clxvzg7weOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGIF17uH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGIF17uH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466084; x=1749002084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQhpQrDpkr5d6QzI9UDmfi+nhpzVyW1CcaBVDpyFpuE=;
  b=jGIF17uHdgSogYLbHJLHkYM6fkeJ0WWQThrap59PHoPAO0b8yEfqkbib
   KCNGMElT4YQrgjSk95cqzgUaaGFmJ4SW+AZpz2ZIlwPY+VMb2rAfYhbez
   MVm9FiLRScsny/uAc4Fc7A5enM5+XQNQluQZZWKCYIhJaaEznXQXkniXg
   b6n6+Z07LDBkHDJdAPBHCpCemtLrsPiUZ/NYjYFoGQBraU+B3lYstu2A9
   zEDKqkiYfvuGkKVItA3OvNWGkUjrVAVLjX83SK7eKh1CAqh8mM9wLDfK9
   Ca21/kAz29HuMFb6rnzOBsQ7rzEViP+qnUVD9SHdf5VLFZmDjQCkEbBhQ
   w==;
X-CSE-ConnectionGUID: TA+qaUJzQAGdPdWM733nXg==
X-CSE-MsgGUID: uXwSQYH3RreBJlfLicXHQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385022"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385022"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:44 -0700
X-CSE-ConnectionGUID: I4TaijsOST+d8oeWfx06Pg==
X-CSE-MsgGUID: U/IxZ0NeQJKr3g9XM7QcXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661891"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/22] media: venus: firmware: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:22 +0800
Message-Id: <20240604015134.164206-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in venus_firmware_init() and is attached to
core->fw.dev in the same function. Use iommu_paging_domain_alloc() to
make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/media/platform/qcom/venus/firmware.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index fe7da2b30482..66a18830e66d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -316,10 +316,10 @@ int venus_firmware_init(struct venus_core *core)
 
 	core->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(core->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		dev_err(core->fw.dev, "Failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

