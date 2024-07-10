Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B413B59F
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600603; cv=none; b=owIoTyVuLyGja7hyV1dz/TSLYDOe1jRw9yYhMKTdtdqunny/tIMlL0NweJD281n31roKmwU2Du0OShfamQUGkqyJ0cpF1smFm1yY4lI6QuiZc1HJ784VNTsye2IARh5uVleMG97hMEeyIP6cYmQWHnL70mFAlDH5nO4QXTq+W0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600603; c=relaxed/simple;
	bh=QE6yDlRdiuYRWqF9/WCzWvWO0J0BeZi/moyxfPUj4eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5xSrq0rfQr3L4sqrzL/ie1CESkr9Bj0aP0QbwokJFnSYmdDuud4BlhA9hTOKWiYYT/y9Ymd59ohBHEBjyNWM2UFZnh6Zn5s3kRfzpJ0x4sboCNFSO4HaUkdRkAeYaJpW1V8AtYJEYVYYyTq9IJHsF1gt13+MYczWRzBNLdo+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLyREKwJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLyREKwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600602; x=1752136602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE6yDlRdiuYRWqF9/WCzWvWO0J0BeZi/moyxfPUj4eE=;
  b=FLyREKwJy5HnvuWYsfhHGEWdfLrbST6T8goUyx9GOllICUJjEDbxOIzZ
   c2XRHmi9SJDcp4Z8PNEuGzaNtCQIXDbNrjIujgui/HNFUkSDl5t99QqpV
   p83OZJRqdDyhFWXc5vI0fCWLFxncRbgF2ptAWH0n7KgIEArxtX5tNXQ5M
   PHLJ9F87BcnZO2byxpMuUsT3pxaiG9PecnYs5tZzskPNAcaREGTZIFie4
   +Qmf0u9h7ZH1Vv1iXBaXy5fEvZeT03R7cIlTGzSDUHx/uGCIA8LPo73rx
   juP5/LKxIb7xHn99EFQFy9VGmmIiBpMo3MwS8cFEii4oeZl2uTEt7x7Uk
   g==;
X-CSE-ConnectionGUID: nbtGhHLVQ3++gnV4WfP23g==
X-CSE-MsgGUID: YVZb6PH9QzGzPNj/xDlj7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770979"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:42 -0700
X-CSE-ConnectionGUID: 7Idk2f7NQdOGX7N/MG4Jdw==
X-CSE-MsgGUID: ndSlM5TFQCWk1L1ooNVDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236160"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/3] iommufd: Add check on user response code
Date: Wed, 10 Jul 2024 16:33:40 +0800
Message-Id: <20240710083341.44617-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The response code from user space is only allowed to be SUCCESS or
INVALID. All other values are treated by the device as a response
code of Response Failure according to PCI spec, section 10.4.2.1.
This response disables the Page Request Interface for the Function.

Add a check in iommufd_fault_fops_write() to avoid invalid response
code.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 54d6cd20a673..044b9b97da31 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -305,6 +305,12 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		if (rc)
 			break;
 
+		if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
+		    response.code != IOMMUFD_PAGE_RESP_INVALID) {
+			rc = -EINVAL;
+			break;
+		}
+
 		group = xa_erase(&fault->response, response.cookie);
 		if (!group) {
 			rc = -EINVAL;
-- 
2.34.1

