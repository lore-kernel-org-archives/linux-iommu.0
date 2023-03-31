Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398A15C0
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232456; x=1711768456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xw2GkG6IOgdCgKgk65V4Tspg+W1DfAYzv2aSk9/y6M=;
  b=XVTjKeWo1lX8rkaFY2Rl+Foi9poVhQkLMwbZH54n+FjjQ8udkVCRYpqV
   rSuf5JdcQjBgDXp9hBlEjO84yzxq5RlrCjBJB9ygj/7vFin5b/tP2Iovs
   vOUu3wiy+YHkf2M3G+B6DM9HmSrUOU7nfDS38qd5YyZAyQpLsskS1kddz
   WEE9RyuZcIsK/1NxlS8doUrlYV4OIEEie5qjdjRt4GA22PCEs9WXvKaMZ
   8o2gLzHibeApkL4XcooIdekTBB4bwJ1PM/PCPm3fpUtQfnsESZYRIAeaH
   KcJ9uJDkhZTCP3TEdIRbJlC0ER147szfHDswZCmav7rO3Igz0yWp2MVJF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991741"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991741"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144771"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144771"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:56 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 6/7] iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
Date: Thu, 30 Mar 2023 22:42:35 -0400
Message-Id: <20230331024236.2716001-7-tina.zhang@intel.com>
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

When dmar_alloc_pci_notify_info() is being invoked, the invoker has
ensured the dev->is_virtfn is false. So, remove the useless BUG_ON in
dmar_alloc_pci_notify_info().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 01d0ca0019f2..9684c96247f8 100644
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

