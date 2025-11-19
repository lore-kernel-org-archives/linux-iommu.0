Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95726158B
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763529509; cv=none; b=fU1Jiq3QkmnWCZId24WtGPa3QG0OiE44oqKMbPPn1sK6qMg6IRWM3gNwC2uACwI6askEF1HQoXMQPv68AWAnUqWfgHEjZf8FuWHX7JH96aT7nCkAtGYIjkufIwHzAk1SnlG1stsi9khPQAbZ2b8HbRPps/Z6iW0O9jdsuO8k2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763529509; c=relaxed/simple;
	bh=w4uCwjMzqrDqCXPU5uXza0YcsPi5nGPFmHAc+wD8C0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pd2uakS03TSOZ7Trj+fylOT+69/+hw6KSXkffnw2QNee/kUU8SFbxfYEhKo7Kgvj+YJ+6XPGuwnFqAlns222e3ISZ95rc2tAm6cYXqtEkNKBw9ZG4stbjI/T25Anwbz4iugGZ5nkplVp5vkVZxDfZmJKzUC+a7P4/wB2XMYF70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JapR0aVN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JapR0aVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763529508; x=1795065508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w4uCwjMzqrDqCXPU5uXza0YcsPi5nGPFmHAc+wD8C0M=;
  b=JapR0aVNy+1hog6elsJPt9NEIJwzh/96pvTd1KtpUA3eD6FrCN3ntWp7
   mIfnk3PRJ4tltdzWraJ+g926pqz8OQPOGD3yUpljvyUCMA0yBPuhJ4tFe
   qPvkiO6gaWq9YxqqSI/KBsrcYkwDkpvUgDd0UiXDGG/K2OQZCqCXNsC0q
   ADbdUOQ5rMZyRf3WcEphaTPI2xUpC4IFnZrkAlSKfHHEcug8hFZFee7hu
   nFjf0tGlAXkbAzRUQ4uWb96vFykDTVSDpBMrGwDNaJ8rAgyX8HjxtCNP+
   pyv1c3MPGDvbP0gwyVSlbFarglHxaUbJquatbE7aouvBEfdjTuZXEAyLj
   g==;
X-CSE-ConnectionGUID: emnX56z4Rdag72UulPn0VQ==
X-CSE-MsgGUID: a3n17qfkTWiJgLE3mu8AHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65604693"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65604693"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 21:18:27 -0800
X-CSE-ConnectionGUID: 3vR5pKRkT6adNzPDqma1SA==
X-CSE-MsgGUID: 1osqyp+QTp6EyDg0Kgq7fg==
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 21:18:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] [PULL REQUEST] Intel IOMMU updates for v6.19
Date: Wed, 19 Nov 2025 13:16:11 +0800
Message-ID: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.19-rc1. They are about two
small and non-critical fixes, including:

 - Use right invalidation hint in qi_desc_iotlb()
 - Reduce the scope of INTEL_IOMMU_FLOPPY_WA

These patches are based on v6.18-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Aashish Sharma (1):
  iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb

Vineeth Pillai (Google) (1):
  iommu/vt-d: Set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD

 drivers/iommu/intel/Kconfig | 2 +-
 drivers/iommu/intel/iommu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

