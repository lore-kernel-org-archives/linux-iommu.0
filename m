Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB113D2A2
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833169; cv=none; b=SuLtBSvZcbFrNDaxvtKk4KaC8HIr+Kw72IKmVsVjL6Msd5r8ByNiwcJSj2P7FHTzQZehc3MczDMA07K36BqaAgqT8f0TSxR+6+Z7CUyIt7OEoJhyeLXgOcdIq0bsy5HtCTDn464nQj5omO2/rlS/Y5wC3J4S/TOBDaTRz+Ga//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833169; c=relaxed/simple;
	bh=UOh6NAvLh2/t+MdkU3eCMHEeuBRILMY37d1QyUjHMks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rMftSRf2H9psfWNU5jeSltM+67Sv2tq76owjA1oKjVk3CuvwMsFKkXm6ZH7eDTZ5f1Qruawm6SMuqqkR2aZynKq9LMXFFD4GI/H0z5VRqekB6VyFxR4Zlm2XOvppRnTS350EoW+21YQyav8kAocPkHbnep4+omoUXE9sWqmm4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZWoSufO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZWoSufO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719833168; x=1751369168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOh6NAvLh2/t+MdkU3eCMHEeuBRILMY37d1QyUjHMks=;
  b=FZWoSufOlXciwszNwyRbg4+pIBIOnoYJ0FUTjxQgwgQIScyxSOkwvUKn
   LNREGfg2OREkAFOZdjW57/1DjbzLCE1vEdOf+FtCjmPyrJkh/lHR5qJge
   LpbsxbimcP4Y/doV2Ot7NaHU3QBd8D1Vpti7QiIvdISYnLChZ+Mx3ZXR3
   DfQOlzM2XlSilhJFRJNzK+CeX7Uf08WCIsK75UPNpynAgLlrWjHm/cVSy
   wxwj+KUIz6J0puHST3aY0SF8dMtaMYn/83UrbiCaxY4iel70ZAQk60Ipa
   AKZFx+Wl9Q1zHSiIYwy2aXmRWfBarUHE5h2WyvCSviTuqFZnf9GAdE/Ty
   w==;
X-CSE-ConnectionGUID: KMmGTF8oQbOGWhAPlC+ZKg==
X-CSE-MsgGUID: tdfp7iggTUW2gptfqi+1AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17082650"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17082650"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:26:05 -0700
X-CSE-ConnectionGUID: GGVS+OMgSvSTvNdJkxv3BA==
X-CSE-MsgGUID: 5LoLl3lERlyxE8Aty3ywIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45481415"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2024 04:26:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/2] iommu/vt-d: Refactor PRI enable/disable steps
Date: Mon,  1 Jul 2024 19:23:15 +0800
Message-Id: <20240701112317.94022-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page fault handling framework within the iommu core has defined the
PRI enable and disable flows in the comments for the
iopf_queue_remove_device() interface. This series aims to refactor the
PRI enable/disable steps in the Intel iommu driver to align with these
definitions.

Change log:
v3:
 - Refine the lock requirement. Only assert the lock when it is
   required.

v2:
 - https://lore.kernel.org/linux-iommu/20240627023121.50166-1-baolu.lu@linux.intel.com/
 - The cache invalidation for a context entry change should not affect
   the devices not related to the entry. Fix this by always using
   device-selective cache invalidation.
v1:
 - https://lore.kernel.org/linux-iommu/20240606034019.42795-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Add helper to flush caches for context change
  iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks

 drivers/iommu/intel/iommu.h |  13 +++++
 drivers/iommu/intel/iommu.c |  89 +++++++++++++++++------------
 drivers/iommu/intel/pasid.c | 108 +++++++++++++++++++++++++++++-------
 3 files changed, 153 insertions(+), 57 deletions(-)

-- 
2.34.1

