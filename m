Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C7ED4
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766278; x=1712302278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06h1Z5p+a27fp0ikqQ2oIa1U5qjjNhaou2cnBzaei7k=;
  b=TYmsf8lJoUdlrpeQg/AUo1lPfoLi0oIS9mR/6yYxJxvrzIVxakpIoMXe
   vG/iQDOehghYlk1GdsEbAU3jBg2VKOhKTOK8BL9qL+N27yPURPidooNiy
   o3YNZ4YGswYIEyonYd1eFzb6stuCVm5kBDC7DTdKjlAE585l0bjdYKEvq
   i7sDqFKkkPTg5NAaBZBGz5TBQK6KL1oxD8BvKxjUMmJ2HsWjiQxDGoO0z
   EMoD4cGyIuulZ3WpIerIb4mULsM00ZC7a3t7ZlR+SQTtiVQ0ICc2mlbwb
   KVcphqFLpsUYu+wrPuFIX5YjDeSU9CgQsAjxPcLlUa7hjCl9CU9Aw6ic8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956774"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033991"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033991"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:16 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 6/7] iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
Date: Thu,  6 Apr 2023 02:59:43 -0400
Message-Id: <20230406065944.2773296-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230406065944.2773296-1-tina.zhang@intel.com>
References: <20230406065944.2773296-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dmar_alloc_pci_notify_info() is being invoked, the invoker has
ensured the dev->is_virtfn is false. So, remove the useless BUG_ON in
dmar_alloc_pci_notify_info().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f0f51c957ccbc..9346c6e7ebae9 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -127,8 +127,6 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	struct pci_dev *tmp;
 	struct dmar_pci_notify_info *info;
 
-	BUG_ON(dev->is_virtfn);
-
 	/*
 	 * Ignore devices that have a domain number higher than what can
 	 * be looked up in DMAR, e.g. VMD subdevices with domain 0x10000
-- 
2.34.1

