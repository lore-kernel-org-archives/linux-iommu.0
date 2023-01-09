Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5C15A4
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229482; x=1704765482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WXohAuzKXOCDLN4oeNIAHB/IpmqKb5YdiBxzFVDKz8k=;
  b=JC574yWbZbSC1W5kEkMH3juMWooqaGXsFfc+Gb8LAvt120pQ7dZ2DlWl
   cpmT/h6k9KsSlCXvj1ZrVTEnBfBxda8qVDJiEmKdKvAag2jyBGdINVY4Q
   458vdWc08qcgNj1AB7C02OH8Ed6ySZAjFxsFONlD0uDxWMezan+mSWZuA
   TRl4b63lrztmXNoh7+spOTglrzTjMX6ypdrdm2C4YayDHucrRtgmq33ZL
   UJrivCYCjSAP1G0J0hMmDrRtWSTqa+xFgGU6J0rjtIiaUSUvCDn536Fzw
   6w71splNOCBXfbJa6f6ipRRXQwOPhQbocXTAR/R1IauGbVLpPs12qIqij
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848716"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848716"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867403"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867403"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
Date: Mon,  9 Jan 2023 09:49:51 +0800
Message-Id: <20230109014955.147068-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a cleanup series after the merge of commit be51b1d6bbff
("iommu/sva: Refactoring iommu_sva_bind/unbind_device()"). It removes
the unused/duplicate data and code.

Lu Baolu (4):
  iommu/vt-d: Remove include/linux/intel-svm.h
  iommu/vt-d: Remove unused fields in svm structures
  iommu/vt-d: Remove users from intel_svm_dev
  iommu/vt-d: Remove sva from intel_svm_dev

 include/linux/intel-svm.h   | 16 -------
 drivers/iommu/intel/iommu.h | 11 +++--
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/svm.c   | 88 +++++++++++++++----------------------
 MAINTAINERS                 |  1 -
 5 files changed, 41 insertions(+), 76 deletions(-)
 delete mode 100644 include/linux/intel-svm.h

-- 
2.34.1

