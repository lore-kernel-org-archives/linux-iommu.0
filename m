Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CB7E
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 00:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077415; x=1700613415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qe9a910lp3C11Os5WJ3iUPlb1nBOGDw3/m+ycILoXGQ=;
  b=eweJ/ZvtEUF9Hirb9kvlxk3PjUdewW0lXN1Sy6SM6vMG/yIWqxzDIEoP
   YMWAs2rN9DvlZRKhMmu0T03FxIN1UR8Wg9A6VO9fHyabvpThpD/YnZtB2
   jX7pW2gFkbuVgkS9c+kCHcF2CEDgIp9PtHpj9SNkZaAPLZe1/IF9WFURD
   Djr5vXu6DX3t8a/PBLAxxdGNG/P3k9bqwvcTH7nTqd7x5rfLeSduIBmo9
   RDBZwKQIc5pONCVSN0gOOXAdk1flHKtnfmsH/oCtz90lJIWuwrUtIJC+T
   Nt7nOU9wQQh+cX9qojHqrE2t1HFkZF2pXuHstWS+ni6KXIs/8uIJQ0Bhv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="297052072"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="297052072"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018413"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018413"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:36:53 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for Linux v6.2
Date: Tue, 22 Nov 2022 08:29:42 +0800
Message-Id: <20221122002949.148140-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v6.2. It includes:

 - Add blocking domain support
 - Cleanups

The whole series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.2

Please consider them for next.

Best regards,
Baolu

Lu Baolu (7):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Add device_block_translation() helper
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Rename iommu_disable_dev_iotlb()
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 ++--
 drivers/iommu/intel/iommu.c | 169 ++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 94 deletions(-)

-- 
2.34.1

