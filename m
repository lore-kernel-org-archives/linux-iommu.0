Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C63D6CC5
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553141; cv=none; b=PfO0UKbUCjgbcuU0t2XDfeBsQtxbUCWu/geRJVgnU8H+nVsxmJiMSL7Wp7hvmkttsiG3J+9i6xu0hTp2mgyzn1UGxLFvENBfNHkJNIGtPy62ALIHKDVd9j1lzfTJGOOtc6UNT4XTKx3GY9IgjdYp7676xdMuHp12EWp2gb+UtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553141; c=relaxed/simple;
	bh=D3dEDDoT3aHbpPxK4hEFaV8P3ei5CFxGflWpK+in12E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOTYuiX6cJmVOAMr9aRg20XoHgHuqr9KGoYMKY8lzQpHciGdVOhR1OV9Gqy8pLkT3uRGWqIfOp1qy/87umWeB/YfbMmY1upjq4VEo94wfTblQ7iTNeOwhCW1BUM1QyvaLshX9WfA52+xD6G8K7q1iF4rcLB9p2l/r6akkOiyT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoUvFCmv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoUvFCmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553140; x=1812089140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3dEDDoT3aHbpPxK4hEFaV8P3ei5CFxGflWpK+in12E=;
  b=HoUvFCmvE50iCc0L1p2WDmkxuBnoPBXuGG1U5W9Nv1VKiaxRx0WSlQiK
   zz2uHBCTRZjqeW6gRoQU1CyrcOwEpKb5roalhfWp5VfxCKIo86MAPTu25
   gWJbflWKqt9YBfYOx3BkJHzuAvjIR/7zCtdvb+83e1kCYw6uDP6fypHn5
   BhQVijEsuKQKr0cEG8z8f1Vqrz47XqZmJsQz+xWSpz/8oPXyNT8z1FUwY
   vctvD5LqsBT2FTX+kf0JkOgxrUCmzJ9Ly7axphTlE9SMUVufvLvIUXFuy
   RgSDy02HuoG69MHQwbmlzZGmBjpYXk0OK/AqVCqCEzeCnHfY2JMg8Sshi
   A==;
X-CSE-ConnectionGUID: Am/Ba0R7RSG4zIhB4r1KnQ==
X-CSE-MsgGUID: ktBHc+EZTkaTNTw5oLAmEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554263"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:40 -0700
X-CSE-ConnectionGUID: gT6dt4HMTXqG3sEObwqJjw==
X-CSE-MsgGUID: wb79acpnQP+XGRs1KBH2ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112170"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iommu/vt-d: Fix RB-tree corruption in probe error path
Date: Thu,  4 Jun 2026 14:03:10 +0800
Message-ID: <20260604060311.365074-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pranjal Shrivastava <praan@google.com>

The info->node RB-tree member is zero-initialized via kzalloc. If
a device does not support ATS, the device_rbtree_insert() call is
skipped. If a subsequent probe step fails, the error path jumps to
device_rbtree_remove(), which misinterprets the zeroed node as
a tree root and corrupts the device RB-tree.

Fix this by explicitly initializing the RB-node as empty using
RB_CLEAR_NODE() during initialization and guarding the removal with
RB_EMPTY_NODE().

Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot failure")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Link: https://lore.kernel.org/r/20260531170254.60493-2-praan@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..849d06dfe1ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -157,7 +157,10 @@ static void device_rbtree_remove(struct device_domain_info *info)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
-	rb_erase(&info->node, &iommu->device_rbtree);
+	if (!RB_EMPTY_NODE(&info->node)) {
+		rb_erase(&info->node, &iommu->device_rbtree);
+		RB_CLEAR_NODE(&info->node);
+	}
 	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
 }
 
@@ -3254,6 +3257,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	info->dev = dev;
 	info->iommu = iommu;
+	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-- 
2.43.0

