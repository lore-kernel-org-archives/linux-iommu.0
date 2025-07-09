Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB026528D
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034267; cv=none; b=o51GVgkfwybSmGF0lxtLZQL5XZIOyV6XCPE0zvBkUR5VDAg/WzlzBmZAbVxaPsMp7M+Moub07LaR1uIPOq2bWWe42oa/NdIdEskMhOmS7MHCKs0DqcZPLqMpPF+KGXZ8AQgO4ZNdX90+iYzPZA16R/+ZpJGPN0FVqRfoY9mNxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034267; c=relaxed/simple;
	bh=Xxqu9V3MYp5Q5oPy+re163/39+IwpjSIGvyrzdyaxbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMLdUbbhe0yvfstYxr7y9LGubpV2VqBoLzcEZUGNkUFnyYaadRGz4116DRuPnzqhUOPKP4tWJg09qnO5Ek4g9jXLlskCFoNC5kd8NM3wpovr1KDncimYyRwDY0BsTSyrvZaNDA2BxKORKSMfA9f2mCKDtBqWE4Ksaxh01PYmcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+INNSuf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+INNSuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034266; x=1783570266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xxqu9V3MYp5Q5oPy+re163/39+IwpjSIGvyrzdyaxbg=;
  b=c+INNSufZ0t2R/XCBq0iTsgFa+HeYny5H3TyI454JF/1VDGZU8KQjtCN
   sknGywEw308gIlJpmTYhAMR8Yk9VCHPxJvSUDYnEi47OdDGC6CwzsnmEd
   WaSW8TnfBX25oVmVoXJFdcFA/hyRBL9tQiGt7lulP0LNsn50QfKeagTqa
   EctO5Wga5xxCHPAC94rok1U1OGZlycw2c6PAb+3Hsmd4VSG3w7/80WSKw
   Vi3LkGi6ahJLmHKezgQWmj/9TM6STp4LLvIdE7CQAaBOciwzivwbz1pwj
   9u6WZ4jQGMkb7T0Ro0kY0efWhMFuYg3tegYhI/anJ5AZLAun7QJdkpIM5
   Q==;
X-CSE-ConnectionGUID: jF2YUQlrQOyYzc12geT0Jg==
X-CSE-MsgGUID: FrwAAFONR8ezwxelYcI/TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831801"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831801"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:06 -0700
X-CSE-ConnectionGUID: 5/hXNZisT2KmTCtNPuVmWA==
X-CSE-MsgGUID: setx69VBR3WEXhEUb06dow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851608"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:11:02 -0700
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
Subject: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Date: Wed,  9 Jul 2025 12:02:30 +0800
Message-Id: <20250709040234.1773573-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
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
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 25ab2f41d650..e91a36cc02d0 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -151,6 +152,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
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

