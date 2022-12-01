Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693507C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867732; x=1701403732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjh7d4AzSK7GzAYNGRKUHRiJpGxHBkXpSkEPbEmZzzE=;
  b=I4Bic7veKpcxCnb28EBanPzveDAu2ykGuiEOxduw/bpJ/skpPGPLihR3
   sej8qQJ/uHJu/m5rO5yLs6ufr2vAuhpriV2szUh8+KgTP7uSNVzdOFIuQ
   wnJ+3Ya3DqK8GzTF9swWWObsTbzFHxcBypv2OjMHXaiDiL2MnPFptF8pO
   TkS9iqk0lCNGR1Cvg3zkou7vd/fjNY4/8SZ9e58p7esBaxtxTsN2JIJW5
   bPQgSjCJI7pQ2iecRYuKHx+oNpSqCmrveG8t/ROn+olmDnNwt7LJptRPO
   BAWX77FdITd5sCMzuKgO0ivTIn4JyCZNQXHvOOvInIjRigViZCQFIARnl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745757"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745757"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911660"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911660"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:46 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
Date: Thu,  1 Dec 2022 12:01:26 +0800
Message-Id: <20221201040127.1962750-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

for_each_pci_dev() is implemented by pci_get_device(). The comment of
pci_get_device() says that it will increase the reference count for the
returned pci_dev and also decrease the reference count for the input
pci_dev @from if it is not NULL.

If we break for_each_pci_dev() loop with pdev not NULL, we need to call
pci_dev_put() to decrease the reference count. Add the missing
pci_dev_put() before 'return true' to avoid reference count leak.

Fixes: 89a6079df791 ("iommu/vt-d: Force IOMMU on for platform opt in hint")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/20221121113649.190393-2-wangxiongfeng2@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 587eebe39820..5287efe247b1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3873,8 +3873,10 @@ static inline bool has_external_pci(void)
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->external_facing)
+		if (pdev->external_facing) {
+			pci_dev_put(pdev);
 			return true;
+		}
 
 	return false;
 }
-- 
2.34.1

