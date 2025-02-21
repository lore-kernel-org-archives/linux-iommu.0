Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425C20B80A
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148419; cv=none; b=r7hBfEJ53CICm/TYUEfvvv1RDto27dYGqliWOzl5cT2jbeO/3942UVOm0XD7hWTp9q3NowAEfvPZNEZ+v2NDy8XzBjqdmUaDv/lvrUQMGE2qmUVPOb2/ga7H5C3sT8rgnfZq38gn7ekVoWa1g8Cww9e5ZAXvC/iYULZ7gRFBPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148419; c=relaxed/simple;
	bh=APumpGsTq7tseBN3uf6Vfk+x0p7yxrEFeh/6evz5VYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAKFFWLs4zyVaT8+RmIoG8KcxvuNLWJnlbZjc/8Z+TBp5bhWzqjhhK8kqMS/gu3Dvfco07ZtSK31qPKhPvJxRHEGu2cNeh94RkonDHaT2tzrJJe0VraoQkQU16M2KGjhINQ6W8Fy98fP4pzSxvgHzypx1UTb6FouDuPTfDUGYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APTqthXq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APTqthXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148417; x=1771684417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APumpGsTq7tseBN3uf6Vfk+x0p7yxrEFeh/6evz5VYk=;
  b=APTqthXq8hdy8lLDAuiNvVmPy1Fc2PZGK+UgAZeZwXLKqCbemTuN82x7
   5XHepr6+/Ksrvfwt4NAoEhQoFpDXxmh2ZyMvQwof0i8HcD+mKW+XEzmlz
   NheSlJgHrieHSeB76iTqnPGbn/b08lhlg6WzZL94ruDTDSNuhioA424mr
   Sp0MT7aHrYsbD3+KmlJRxbl7D4QxnDwdAkz8+KAcnxGPAgWIGa77IDrNu
   f6xFpWCeEA6UFf9oykbNTKqcXegFzN8qXkh3+JEof0PwzFPi4Q2xhW6Kz
   la4/uW2Vw3ju2Dq1EY+bc6GnfZh77fgfq7W97Z6Ba+v9/FNA0WLNHQ1Tz
   Q==;
X-CSE-ConnectionGUID: Bhrrrs63RWGK0eEhsFGI6g==
X-CSE-MsgGUID: nb/Je0M+Se+yzvlajXHYyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441038"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63441038"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:33:36 -0800
X-CSE-ConnectionGUID: RsyiXF1YSuuguA1ccuCo3A==
X-CSE-MsgGUID: Yw1AeHfCTzCDrs5FBmdC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115887151"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 06:33:37 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH v2 0/4] Misc iommu_attach_handle enhancements in iommu core
Date: Fri, 21 Feb 2025 06:33:31 -0800
Message-Id: <20250221143335.49874-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to enhance the iommu_attach_handle-related APIs
in the IOMMU core. The changes build upon Nic's previous series[1], which
ensured that users of the attach/replace handle APIs always provide a
valid handle. With this foundation, the series refactors the IOMMU core
to share code between the normal attach/replace APIs and the
handle-supporting APIs. Additionally, it seeks to avoid processing Page
Request Interrupts (PRIs) before the attach operation succeeds.

This series also covers the prior series[2] which only takes care of the
iommu_attach_device_pasid().

[1] https://lore.kernel.org/linux-iommu/cover.1738645017.git.nicolinc@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20250120030840.4171-1-yi.l.liu@intel.com/

Change log:

v2:
 - Move handl->domain under group->mutex protect (Nic)
 - Refine the patch 04 per the model of reserve xa first and then xa_store in
   the end which does not suppose to fail (Jason)
 - Drop the patch 05 of v1 as retire group->domain requires further effort
 - Add r-b tags

v1: https://lore.kernel.org/linux-iommu/20250212060540.261436-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (4):
  iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
  iommu: Drop iommu_group_replace_domain()
  iommu: Store either domain or handle in group->pasid_array
  iommu: Swap the order of setting group->pasid_array and calling attach
    op of iommu drivers

 drivers/iommu/iommu-priv.h |   3 -
 drivers/iommu/iommu.c      | 131 +++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.34.1

