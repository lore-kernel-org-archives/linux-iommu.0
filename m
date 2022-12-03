Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAF7C
	for <iommu@lists.linux.dev>; Sat,  3 Dec 2022 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670028738; x=1701564738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBCQNsRuOx2E0G1m+ZeUdBDQ1eqUNmG0Ajh8Ft8jqvU=;
  b=l8wa2y6zfmnxRfU7WMkiz4L+Tz/TQGb0QFT5Le4wdvJ0uY3FyRH9UDLV
   gDhuyG2xr8eDQKouUY+AkFTV9TWnQxLtX80TDn1OlBsfIAIa7EemCdAHF
   BedmIVIrKv/i9ALztPrZyx3AfoI5Zod5Xfhs6DpkK4cZvaZHdhKufWNZV
   KAkxibxsGDUpLKMlIfb8drwvn548dgbf0mkq24ERqdClzgmE69MQETDNj
   +pXUiD41ExuVQxl/QqU9iEFZSmKT8t/otynJ4Ze6NUFEhBmfskpICNWCN
   l3oO0l26TL9WSYe1wqmFGAAHI7dY0r8VKeLdIO16JgZ5qAG6LTYqCJxSh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296432521"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="296432521"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819615292"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="819615292"
Received: from otc-nc-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.110])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 16:52:17 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Subject: [PATCH] iommu/vt-d: Fix buggy QAT device mask
Date: Fri,  2 Dec 2022 16:56:10 -0800
Message-Id: <20221203005610.2927487-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Impacted QAT device IDs that need extra dtlb flush quirk is ranging
from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
result should be 0x4940 instead of 0x494c to identify these devices.

Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d8759f445aff..0b10104c4b99 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1401,7 +1401,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
  * This quirk is exempted from risky_device() check because it applies only
  * to the built-in QAT devices and it doesn't grant additional privileges.
  */
-#define BUGGY_QAT_DEVID_MASK 0x494c
+#define BUGGY_QAT_DEVID_MASK 0x4940
 static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 {
 	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
-- 
2.25.1

