Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80905BA34
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912194; cv=none; b=maWSpAz+VKVq80zYXLZatCzrChhIVNYMF5djjWe4G+rUd9addrCOtva8P4nKD5u1+m8A0KOEzSlYH846bBLwx7FoIJ3Y/RT2Evqwnjb/rmb8ji5Ebu+QRrhipQYxRGUjibK6IyJ706fTfOxcfMnUfdiJ4KYbdGaOZef2UG53a2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912194; c=relaxed/simple;
	bh=8ikBy/tLCc+vKeAiQwAsjkffCbEbddVM4RZBSOSSBeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5gPt3flj/8IidbkCtzH8M1D4Y08ck+htptGoztBx9FquA0cxN2zK5/HWEUFJgPTVpH7SiO0isbMd4XPsniKNROsOqVtFlQOWtZ/aLUwh6cBNXY/a0tdkKzygzSwctyQHODTC7+HaNWEt0HLRYLK5L5paT0qc1KnrSu1lOKj8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIeukoio; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIeukoio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912192; x=1754448192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ikBy/tLCc+vKeAiQwAsjkffCbEbddVM4RZBSOSSBeY=;
  b=hIeukoio/QBOA4OtRyE8zznB9j0gtDRFAWkbgwo8QUYTf3lNOdrfuDLM
   eQq26vjvabidkqxTd474kyz/YGWBUMkCDgMzxRXMfcwDkqO1gXcZ/Cr9h
   7igR3+evHVtQtJg/AC+zNM8VrZ3zVjxFgoV1BgUYf1cEYNHZYtnVWaj7H
   IzdoCTkaINxRTgtAfkaKwQ9IhICvNvKaieeNt/aX7Pt14B7kKF/50UPZo
   GIbEGDnyEfQG4FfvocGJdm9qTh28N07qKhmwg6fTSaZVOAnve1oKOTPZa
   A2PsfRv5k/ZL6qyjhb0GtWWY+mqxFh/gG4YaTdF3w/Cs1mP28TIjwPVgZ
   A==;
X-CSE-ConnectionGUID: gJHX7jibSaajZ0NcOs8h0Q==
X-CSE-MsgGUID: GjbUy6dASdCBCNKL1uGNAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756249"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756249"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:12 -0700
X-CSE-ConnectionGUID: GbRGz6+4SmmFDSV48u5t1A==
X-CSE-MsgGUID: n1TJ2T7SSLCTw/+xLlAmFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572509"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/7] iommu/vt-d: Convert to use static identity domain
Date: Tue,  6 Aug 2024 10:39:34 +0800
Message-Id: <20240806023941.93454-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel's IOMMU driver used a special domain called 1:1 mapping domain to
support the domain of type IOMMU_DOMAIN_IDENTITY, which enables device
drivers to directly utilize physical addresses for DMA access despite
the presence of IOMMU units.

The implementation of the 1:1 mapping domain is influenced by hardware
differences. While modern Intel VT-d implementations support hardware
passthrough translation mode, earlier versions lacked this feature,
which requires a more complex implementation approach.

The 1:1 mapping domain for earlier hardware was implemented by associating
a DMA domain with an IOVA (IO Virtual Address) equivalent to the
physical address. While, for most hardware supporting passthrough mode,
simply setting the hardware's passthrough mode is sufficient. These two
modes were merged together in si_domain, which is a special DMA domain
sharing the domain ops of an ordinary DMA domain.

As the iommu core has evolved, it has introduced global static identity
domain with "never fail" attach semantics. This means that the domain is
always available and cannot fail to attach. The iommu driver now assigns
this domain directly at iommu_ops->identity_domain instead of allocating
it through the domain allocation interface.

This converts the Intel IOMMU driver to embrace the global static
identity domain. For early legacy hardwares that don't support
passthrough translation mode, ask the iommu core to use a DMA type of
default domain. For modern hardwares that support passthrough
translation mode, implement a static global identity domain.

The whole series is also available at

https://github.com/LuBaolu/intel-iommu/commits/vtd-static-identity-domain-v3

Change log:
v3:
 - Kevin worried that some graphic devices might still require identity
   domain. Forcing DMA domain for those drivers might break the existing
   functionality.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com/

   After confirmed with the graphic community, we decouple "igfx_off"
   kernel command from graphic identity mapping with the following commits:
   ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic identity mapping")
   4b8d18c0c986 ("iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA").

v2: https://lore.kernel.org/linux-iommu/20231205012203.244584-1-baolu.lu@linux.intel.com/
 - Re-orgnize the patches by removing 1:1 mappings before implementing
   global static domain.

v1: https://lore.kernel.org/linux-iommu/20231120112944.142741-1-baolu.lu@linux.intel.com/ 

Lu Baolu (7):
  iommu/vt-d: Require DMA domain if hardware not support passthrough
  iommu/vt-d: Remove identity mappings from si_domain
  iommu/vt-d: Always reserve a domain ID for identity setup
  iommu/vt-d: Prepare for global static identity domain
  iommu/vt-d: Factor out helpers from domain_context_mapping_one()
  iommu/vt-d: Add support for static identity domain
  iommu/vt-d: Cleanup si_domain

 drivers/iommu/intel/iommu.c | 434 +++++++++++++++++-------------------
 1 file changed, 201 insertions(+), 233 deletions(-)

-- 
2.34.1

