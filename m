Received: from mgamail.intel.com (unknown [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56182111C
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690871618; x=1722407618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38X/UQN2S8KMhUmc07Z43oFl0p6G/FE1mEl9dZQsBt4=;
  b=aUnMTBqN1VR+Wj3VC6kjkd6ubZpJbnXdP3ZyXywOuJLwzUC8qZ8WhbVt
   7OZ3z24qqN3oluL6z4aAZl1USXt09RhuisSzy4uuuC80ccOB+ME+p2xl5
   sXwB+dOPFjhb62VlQgeSD54dvOWs2XK06cQmQQYVjhbohPQ5kldfmKLY+
   4iVYb8g4er4xIUKTMIYdBtOYzg0Miu8qkmT6UYBe1jUM2DPgaTxwr22h8
   4Zck8Q1Z7K1Yc61C/IGWdQAFbCs3P8TZEoIrVCig5qM5bZqHIJ6vJGmED
   4wTC8Jpt6ig/8aDxqpXkCjyy46C66Us561mTegyOgTS8VGEQsCQcbbkHx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372839954"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372839954"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 23:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798537908"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798537908"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 23:33:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu: Make pasid array per device
Date: Tue,  1 Aug 2023 14:31:23 +0800
Message-Id: <20230801063125.34995-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI PASID enabling interface guarantees that the address space used
by each PASID is unique. This is achieved by checking that the PCI ACS
path is enabled for the device. If the path is not enabled, then the
PASID feature cannot be used.

    if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
            return -EINVAL;

The PASID array is not an attribute of the IOMMU group. It is more
natural to store the PASID array in the per-device IOMMU data. This
makes the code clearer and easier to understand. No functional changes
are intended.

Please help review and suggest.

Lu Baolu (2):
  iommu: Consolidate pasid dma ownership check
  iommu: Move pasid array from group to device

 include/linux/iommu.h |   2 +
 drivers/iommu/iommu.c | 105 +++++++++++++++++-------------------------
 2 files changed, 43 insertions(+), 64 deletions(-)

-- 
2.34.1

