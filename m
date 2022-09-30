Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575147B
	for <iommu@lists.linux.dev>; Fri, 30 Sep 2022 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664524386; x=1696060386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhsp8GlSHDd8/AmhSlTSi78LT62QfZBL8pEfN0JGc3E=;
  b=VtXGmxzVw/DlQISZf5UskqwP6iL1oFCbtzLuPSswpG2dE2MfpHT6HpxI
   W1T4+rrCRXKd0kGbVKNfpStp14Mm9rELrwhf/bkh0Aa2/ushXll8XNgA0
   /MsSupRUBLi+JtJyNosHTDcAC8/3pJVJ0TnRIwXXJ6UqiBdNy6XVWlMc6
   17J7kUJGmwfOKrXtebGAurm70KBnKCXl/MmRyA97CyJPKPFs066+7htLQ
   AHuxx6TG1TtRwvjDHahTVVLf1kFKAmnFxdypjXVn55jsE2bOYgFcbCGew
   kj7L1oKUyZl0XRr/FnPQiKQ1DNgvxbFe4LXLisG8qfUCt0Al+17EQt2jl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303043825"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="303043825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 00:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="765046044"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="765046044"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2022 00:49:55 -0700
From: Yu Zhang <yu.c.zhang@linux.intel.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: remove useless parameter in iommu_bus_init().
Date: Fri, 30 Sep 2022 15:02:02 +0800
Message-Id: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parameter 'ops' is no longer used by iommu_bus_init(), after
commit 8cec63e52966 ("iommu: Remove iommu_callback_data").

So just remove it.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a808146b50f..bedda1e0f016 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1775,7 +1775,7 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
+static int iommu_bus_init(struct bus_type *bus)
 {
 	struct notifier_block *nb;
 	int err;
@@ -1836,7 +1836,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-	err = iommu_bus_init(bus, ops);
+	err = iommu_bus_init(bus);
 	if (err)
 		bus->iommu_ops = NULL;
 
-- 
2.25.1

