Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38C02C68B
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341715; cv=none; b=Ke8eInqVN/DhSFBsyp+EXsYcwLCXIVxJFiLuQFnCTxCKbTmWDg5W/kFHm33iV0qu+mVGbaDZUU7syqRlteB7VqE+nsNl2Znq7ErBh1Ky4yST+NIEH5vsPINQhYg+3a1/pEXBRr+G+w5jsf6B42olsszjw/W0UwJKtsXwUx+WId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341715; c=relaxed/simple;
	bh=4DnwBO9+Yc+LZhrZxqmcmMCN3Z559XhP2LH71F6BApA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cghgUjFq/2zpDohXiv2JXISe/7ghnvU7uqnvrBVHH00jM2qaaKoo8m5L2GkB7LdkKEDHNytsvzAylzOqxKhoMPfmC4oH2ieUyzrnOduTlH8asMIDDO8vmSNHg2Issgd8sZlTUnr3uBJ3kQ/VKcYugYUCCsKXZcCokaqGsfaalQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkv/laDv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkv/laDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341713; x=1739877713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DnwBO9+Yc+LZhrZxqmcmMCN3Z559XhP2LH71F6BApA=;
  b=Qkv/laDv6Y+CHY/7Ekk4QUiHpjODVQMX/x7CeqTvixNo30nELGLnnjVr
   Juu/XzioZcgTG1njlHtVQVOsnK1bZ9yx8m0tFamlqIza8+Gu3qTj4rTeT
   SRT2F/G4lMdpWbrjhefKo97YPi4Gn0iAcUwWAQTt9z6AlfxGVr75QelRv
   ikNKaADoQanpi02MrioOcDxpy9xYZSZBWOq1bzgHRJB24N4Lar09Pk6ea
   dZrXME+slbdWLqpahYiJxftQlnwyVxuGyD3H27veJBwGEYRhMvOj3mc3x
   iOApba9UjTgl9A/m28rNgUlA9mSuVO4Hu7TqvhDr5ZkP3rAdXossVhH4/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823327"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826776"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:21:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] [PULL REQUEST] iommu/vt-d: Fixes for v6.8-rc5
Date: Mon, 19 Feb 2024 19:15:51 +0800
Message-Id: <20240219111601.96405-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following patches have been queued for v6.8. They fix some missed
behavior for nested domain implementation in the Intel IOMMU driver. To
be more specific, they aim to achieve comprehensive:

- Cache invalidation for changes in a parent domain;
- Dirty tracking setting for parent and nested domains;
- Fix a constant-out-of-range warning.

As the nested domain implementation in the Intel IOMMU driver was
introduced in v6.8-rc1, I would suggest merging this series in the rc
phase. So,

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Arnd Bergmann (1):
  iommu/vt-d: Fix constant-out-of-range warning

Yi Liu (9):
  iommu/vt-d: Track nested domains in parent
  iommu/vt-d: Add __iommu_flush_iotlb_psi()
  iommu/vt-d: Add missing iotlb flush for parent domain
  iommu/vt-d: Update iotlb in nested domain attach
  iommu/vt-d: Add missing device iotlb flush for parent domain
  iommu/vt-d: Remove domain parameter for
    intel_pasid_setup_dirty_tracking()
  iommu/vt-d: Wrap the dirty tracking loop to be a helper
  iommu/vt-d: Add missing dirty tracking set for parent domain
  iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking

 drivers/iommu/intel/iommu.h  |   7 ++
 drivers/iommu/intel/pasid.h  |   1 -
 drivers/iommu/intel/iommu.c  | 214 ++++++++++++++++++++++++++---------
 drivers/iommu/intel/nested.c |  16 ++-
 drivers/iommu/intel/pasid.c  |   5 +-
 5 files changed, 187 insertions(+), 56 deletions(-)

-- 
2.34.1

