Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6281182D4
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585449; x=1723121449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ql8GvqSQc3MnpAxdXzxymy2oKa6nPM5ZIi5KTo5aEM=;
  b=gXdeyJ6NSkL3XCyFAI3G12PV84kK3Lvmh+ZT6XiPdOxSJ6IU9By83QaK
   Fn2mjqpg8wndFr1FKtgLSAp76gZeeKpFy2sf0uCrG3l7CfJD7OO3L3cvT
   YMLvqMFwl3Y4GAifdgnVl08SXzELdkkc77sK04SRdO7NAGEiSdicwv1Ij
   cdVh4UNkaGmfzO+IOmB8Y31TkiZ+3JOupAoxg3WLR+hbMq1NWzqfjtf4P
   PtVBcjom9GFmpS9nfuRrcI+RRjJVuXGh/pokaX599hNq8MDeE6dzn7j7/
   9WSucIGj08NRNiYa6Dtvi5heBnVguRuKAq4qhDPDvf3VobDls6KbI1NMr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821780"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521902"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521902"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>,
	Yanfei Xu <yanfei.xu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iommu/vt-d: Remove unused extern declaration dmar_parse_dev_scope()
Date: Wed,  9 Aug 2023 20:48:06 +0800
Message-Id: <20230809124806.45516-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: YueHaibing <yuehaibing@huawei.com>

Since commit 2e4552893038 ("iommu/vt-d: Unify the way to process DMAR
device scope array") this is not used anymore, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20230802133934.19712-1-yuehaibing@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dmar.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 27dbd4c64860..e34b601b71fd 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -106,8 +106,6 @@ static inline bool dmar_rcu_check(void)
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
-extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
-				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
 extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt);
 extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
-- 
2.34.1

