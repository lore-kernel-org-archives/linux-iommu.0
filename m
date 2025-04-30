Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D32DC770
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979142; cv=none; b=qzO6xmZSvZ3ASfAO88Wq9SR33Y1/wNIErsZHomCse2L5+g/lE0i4YXBJzFplxFb78ZNdbaN0awnuYPQUrjQrwOa/ET1NuuQzUluUAVHtHTRdm+2zFFV+ktQpwo40FR84b4cyCeu7FJsSmprUt3ohRGi4wXJivjmHlKNPDn8R/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979142; c=relaxed/simple;
	bh=i0xhYBoE9NEM38VpBCc8GYhwV6BIRufPgSa7+Tzxa1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPLMggS60Sy/GK7OrF7W+GPu9t3gLONfqeRTAtLIkF6L5VjIowUjooT15GgWGcy3P+Ov91V1/KxLuqMw5VGAnX6IyG+nwUTRuiNq8bEEx3eIwaY4UExokjbYz8zLxZ+ZOywb507CL+BX9TtU89co6ZCVnjBIiNZ3geeY60HgQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/itnw0F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/itnw0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745979142; x=1777515142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i0xhYBoE9NEM38VpBCc8GYhwV6BIRufPgSa7+Tzxa1A=;
  b=i/itnw0FOIhj+lMxBL8C8lmdiWBjeVIyOu1cUT2mZGmRTpZscmwDlKHf
   lENyvJITdKIbC2STzwaLpYGTIppNv5ICJ/6Il+ZqJXRmSkSaw2A+kL7dX
   6p7vfvCm3xzKI14FSUISSho19/r9WHnx6tPsxXgUvDNsoGipEzF6C5Nsq
   VCalkTW9vs2uTBx0I8dNbWU7LNvaKymF9RnuTzZOcabdmKVgWoX8w3sL/
   xSmI4alj3FcX5D29zaKWFLBtiZwcZTmG+Y4TJF5pv3GotONnnf/pu6rKo
   6HkezAU8pdtp0Mkf7YoEW/64VxcGtz4irbeSrMr+HM5wpU1sHKOtsacnj
   w==;
X-CSE-ConnectionGUID: 6Mhp4dKLQTK5EId0hY/VXg==
X-CSE-MsgGUID: qbWgx58RT96dLegMjzSFJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51288429"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="51288429"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:11:05 -0700
X-CSE-ConnectionGUID: bWGc7LQATJmfaFUzbUISnQ==
X-CSE-MsgGUID: h4UI0eYiTRejRWwPiexuCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134303413"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2025 19:11:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Use ida for domain ID management
Date: Wed, 30 Apr 2025 10:11:33 +0800
Message-ID: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This converts the Intel iommu driver's domain ID management from a
fixed-size bitmap to the dynamic ida allocator. This improves memory
efficiency by only allocating resources for the domain IDs actually in
use, rather than the maximum possible number.

The also includes necessary cleanups after the ida conversion, including
locking adjustment for the ida.

---
Change log:
v2:
 - Drop the last patch which simplified the code with __free(). There
   needs a helper like xa_store_or_{reset,kfree}(). Thus I plan to put
   it a separated series with broader reviewers.

v1: https://lore.kernel.org/linux-iommu/20250423031020.2189546-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Use ida to manage domain id
  iommu/vt-d: Replace spin_lock with mutex to protect domain ida

 drivers/iommu/intel/dmar.c  |  4 ++
 drivers/iommu/intel/iommu.c | 90 ++++++++-----------------------------
 drivers/iommu/intel/iommu.h | 21 +++++++--
 3 files changed, 40 insertions(+), 75 deletions(-)

-- 
2.43.0

