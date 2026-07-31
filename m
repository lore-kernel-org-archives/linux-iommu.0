Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE035E1C3
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477283; cv=none; b=YHbofKey9uKBWVfYUrB8emOQqBitUq2wToWAeGUqZKHbvsGoOukQXJOfTGlFvGxMVY49TQsDfubrcauqbKicyY6xKIYSM3MImpRemEVfeHvsiGw1VFL/6MRj7pcWmFWVWzg7DMrEx/E2dvN0+/g20iSPzgJmpJ+jZ/xMJULldiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477283; c=relaxed/simple;
	bh=CyilZMx8+i3u6hEQasIHojx7LCzJwkdv6KmqAfIknFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQGnmdGrVnJrfKFFJqZU+TVmnbuOnsZNF24cYoRKBgvJsDOzCX7l2vsEpRaBEVP2nMOSCLQ4hIvDNrkTBGuC7YxhPTVwUWzePFGUMDfOsApmCECV91No1F53R967L2wUpQpFIXdhVxi1VxZ58EDojUz7TfptxHKixKceitNjQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CD7o5tyo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CD7o5tyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477281; x=1817013281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyilZMx8+i3u6hEQasIHojx7LCzJwkdv6KmqAfIknFA=;
  b=CD7o5tyovwpRvDoGFWEglswGNYASOK0hxmpnbvuIgsYW6EVIi5cpcc7S
   bNn9fXe1uNYTTQerlQCsTcoWRtNdX8kx2VRALzbU8si22VZ3OyKq6cqo3
   r4pJh7REClUlENhJSZefpP1x7kRkXGn8X6O2W0camO2EZzYFpEeEn6S8R
   Dxy1estRU95tdGdlOy8T74DNmN6M1YHF1iacuq23S1Q6oQbD/LahRnalp
   6TdnImsnRfhFUkXVGWp398WQ9gaLmwLAFrYI5z3/5vNHOaLZ0cUI2Mf45
   fCPOcBQzHsXA2teULpb+X49HzfUYz/3jP4hl7eIlEhQUxhFRodxAB6/N1
   Q==;
X-CSE-ConnectionGUID: gM2xFlwySqi3L0adWGga5g==
X-CSE-MsgGUID: Lb3yklUhRh6tpAqBC3V8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615867"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:40 -0700
X-CSE-ConnectionGUID: uIaU1wL2SWuXA4x4g/TniQ==
X-CSE-MsgGUID: o1owNxU7TAyIHyW3pGqtrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695461"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Fixes for issues reported by Sashiko
Date: Fri, 31 Jul 2026 13:43:24 +0800
Message-ID: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This collects a number of pre-existing issues that were reported by
Sashiko while reviewing recent VT-d patches. None of them are
regressions from the patches under review; they are latent problems in
code those patches happened to touch. They are independent of each other
and can be applied in any order.

Thanks,
baolu

Lu Baolu (5):
  iommu/vt-d: Fix shift overflow in qi_desc_dev_iotlb_pasid()
  iommu/vt-d: Clear Present bit before tearing down copied context entry
  iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
  iommu/vt-d: Tear down scalable-mode context on probe failure
  iommu/vt-d: Flush context cache with correct SID when tearing down
    aliases

 drivers/iommu/intel/iommu.h | 18 +++++++++++++-----
 drivers/iommu/intel/iommu.c | 22 +++++++++++++++-------
 drivers/iommu/intel/pasid.c |  9 ++++++---
 3 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.43.0

