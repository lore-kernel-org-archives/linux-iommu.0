Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADB33999
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347477; cv=none; b=Xj4YFpQw9wJsykrZbUtAfOAJZegL1F6BHapnr5Y999imgVxwq/OMD5DCT2UbON8M2XO10O5ploCGA4ItkQc44Hw1Z7TN4gUSeT+qbgIlz5csKc5UjQaJ6EODLbTq0oORCNX6Ga243xzl+BypJ0krsPeeI5yvXGNqohUNSEyv8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347477; c=relaxed/simple;
	bh=oHWjs3O2hgroG51EY94mYRQuEBQbtn7xi0YEVVnw4js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eu3JTdxr9Ik3qxEUMf4IAQAzmvYFtPNNEoyqmyCcfp3aH2qD2RGBdj2zO+KGXfhRi33de1YcCnApTRvTJSPEJtxWB9IA+mVEN+5Yv5dPz7HQi5VR2YypJwTB7s+oTYREmHyZIguStZ+cDjrh7yTCYRpIWm2h7QR+OEzLdHsdtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asofUtEA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asofUtEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347476; x=1739883476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHWjs3O2hgroG51EY94mYRQuEBQbtn7xi0YEVVnw4js=;
  b=asofUtEArhzW3L6TwusBjmY54bRWoIFRW5vwFRI69B8Yl/hUAAWOelf5
   xoZqYW/x0pB3YJSBQtvuxHN0tRPyO+L+HXmS+jpwqXDVvvOcwrEh3toQO
   jc5q/A2zs296200kNRNTTL3Ji17wS6nWaaZ2UDKEL1eXYg+6gCqFyA246
   8646F7pydrjDJIjG30b+Z2HeZvO0VbCzgUGuh/OkQrJyhzG4X2sR2pbo+
   LiPsZX9w0iFEv0ZXnhqztYGa2bhDoLMu0Qc4hT2obP+voXrIOrLrmeLb7
   snG8nK3XoleRkxkLNZIrjhiq0ML8rdhwttTrTf3h5sfJFbD71eT5hEjv9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296464"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296464"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449305"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:54 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 10/13] iommu/vt-d: Use dev_pasid->sid field
Date: Mon, 19 Feb 2024 20:57:20 +0800
Message-Id: <20240219125723.1645703-11-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_pasid->sid, since it has been assigned the value of
PCI_DEVID(info->bus, info->devfn).

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c16ff5c64264..0d4d8cee1639 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1348,7 +1348,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 			continue;
 
 		qi_flush_dev_iotlb_pasid(info->iommu,
-					 PCI_DEVID(info->bus, info->devfn),
+					 dev_pasid->sid,
 					 info->pfsid, dev_pasid->pasid,
 					 info->ats_qdep, addr,
 					 mask);
-- 
2.34.1

