Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B3A5C
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 00:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718577; x=1709254577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B7l47jDXL6XYjzlb7DoYwki6AJEFxkHN4ykXqiXARNk=;
  b=gtUh2+V86VMQiWDbkaPK0IgmTj6qDNJ07YER0mapCTM+edNOzO1rzdkX
   Jz2Ot5M1E0PWzmOF1gNhPMceoFaWdNARSx0Mhv1CAJG5qc29RrkpZeWG0
   /y/dkvNDL/m5oaNAB3uxBu/cPDXCbadCq0HRe+QCVkI5TOQNlpxFHFrrF
   RRD5sEdi4qtGQMeae6YFw7mU3AwaFuO6EFuIUFkwQWOCQej/Fd7BKA+kU
   UkNNhaR8QD27YWzb5tcLU/FA8im4Vq86D24V8mmfMB+hvCb+inEIgxhQZ
   P/yVpB66uUng0k6zgQRnawfRDSHyhbrBRRRi+bVC/Gh2nXtaAFW2jclAe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397141468"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397141468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624708987"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624708987"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 16:56:11 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/4] Re-enable IDXD kernel workqueue under DMA API
Date: Wed,  1 Mar 2023 16:59:55 -0800
Message-Id: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to reserve global PASIDs from SVA APIs. We can then
re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series.
https://lore.kernel.org/linux-iommu/20230301235646.2692846-1-jacob.jun.pan@linux.intel.com/T/#t

Thanks,

Jacob

Jacob Pan (4):
  iommu/vt-d: Implement set device pasid op for default domain
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/sva: Support reservation of global PASIDs
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

 drivers/dma/idxd/device.c   | 30 ++++-------------------
 drivers/dma/idxd/init.c     | 47 +++++++++++++++++++++++++++++++++----
 drivers/dma/idxd/sysfs.c    |  7 ------
 drivers/iommu/intel/iommu.c | 34 +++++++++++++++++++++++++--
 drivers/iommu/iommu-sva.c   | 25 ++++++++++++++++++++
 include/linux/iommu.h       | 14 +++++++++++
 6 files changed, 119 insertions(+), 38 deletions(-)

-- 
2.25.1

