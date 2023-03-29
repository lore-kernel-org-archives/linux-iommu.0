Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA2187C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680095892; x=1711631892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nH4o+lM2uJ+fB8IIcR/WsQzWCzC+uZgYOg1JRTm+NAg=;
  b=Oe6UAHNSsOR5neKpgXfpcZ4//YfZRST7DbxLCPMqggh+LRSrovgNlKIg
   Kw8eC+YcHjhRNYF2mYh7ocjIxe7APzmHR9Zkc/VTP2Z5Z/z4MwJ0TQ550
   KNc1QkjkNwQT2jjXvtoPPJrk0JXOpOkGNVthg+lulHDUQO6ik030+rP2O
   DrA/lO5l8owQjj2fhzm4vqOFZhdGpQLz+XrJcfH8UxOJzg5Nc+WZg8AOl
   Kbtb0mYVzBzLXDSuBeMWZ9NCIQmU2ysuFvs8dk60kykxkXrS5st6a40N8
   pOOkm3HLUHo/xhipSg5h6wDU/A7XgcUk8x7GbqUafRvj/8BLvzVYz0zdd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343293155"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343293155"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686821263"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="686821263"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 06:18:10 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Fix quoted string split across lines
Date: Wed, 29 Mar 2023 08:46:53 -0400
Message-Id: <20230329124654.2698853-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329124654.2698853-1-tina.zhang@intel.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves checkpatch warnings for intel iommu driver.

WARNING: quoted string split across lines
	pr_err("%s: iommu width (%d) is not "
		"sufficient for the mapped address (%llx)\n",

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 085d31a77f6f..286bb17973a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4294,8 +4294,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		/* check if minimum agaw is sufficient for mapped address */
 		end = __DOMAIN_MAX_ADDR(dmar_domain->gaw) + 1;
 		if (end < max_addr) {
-			pr_err("%s: iommu width (%d) is not "
-			       "sufficient for the mapped address (%llx)\n",
+			pr_err("%s: iommu width (%d) is not sufficient for the mapped address (%llx)\n",
 			       __func__, dmar_domain->gaw, max_addr);
 			return -EFAULT;
 		}
-- 
2.34.1

