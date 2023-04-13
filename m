Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3F4648
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358832; x=1712894832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiukwRnefzsk0G3cv6MPqdFvIODlX3L3N/gwsxTD9ak=;
  b=jQSQALmcifK1fFFrrqgZ5VymZN722Neq0d42JVCUDnKzJVBeyn2LLKOv
   NrU04Rhmxs5B8DK0Gqs64MvevTJoinZp9+CJ4ThXmvOb3eBzbicwf080d
   VKUtmtHCYaOaaLdutgKP1xcPLID4PNw77XocCzNa2w370isTtpozq8grd
   w8J7Ho6z3LvlvwZaXtjDuHNboEJbyjkiZalDmm4p8+DSezGDesP038N77
   kVEKJC9vT6ww6al+uThs16giV++D05KI3fe0U0Bfbui+QWgoj6QjLmBx9
   Fgc81iqmKFRgSG1+hMXtnkLwFlx5Wjb0q9YFK+XOFctHMIoXQYRLEiw5j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786669"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786669"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361122"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361122"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
Date: Thu, 13 Apr 2023 12:06:44 +0800
Message-Id: <20230413040645.46157-17-baolu.lu@linux.intel.com>
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

When dmar_alloc_pci_notify_info() is being invoked, the invoker has
ensured the dev->is_virtfn is false. So, remove the useless BUG_ON in
dmar_alloc_pci_notify_info().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-7-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f0f51c957ccb..9346c6e7ebae 100644
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

