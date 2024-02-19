Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272932C91
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347464; cv=none; b=tcrnSgbc7UjdnwW58+HpfssWedIBd2dST2/6uz5bliR1dkDwNl+Rz4mNd9+UlBXr6y7fqWIhjcTX10BSJJ1Lc8E9TgJAEmbzsndbuquEZUP8RlZMVVm2M8XSeBK7mzsEBGq7Zvy3rnOyO52bRnCrFV65Wi7elL+K8s3WWUwO+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347464; c=relaxed/simple;
	bh=INfAXPSz8KP2vR8GscMmkCXdmNP8tVASvwVU/xPRVsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvUIJ6UlAqFFCHc0bV5+E9tXwlhIprrw31rOkcwbqcVM639t9hvnxXirj2e3WBJ2oTaiLRhB8agbiOsYIW9LuWmXkAN4w/AArCxE0yoU4H/FvR0vK5Z4l8IkdTP2rNaBUs3Wixl6ENEj4YTW+21OvgoLSfK8vbRnJzOUVfYAWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiyhKOWU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiyhKOWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347463; x=1739883463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INfAXPSz8KP2vR8GscMmkCXdmNP8tVASvwVU/xPRVsQ=;
  b=LiyhKOWUo4L+B9ilRCU4J++ywo658jfpWOlrOSKSjqx2L5SM/beo+h/1
   FqzISK8rDROPQh95JwE8qBBbEoL/MCDPlM3ikPR54VSp9RS323KwrW53D
   Xz7W3HiQ9B04Dsdor8jTwPH/jqxsk/K68LP1jFGQPT/PV9a3W4yjLRXDd
   WKXPSpgyQNy7/d27vvwME/iOJMDX1SzStacKqsYujyU3byJKYHY4UV15b
   5UwUsryiCh1aSxc9Sowz2xiaBIlPiZd/8FxtGG+bbyLM2VGiSXaNp795+
   FaINiIwpehwVIMm8IZkU6dqg2xoZ6Hk39szZkXN+iJ8twlfE6AeZf64o2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296427"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296427"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449267"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:41 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 02/13] iommu/vt-d: Remove initialization for dynamically heap-allocated rcu_head
Date: Mon, 19 Feb 2024 20:57:12 +0800
Message-Id: <20240219125723.1645703-3-tina.zhang@intel.com>
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

The rcu_head structures allocated dynamically in the heap don't need any
initialization. Therefore, remove the init_rcu_head().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a815362c8e60..a92a9e2239e2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -360,7 +360,6 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-- 
2.34.1

