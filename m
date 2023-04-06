Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAFED6
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766279; x=1712302279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAGMr+r+frHp7o/syAN9pYiWQkrBlnmZKpzRHpvjFKc=;
  b=lT+3rRmVCN1OxtjgIC3EGGYDs5z8E/JBpzdgfUGOu0CXrCB390If+c2u
   YViYByX5M9EU9V3QHpMHE22D9lbtrIm+/Hw4eoQF0fmzCznS55uMGWo/j
   uMG9s+tbcGN1iyJiaWGdt69WjkJ9BWiM5MKGASsnGx8TovEGQZUXwKzMq
   CzKM45Y6HcPNNRkznvOopfFORBM9nQJxAMwX6LpypnnzoB48f9uK18ucW
   KHBb2sRVzeB9qH1tbigGEEy7nVbx6WbaqkXHIOw2p5q1k7yBQTgc0rPBE
   YQtU+p2UGOftH09gH0KodBmBbMGEEEaKuff6aRoTeXf2vW4mtH8LkUGMo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956788"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033995"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033995"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:18 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 7/7] iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()
Date: Thu,  6 Apr 2023 02:59:44 -0400
Message-Id: <20230406065944.2773296-8-tina.zhang@intel.com>
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

The dmar_insert_dev_scope() could fail if any unexpected condition is
encountered. However, in this situation, the kernel should attempt
recovery and proceed with execution. Remove BUG_ON with WARN_ON, so that
kernel can avoid being crashed when an unexpected condition occurs.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9346c6e7ebae9..e35be3786bde6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -262,7 +262,8 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 						   get_device(dev));
 				return 1;
 			}
-		BUG_ON(i >= devices_cnt);
+		if (WARN_ON(i >= devices_cnt))
+			return -EINVAL;
 	}
 
 	return 0;
-- 
2.34.1

