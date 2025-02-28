Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959A25E47E
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738435; cv=none; b=QyF9CM9y7f3uvSTbE5R+K7KYrQl6hlS1R+90Qy83MCbwiIyqFezrZBJZcukR8BgULZyb+JsFQ0KiGDGFeILIGqGQcx5urrWMgMNF5sNov0FlA9cS/5K7XwCJKbhupARb9eZDiZBMNr+5cuH80bmu3rhhzpFJ/9bgCQ7Fk73vDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738435; c=relaxed/simple;
	bh=Om3oLCN05RWCtxtm4YrmzKGpCrmY1yzTB9fpPxmib3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqJOCz+SAPJb7XvPdO/4nSDeyTeU5xt/rSAnmdSSO6VW/HmmpLOQ/2W8Loo/m++1uIRxASyUzwdqpvDFTdk2DDyuN2nom13+7XQ+dr38e/gxhiEMz63DwjiveNVxmJhlpdBV91xTIAqvzfHlPrYWiQX5VXSF9uIFUOPas9Dip8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmQwvXUG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmQwvXUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740738433; x=1772274433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Om3oLCN05RWCtxtm4YrmzKGpCrmY1yzTB9fpPxmib3g=;
  b=bmQwvXUGedZvaABVlE1KmHm15gpX9Wv7CAccheViUPep+3eTou16rs7h
   2FibWEVPIwiobLSsKTVLcEjjWntK69GitZKYsVuM2c/sB5S5SBjdJ8JXg
   s+ZX/TFzULeZH7W+BuH2ZnZfBA6xT7j1+wYQENC1UopFHFRShjMBj4BXn
   iU9/INZOcUnk4Ll7zlen2kBPlc4YhCZifTTm4/7ETrv1gAI9bm61LyNmv
   xcqd989bHSZylA6z3cKmNq18TUXJfHMVYP03GUGA2uU+4+JJl6BCTQX/0
   v1lEsggjJuMBEus7/PPCoDDz8w3OCdbPd45C3DKktftdCxN2GWjYKq018
   w==;
X-CSE-ConnectionGUID: 5iHoXYlIRZavv8DteYHPAw==
X-CSE-MsgGUID: Um0PMO7TTSu2bRI/SwkiaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45313083"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45313083"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:27:13 -0800
X-CSE-ConnectionGUID: zD8sAYRQQfS1sHkhXnmZYw==
X-CSE-MsgGUID: cwHuX5xzSg2CQAT9yIKvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121909451"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 02:27:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Remove device comparison in context_setup_pass_through_cb
Date: Fri, 28 Feb 2025 18:27:25 +0800
Message-ID: <20250228102726.3429268-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
References: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jerry Snitselaar <jsnitsel@redhat.com>

Remove the device comparison check in context_setup_pass_through_cb.
pci_for_each_dma_alias already makes a decision on whether the
callback function should be called for a device. With the check
in place it will fail to create context entries for aliases as
it walks up to the root bus.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://lore.kernel.org/linux-iommu/82499eb6-00b7-4f83-879a-e97b4144f576@linux.intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20250224180316.140123-1-jsnitsel@redhat.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..4d8d4593c9c8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4378,9 +4378,6 @@ static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *
 {
 	struct device *dev = data;
 
-	if (dev != &pdev->dev)
-		return 0;
-
 	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
 }
 
-- 
2.43.0

