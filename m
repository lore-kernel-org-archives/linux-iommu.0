Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A29A3D
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235680; x=1692771680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4XVTa44bo7+JZ58wSpvzqYtsKH+8LVXTWmjRg+KCX8=;
  b=WMdGI0sg92BE4EqzKTWC1c7fswmrMXQXpkNaBpqvBt1FUjmhfZiemTIr
   trfuNZXHODI6HRbs7ovy3giFCMyVzFZHwjqdJDxmY7X9GuKwPDD6amD3d
   HxJz6JVdW+z9uwzdh7oCI+XdnOsZFnTHCAN6DULbiW+HpeFBVD0zx657c
   byztSI4mpuPrA5PU9oGljL+eNr/JT7xELDtty6SRV4UihbexTAqyPlJUj
   Hhza9fLbfKkgOdt8ksccXIVcAQD9UBrgLC9txysPvjWTexM4Xwy7iyePc
   SG0BiDZxsd+TVnF4FxjS11Zqkd/oPQLXmkuPAJ+9PDPOB2CTYAzf6lUYD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273356195"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273356195"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605553170"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2022 23:21:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Wen Jin <wen.jin@intel.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/4] iommu/vt-d: Fixes for v6.0-rc3
Date: Tue, 23 Aug 2022 14:15:53 +0800
Message-Id: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fixes are queued for v6.0-rc3. They aim to fix:

- Boot kdump kernels with VT-d scalable mode on
- Calculate the right page table levels
- Fix a recursive lock issue
- Fix a lockdep splat issue

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (4):
  iommu/vt-d: Fix kdump kernels boot failure with scalable mode
  iommu/vt-d: Correctly calculate sagaw value of IOMMU
  iommu/vt-d: Fix recursive lock issue in iommu_flush_dev_iotlb()
  iommu/vt-d: Fix lockdep splat due to klist iteration in atomic context

 drivers/iommu/intel/iommu.h |   9 +-
 drivers/iommu/intel/iommu.c | 214 +++++++++++++++++++-----------------
 2 files changed, 117 insertions(+), 106 deletions(-)

-- 
2.25.1

