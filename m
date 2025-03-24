Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435418FC89
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817641; cv=none; b=Z3tBjcgy0XznU99PRV9C/V+tl0Y6RNzsJYOgC1w6Glv3Jp6P735JKA7W89xzkMaea8seYymuVz/xRdJ1o6pRESIFDiwQqeF8eKJKcXIopx+nT0VfK69A5B4vl4huD7j0It1hpI2lrZS/HZTK6VCuZSx1ohPlGClEMRs4nIpvuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817641; c=relaxed/simple;
	bh=v5C1YVDMmWky4wBptq+9M24qsTlVVxde+iqI3PNNoDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHyutb81KNISP6z0syj02lrKtZNXg3B4Lb2Waig8OTqqRTnYD8Acb9mVsQCYe5OQnLdnn8XARrEGGHASMsnV8ayi7039ZnDa/tRvnxbuV7A2/QcGNE9xW+4qR7p+cJlki7Vb3qDXq+8DzVMHMpYHUUrlUwgrxbpp6RjrL5IaxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jv1vAeuj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jv1vAeuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742817639; x=1774353639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5C1YVDMmWky4wBptq+9M24qsTlVVxde+iqI3PNNoDc=;
  b=Jv1vAeujs9tTle0PT/pZoNfxexpVE8UKIBGP5pOoNp/TbKUiwUUPtAr1
   W3Bo22IZEjLJuUybkHmrHZMQLcjG2m/S4s/dDynFhQ5dvcIGn2FDqjNg8
   aFX53wVRqaySFkTNfo+g3B5Ov6iOikMaSBYINXwkHc0ShGIVLEEWDbrCe
   S4Kb9V4gxbS8IPNvWQiSXkFsb3reu3gzCGFv9ytiF5eGed2K9DHuR4EAn
   JESxvTAndu7qlMwItuug54LGn0UvVxk+DgH16zVg+6LQHnb+J3XQ7TXSK
   LL+1VFxJpum4AJiLMoXe4dgjtN3Ux9vzSzCErabiC6lQIghxbTTBOwhOx
   w==;
X-CSE-ConnectionGUID: 6v6fsUYhR+eWPs/SJTh12Q==
X-CSE-MsgGUID: lEKQ0UcLS8i7udy0jfNY9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44031309"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="44031309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:00:36 -0700
X-CSE-ConnectionGUID: cxASITTBS4OKw3g47BNIIA==
X-CSE-MsgGUID: iTPi+NXTRzm9jE+TuIAqRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123753922"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 24 Mar 2025 05:00:36 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	yi.l.liu@intel.com,
	baolu.lu@linux.intel.com,
	iommu@lists.linux.dev
Subject: [PATCH 1/2] iommufd: Initialize the flags of vevent in iommufd_viommu_report_event()
Date: Mon, 24 Mar 2025 05:00:33 -0700
Message-Id: <20250324120034.5940-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324120034.5940-1-yi.l.liu@intel.com>
References: <20250324120034.5940-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vevent->header.flags is not initialized per allocation, hence the
vevent read path may treat the vevent as lost_events_header wrongly.
Use kzalloc() to alloc memory for new vevent.

Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 352513974154..81e01d85b7d4 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -102,7 +102,7 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_set_header;
 	}
 
-	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
+	vevent = kzalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
 	if (!vevent) {
 		rc = -ENOMEM;
 		vevent = &veventq->lost_events_header;
-- 
2.34.1

