Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93628A1D1
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649970; cv=none; b=luc7w9ztOvrjqz0WFgXrS2fhNjlDd2giIFPKLD3q3gZyH39K42Ke6V3rcBng012wPD7YMdFyzhC9XFsO2bWH5tCoFWzDIqKfPmJTVLZ8UcpyfvTQm0NyC7PyQuzt6OgZ6x8uS3+/KzmbODflCOMOLcNpsFlf0TdM2gOEIVIcleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649970; c=relaxed/simple;
	bh=EPmB3ER5RAbb7WUUJI2oQq79I7IlOIoDuKOxpyoZWOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmYqLYPC0lkV4NUuon3UECp3U6kNl0a/UjCzkRq2+fEzMs0pmijHFwyKrlON3Rd9I8Ty/ZAt3K6zkQ25smUsjP1Fsd69WdjDGLKSuSHgOBcZVs57w1JUHDw9OBkcfEJ1g9V5FARx2iotYixkn47eka+UM2xhFzVb8euyM3gZ89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koNHCQby; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koNHCQby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649969; x=1784185969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPmB3ER5RAbb7WUUJI2oQq79I7IlOIoDuKOxpyoZWOY=;
  b=koNHCQbyhnkuT105BqvghN/o2kP1KXV0getTFbd7Qa5oYXlRPhJehb+T
   SIPb4AuETn5zHHcF+F4D5tAo5wbA/hbW2dED4Q83OURMpMmyCKTwCYu93
   4aEYCc2bWUa4aSs/ZYGp8O5xOgJYlpGRZ2CiAHQfSVeJJcL0kYoW0WuP3
   cS6Sh/mSHdO32RegHdg7VZp8TnaJdN36wh6/Ge/FFwATLs/dPcq/ATeA8
   TvxrnXtX9q4qZJHll+2FmwOX47+M2DGaWPMa9JuHOPcvdSt7joYHF8WLL
   vNgsExPRONt7fhhP/McFG/KwprB4s0erx+DTJPrU6vmlySH3wrlZCKocL
   Q==;
X-CSE-ConnectionGUID: Y3/JtYLHQwe30iM96FHYIQ==
X-CSE-MsgGUID: SD8O1c7KRWmBKAegEfa2Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540813"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:40 -0700
X-CSE-ConnectionGUID: 2KHVZEhMRH+FoRgpVKFGsQ==
X-CSE-MsgGUID: xxsexjI7RNiyxt6M6Vt78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453643"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:36 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v6 3/8] iommufd: Add a pre_destroy() op for objects
Date: Wed, 16 Jul 2025 15:03:44 +0800
Message-Id: <20250716070349.1807226-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pre_destroy() op which gives objects a chance to clear their
short term users references before destruction. This op is intended for
external driver created objects (e.g. idev) which does deterministic
destruction.

In order to manage the lifecycle of interrelated objects as well as the
deterministic destruction (e.g. vdev can't outlive idev, and idev
destruction can't fail), short term users references are allowed to
live out of an ioctl execution. An immediate use case is, vdev holds
idev's short term user reference until vdev destruction completes, idev
leverages existing wait_shortterm mechanism to ensure it is destroyed
after vdev.

This extended usage makes the referenced object unable to just wait for
its reference gone. It needs to actively trigger the reference removal,
as well as prevent new references before wait. Should implement these
work in pre_destroy().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 71135f0ec72d..53085d24ce4a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -160,6 +161,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (refcount_dec_and_test(&to_destroy->shortterm_users))
 		return 0;
 
+	if (iommufd_object_ops[to_destroy->type].pre_destroy)
+		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
+
 	if (wait_event_timeout(ictx->destroy_wait,
 			       refcount_read(&to_destroy->shortterm_users) == 0,
 			       msecs_to_jiffies(60000)))
-- 
2.25.1

