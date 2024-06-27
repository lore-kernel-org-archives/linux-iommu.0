Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EAF9E4
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455645; cv=none; b=LQPwBUhv/6wXIdc4w3eA8b3Ockr4WljMf4YWUX3IkfIrUPjnqIknEdEhfabP1LXDlVrg3wsfAkqBNgVZnN9vYh8jspItoB96U+xlLdFDQMxkEeaohbInE/9CozaCUoRWNONyShVWHruHhcFGDVUHjDs1bvz9GQVDgBdVc4VrLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455645; c=relaxed/simple;
	bh=uhT9No+0wyYhMA8btKDJrjBmA4A+FpJc2RdTEzaIQS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1O/KwogtTYA1gF2lhJ5TOQGRcp31MbrWnz7stfIpxCUciGyl3ne7G78BZYhivIdSfmxScFnjYyAsfgf94UuG3UHztDLwqodMEVM1EIzK6DWQCWQ9uhNcLdy0hiV5MyO4XoTSalW0N3HBQ8IzBNul3v+O3+a2397FbJM5etmQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAA//8Fi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAA//8Fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455644; x=1750991644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhT9No+0wyYhMA8btKDJrjBmA4A+FpJc2RdTEzaIQS4=;
  b=WAA//8FiDfrRiqMTlZBVf/hJLJLxOBK2rfAcNSxIFnt0B/eQdlXQSK+G
   ag7RQ7D11xNt6LzgZUcB/7O60mKaowkpzc7MPf7OdwvagLJCut8LjVTe7
   91uytvtrbDEGGQc/9A638sEJa5hIORJ0cP4eT4rXmBX6lIhL9WXB3M2Eh
   uoOVaAElNk+BIBz0b0QvSnje4lVut8O/JkIY+K2zcRqWQVLzoqJCID9M6
   OAx2OALu6FOCHBFNadO+ahQmGKy20HA54ZsZv0d+0JfFhtgKpLETRsxJ+
   GPtJ08ht1gQwExbrR0sjoPXMmOJKXKekyj++DFXQGpEw+AsR4BI5qNPaK
   g==;
X-CSE-ConnectionGUID: rnXyGS++TzK/FkNMEYG1BA==
X-CSE-MsgGUID: xN+c57pJTEmi1fg3giOo9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16786005"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16786005"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:34:04 -0700
X-CSE-ConnectionGUID: gZyHkqiITtOc6a4kO7EhRw==
X-CSE-MsgGUID: 82SAhlGPQbS7AAF/tzb0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49385420"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 19:34:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Refactor PRI enable/disable steps
Date: Thu, 27 Jun 2024 10:31:19 +0800
Message-Id: <20240627023121.50166-1-baolu.lu@linux.intel.com>
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

v2:
 - The cache invalidation for a context entry change should not affect
   the devices not related to the entry. Fix this by always using
   device-selective cache invalidation.
v1:
 - https://lore.kernel.org/linux-iommu/20240606034019.42795-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Add helper to flush caches for context change
  iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks

 drivers/iommu/intel/iommu.h |  13 +++++
 drivers/iommu/intel/iommu.c |  89 ++++++++++++++++++-------------
 drivers/iommu/intel/pasid.c | 103 ++++++++++++++++++++++++++++--------
 3 files changed, 148 insertions(+), 57 deletions(-)

-- 
2.34.1

