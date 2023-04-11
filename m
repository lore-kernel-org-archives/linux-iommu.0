Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957A28EF
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195729; x=1712731729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGa6nb2+nmNFRDt+vgd1O06FQw1KI1Dbhhp5ECOkeNE=;
  b=Rn7FLXVHXWNveh0MW8x3CLeFwQBS5vUNlemGnZGq9mzD9Lh8ymm5xeDv
   QoUsUdkXS25AxV9ZjedkGFjV0/S9NuIxlRX5Ea+HbVvaDnEH5ZW7OoUZf
   h59AJMiENnlzNOvBtMeW9S7CTCz5SAGFKag9K/5tpDlDPcoFpCMbMlLkZ
   tToFQ+MdYK+eZl+YqlvdkLRsiRaxp+vyuvdUyOX4eoAvnUG0ejFeVL/xH
   VUbWa903L9Q9x7pzl+9+e4jNoDlF/TTvalmJd6VxJ9XMf6P8FSKb1u4i8
   BkT8EbPziKCgKK6GyxHqqgKYc8BBwV91E9C8ikLdbt2HhbcydIkjx8XNW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028643"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256664"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256664"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()
Date: Tue, 11 Apr 2023 14:48:15 +0800
Message-Id: <20230411064815.31456-18-baolu.lu@linux.intel.com>
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

The dmar_insert_dev_scope() could fail if any unexpected condition is
encountered. However, in this situation, the kernel should attempt
recovery and proceed with execution. Remove BUG_ON with WARN_ON, so that
kernel can avoid being crashed when an unexpected condition occurs.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-8-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9346c6e7ebae..e35be3786bde 100644
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

