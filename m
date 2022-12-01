Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645B7C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867728; x=1701403728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wDFL+yM/dCNG+ZwuVw9ZgnAnjVMbNp4Dy+Z5/rRcjE0=;
  b=jVvlDVso4+Tg7XXcF/d/WGG3EwlOyA+MuG5u5uUoWSG0AAP9xtvHW8kc
   dAi+029OhfgnC1ELiOp4qAe1FKYVEAlJa2fOJSe99KCp7eTS4TEYBaUzO
   Nrxhn/74E2rKBBRqIHmPBmEsr3QFKBUxDSQodqoZr3YLmfeuAh+mXzhbO
   cCyFsTuDZY/NVGzz0ryIg0l7+5KGSDv+yLD26865Bf6Kd3hGfs9DlOfQm
   2QzarJluHLWDIW28te4bwr7IsAFz1BFEf0psv8E9FkCGN9x00/WciLbwz
   MQXD48lzSM0smw59vWe5akHnoWJRdWZRZOZZ0lVWxZAp3J1LewWkChxme
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745722"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745722"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911652"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911652"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:41 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc8
Date: Thu,  1 Dec 2022 12:01:23 +0800
Message-Id: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fixes are queued for v6.1. They aim to:

- Add a fix to handle a QAT device quirk.
- Fix 3 PCI device refcount leaks.

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc8

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Jacob Pan (1):
  iommu/vt-d: Add a fix for devices need extra dtlb flush

Xiongfeng Wang (2):
  iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
  iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()

Yang Yingliang (1):
  iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()

 drivers/iommu/intel/iommu.h |  4 ++
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/svm.c   | 19 +++++++---
 4 files changed, 88 insertions(+), 9 deletions(-)

-- 
2.34.1

