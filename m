Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796346AC
	for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXZaPzns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703394434; x=1734930434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sULywt8zsfoKfsRdUyCgR8KmLm7/3YpeQ7pKzjInUqY=;
  b=KXZaPzns/YKYGRF3YNWYSzwTku4ERq/CXThfiUNYHDHdDbqXp9ZkcdpQ
   3Nd4SRbKWLg+ShQcAkRWss0y9xdPtbQCWS8N4AO6mq3Du6hpegCNIb4cV
   WjqRy/QtgFZtS6Qzm4SbHmxBa+ccbR2whvo8SBz0HgUvK8bTUXb2AdH3v
   frFSiCkOb2LTdHe1bpT7ZtYZOQcxl53D74xHy2fZHwdQh1JA2WWOprZRN
   usAonFBkP9WpZ2Uj5Ay3e5jbPMEuee0NHl5fT1Y/5QGzHie9LugoWxG/c
   QEo+QtSfICfsBWSQbvs1MvJ2Mj4B7vrnpi9mgbrhYHtgCEIO0uMTSk4dy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="399005143"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="399005143"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="780982582"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="780982582"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2023 21:07:11 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 4/4] iommu/vt-d: break out devTLB invalidation if target device is gone
Date: Sun, 24 Dec 2023 00:06:57 -0500
Message-Id: <20231224050657.182022-5-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to fix the rare case, the in-process safe_removal unpluged device could
be supprise_removed anytime, thus check the target device state if it
is gone, don't wait for the completion/timeout anymore. it might cause
hard lockup or system hang

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..7a273ee80c49 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1423,6 +1423,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
 	while (qi->desc_status[wait_index] != QI_DONE) {
+		/*
+		 * if the devTLB invalidation target device is gone, don't wait
+		 * anymore, it might take up to 1min+50%, causes system hang.
+		 */
+		if (type == QI_DIOTLB_TYPE && iommu->flush_target_dev)
+			if (!pci_device_is_present(to_pci_dev(iommu->flush_target_dev)))
+				break;
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
-- 
2.31.1

