Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D928EF
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195726; x=1712731726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiukwRnefzsk0G3cv6MPqdFvIODlX3L3N/gwsxTD9ak=;
  b=ZqL9uv3l5cVqFpZsHX8aiFQ+slCvwE9ObezOSA5GJRy3kz20rw7urv7f
   uOzrN/TrNo4T5Mfa3eB2cTCHJYTenCC0x0FJRgjmeBpcySUgDzme2tWtu
   RkxvL75jGivGj0thnW2JRy/YzpmniY7a51YO04UfE5gLcSpthGNR3rZNM
   gv8OdZbB2ojSRkY7A11vh7dLqtxVbeANRuuWqqfBgHSHOpERGUR5Q7vjo
   e3E7p69jmERFXMCMtU4UMKPYB9enrayo19VNS0u5oj9+cgYW+px06wYKm
   FucJt5YOmURooA4xcyvpOVUsNkn7viCv6NeVDmUOF+Yy4OknOOM93uRby
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028634"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256657"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256657"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
Date: Tue, 11 Apr 2023 14:48:14 +0800
Message-Id: <20230411064815.31456-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
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

