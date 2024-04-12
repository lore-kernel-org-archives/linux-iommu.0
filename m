Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904951C23
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909740; cv=none; b=k2u1j8BvVO6HaVoeNgwCLcSRmpsj9mXSWaEkFPxx5ewRfC2qRZU1UykWkMbLtg+B1idcB0TWqCPI3/a+Xl0pz+4jmrqYwJ0VcFuF2RCw34pDcAc4pqRP+6DggPANkQd6BvPhFh94Ge/xZVRZfS/zBexC5N0tgsW97EJe+80vxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909740; c=relaxed/simple;
	bh=+YxNjmAnxPz08ugfMnJTp/OXUrhN2kOcrXB2YzepySE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P59i6610FnOfETUqRLncIM/YmlbGuJ6Y9UyT9hTRR790IKvqrscCZefvuBj8dD17saQUO06CXJlU7Xdc/k2USLtdb735PYI5I71gODSNHeX0bcDconBfVKxJn/gp+yMI8I3BPCRqCd1ImUlgwqJFWtLJL7xQ3gMl9/ZXQJf6Ix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaFpusKx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaFpusKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712909739; x=1744445739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YxNjmAnxPz08ugfMnJTp/OXUrhN2kOcrXB2YzepySE=;
  b=JaFpusKxQQgjWrnU1xahEJB22wn53i+E1rkrk4BZrAneu9hId9k+1dNF
   hpfbGbBlmf2fmBbFe0LMlwTAnJZaO1F//fdQIT6ZbxJKxMVAXXGHYfnhI
   YDMtVLUvUZzObcTG/m+hp4rtL08hVJ+AnajFQU91vVfZ26Pihcuxni9u6
   84urcAxCJazG0YBuzhaki5DfKSsf9omhx3daVeB8Trr/36d2rRkZ2VXwT
   lCjZL+jE5ltKlDndYuGRsxQzXpn3DjLmWspds/vPbS9CpvLf53FxPzcT0
   0gx8Tz6z/HqLiEEMZCV0mv/E7xPqRS6mZ7ZAJmjRwIBD7zAIg8+slbluE
   w==;
X-CSE-ConnectionGUID: Br8BDgC1R9aGrky80oAPug==
X-CSE-MsgGUID: WI2a47cRQ7SbeqrmWUIgww==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8465115"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8465115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:15:38 -0700
X-CSE-ConnectionGUID: BLkJyJ6RT++WXfcfpW8FJw==
X-CSE-MsgGUID: Cp2l4cqISM+3TniCaJCaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52137881"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa002.jf.intel.com with ESMTP; 12 Apr 2024 01:15:37 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH v2 11/12] iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain replacement
Date: Fri, 12 Apr 2024 01:15:15 -0700
Message-Id: <20240412081516.31168-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412081516.31168-1-yi.l.liu@intel.com>
References: <20240412081516.31168-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing intel_iommu_set_dev_pasid() does not support domain replacement.
However, iommu layer requires set_dev_pasid() to handle domain replacement.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fff7dea012a7..9e79ffdd47db 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4646,6 +4646,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
+	/* Block old translation */
+	if (old)
+		intel_iommu_remove_dev_pasid(dev, pasid, old);
+
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
 		return ret;
-- 
2.34.1

