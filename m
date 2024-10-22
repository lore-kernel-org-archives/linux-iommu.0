Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CB196DA2
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590802; cv=none; b=qGZ1d5JOMzZeMaN28qqfD2RnxP/zJ8Vc5CBzKtgzkQDOxlIspPSxLBIT+KpQ05Tsf92/WUxSgdEU5K8/0Ys6SdRFZsMO3E/ma+pR1YS74Lr46oCyxxmxcUng3EH2sm85UbV1KTuarygeN/EQzJ/BJ5MnIjZQEEp+NCT96YQirZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590802; c=relaxed/simple;
	bh=NjBpeThJZhEOXSbpB4jvHxplMDLrEb5adj9V+7MZTdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hji7oLWWqfkSSfn7wjYIc+Duo+lba3OMqZ4PLeg0KEY3kXoPiOQIihVp8jjiEvnUR5pEknlUa+s/T10fZ4dezsrhDfFZIUY0ORdfYy1oLXvaN/Qq1O7g/f8THHi43f29CY3iik0tYJsBJpNcUJ2rp4d8YPZ4kdbU+2/pI5BTam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6be9vNc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6be9vNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729590801; x=1761126801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NjBpeThJZhEOXSbpB4jvHxplMDLrEb5adj9V+7MZTdM=;
  b=U6be9vNcxQeCPvL5tXtzghgpdskWl4Fpau5xzffxysM2ti6TwhYP4lCn
   7hqHebGgzhIuyVZovvTkZ5bctaIthHPkFGBy/dbjX3sb745VerTpuOPbj
   U/V2OUenWxUp55AWcdhDcH8rMhK2PFvHWQvjNOjl2zeT2ZcgXiERXy5Ed
   xAQTp0keTD+7D+/2zTM2yi46F2wsFKFH8UXuxh3yVTyGjnK9d+ayE+3dN
   LbJlE+O2gJ4YTqzFoDrSfB4YnEiZLXXZUckk8qj7i029ekIik+/MHyieV
   D0Za17PwXheSWf7fTYoJjCKIUQH0/XhTseto16KwyfSgdcTVXO43WNmwU
   Q==;
X-CSE-ConnectionGUID: eCoPJqCgRPa4k7mfVJwtXw==
X-CSE-MsgGUID: /cILPqn2TOqqDB5ZW7E58w==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31976790"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="31976790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:20 -0700
X-CSE-ConnectionGUID: arFbb2+ITtaxTRW95zee0w==
X-CSE-MsgGUID: E502hMGuS9KOBZYEdJ6Qsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84412563"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] vtd: Minor cleanup
Date: Tue, 22 Oct 2024 17:50:15 +0800
Message-Id: <20241022095017.479081-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This cleanup the vtd dump code to dump entry when it's present.
See patch log for details.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
  iommu/vt-d: Fix checks in pgtable_walk()

 drivers/iommu/intel/iommu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

-- 
2.34.1

