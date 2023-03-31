Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965515C9
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232456; x=1711768456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AR95O6zCe5vMvGKLYr+pgvj2KdNlnK9qmd2385lIv3Y=;
  b=hDT8RCf453tfiLx5AzLvoDrqUK37jcFdFfsKR/fhU+9yh+flgwqcUGVu
   8IkwOfHrOMLSYXkCzdWq1btK2mXXUVWtsr4tLamy9SLu+cyKjgv3epUeb
   a9fxrKKB/1BupN9PPYFthorjmbGB/XKv+hzCAvdIlKuvzpJv3Gh6VUN7R
   OvxqYx0RUOCRK01NxK3EH0xRLQTYB2cLTE9biW8YNt8JkMS4BiuyNTBCZ
   bduZ+vemnfY/UH7KiqmXF21YqCVmbeXAvItjyHj00hJffTCLGuIT2Sa6J
   5ojbXkohm/SrmEArz603q5oqAVMp41dVt9u/07ds3Xt+pjM8DEzOaKuZB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991742"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144781"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144781"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:57 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 7/7] iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()
Date: Thu, 30 Mar 2023 22:42:36 -0400
Message-Id: <20230331024236.2716001-8-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331024236.2716001-1-tina.zhang@intel.com>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
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
index 9684c96247f8..7eceee081235 100644
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

