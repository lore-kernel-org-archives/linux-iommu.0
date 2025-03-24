Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAF10F9
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817640; cv=none; b=b/SQi3ErC6EDKLUOqQMlnpY6hiRfh2VrX1C/GND7Y47+B2IEwa8JSvjzYZibH6qcJJ+Cu27jOZs/IEcjDi+VEeckRiZcBEIC36Bx0Jh9tEQ1caskr+TYL5xkGlKF/FlQurH3fZr/Cwsb3m/RzwfB/lz9u+JSkKp3dyH1rpoVCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817640; c=relaxed/simple;
	bh=rh9vZtObhEkbhuuhWcHvxy9KKUWs3g8DJZ1s+Hfxelo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9hxG0vGsgPzpPiE/3Cr3LxcZuSBziYxi+OZez53d39BrRNmuAYA1JNsET89RiLRZu+NFiPbZlPB6cNJscLfbYSZWLt5t0gBmujhTiaGM5a6OZ1DYU34ygtepecwqFP8NA9ZDuhsrFsKw9hv8io9H4LJ3IY33qRKPeiwEB3PDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJO3og4x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJO3og4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742817638; x=1774353638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rh9vZtObhEkbhuuhWcHvxy9KKUWs3g8DJZ1s+Hfxelo=;
  b=fJO3og4xszAoRjFyBX4vxtkMKHVLyUrQbgWNHf5EuwZH3Mfy1kXRB8R3
   bRFYl2cyIF9U+wiJLlExJnkwY6VzTsmxKvXdZhrfFbw4Mhk4pYvVJn1rz
   +OFV9PNGfbYbIpRdVr7ualixklcjPl3/sPzNUS1ki7xC82TJM1v+xLF7W
   9PQKJJ/6wR3aUV5i9f8TSqIbKbHCGGfOFtoasJ4GjI6WY0cuxFGSBSV2R
   3g93TW28dkPlukUzqUxz5XLN6KQnWW0GIy+PJbHog8VT4isnlKW1tFNXQ
   kfjPndKzv09nkJyGj498ZYpf3vuqHrAIjINcj8yCLzxrdLJeUDd5wlKJF
   w==;
X-CSE-ConnectionGUID: W3/78dnuSZ2XGX9f+vGZ/Q==
X-CSE-MsgGUID: khLonzBIRQKnseHiIFoofA==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44031307"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="44031307"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:00:36 -0700
X-CSE-ConnectionGUID: jBsJPvPeTJGSMvB9uE+a3Q==
X-CSE-MsgGUID: 8YEYqgAxQbGd0yPhi2M3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123753917"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 24 Mar 2025 05:00:35 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	yi.l.liu@intel.com,
	baolu.lu@linux.intel.com,
	iommu@lists.linux.dev
Subject: [PATCH 0/2] Two fixes to vevent path
Date: Mon, 24 Mar 2025 05:00:32 -0700
Message-Id: <20250324120034.5940-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd selftest occassionally fail when reading vevent. After debugging,
it is due to vevent->header.flags. It is not set properly per allocation.
This can be fixed by using kzalloc(). There is another related issue. The
veventq->num_events inc/dec is not balanced. This is problemtic. Make a
fix for it as well.

Regards,
	Yi Liu

Yi Liu (2):
  iommufd: Initialize the flags of vevent in
    iommufd_viommu_report_event()
  iommufd: Balance veventq->num_events inc/dec

 drivers/iommu/iommufd/driver.c | 2 +-
 drivers/iommu/iommufd/eventq.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

