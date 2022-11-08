Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEED612F
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893280; x=1699429280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6qOtZq4rvrJXcgDLPt2P44yk74yMTtt98uYccFxHG8k=;
  b=D17EfEDaaoOtzL38G1cufANgox6oeINiUpHcV+Hk/ohV12v1R6ZbvR2i
   AXu22jSv7HZX0nkvYDs4DJGLn2pLMpTSMSTMcOkPPJwJW1lHB8z7T4b8w
   E0fCVlZpdw/Cp2zoViFtXGL3c7enBElwytm+TCfnNF9Ws5oceTm/G/b9h
   jI5u6Icg1c83DQb1bcVDOjGhlD4uIkqZDIpypS4B5C24w5bjnw/k/PNo7
   NTmurmwfSYGcnGnPlbHtdeHfue7QWcQg8U6O9VJhiPxqnnQWoIV96jk8M
   wh8kgQF51RgLAmlzMGm/LC7shK97kno5VQ8lYQaCAZAZu7xDEY4uwPVKg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290350016"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="290350016"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821790"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821790"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:40:59 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/8] iommu/vt-d: Some cleanups
Date: Tue,  8 Nov 2022 15:34:00 +0800
Message-Id: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series includes some cleanups in the Intel IOMMU implementation
after the IOMMU core implemented the blocking domain. The cleanup work
is mainly in the attach_dev/device_probe/device_release paths.

Please help to review.

Best regards,
baolu

Change log:
v2:
 - Reorder the patches to make the device_block_translation() work with
   the existing path first.
 - Add a new patch to improve iommu_enable_pci_caps().

v1:
 - https://lore.kernel.org/linux-iommu/20221103055329.633052-1-baolu.lu@linux.intel.com/

Lu Baolu (8):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Improve iommu_enable_pci_caps()
  iommu/vt-d: Add device_block_translation() helper
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 +--
 drivers/iommu/intel/iommu.c | 252 +++++++++++++++++++-----------------
 2 files changed, 138 insertions(+), 129 deletions(-)

-- 
2.34.1

