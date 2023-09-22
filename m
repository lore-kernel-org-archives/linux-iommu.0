Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA432AB4D
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395971; x=1726931971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DGjGBqtW0YmDzNhpM7gkO90ycKqRlM8UiiecicTQT7E=;
  b=Jwq24lc0vLpmuHAe2jyNoxeM+Z7gwmgzbLyFOJ40QH6lBeSrGGH6uHbg
   WGRf7+1zCThCgpGD1fUdcOQPNApIftq9GXim69gFX+K814KhBGguzIn7g
   mX04uhyqY5m24qM5AjEmzedz/N/UMhynB4T5LRrhZ6HNnkX5lFQPgcXLv
   0I/H09eTR6yk4Dw0Si98yI4d8LT9oVAfgEzmfQ0YRfLahIacEr3BAfriP
   ImmofZFfNVDDMst/altZIhbtuReYYIzrVDh1VLaBdFkNqhUDi42NnGSjI
   CkU+nMLbytDR6HIASbSMVb3DFtc17tB18N4u+/YZj8EuZHduu/AWyQeSg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360235273"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360235273"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741133124"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741133124"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2023 08:19:27 -0700
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH v2 0/3] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Date: Fri, 22 Sep 2023 23:16:33 +0800
Message-Id: <20230922151636.77139-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original debugfs only dumps all IOMMU page tables without pasid
supported. It traverses all devices on the pci bus, then dumps all
page tables based on device domains. This traversal is from software
perspective.

This series dumps page tables whose mappings are created and destroyed
by the iommu_map/unmap() interfaces, by traversing root tables,
context tables, pasid directories and pasid tables from hardware
perspective. It supports dumping a specified page table in legacy mode
or scalable mode with or without a specified pasid.

It adds a debugfs directory per pair of {device, pasid} when attaching
device with or without pasid, i.e.
/sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
And create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/0/domain_translation_struct.
Each device has a PASID#0, i.e. RID_PASID. Remove the corresponding
debugfs directory and file when detaching or releasing a device.

For legacy mode, according to bus number and DEVFN, traverse the root
table and context table to get the pointer of page table in the
context table entry, then dump the specified page table.

For scalable mode, according to bus number, DEVFN and pasid, traverse
the root table, context table, pasid directory and pasid table to get
the pointer of page table in the pasid table entry, then dump the
specified page table.

Examples are as follows:
1) Dump the page table of device "0000:00:01.0" that only supports
    legacy mode.
    $ sudo cat
    /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct

2) Dump the page table of device "0000:00:02.0" with PASID "1" that
   supports scalable mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

Change log:

v2:
 - Add a debugfs directory per {dev, pasid} as suggested by Kevin.
 - Create the debugfs directory when attaching device as suggested by Baolu.
 - Only dump the page tables whose mappings are created and destroyed
   by the iommu_map/unmap() interfaces per Baolu's review.
 - Rename the helpers for creating/removing debugfs directory/file and
   merge patch 2,3,4,5 to one patch per Baolu's review.

v1: https://lore.kernel.org/linux-iommu/20230625150442.42197-1-Jingqi.liu@intel.com

Jingqi Liu (3):
  iommu/vt-d: debugfs: Dump entry pointing to huge page
  iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
  iommu/vt-d: debugfs: Support dumping a specified page table

 drivers/iommu/intel/debugfs.c | 291 ++++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c   |  16 ++
 drivers/iommu/intel/iommu.h   |   4 +
 3 files changed, 261 insertions(+), 50 deletions(-)

-- 
2.21.3

