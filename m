Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395052;
	b=4XrNtkmsQan+F7Z3Z0bxR6Uq/FtkerVOgA2dUvQhV4cK8IvgQeV7flmEiOmOMY0YxOdV
	 H4xpzhrlTKire5qk1lRabwcqlSkVCjXNx6RazcML6FI2MfxxGhQiSlc0udismT9iCX41w
	 6f1tdOYV+Lh5jjTnW74A6153yXurqiWDkcQV+tb37sADvEo0sFDKeO8VibhFJ25+b9OAE
	 2RD+1nQonqJs0sfDCKEVChe+uDFAKVz/M675ql22KJmL6N/n/NXoU+dhxsK6iCa8zc618
	 VqqGNrEzOlMNy8lFzOUkKeofQuWb+9x7I3MRzDGllJ9TTh4yUCcfwh5p5ML4xR0eEQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395052;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mbF3zfNeq0U94Hyf7yHm1UWZ1t/nApD3AR6YPhHk6Kw=;
	b=RUvqsHPV3S9ykYkKzf+OO0YRDT13UA0VvQd2igSbNR/OIuFNAv4yTPRsShq+tlZ8uhuM
	 BK6wbPZPnoBSxPP8mrgVhXq1imcaVjXp5KS2E8eSISPrUc3oiwfJ4WxjBLpXLRvW17g81
	 T9tTdDw7hXwvKKZHa53fhmmW7pNtpMC4u/1fRq3gRLTQSQX+L4XDJs3eqsWu3UFSEK3FQ
	 Z/GxH3l6B1coTBFEk+7uCy1Rx6YFuEsvwhzYxFG7Ddb8RjDfugQDEp6qjYtVx4B7j1hE0
	 AFzUkrbtinwfHNpCqWCfPhZ16slZIa7maH7mtu4k2zaeTyC4pDOxuNGRS8Z9LOtTFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c7X66CPS;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEE606A68B
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 00:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AEE606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c7X66CPS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795395052; x=1826931052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVbf9rXNrD3o7xYlB/OQdzTeLHIptExXW40MEAxmofY=;
  b=c7X66CPSfUnkLD8e8Tj38nejL6H0H9s35Vycl9R1M6rjZClrDc2Yr9VU
   YkFy+3yRuX8If64qCMmTWFsi0TiXamwMW1DrFFOFKrSdEtM+EThtLNDjq
   qaa/+CH3dzrUlMhZFt1QVgeMLw2985/BfQFNz5HBcZRdjkkESYQj+sijC
   8IM7Rhi8O6wL7v9kjF93fprj/+5MVDVioU/rq0WaeUNdcozg2eUmtMnCX
   z0FBsVKIT0XWkeeeEQXWKzSNIDHDcCJAGlEFtTx0kglS/nKwvf/7r1tOH
   B6XqEZew7LLhenmrE9NBNkHyzeNtzumB7+5IYmtsCm/+OZhplFrDTKHLp
   g==;
X-CSE-ConnectionGUID: YT/fRWQVThKgiknRdzYKKQ==
X-CSE-MsgGUID: ZArbpo2AQvitO1CDKeBueA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4203729"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4203729"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:50:51 -0800
X-CSE-ConnectionGUID: jJoeSYGRQFC0nYPj88vd5A==
X-CSE-MsgGUID: Qd5VORSJTseYObhVAlXQNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="13153315"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa013.fm.intel.com with ESMTP; 22 Nov 2026 16:50:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Avoid relying on pci_ats_supported() for rbtree removal
Date: Mon, 23 Nov 2026 08:38:05 +0800
Message-ID: <20261123003805.2828580-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path") made
the device rbtree insertion in intel_iommu_probe_device() conditional on
pci_ats_supported(). To match, intel_iommu_release_device() only removes
the device from the rbtree if pci_ats_supported() is still true.

That relies on pci_ats_supported() returning the same result at release
as it did at probe. If it changes in between, the rbtree can retain an
entry after its device_domain_info has been freed, resulting in a
use-after-free during a later lookup.

Checking RB_EMPTY_NODE() to track rbtree membership is common in the
iommu subsystem. Since device_rbtree_remove() safely handles an empty
node, call it unconditionally in the release path. This makes removal
depend on the device's actual rbtree membership.

Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..82f7bd8ecadf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3393,6 +3393,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	info->dev = dev;
 	info->iommu = iommu;
+	/* An empty node marks the device as not in the rbtree. */
 	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
@@ -3508,8 +3509,7 @@ static void intel_iommu_release_device(struct device *dev)
 	}
 
 	mutex_lock(&iommu->iopf_lock);
-	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
-		device_rbtree_remove(info);
+	device_rbtree_remove(info);
 	mutex_unlock(&iommu->iopf_lock);
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
-- 
2.43.0

