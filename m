Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327B63E
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358826; x=1712894826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSH+9CuukwrVCuz9aJxEFN4y0MR5HKb9VSv4IIAZmfM=;
  b=GSaGvf0aeGnC3fnHwHemK6ADs/e/Mj/R7RidQMQsz3MnL2llM+3I5snI
   RnqxTSB3cZyE8NmH5HYI6kwYhp2OG7IyL7G8IzXNgbd5GRjgGt1rhalcw
   KCU+CPVqWi24qNZN2dkuZTY4llqOMbRxL0w7wLhhoxX+lloGksMddfS7d
   g/986Seg7NyOeKXVS6wJgjgWWhHSuo4iZ3d2J/2MUfzyrUAHldgPsAyky
   md5oSwjy04NYuP0JjcMZHTa7HueVgsEV+GDaCLhAfLJkiFRTCrAWJ5JAV
   9Jy/h3hrjg4x6WvYsxWrtHAn5gE1jNgYHy14FJd7QxQHbw+EaeQVGUEJK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786631"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786631"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361078"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361078"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] iommu/vt-d: Remove BUG_ON on checking valid pfn range
Date: Thu, 13 Apr 2023 12:06:40 +0800
Message-Id: <20230413040645.46157-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

When encountering an unexpected invalid pfn range, the kernel should
attempt recovery and proceed with execution. Therefore, using WARN_ON to
replace BUG_ON to avoid halting the machine.

Besides, one redundant checking is reduced.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-3-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acbf82fa90e7..c4847a5aaf52 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1005,9 +1005,9 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 	unsigned int large_page;
 	struct dma_pte *first_pte, *pte;
 
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	do {
@@ -1166,9 +1166,9 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 			 unsigned long last_pfn, struct list_head *freelist)
 {
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-- 
2.34.1

