Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08620DC3
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHhB6Hyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367575; x=1736903575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XYbiZr19/1AKx6jFE1ngW+Hh/8H+xul3lQBkbfqxmYs=;
  b=dHhB6Hyx6x0xaxgXg8JTdKiBaSFQfRL5yy7JUv9EN2/OcJ2FPulf38tl
   TF/Pe2M+Or08qTxayLhBSrKm0mceF3AAxgwjr0b7Q2a7tSdh8yqoTerqB
   8NH1wCCQgkvIkAadz4dlQRgYwlXbjDLXXsm7dmbD4/lpQel83GjbO0LW5
   RlerE0f/oGqmDmhdlpmmrc8E9zlAyXmMS3Prcj7FFVPj8qCQV/DtmBlIe
   fy9dcif9ivo+zkjKIhQKu3B/HGrrWaI0GQ3WIxTQsULvvo93CAHun6qhr
   q3JTnsa4ec3azEOS/drP//QA0Co1EMuNFGYAo79BM/VC9Xyrxt+/WXArb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004385"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004385"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427235"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427235"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:53 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 02/11] iommu/vt-d: Remove initialization for dynamically heap-allocated rcu_head
Date: Tue, 16 Jan 2024 09:11:37 +0800
Message-Id: <20240116011146.18645-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The rcu_head structures allocated dynamically in the heap don't need any
initialization. Therefore, remove the init_rcu_head().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a88051b9d802..1a72b684baea 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -359,7 +359,6 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-- 
2.39.3

