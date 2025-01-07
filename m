Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84A2594A5
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216388; cv=none; b=GRKmznGmBp6WfrtID3W1sESDh0CE/k3xMPe+jLpgGe3ekZL2NVuayVdqhB1u10u50OQcwyz9CBksWQdtmvo5Gg0votw+eFwsblqdI1UoyrmPRMpdoerXONf8qJ/VVA9s+W/s/m+cU7EijVflzgfeNYkN/Y8p/Tb9rJss/BJU7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216388; c=relaxed/simple;
	bh=rbGf6rT+Cm3J61ZGFndlpgPASQjd2g5y6byaF+Ysfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+no7eRC3+w8xUVuj72Fk39FnwxFyQ4KJ4lMsOGHJBuaisyV+QbWnZsiZHlvXNxJBauLXx9qAGUtRlGESHob2OroxEZTMtorRu9ICwPhqQJrQE6tdVsGRJEYrHMWREAA+q81/4je++GPG604zylnOyJB2RqIOYp+TZ254AspGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOQ/kAFV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOQ/kAFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216386; x=1767752386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rbGf6rT+Cm3J61ZGFndlpgPASQjd2g5y6byaF+Ysfuk=;
  b=aOQ/kAFVqgg9P9/TKz2yf1k0Q1q8K0slMoM4U0yMfE8mkYQ3O1J/YBcN
   H3qtUE4CJHgss0HC7sC7K/wjTjMugDRdqNEXob5MrkC/1SteVYklziMSR
   zVuz+c0huB7UDnoidELoZkSZEa7R/YNbyroeIbPUIEdC195g+hpjgUffB
   9e0gyXqIIlOozX8244AY7ZfSVQb3f52S4pP1J5paCu4E48wA6sLzP11Zw
   mgkHN4GgLzXFrQh1dVEqe0oXLnUmLFKZPPC/tif19Qb3MdUxyDvtJjYMi
   WfW+85IaBzO0XZASNfxuuvzRthtiWT5iLPkBFOXji/86d2qIP/7rws8D3
   Q==;
X-CSE-ConnectionGUID: kbh/ybZrTK+saIdl2r9WGQ==
X-CSE-MsgGUID: /ewIXoIZS3SOsaUvjtcc4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800757"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800757"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:45 -0800
X-CSE-ConnectionGUID: 7kCqahVYQJaHZIrRQLRrYQ==
X-CSE-MsgGUID: FM7p5ujcRQyBNnTjGDLrAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442910"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] [PULL REQUEST] Intel IOMMU updates for v6.14
Date: Tue,  7 Jan 2025 10:17:41 +0800
Message-ID: <20250107021746.6908-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.14-rc1. They are about new
features and code refactoring, including:

 - Remove domain_alloc_paging()
 - Remove capability audit code
 - Draining PRQ in sva unbind path when FPD bit set
 - Link cache tags of same iommu unit together

These patches are based on v6.13-rc6. The complete patches are also
available at:

https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.14

Please consider them for iommu next.

Best regards,
baolu

Jason Gunthorpe (1):
  iommu/vt-d: Remove domain_alloc_paging()

Kees Bakker (1):
  iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Lu Baolu (2):
  iommu/vt-d: Remove iommu cap audit
  iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set

Zhenzhong Duan (1):
  iommu/vt-d: Link cache tags of same iommu unit together

 drivers/iommu/intel/Makefile        |   2 +-
 drivers/iommu/intel/cache.c         |  11 +-
 drivers/iommu/intel/cap_audit.c     | 217 ----------------------------
 drivers/iommu/intel/cap_audit.h     | 131 -----------------
 drivers/iommu/intel/iommu.c         |  32 +---
 drivers/iommu/intel/irq_remapping.c |   8 -
 drivers/iommu/intel/pasid.c         |  22 ++-
 drivers/iommu/intel/pasid.h         |   6 +
 8 files changed, 42 insertions(+), 387 deletions(-)
 delete mode 100644 drivers/iommu/intel/cap_audit.c
 delete mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.43.0

