Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172938A
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710897; x=1718246897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajj3+Tvbe7c1CGxr5IoLKuJl8BuTkCHeP1QAQhNq9bM=;
  b=SWqvETxnzvliPCZNpSWRQyATV5vKOLqs49W5WBZtiYd0qgF+o6hMK7N+
   0MNB5rl0wu92sz7tES/m8vZsW3oManO98e7NgXXhqNEd6V/Vq70PB+y2b
   87DXYLi5wVbv0YfsVlUfOZ/V+Ar5V+RZyh0RgBKQSwGm8y1yF8EXOqUTt
   L/OcJuFojp/WSLOK8qWuuyoRMluaSEkcWaiBeGe5MknKZVS8QTZw02mr4
   IH3EdvkwzQ7jR0P15vhDuE5BkZ2/r/Ko8LQiicXaGg/C9oBE52H9vso/G
   xuqYaHGK3ZhUSP72FrjHdJTn+EqmM15+X0drxVRVw/B+pHCw9dCyxx3tH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164449"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164449"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884191"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884191"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yanfei Xu <yanfei.xu@intel.com>,
	Suhui <suhui@nfschina.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Remove unnecessary (void*) conversions
Date: Wed, 14 Jun 2023 10:47:02 +0800
Message-Id: <20230614024705.88878-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhui <suhui@nfschina.com>

No need cast (void*) to (struct root_entry *).

Signed-off-by: Suhui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20230425033743.75986-1-suhui@nfschina.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..323fa1a93765 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1185,7 +1185,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
 
-	root = (struct root_entry *)alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+	root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
-- 
2.34.1

